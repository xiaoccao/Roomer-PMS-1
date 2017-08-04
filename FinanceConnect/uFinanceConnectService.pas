unit uFinanceConnectService;

interface

uses UITypes, SysUtils, Classes, uD, Forms, Generics.Collections;

type
    TFinanceXmlListElements = record
      listName : String;
      rootName : String;
      codeName : String;
      descriptionName :String;

      constructor Create(list, root, code, description : String);
    end;

    TFinanceConnectSettings = record
      systemActive : Boolean;
      cashBalanceAccount,
      cashCode,
      companyGuid,
      hotelId,
      invoiceCode,
      officeCode,
      organizationId,
      password,
      receivableBalanceAccount,
      serviceUri,
      systemCode,
      usedCurrency,
      username,
      preceedingInvoiceNumber,
      succeedingInvoiceNumber : String;

      constructor Create(_systemActive: Boolean;
                         _cashBalanceAccount,
                         _cashCode,
                         _companyGuid,
                         _hotelId,
                         _invoiceCode,
                         _officeCode,
                         _organizationId,
                         _password,
                         _receivableBalanceAccount,
                         _serviceUri,
                         _systemCode,
                         _usedCurrency,
                         _username,
                         _preceedingInvoiceNumber,
                         _succeedingInvoiceNumber : String);
    end;

    TFinanceConnectService = class
    private
      CustomerXmlElements : TFinanceXmlListElements;
      ItemXmlElements : TFinanceXmlListElements;
      VatXmlElements : TFinanceXmlListElements;
      PayGroupsXmlElements : TFinanceXmlListElements;
      CashBooksXmlElements : TFinanceXmlListElements;

      SystemsXmlElements : TFinanceXmlListElements;

      MappingsXmlElements : TFinanceXmlListElements;

      procedure InitializeXmlElements;
    private
      FinanceConnectSettings : TFinanceConnectSettings;
    private
      procedure ParseList(XmlString: String; KeyPairList: TKeyPairList; XmlElements : TFinanceXmlListElements);
      procedure RetrieveFinanceConnectMappings;
      function ParseSettings(XmlString : String) : TFinanceConnectSettings;
    public
      constructor Create;
      procedure PrepareForMapping;

      function SystemName: String;

      function RetrieveFinanceConnectKeypair(keyPairType: TKeyPairType): TKeyPairList;
      function RetrieveFinanceConnectAvailableSystems: TKeyPairList;
      procedure MapForFinanceConnect(keyPairType: TKeyPairType; RoomerCode, ExternalCode : String);
      function keyPairTypeByIndex(index : Integer) : TKeyPairType;
      function MappingCaptionByIndex(keyPairType : TKeyPairType) : String;
      function FinanceConnectConfiguration: TFinanceConnectSettings;
      function CreateSettingsXml(settings: TFinanceConnectSettings): String;
      procedure SaveFinanceConnectSettings(FinanceConnectSettings : TFinanceConnectSettings);
    end;

var
    CustomersLookupList : TKeyPairList;
    ItemsLookupList : TKeyPairList;
    VatsLookupList : TKeyPairList;
    PayGroupsBalanceAccountLookupList : TKeyPairList;
    PayGroupsCashBookLookupList : TKeyPairList;

    SystemsLookupList : TKeyPairList;

    MappingsLookupMap : TObjectDictionary<String,String>;

    ActiveFinanceConnectSystemCode : String;
    ActiveFinanceConnectSystemName : String;

const MAPPING_ENTITIES : Array[TKeyPairType] Of String = ('CUSTOMER','ITEM', 'PAYTYPE', 'VAT', 'PAYGROUP', 'PAYGROUP');

procedure ClearFinanceConnectServices;
function FinanceConnectActive : Boolean;
procedure SendInvoiceToActiveFinanceConnector(invoiceNumber : Integer);

implementation

uses MSXML2_TLB, XmlUtils, msxmldom, XMLDoc, Xml.Xmldom, Xml.XMLIntf, uUtils;

function FinanceConnectActive : Boolean;
begin
  result := (trim(ActiveFinanceConnectSystemCode) <> '');
end;

procedure SendInvoiceToActiveFinanceConnector(invoiceNumber : Integer);
begin
  if FinanceConnectActive then
  begin
    d.roomerMainDataSet.downloadUrlAsStringUsingPut(d.roomerMainDataSet.RoomerUri + 'financeconnect/invoices/' + inttostr(invoiceNumber), '');
  end;
end;

const MAP_ENTITY_PATH = 'financeconnect/mappings/%s/%s/%s';

      XML_CONFIGURATION_ROOT = 'configuration';
      XML_CASH_BALANCE_ACCOUNT = 'cashBalanceAccount';
      XML_CASH_CODE = 'cashCode';
      XML_COMPANY_GUID = 'companyGuid';
      XML_HOTEL_ID = 'hotelId';
      XML_INVOICE_CODE = 'invoiceCode';
      XML_OFFICE_CODE = 'officeCode';
      XML_ORGANIZATION_ID = 'organizationId';
      XML_PASSWORD = 'password';
      XML_RECEIVABLE_BALANCE_ACCOUNT = 'receivableBalanceAccount';
      XML_SERVICE_URI = 'serviceUri';
      XML_SYSTEM_ACTIVE = 'systemActive';
      XML_SYSTEM_CODE = 'systemCode';
      XML_USED_CURRENCY = 'usedCurrency';
      XML_USERNAME = 'username';
      XML_PRE_INVOICE_NUMBER = 'preceedingInvoiceNumber';
      XML_SUC_INVOICE_NUMBER = 'succeedingInvoiceNumber';

{ TFinanceConnectService }

constructor TFinanceConnectService.Create;
begin
  if ActiveFinanceConnectSystemCode = '' then
    ActiveFinanceConnectSystemCode := Utf8ToString(d.roomerMainDataSet.downloadUrlAsString(d.roomerMainDataSet.RoomerUri + 'financeconnect'));

  if NOT assigned(SystemsLookupList) then
  begin
    InitializeXmlElements;
    SystemsLookupList := RetrieveFinanceConnectAvailableSystems;
  end;
end;

function TFinanceConnectService.SystemName : String;
var KeyAndValue : TKeyAndValue;
begin
  result := '';

  if ActiveFinanceConnectSystemCode <> '' then
    for KeyAndValue IN SystemsLookUpList do
      if KeyAndValue.Key = ActiveFinanceConnectSystemCode then
      begin
        result := KeyAndValue.Value;
        ActiveFinanceConnectSystemName := result;
        Break;
      end;
end;

procedure TFinanceConnectService.PrepareForMapping;
begin
  if ActiveFinanceConnectSystemCode <> '' then
  begin
    InitializeXmlElements;

    if NOT assigned(CustomersLookupList) then
      CustomersLookupList := RetrieveFinanceConnectKeypair(FKP_CUSTOMERS);

    if NOT assigned(ItemsLookupList) then
      ItemsLookupList := RetrieveFinanceConnectKeypair(FKP_PRODUCTS);

    if NOT assigned(VatsLookupList) then
      VatsLookupList := RetrieveFinanceConnectKeypair(FKP_VAT);

    if NOT assigned(PayGroupsBalanceAccountLookupList) then
      PayGroupsBalanceAccountLookupList := RetrieveFinanceConnectKeypair(FKP_PAYGROUPS);

    if NOT assigned(PayGroupsCashBookLookupList) then
      PayGroupsCashBookLookupList := RetrieveFinanceConnectKeypair(FKP_CASHBOOKS);

    if NOT assigned(SystemsLookupList) then
      SystemsLookupList := RetrieveFinanceConnectAvailableSystems;

    if (NOT assigned(MappingsLookupMap)) then
         RetrieveFinanceConnectMappings;

  end;
end;

procedure TFinanceConnectService.ParseList(XmlString : String; KeyPairList : TKeyPairList; XmlElements : TFinanceXmlListElements);
var
  XML: IXMLDOMDocument2;
  listNode, rootNode, dataNode: IXMLDOmNode;
  i, l : Integer;
  code, name : String;
begin
  xml := CreateXmlDocument;
  xml.loadXML(XmlString);
  listNode := xml.documentElement;
  if listNode <> nil then
  begin
    if listNode.nodeName = XmlElements.listName then
    begin
      for i := 0 to listNode.childNodes.length - 1 do
        if listNode.childNodes.item[i].nodeName = XmlElements.rootName then
        begin
          code := '';
          name := '';
          rootNode := listNode.childNodes.item[i];
          for l := 0 to rootNode.childNodes.length - 1 do
          begin
            dataNode := rootNode.childNodes.item[l];
            if dataNode.nodeName = XmlElements.codeName then
            begin
              code := dataNode.text;
            end else
            if dataNode.nodeName = XmlElements.descriptionName then
            begin
              name := dataNode.text;
            end;
          end;
          if (code <> '') and (name <> '') then
          begin
            KeyPairList.Add(TKeyAndValue.Create(code, name));
          end;
        end;

    end;
  end;
end;

function TFinanceConnectService.ParseSettings(XmlString : String) : TFinanceConnectSettings;
var
  XML: IXMLDOMDocument2;
  listNode, rootNode: IXMLDOmNode;
  i, l : Integer;
  code, name : String;
begin
  xml := CreateXmlDocument;
  xml.loadXML(XmlString);
  listNode := xml.documentElement;
  if listNode <> nil then
  begin
    if listNode.nodeName = XML_CONFIGURATION_ROOT then
    begin
      with result do
      begin
        for i := 0 to listNode.childNodes.length - 1 do
        begin
          rootNode := listNode.childNodes.item[i];
          with rootNode do
          begin
            if rootNode.nodeName = XML_CASH_BALANCE_ACCOUNT then
               cashBalanceAccount := rootNode.text
            else
            if rootNode.nodeName = XML_CASH_CODE then
               cashCode := rootNode.text
            else
            if rootNode.nodeName = XML_COMPANY_GUID then
               companyGuid := rootNode.text
            else
            if rootNode.nodeName = XML_HOTEL_ID then
               hotelId := rootNode.text
            else
            if rootNode.nodeName = XML_INVOICE_CODE then
               invoiceCode := rootNode.text
            else
            if rootNode.nodeName = XML_OFFICE_CODE then
               officeCode := rootNode.text
            else
            if rootNode.nodeName = XML_ORGANIZATION_ID then
               organizationId := rootNode.text
            else
            if rootNode.nodeName = XML_PASSWORD then
               password := rootNode.text
            else
            if rootNode.nodeName = XML_RECEIVABLE_BALANCE_ACCOUNT then
               receivableBalanceAccount := rootNode.text
            else
            if rootNode.nodeName = XML_SERVICE_URI then
               serviceUri := rootNode.text
            else
            if rootNode.nodeName = XML_SYSTEM_ACTIVE then
               systemActive := LowerCase(rootNode.text) = 'true'
            else
            if rootNode.nodeName = XML_SYSTEM_CODE then
               systemCode := rootNode.text
            else
            if rootNode.nodeName = XML_USED_CURRENCY then
               usedCurrency := rootNode.text
            else
            if rootNode.nodeName = XML_USERNAME then
               username := rootNode.text
            else
            if rootNode.nodeName = XML_PRE_INVOICE_NUMBER then
               preceedingInvoiceNumber := rootNode.text
            else
            if rootNode.nodeName = XML_SUC_INVOICE_NUMBER then
               succeedingInvoiceNumber := rootNode.text;
          end;
        end;
      end;
    end;
  end;
end;

function TFinanceConnectService.CreateSettingsXml(settings :  TFinanceConnectSettings) : String;
var
  iRoot : IXMLNode;
  XMLDoc: TXMLDocument;

  procedure AddDataElement(name, data : String);
  var iNode : IXMLNode;
  begin
    iNode := iRoot.addChild(name);
    iNode.Text := data;
  end;

begin
  XMLDoc := TXMLDocument.Create(nil);
  XMLDoc.Active := False;
  XMLDoc.XML.Text := '';
  XMLDoc.Active := True;
//  iXml := XMLDoc.DOMDocument;
  iRoot := XMLDoc.addChild(XML_CONFIGURATION_ROOT);
  with settings do begin
    AddDataElement(XML_CASH_BALANCE_ACCOUNT, cashBalanceAccount);
    AddDataElement(XML_CASH_CODE, cashCode);
    AddDataElement(XML_COMPANY_GUID, companyGuid);
    AddDataElement(XML_HOTEL_ID, hotelId);
    AddDataElement(XML_INVOICE_CODE, invoiceCode);
    AddDataElement(XML_ORGANIZATION_ID, organizationId);
    AddDataElement(XML_PASSWORD, password);
    AddDataElement(XML_OFFICE_CODE, officeCode);
    AddDataElement(XML_RECEIVABLE_BALANCE_ACCOUNT, receivableBalanceAccount);
    AddDataElement(XML_SERVICE_URI, serviceUri);
    AddDataElement(XML_SYSTEM_ACTIVE, IIF(systemActive, 'true', 'false'));
    AddDataElement(XML_SYSTEM_CODE, systemCode);
    AddDataElement(XML_USED_CURRENCY, usedCurrency);
    AddDataElement(XML_USERNAME, username);
    AddDataElement(XML_PRE_INVOICE_NUMBER, preceedingInvoiceNumber);
    AddDataElement(XML_SUC_INVOICE_NUMBER, succeedingInvoiceNumber);
  end;
  xmlDoc.SaveToXML(result);
end;

procedure TFinanceConnectService.SaveFinanceConnectSettings(FinanceConnectSettings : TFinanceConnectSettings);
var s : String;
begin
  s := CreateSettingsXml(FinanceConnectSettings);
  s := Utf8ToString(d.roomerMainDataSet.downloadUrlAsStringUsingPut(d.roomerMainDataSet.RoomerUri + 'financeconnect', s));
end;

function TFinanceConnectService.RetrieveFinanceConnectKeypair(keyPairType: TKeyPairType): TKeyPairList;
var
  cursorWas : SmallInt;
  i, l: Integer;
  s: String;
  XmlElements : TFinanceXmlListElements;
begin
  cursorWas := Screen.Cursor;
  Screen.Cursor := crHourglass;
  Application.ProcessMessages;
  try
    case keyPairType of
      FKP_CUSTOMERS: begin
                       s := Utf8ToString(d.roomerMainDataSet.downloadUrlAsString(d.roomerMainDataSet.RoomerUri + 'financeconnect/customers'));
                       XmlElements := CustomerXmlElements;
                     end;
      FKP_PRODUCTS : begin
                       s := Utf8ToString(d.roomerMainDataSet.downloadUrlAsString(d.roomerMainDataSet.RoomerUri + 'financeconnect/items'));
                       XmlElements := ItemXmlElements;
                     end;
      FKP_VAT      : begin
                       s := Utf8ToString(d.roomerMainDataSet.downloadUrlAsString(d.roomerMainDataSet.RoomerUri + 'financeconnect/vatcodes'));
                       XmlElements := VatXmlElements;
                     end;
      FKP_PAYGROUPS: begin
                       s := Utf8ToString(d.roomerMainDataSet.downloadUrlAsString(d.roomerMainDataSet.RoomerUri + 'financeconnect/items'));
                       XmlElements := PayGroupsXmlElements;
                     end;
      FKP_CASHBOOKS: begin
                       s := Utf8ToString(d.roomerMainDataSet.downloadUrlAsString(d.roomerMainDataSet.RoomerUri + 'financeconnect/cashbooks'));
                       XmlElements := CashBooksXmlElements;
                     end;
    end;


    result := TKeyPairList.Create(True);
    ParseList(s, result, XmlElements);
  finally
    Screen.Cursor := cursorWas;
    Application.ProcessMessages;
  end;
end;

function TFinanceConnectService.RetrieveFinanceConnectAvailableSystems: TKeyPairList;
var
  cursorWas : SmallInt;
  i, l: Integer;
  s: String;
begin
  cursorWas := Screen.Cursor;
  Screen.Cursor := crHourglass;
  Application.ProcessMessages;
  try
    s := Utf8ToString(d.roomerMainDataSet.downloadUrlAsString(d.roomerMainDataSet.RoomerUri + 'financeconnect/availablesystems'));
    result := TKeyPairList.Create(True);
    ParseList(s, result, SystemsXmlElements);
  finally
    Screen.Cursor := cursorWas;
    Application.ProcessMessages;
  end;
end;

procedure TFinanceConnectService.RetrieveFinanceConnectMappings;

  procedure saveInMap(entity : String; LookupList : TKeyPairList);
  var KeyAndValue : TKeyAndValue;
  begin
    for KeyAndValue IN LookupList do
      MappingsLookupMap.AddOrSetValue(format('%s_%s', [entity, KeyAndValue.Key]), KeyAndValue.Value);
  end;

var
  cursorWas : SmallInt;
  s: String;
  LookupList : TKeyPairList;
  entity : String;

begin
  cursorWas := Screen.Cursor;
  Screen.Cursor := crHourglass;
  Application.ProcessMessages;
  try
    MappingsLookupMap := TObjectDictionary<String,String>.Create;
    for entity IN MAPPING_ENTITIES do
    begin
      if entity <> 'PAYTYPE' then
        try
          s := Utf8ToString(d.roomerMainDataSet.downloadUrlAsString(d.roomerMainDataSet.RoomerUri + 'financeconnect/mappings/' + entity));
          LookupList := TKeyPairList.Create(True);
          MappingsXmlElements.listName := format('%sMap', [LowerCase(entity)]);
          ParseList(s, LookupList, MappingsXmlElements);
          saveInMap(entity, LookupList);
        finally
          LookupList.Free;
        end;
    end;
  finally
    Screen.Cursor := cursorWas;
    Application.ProcessMessages;
  end;
end;

function TFinanceConnectService.FinanceConnectConfiguration : TFinanceConnectSettings;
var
  cursorWas : SmallInt;
  i, l: Integer;
  s: String;
begin
  cursorWas := Screen.Cursor;
  Screen.Cursor := crHourglass;
  Application.ProcessMessages;
  try
    s := Utf8ToString(d.roomerMainDataSet.downloadUrlAsString(d.roomerMainDataSet.RoomerUri + 'financeconnect/' + ActiveFinanceConnectSystemCode));
    FinanceConnectSettings := ParseSettings(s);
    result := FinanceConnectSettings;
  finally
    Screen.Cursor := cursorWas;
    Application.ProcessMessages;
  end;
end;

procedure TFinanceConnectService.MapForFinanceConnect(keyPairType: TKeyPairType; RoomerCode, ExternalCode : String);
var
  cursorWas : SmallInt;
  i, l: Integer;
  s, MapType: String;
begin
  cursorWas := Screen.Cursor;
  Screen.Cursor := crHourglass;
  Application.ProcessMessages;
  MapType := MAPPING_ENTITIES[keyPairType];
  try
    s := Utf8ToString(d.roomerMainDataSet.downloadUrlAsStringUsingPut(d.roomerMainDataSet.RoomerUri +
                      format(MAP_ENTITY_PATH, [MapType, RoomerCode, ExternalCode]), ''));
  finally
    Screen.Cursor := cursorWas;
    Application.ProcessMessages;
  end;
end;

procedure TFinanceConnectService.InitializeXmlElements;
begin
  CustomerXmlElements := TFinanceXmlListElements.Create('customers', 'customer', 'customerCode', 'customerName');
  ItemXmlElements := TFinanceXmlListElements.Create('items', 'item', 'itemCode', 'itemName');
  VatXmlElements := TFinanceXmlListElements.Create('vatCodes', 'vatCode', 'vatCode', 'vatName');
  PayGroupsXmlElements := TFinanceXmlListElements.Create('items', 'item', 'itemCode', 'itemName');
  CashBooksXmlElements := TFinanceXmlListElements.Create('cashBooks', 'book', 'bookCode', 'bookName');

  SystemsXmlElements := TFinanceXmlListElements.Create('availableSystems', 'systemCode', 'code', 'name');

  MappingsXmlElements := TFinanceXmlListElements.Create('%sMap', 'map', 'roomerCode', 'externalCode');

end;

function TFinanceConnectService.keyPairTypeByIndex(index : Integer) : TKeyPairType;
begin
  result := FKP_CUSTOMERS;
  case index of
    0 : result := FKP_CUSTOMERS;
    1 : result := FKP_PRODUCTS;
    2 : result := FKP_VAT;
    3 : result := FKP_PAYGROUPS;
  end;
end;

function TFinanceConnectService.MappingCaptionByIndex(keyPairType : TKeyPairType) : String;
begin
  result := '';
  case keyPairType of
    FKP_CUSTOMERS : result := 'CSTOMERS';
    FKP_PRODUCTS : result := 'PRODUCTS';
    FKP_VAT : result := 'VAT CODES';
    FKP_PAYGROUPS : result := 'PAY GROUPS';
  end;
end;


{ TFinanceXmlListElements }

constructor TFinanceXmlListElements.Create(list, root, code, description: String);
begin
  listName := list;
  rootName := root;
  codeName := code;
  descriptionName := description;
end;

/////////////////////////// Global methods ////////////////////////////////

procedure ClearFinanceConnectServices;
begin
  ActiveFinanceConnectSystemCode := '';
  ActiveFinanceConnectSystemName := '';

  FreeAndNil(CustomersLookupList);
  FreeAndNil(ItemsLookupList);
  FreeAndNil(VatsLookupList);
  FreeAndNil(PayGroupsBalanceAccountLookupList);
  FreeAndNil(PayGroupsCashBookLookupList);

  FreeAndNil(SystemsLookupList);

  FreeAndNil(MappingsLookupMap);
end;

{ TFinanceConnectSettings }

constructor TFinanceConnectSettings.Create(_systemActive: Boolean;
                         _cashBalanceAccount, _cashCode, _companyGuid, _hotelId, _invoiceCode, _officeCode, _organizationId,
  _password, _receivableBalanceAccount, _serviceUri, _systemCode, _usedCurrency, _username,
                         _preceedingInvoiceNumber,
                         _succeedingInvoiceNumber : String);
begin
  cashBalanceAccount := _cashBalanceAccount;
  cashCode := _cashCode;
  companyGuid := _companyGuid;
  hotelId := _hotelId;
  invoiceCode := _invoiceCode;
  officeCode := _officeCode;
  organizationId := _organizationId;
  password := _password;
  receivableBalanceAccount := _receivableBalanceAccount;
  serviceUri := _serviceUri;
  systemActive := _systemActive;
  systemCode := _systemCode;
  usedCurrency := _usedCurrency;
  username := _username;
  preceedingInvoiceNumber := _preceedingInvoiceNumber;
  succeedingInvoiceNumber := _succeedingInvoiceNumber;
end;

initialization
  ClearFinanceConnectServices;

finalization
  ClearFinanceConnectServices;

end.