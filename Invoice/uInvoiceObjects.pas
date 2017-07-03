unit uInvoiceObjects;

interface

uses
  Generics.Collections
  , uInvoiceEntities
  , hData
  ;

type
  /// <summary>
  /// Object attached to a gridline of the invoiceform, containing all Invoice related info shown in that gridline
  /// Notice that all amounts are in hotel-native currency
  // TODO: Merge this class with TInvoiceItemEntity
  /// </summary>
  /// <remarks>
  /// Example of influence of properties VisibleOnInvoice and TotalIsIncludedInParent:
  ///
  /// Room 1000,= 5% vat, Breakfast 30,= 10% vat
  ///
  /// |  Visible | Included | Room | Brkf | Room | Brkf | Room | Brkf | Room | Brkf |
  /// |          |          | Inv  | Inv  | Rev  | Rev  | VAT  | VAT  | VAT  | VAT  |
  /// |          |          |      |      |      |      | inv  | inv  | rev  | rev  |
  /// =============================================================================
  /// |    F     |    F     | 1030 |    0 | 1000 |   30 | 53   |   0  | 50   |   3  |
  /// |    F     |    T     | 1000 |    0 |  970 |   30 | 51,5 |   0  | 48,5 |   3  |
  /// |    T     |    T     |  970 |   30 |  970 |   30 | 48,5 |   3  | 48,5 |   3  |
  /// |    T     |    F     | 1000 |   30 | 1000 |   30 | 50   |   3  | 50   |   3  |
  ///
  /// </remarks>
  {$M+}
  TInvoiceLine = class(TObject)
  strict private
    FInvoiceLineIndex: integer;
    FItem: string;
    FText: string;
    FNumber: Double; // -96
    FPrice: Double;
    FTotal: Double;
    FDate: TDate;
    FAuto: boolean;
    FReference: string;
    FSource: string;
    FIspackage: boolean;
    FNoGuests: integer;
    FConfirmDate: TDateTime;
    FConfirmAmount: Double;
    FitemIndex: integer;
    FrrAlias: integer;
    FAutoGen: string;
    FLineId: integer;
    FVisibleOnInvoice: boolean;
    FVATCode: string;
    FVATPercentage: Double;
    FParentInvoiceLine: TInvoiceLine;
    FChildInvoiceLines: TList<TInvoiceLine>;
    FROomEntity: TInvoiceRoomEntity;
    FInvoiceNumber: integer;
    FChanged: boolean;
    FCurrency: string;
    FTotalIsIncludedInParent: boolean;

  private
    function GetRevenueNativeCurrency: Double;
    function GetAmountOnInvoice: Double;
    function GetTotal: Double;
    function GetVatOnRevenueNativeCurrency: Double;
    procedure GetPurchaseDate(const Value: TDate);
    function GetItemKind: TItemKind;
    function GetVatOnInvoice: Double;
    procedure SetVATCode(const Value: string);
    function GetTotalNativeCurrency: Double;
    function GetPriceNativeCurrency: Double;
    function GetAmountOnInvoiceNativeCurrency: Double;
    function GetVatOnInvoiceNativeCurrency: Double;
    function GetPrice: Double;
    function GetPriceOnInvoice: Double;
    function GetPriceOnInvoiceNativeCurrency: Double;
    function GetTotalRevenue: Double;
    function GetRevenuePrice: Double;
    function GetParentReservation: integer;
    function GetParentRoomReservation: integer;
    procedure SetParentInvoiceLine(const Value: TinvoiceLine);
  protected
    function GetAmountIncludedInParent: double; virtual;
    function GetIsGenerated: boolean; virtual;
  public
    constructor Create(aIndex, _id: integer); virtual;
    destructor Destroy; override;
    /// <summary>
    /// Indicates whether or not the "VisibleOnInvoice" functionality is available for this line
    /// At this moment only line that are generated and linked to a roomrent item can be made invisible
    /// </summary>
    function CanBeHiddenFromInvoice: boolean; virtual;
    property TotalNativeCurrency: Double read GetTotalNativeCurrency;
    /// <summary>
    /// Revenue total in selected currency, including VAT for this item, calculated as Price * Number
    /// </summary>
    property Total: Double read GetTotal;
    /// <summary>
    /// Amount which will be visible on the invoice in selected currency.
    /// Dependent on the VisibleOnInvoice property and on ChildInvoiceLines which are not visible on the invoice
    /// See table in class documentation
    /// </summary>
    property AmountOnInvoice: Double read GetAmountOnInvoice;
    property AmountOnInvoiceNativeCurrency: Double read GetAmountOnInvoiceNativeCurrency;
    /// <summary>
    ///   The Native amount that will be added to the InvoiceAmount of a Parent
    /// </summary>
    property AmountIncludedInParent: double read GetAmountIncludedInParent;
    /// <summary>
    /// Price which will be visible on the invoice in selected currency. Calculated as AmountOnInvoice / Number
    /// </summary>
    property PriceOnInvoice: Double read GetPriceOnInvoice;
    property PriceOnInvoiceNativeCurrency: Double read GetPriceOnInvoiceNativeCurrency;

    property RevenuePrice: Double read GetRevenuePrice;
    /// <summary>
    /// Total administrative revenue for this item, in selected currency
    /// Consists of the Total minus the total of all not-visible childlines
    /// See table in class documentation
    /// </summary>
    property TotalRevenue: Double read GetTotalRevenue;
    /// <summary>
    /// Total administrative revenue for this item, in native currency
    /// Consists of the Total minus the total of all not-visible childlines
    /// See table in class documentation
    /// </summary>
    property RevenueNativeCurrency: Double read GetRevenueNativeCurrency;
    /// <summary>Order index of line in invoice</summary>
    property InvoiceLineIndex: integer read FInvoiceLineIndex write FInvoiceLineIndex;
    /// <summary>This invoicelines "belongs" to or a child of invoicelines with this InvoicelineIndex </summary>
    property Parent: TinvoiceLine read FParentInvoiceLine write SetParentInvoiceLine;
    /// <summary>
    /// List of TInvoiceLineItems that are derived from this line. If any of these child lines are not VisibleOnInvoice then
    /// their invoice-totals are added to the parent line
    /// </summary>
    property ChildInvoiceLines: TList<TInvoiceLine> read FChildInvoiceLines;
    property RoomEntity: TInvoiceRoomEntity read FROomEntity write FROomEntity;

    property ItemKind: TItemKind read GetItemKind;
    /// <summary>
    /// Calculated VAT based on revenue of this item, in native currency
    /// See table in class documentation
    /// </summary>
    property VATOnRevenueNativeCurrency: Double read GetVatOnRevenueNativeCurrency;
    /// <summary>
    /// Calculated VAT on the invoice for this item, in selected currency
    /// See table in class documentation
    /// </summary>
    property VATOnInvoice: Double read GetVatOnInvoice;
    /// <summary>
    /// Calculated VAT on the invoice for this item, in native currency
    /// See table in class documentation
    /// </summary>
    property VATOnInvoiceNativeCurrency: Double read GetVatOnInvoiceNativeCurrency;
    property PriceNativeCurrency: Double read GetPriceNativeCurrency;
    property Changed: boolean read FChanged write FChanged;
    property ParentReservation: integer read GetParentReservation;
    property ParentRoomReservation: integer read GetParentRoomReservation;
  published
    /// <summary>Id in invoicelines table of this invoiceline item, if <= 0 then this invoiceline instance does not have
    /// a record in the table invoicelines </summary>
    property LineId: integer read FLineId write FLineId;
    property InvoiceNumber: integer read FInvoiceNumber write FInvoiceNumber;
    property Item: string read FItem write FItem;
    property Text: string read FText write FText;

    /// <summary>
    /// Number of (or quantity) items for this invoiceline
    /// </summary>
    property Number: Double read FNumber write FNumber;
    /// <summary>
    /// Price per item in selected currency
    /// </summary>
    property Price: Double read GetPrice write FPrice;
    /// <summary>
    /// Selected currency for this invoiceline
    /// </summary>
    property Currency: string read FCurrency write FCurrency;
    property VATCode: string read FVATCode write SetVATCode;
    property VATPercentage: Double read FVATPercentage;
    property Reference: string read FReference write FReference;
    property Source: string read FSource write FSource;
    property isPackage: boolean read FIspackage write FIspackage;
    property noGuests: integer read FNoGuests write FNoGuests;
    property ConfirmDate: TDateTime read FConfirmDate write FConfirmDate;
    property ConfirmAmount: Double read FConfirmAmount write FConfirmAmount;
    property itemIndex: integer read FitemIndex write FitemIndex;
    property Roomreservation: integer read FrrAlias write FrrAlias;
    property PurchaseDate: TDate read FDate write GetPurchaseDate;
    /// <summary>
    /// True if this line has not been retrieved from the invoicelines table but is generated based on i.e. roomsdate
    /// </summary>
    property IsGeneratedLine: boolean read GetIsGenerated write FAuto;
    property AutoGen: string read FAutoGen write FAutoGen;
    /// <summary>
    /// True if this line should be printed on the actual invoice. This setting influences the amounts on invoice, revenues and calculated VAT
    /// for this line and its parentline (if present)
    /// </summary>
    property VisibleOnInvoice: boolean read FVisibleOnInvoice write FVisibleOnInvoice;
    /// <summary>
    /// If true then the total amount of this invoicelineitem is originally included in its parent
    /// When this line is set VisibleOnInvoice then the amount of the parent will be decreased with the amount of this line
    /// </summary>
    property TotalIsIncludedInParent: boolean read FTotalIsIncludedInParent write FTotalIsIncludedInParent;
  end;

  /// <summary>
  ///   Extension of a standard invoiceline for package items
  ///  Extensions include:
  ///   - Package invoice line can have multiple parent lines
  ///   - When not visible on the invoice, the amount on invoice is distributed equally over all the parents
  /// </summary>
  TPackageInvoiceLine = class(TInvoiceLine)
  private
    FParentList: TList<TInvoiceline>;
  protected
    function GetIsGenerated: boolean; override;
    function GetAmountIncludedInParent: double; override;
  public
    constructor Create(aIndex, _id: integer); override;
    destructor Destroy; override;

    function CanBeHiddenFromInvoice: boolean; override;

    procedure AddParent(aParent: TInvoiceLine);
    procedure RemoveParent(aParent: TInvoiceLine);
    procedure ClearParentsList;
    procedure AddParentsForRoomreservation(aRoomRes: integer);

  end;

  // TODO Refactor into TCollection, so CollectionItems can call functions from this collection
  TInvoiceLineList = class(TObjectlist<TInvoiceLine>)
  private
    function GetTotalOnInvoiceNativeCurrency: Double;
    function GetTotalVatOnInvoice: Double;
    function GetTotalCityTaxRevenues: Double;
    function GetIsChanged: boolean;
    function GetCityTaxUnitCount: Double;
    function GetLastLineIndex: integer;
  public
    function AddInvoiceLine(aLineId: integer; aParent: TInvoiceLine): TInvoiceLine;
    function AddPackageInvoiceLine(aLineId: integer; aParent: TInvoiceLine; aRoomreservation:integer): TPackageInvoiceLine;

    procedure SetAllVisibleOnInvoiceTo(aVisible: boolean; aItemKindSet: TItemKindSet = [ikRoomRentDiscount, ikStayTax, ikBreakfast]);
    procedure SortOnInvoiceLineIndex;
    /// <summary>
    /// Calculate the total native amount including VAT
    /// </summary>
    property TotalOnInvoiceNativeCurrency: Double read GetTotalOnInvoiceNativeCurrency;
    /// <summary>
    /// Calculate the total sum of VAT in native currency
    /// </summary>
    property TotalVatOnInvoiceNativeCurrency: Double read GetTotalVatOnInvoice;
    property TotalCityTaxRevenues: Double read GetTotalCityTaxRevenues;
    property CityTaxUnitCount: Double read GetCityTaxUnitCount;
    property IsChanged: boolean read GetIsChanged;
  end;


implementation

uses
  uG
  , _Glob
  , uD
  , System.Generics.Defaults
  , Math
  ;

{ TInvoiceLine }
function TInvoiceLine.CanBeHiddenFromInvoice: boolean;
begin
  result := (Item <> g.qRoomRentItem) and IsGeneratedLine and assigned(Parent);
end;

constructor TInvoiceLine.Create(aIndex, _id: integer);
begin
  inherited Create;

  FInvoiceLineIndex := aIndex;
  FVisibleOnInvoice := True;
  FInvoiceNumber := -1;
  FLineId := _id;
  FItem := '';
  FText := '';
  FNumber := 0;
  FPrice := 0.00;
  FTotal := 0.00;
  FReference := '';
  FSource := '';
  FChildInvoiceLines := TList<TInvoiceLine>.Create;
  FCurrency := g.qNativeCurrency;
end;

destructor TInvoiceLine.Destroy;
begin
  Parent := nil;
  FChildInvoiceLines.Free;
  inherited Destroy;
end;

function TInvoiceLine.GetAmountIncludedInParent: double;
begin
  Result := 0;
  if VisibleOnInvoice and TotalIsIncludedInParent then
    result := - TotalNativeCurrency
  else if not VisibleOnInvoice and not TotalIsIncludedInParent then
    result := TotalNativeCurrency;
end;

function TInvoiceLine.GetAmountOnInvoice: Double;
begin
  result := GetAmountOnInvoiceNativeCurrency / GetRate(FCurrency);
end;

function TInvoiceLine.GetAmountOnInvoiceNativeCurrency: Double;
var
  lChild: TInvoiceLine;
begin
  if FVisibleOnInvoice then
  begin
    result := TotalNativeCurrency;
    for lChild in FChildInvoiceLines do
        result := result + lChild.AmountIncludedInParent; //lChild.TotalNativeCurrency;
  end
  else
    result := 0;
end;

function TInvoiceLine.GetIsGenerated: boolean;
begin
  Result := FAuto;
end;

function TInvoiceLine.GetItemKind: TItemKind;
begin
  result := Item_GetKind(Item);
end;

function TInvoiceLine.GetParentReservation: integer;
begin
  if assigned(Parent) and assigned(Parent.RoomEntity) then
    Result := Parent.RoomEntity.Reservation
  else
    Result := -1;
end;

function TInvoiceLine.GetParentRoomReservation: integer;
begin
  if assigned(Parent) and assigned(Parent.RoomEntity) then
    Result := Parent.RoomEntity.RoomReservation
  else
    Result := -1;
end;

function TInvoiceLine.GetPrice: Double;
begin
  result := FPrice;
end;

function TInvoiceLine.GetPriceNativeCurrency: Double;
begin
  result := Price * GetRate(FCurrency);
end;

function TInvoiceLine.GetPriceOnInvoice: Double;
begin
  result := AmountOnInvoice / Number;
end;

function TInvoiceLine.GetPriceOnInvoiceNativeCurrency: Double;
begin
  result := AmountOnInvoiceNativeCurrency / Number;
end;

procedure TInvoiceLine.GetPurchaseDate(const Value: TDate);
begin
  FDate := Value
end;

function TInvoiceLine.GetRevenueNativeCurrency: Double;
var
  lInvLine: TInvoiceLine;
begin
  result := TotalNativeCurrency;
  for lInvLine in FChildInvoiceLines do
    if lInvLine.TotalIsIncludedInParent then
      result := result - lInvLine.TotalNativeCurrency;
end;

function TInvoiceLine.GetRevenuePrice: Double;
begin
  Result := TotalRevenue / Number;
end;

function TInvoiceLine.GetTotal: Double;
begin
  result := FNumber * FPrice;
end;

function TInvoiceLine.GetTotalNativeCurrency: Double;
begin
  result := Total * GetRate(FCurrency);
end;

function TInvoiceLine.GetTotalRevenue: Double;
var
  lInvLine: TInvoiceLine;
begin
  result := Total;
  for lInvLine in FChildInvoiceLines do
    if lInvLine.TotalIsIncludedInParent then
      result := result - lInvLine.Total;
end;

function TInvoiceLine.GetVatOnInvoice: Double;
begin
  result := GetVatOnInvoiceNativeCurrency / GetRate(FCurrency);
end;

function TInvoiceLine.GetVatOnInvoiceNativeCurrency: Double;
var
  lInvLine: TInvoiceLine;
begin
  result := 0;
  if VisibleOnInvoice then
  begin
    result := VATOnRevenueNativeCurrency;
    for lInvLine in ChildInvoiceLines do
      if not lInvLine.VisibleOnInvoice then
        result := result + lInvLine.VATOnRevenueNativeCurrency;
  end;
end;

function TInvoiceLine.GetVatOnRevenueNativeCurrency: Double;
begin
  result := _calcVat(TotalNativeCurrency, FVATPercentage);
end;

procedure TInvoiceLine.SetParentInvoiceLine(const Value: TinvoiceLine);
begin
  if FParentInvoiceLine <> nil then
    FParentInvoiceLine.ChildInvoiceLines.Remove(Self);

  if assigned(Value) then
      Value.ChildInvoiceLines.Add(self);

  FParentInvoiceLine := Value;
end;

procedure TInvoiceLine.SetVATCode(const Value: string);
begin
  FVATCode := Value;
  if FVATCode = '' then
    FVATPercentage := 0
  else
    FVATPercentage := d.VATPercentage(FVATCode);
end;

{ TInvoiceLineList }

function TInvoiceLineList.AddInvoiceLine(aLineId: integer; aParent: TInvoiceLine): TInvoiceLine;
begin
  Result := TInvoiceLine.Create(aLineId, GetLastLineIndex+1);
  Result.Parent := aParent;
  Add(Result);
end;

function TInvoiceLineList.GetLastLineIndex: integer;
var
  lInvLine: TInvoiceLine;
begin
  Result := 0;
  for lInvLine in Self do
    Result := max(Result, linvLine.InvoiceLineIndex);
end;

function TInvoiceLineList.AddPackageInvoiceLine(aLineId: integer; aParent: TInvoiceLine; aRoomreservation: integer): TPackageInvoiceLine;
var
  lInvLine: TInvoiceLine;
begin
  Result := TPackageInvoiceLine.Create(aLineId, GetLastLineIndex+1);
  Result.Parent := aParent;
  Add(Result);

  if not assigned(aParent) and (aRoomReservation > 0) then
    for lInvLine in Self do
      if (lInvLine.ItemKind = ikRoomRent) and (linvLine.RoomEntity.RoomReservation = aRoomreservation) then
        Result.AddParent(lInvLine);
end;

function TInvoiceLineList.GetCityTaxUnitCount: Double;
var
  lInvLine: TInvoiceLine;
begin
  result := 0;
  for lInvLine in self do
    if lInvLine.ItemKind = ikStayTax then
      result := result + lInvLine.Number;
end;

function TInvoiceLineList.GetIsChanged: boolean;
var
  lInvLine: TInvoiceLine;
begin
  result := false;
  for lInvLine in self do
    result := result or lInvLine.Changed;
end;

function TInvoiceLineList.GetTotalCityTaxRevenues: Double;
var
  lInvLine: TInvoiceLine;
begin
  result := 0.0;
  for lInvLine in self do
    if (lInvLine.ItemKind = ikStayTax) then
      result := result + lInvLine.TotalNativeCurrency;
end;

function TInvoiceLineList.GetTotalOnInvoiceNativeCurrency: Double;
var
  lInvLine: TInvoiceLine;
begin
  result := 0.0;
  for lInvLine in self do
    result := result + (lInvLine.AmountOnInvoice * GetRate(lInvLine.Currency));
end;

function TInvoiceLineList.GetTotalVatOnInvoice: Double;
var
  lInvLine: TInvoiceLine;
begin
  result := 0.0;
  for lInvLine in self do
    result := result + (lInvLine.VATOnInvoice * GetRate(lInvLine.Currency));
end;

procedure TInvoiceLineList.SetAllVisibleOnInvoiceTo(aVisible: boolean; aItemKindSet: TItemKindSet);
var
  lInvLine: TInvoiceLine;
begin
  for lInvLine in self do
    if linvLine.CanBeHiddenFromInvoice and (lInvLine.ItemKind in aItemKindSet) then
    begin
      linvLine.VisibleOnInvoice := aVisible;
      lInvLine.Changed := true
    end;
end;

procedure TInvoiceLineList.SortOnInvoiceLineIndex;
begin
  Sort(TComparer<TInvoiceLine>.Construct(
    function(const l, R: TInvoiceLine): integer
    begin
      result := l.InvoiceLineIndex - R.InvoiceLineIndex;
    end));
end;

{ TPackageInvoiceLine }

procedure TPackageInvoiceLine.AddParent(aParent: TInvoiceLine);
begin
  if assigned(aParent) then
      aParent.ChildInvoiceLines.Add(self);

  FParentList.Add(aParent);
end;

procedure TPackageInvoiceLine.AddParentsForRoomreservation(aRoomRes: integer);
begin
  ClearParentsList;

end;

function TPackageInvoiceLine.CanBeHiddenFromInvoice: boolean;
begin
  Result := false;
end;

procedure TPackageInvoiceLine.ClearParentsList;
var
  i: integer;
begin
  for i := FParentList.count-1 downto 0 do
    RemoveParent(FParentList[i]);
end;

constructor TPackageInvoiceLine.Create(aIndex, _id: integer);
begin
  inherited;
  FParentList := TList<TInvoiceLine>.Create;
end;

destructor TPackageInvoiceLine.Destroy;
begin
  ClearParentsList;
  FParentList.Free;
  inherited;
end;

function TPackageInvoiceLine.GetAmountIncludedInParent: double;
begin
  Result := inherited / FParentList.Count;
end;

function TPackageInvoiceLine.GetIsGenerated: boolean;
begin
  Result := true;
end;

procedure TPackageInvoiceLine.RemoveParent(aParent: TInvoiceLine);
begin
  if assigned(aParent) then
      aParent.ChildInvoiceLines.Remove(self);

  FParentList.Remove(aParent);
end;


end.