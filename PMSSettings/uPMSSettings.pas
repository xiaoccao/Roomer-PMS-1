unit uPMSSettings;

interface

uses
  SysUtils
  , cmpRoomerDataset
  , uMandatoryFIeldDefinitions
  ;

type

  EPMSSettingsKeyValueNotFound = class(Exception);


  /// <summary>
  ///   Provides access to PMS configuration-items stored in PMSSettings table in database
  /// </summary>
  TPMSSettings = class
  private
    FPMSDataset: TRoomerDataset;
    procedure PutSettingsValue(KeyGroup, Key, Value: String; CreateIfNotExists : Boolean = False);
    function GetSettingsAsBoolean(KeyGroup, Key : String; ExceptionOnNotFound : Boolean = false; Default : Boolean = False) : Boolean;
    procedure SetSettingsAsBoolean(KeyGroup, Key: String; Value : Boolean; CreateIfNotExists: Boolean = False);
    function GetSettingsAsInteger(KeyGroup, Key : String; ExceptionOnNotFound : Boolean = false; Default : Integer = 0) : Integer;
    procedure SetSettingsAsInteger(KeyGroup, Key : String; Value : Integer; CreateIfNotExists : Boolean = False);
    function GetSettingsAsString(KeyGroup, Key : String; ExceptionOnNotFound : Boolean = false; Default : String = '') : String;
    procedure SetSettingsAsString(KeyGroup, Key : String; Value : String; CreateIfNotExists : Boolean = False);

    function GetMandatoryCheckinFields: TMandatoryCheckInFieldSet;
    procedure SetMandatoryCheckinFields(const Value: TMandatoryCheckInFieldSet);
    function GetBetaFunctionsAvailable: boolean;
    procedure SetBetaFunctionsAvailable(const Value: boolean);
    function GetEditAllGuestsNationality: boolean;
    procedure SetEditAllGuestsNationality(const Value: boolean);
    function GetShowInvoiceAsPaidWhenStatusIsZero: boolean;
    procedure SetShowInvoiceAsPaidWhenStatusIsZero(const Value: boolean);
    function GetShowIncludedBreakfastOnInvoice: boolean;
    procedure SetShowIncludedBreakfastOnInvoice(const Value: boolean);
    function GetAllowPaymentModification: boolean;
    procedure SetAllowPaymentModification(const Value: boolean);
    function GetAllowDeletingItemsFromInvoice: boolean;
    procedure SetAllowDeletingItemsFromInvoice(const Value: boolean);
    function GetTopClassAvaiabilityOrderActive: boolean;
    procedure SetTopClassAvaiabilityOrderActive(const Value: boolean);
    function GetMasterRateDefaultsActive: boolean;
    procedure SetMasterRateDefaultsActive(const Value: boolean);
    function GetMasterRateCurrency: String;
    procedure SetMasterRateCurrency(const Value: String);
    function GetMasterRateCurrencyConvert: boolean;
    procedure SetMasterRateCurrencyConvert(const Value: boolean);
    function GetAllowTogglingOfCityTaxes: boolean;
    procedure SetAllowTogglingOfCityTaxes(const Value: boolean);

  public
    constructor Create(aPMSDataset: TRoomerDataset);

    /// <summary>
    ///   Currently enabled TMandatoryCheckinFields in PMS settings
    /// </summary>
    property MandatoryCheckinFields: TMandatoryCheckInFieldSet read GetMandatoryCheckinFields write SetMandatoryCheckinFields;
    /// <summary>
    ///   If true then functions marked as Beta are available in the PMS
    /// </summary>
    property BetaFunctionsAvailable: boolean read GetBetaFunctionsAvailable write SetBetaFunctionsAvailable;
    /// <summary>
    ///   If true then the reservation profile window contains function to change nationality of all guests
    /// </summary>
    property EditAllGuestsNationality: boolean read GetEditAllGuestsNationality write SetEditAllGuestsNationality;
    /// <summary>
    ///   If true then the room will appear as paid in the main-window of Roomer when the invoice balance for the Room-rent is zero
    /// </summary>
    property ShowInvoiceAsPaidWhenStatusIsZero: boolean read GetShowInvoiceAsPaidWhenStatusIsZero write SetShowInvoiceAsPaidWhenStatusIsZero;
    property ShowIncludedBreakfastOnInvoice: boolean read GetShowIncludedBreakfastOnInvoice write SetShowIncludedBreakfastOnInvoice;

    property AllowPaymentModification: boolean read GetAllowPaymentModification write SetAllowPaymentModification;
    property AllowDeletingItemsFromInvoice: boolean read GetAllowDeletingItemsFromInvoice write SetAllowDeletingItemsFromInvoice;
    property AllowTogglingOfCityTaxes: boolean read GetAllowTogglingOfCityTaxes write SetAllowTogglingOfCityTaxes;


    property TopClassAvaiabilityOrderActive: boolean read GetTopClassAvaiabilityOrderActive write SetTopClassAvaiabilityOrderActive;
    property MasterRateDefaultsActive: boolean read GetMasterRateDefaultsActive write SetMasterRateDefaultsActive;
    property MasterRateCurrency: String read GetMasterRateCurrency write SetMasterRateCurrency;
    property MasterRateCurrencyConvert: boolean read GetMasterRateCurrencyConvert write SetMasterRateCurrencyConvert;

  end;

implementation

uses
  Variants
  , uUtils
  , hData
  ;

const
  cBetaFunctionsGroup = 'BETA_FUNCTIONS';
  cAllGuestsNationalityGroup = 'RESERVATIONPROFILE_FUNCTIONS';
  cInvoiceHandlingGroup = 'INVOICE_HANDLING_FUNCTIONS';
  cRatesAndAvailabilitiesGroup = 'RATES_AND_AVAILABILITY_FUNCTIONS';

  cBetaFunctionsAvailableName = 'BETA_FUNCTIONS_AVAILABLE';
  cAllGuestsNationality = 'EDIT_ALLGUESTS_NATIONALITY';
  cInvoiceHandlingShowAsPaidWhenZero = 'SHOW_AS_PAID_WHEN_ZERO';
  cAllowPaymentModifications = 'ALLOW_PAYMENT_MODIFICATIONS';
  cAllowDeletingItemsFromInvoice = 'ALLOW_DELETING_FROM_INVOICE';
  cAllowTogglingOfCityTaxes = 'ALLOW_TOGGLING_OF_CITY_TAXES_INVOICE';
  cShowIncludedBreakfastOnInvoice = 'SHOW_INCLUDED_BREAKFAST_ON_INVOICE';
  cTopClassAvailabilityOrderActive = 'TOP_CLASS_AVAILABILITY_ORDER_ACTIVE';
  cMasterRateDefaultsActive = 'MASTER_RATE_DEFAULTS_ACTIVE';
  cMasterRateCurrency = 'MASTER_RATE_CURRENCY';
  cMasterRateCurrencyActive = 'MASTER_RATE_CURRENCY_CONERT_ACTIVE';

procedure TPmsSettings.PutSettingsValue(KeyGroup, Key, Value : String; CreateIfNotExists : Boolean = False);
begin
  if FPMSDataset.Locate('KeyGroup;key', VarArrayOf([KeyGroup, Key]), []) then
  begin
    FPMSDataset.Edit;
    try
      FPMSDataset['value'] := Value;
      FPMSDataset.Post;
    except
      FPMSDataset.Cancel;
      raise;
    end;
  end else
  if CreateIfNotExists then
  begin
    FPMSDataset.Insert;
    try
      FPMSDataset['KeyGroup'] := KeyGroup;
      FPMSDataset['Key'] := Key;
      FPMSDataset['value'] := Value;
      FPMSDataset.Post;
    except
      FPMSDataset.Cancel;
      raise;
    end;
  end;
end;

constructor TPmsSettings.Create(aPMSDataset: TRoomerDataset);
begin
  FPMSDataset := aPMSDataset;
end;

function TPmsSettings.GetSettingsAsBoolean(KeyGroup, Key : String; ExceptionOnNotFound : Boolean = false; Default : Boolean = False) : Boolean;
begin
  result := Default;
  if FPMSDataset.Locate('KeyGroup;key', VarArrayOf([KeyGroup, Key]), []) then
    result := FPMSDataset['value'] = 'TRUE'
  else
    if ExceptionOnNotFound then
      raise EPMSSettingsKeyValueNotFound.Create('Key ' + Key + ' was not found in settings.');
end;

function TPmsSettings.GetSettingsAsInteger(KeyGroup, Key : String; ExceptionOnNotFound : Boolean = false; Default : Integer = 0) : Integer;
begin
  result := Default;
  if FPMSDataset.Locate('KeyGroup;key', VarArrayOf([KeyGroup, Key]), []) then
    result := StrToIntDef(FPMSDataset['value'], Default)
  else
    if ExceptionOnNotFound then
      raise EPMSSettingsKeyValueNotFound.Create('Key ' + Key + ' was not found in settings.');
end;


procedure TPmsSettings.SetSettingsAsInteger(KeyGroup, Key : String; Value : Integer; CreateIfNotExists : Boolean = False);
begin
  PutSettingsValue(KeyGroup, Key, IntToStr(Value), CreateIfNotExists);
end;


function TPmsSettings.GetSettingsAsString(KeyGroup, Key : String; ExceptionOnNotFound : Boolean = false; Default : String = '') : String;
begin
  result := Default;
  if FPMSDataset.Locate('KeyGroup;key', VarArrayOf([KeyGroup, Key]), []) then
    result := FPMSDataset['value']
  else
    if ExceptionOnNotFound then
      raise EPMSSettingsKeyValueNotFound.Create('Key ' + Key + ' was not found in settings.');
end;

procedure TPmsSettings.SetSettingsAsString(KeyGroup, Key : String; Value : String; CreateIfNotExists : Boolean = False);
begin
  PutSettingsValue(KeyGroup, Key, Value, CreateIfNotExists);
end;

procedure TPmsSettings.SetSettingsAsBoolean(KeyGroup, Key : String; Value : Boolean; CreateIfNotExists : Boolean = False);
begin
  PutSettingsValue(KeyGroup, Key, IIF(Value, 'TRUE', 'FALSE'), CreateIfNotExists);
end;

procedure TPMSSettings.SetAllowDeletingItemsFromInvoice(const Value: boolean);
begin
  SetSettingsAsBoolean(cInvoiceHandlingGroup, cAllowDeletingItemsFromInvoice, Value, True);
end;

procedure TPMSSettings.SetAllowPaymentModification(const Value: boolean);
begin
  SetSettingsAsBoolean(cInvoiceHandlingGroup, cAllowPaymentModifications, Value, True);
end;

procedure TPMSSettings.SetAllowTogglingOfCityTaxes(const Value: boolean);
begin
  SetSettingsAsBoolean(cInvoiceHandlingGroup, cAllowTogglingOfCityTaxes, Value, True);
end;

procedure TPmsSettings.SetBetaFunctionsAvailable(const Value: boolean);
begin
  SetSettingsAsBoolean(cBetaFunctionsGroup, cBetaFunctionsAvailableName, Value, True);
end;

procedure TPMSSettings.SetEditAllGuestsNationality(const Value: boolean);
begin
  SetSettingsAsBoolean(cAllGuestsNationalityGroup, cAllGuestsNationality, Value, True);
end;

procedure TPMSSettings.SetShowIncludedBreakfastOnInvoice(const Value: boolean);
begin
  SetSettingsAsBoolean(cInvoiceHandlingGroup, cShowIncludedBreakfastOnInvoice, Value, True);
end;

procedure TPMSSettings.SetShowInvoiceAsPaidWhenStatusIsZero(const Value: boolean);
begin
  SetSettingsAsBoolean(cInvoiceHandlingGroup, cInvoiceHandlingShowAsPaidWhenZero, Value, True);
end;

procedure TPMSSettings.SetTopClassAvaiabilityOrderActive(const Value: boolean);
begin
  SetSettingsAsBoolean(cRatesAndAvailabilitiesGroup, cTopClassAvailabilityOrderActive, Value, True);
end;

procedure TPmsSettings.SetMandatoryCheckinFields(const Value: TMandatoryCheckInFieldSet);
var
  lMF: TMandatoryCheckinField;
begin
  for lMF := low(lMF) to high(lMF) do
    SetSettingsAsBoolean(lMF.PMSSettingGroup, lMF.PMSSettingName, (lMF in Value), True);
end;

procedure TPMSSettings.SetMasterRateCurrency(const Value: String);
begin
  SetSettingsAsString(cRatesAndAvailabilitiesGroup, cMasterRateCurrency, Value, True);
end;

procedure TPMSSettings.SetMasterRateCurrencyConvert(const Value: boolean);
begin
  SetSettingsAsBoolean(cRatesAndAvailabilitiesGroup, cMasterRateCurrencyActive, Value, True);
end;

procedure TPMSSettings.SetMasterRateDefaultsActive(const Value: boolean);
begin
  SetSettingsAsBoolean(cRatesAndAvailabilitiesGroup, cMasterRateDefaultsActive, Value, True);
end;

function TPMSSettings.GetAllowDeletingItemsFromInvoice: boolean;
begin
  Result := GetSettingsAsBoolean(cInvoiceHandlingGroup , cAllowDeletingItemsFromInvoice, False, True);
end;

function TPMSSettings.GetAllowPaymentModification: boolean;
begin
  Result := GetSettingsAsBoolean(cInvoiceHandlingGroup , cAllowPaymentModifications, False, True);
end;

function TPMSSettings.GetAllowTogglingOfCityTaxes: boolean;
begin
  Result := GetSettingsAsBoolean(cInvoiceHandlingGroup, cAllowTogglingOfCityTaxes, False, True);
end;

function TPmsSettings.GetBetaFunctionsAvailable: boolean;
begin
  Result := GetSettingsAsBoolean(cBetaFunctionsGroup , cBetaFunctionsAvailableName, False, False );
end;

function TPMSSettings.GetEditAllGuestsNationality: boolean;
begin
  Result := GetSettingsAsBoolean(cAllGuestsNationalityGroup, cAllGuestsNationality, False, True );
end;

function TPMSSettings.GetShowIncludedBreakfastOnInvoice: boolean;
begin
  Result := GetSettingsAsBoolean(cInvoiceHandlingGroup, cShowIncludedBreakfastOnInvoice, False, False);
end;

function TPMSSettings.GetShowInvoiceAsPaidWhenStatusIsZero: boolean;
begin
  Result := GetSettingsAsBoolean(cInvoiceHandlingGroup, cInvoiceHandlingShowAsPaidWhenZero, False);
end;

function TPMSSettings.GetTopClassAvaiabilityOrderActive: boolean;
begin
  Result := GetSettingsAsBoolean(cRatesAndAvailabilitiesGroup, cTopClassAvailabilityOrderActive, False, False);
end;

function TPmsSettings.GetMandatoryCheckinFields: TMandatoryCheckInFieldSet;
var
  lMF: TMandatoryCheckinField;
begin
  Result := [];
  for lMF := low(lMF) to high(lMF) do
    if GetSettingsAsBoolean(lMF.PMsSettingGroup, lMF.PMSSettingName, False, True) then
      Include(Result, lMF);
end;

function TPMSSettings.GetMasterRateCurrency: String;
begin
  Result := GetSettingsAsString(cRatesAndAvailabilitiesGroup, cMasterRateCurrency, False, ctrlGetString('NativeCurrency'));
end;

function TPMSSettings.GetMasterRateCurrencyConvert: boolean;
begin
  Result := GetSettingsAsBoolean(cRatesAndAvailabilitiesGroup, cMasterRateCurrencyActive, False, False);
end;

function TPMSSettings.GetMasterRateDefaultsActive: boolean;
begin
  Result := GetSettingsAsBoolean(cRatesAndAvailabilitiesGroup, cMasterRateDefaultsActive, False, False);
end;

end.
