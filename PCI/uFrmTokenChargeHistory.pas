unit uFrmTokenChargeHistory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTokenHelpers, uRoomerForm, Vcl.StdCtrls, sLabel, Vcl.ComCtrls, sListView, sGroupBox, Vcl.ExtCtrls, sPanel,
  cxGridTableView, cxStyles, dxPScxCommon, dxPScxGridLnk, cxClasses, cxPropertiesStore, sStatusBar,
  Generics.Collections, sButton, Vcl.Menus, udImages;

type
  TFrmTokenChargeHistory = class(TfrmBaseRoomerForm)
    sPanel1: TsPanel;
    sPanel2: TsPanel;
    sPanel3: TsPanel;
    lvTokens: TsListView;
    sPanel4: TsPanel;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    lvCharges: TsListView;
    sPanel5: TsPanel;
    sPanel6: TsPanel;
    btnTokenView: TsButton;
    btnChargeView: TsButton;
    btnTokenNew: TsButton;
    sLabel3: TsLabel;
    sLabel4: TsLabel;
    sLabel5: TsLabel;
    sLabel6: TsLabel;
    lbReservation: TsLabel;
    lbRoomReservation: TsLabel;
    lbRoom: TsLabel;
    lbGuest: TsLabel;
    mnuTokenNew: TPopupMenu;
    mnuNewForRes: TMenuItem;
    mnuNewForRoom: TMenuItem;
    btnRefresh: TsButton;
    btnCharge: TsButton;
    btnRefundOrCapture: TsButton;
    pupCard: TPopupMenu;
    mnuCharge: TMenuItem;
    mnuPreAuth: TMenuItem;
    pupCharge: TPopupMenu;
    mnuCapture: TMenuItem;
    mnuVoid: TMenuItem;
    mnyRefund: TMenuItem;
    sPanel7: TsPanel;
    sLabel7: TsLabel;
    lbCharged: TsLabel;
    sLabel9: TsLabel;
    sLabel10: TsLabel;
    lbPreAuth: TsLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvTokensSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure rgWhichTokensChange(Sender: TObject);
    procedure lvChargesSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btnChargeViewClick(Sender: TObject);
    procedure lvChargesChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvChargesDblClick(Sender: TObject);
    procedure mnuNewForResClick(Sender: TObject);
    procedure mnuNewForRoomClick(Sender: TObject);
    procedure btnTokenViewClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure lvTokensDblClick(Sender: TObject);
    procedure pupChargePopup(Sender: TObject);
    procedure mnyRefundClick(Sender: TObject);
    procedure mnuCaptureClick(Sender: TObject);
    procedure mnuVoidClick(Sender: TObject);
    procedure mnuChargeClick(Sender: TObject);
    procedure mnuPreAuthClick(Sender: TObject);
  private
    FTokenList : TObjectList<TToken>;
    FTokenChargeList : TObjectList<TTokenCharge>;
    FReservation: integer;
    FRoomReservation: integer;
    procedure DisplayTokens;
    procedure DisplayCharges;
    function GetCardStatusByReference(tokenId: Integer; GatewayReference: String): Double;
    function IsThereAnActiveContract: Boolean;
    { Private declarations }
  protected
    procedure DoLoadData; override;
    procedure DoShow; override;
  public
    { Public declarations }
    property Reservation: integer read FReservation write FReservation;
    property RoomReservation: integer read FRoomReservation write FRoomReservation;
  end;

procedure ManagePaymentCards(Reservation, RoomReservation : Integer);

implementation

{$R *.dfm}

uses ud,
     hData,
     cmpRoomerDataSet,
     uDateUtils,
     uFrmViewChargeInfo,
     uFrmViewPayCardDetails,
     uFrmPayCardCreateNew,
     uAppGlobal,
     uG,
     uUtils,
     uFmrChargePayCard,
     uFrmOptInMessage,
     _Glob,
     uFrmPayCardView
     ;

procedure ManagePaymentCards(Reservation, RoomReservation : Integer);
var
  _FrmTokenChargeHistory: TFrmTokenChargeHistory;
begin
  _FrmTokenChargeHistory := TFrmTokenChargeHistory.Create(nil);
  try
    _FrmTokenChargeHistory.Reservation := Reservation;
    _FrmTokenChargeHistory.RoomReservation := RoomReservation;
    _FrmTokenChargeHistory.ShowModal;
  finally
    _FrmTokenChargeHistory.Free;
  end;
end;

procedure TFrmTokenChargeHistory.FormCreate(Sender: TObject);
begin
  inherited;
  FTokenList := TObjectList<TToken>.Create;
  FTokenChargeList := TObjectList<TTokenCharge>.Create;
end;

procedure TFrmTokenChargeHistory.FormDestroy(Sender: TObject);
begin
  inherited;
  FTokenList.Free;
  FTokenChargeList.Free;
end;

procedure TFrmTokenChargeHistory.DisplayTokens;
var token : TToken;
    lvi : TListItem;
begin
  lvTokens.Items.Clear;
  for token IN FTokenList do
  begin
    lvi := lvTokens.Items.Add;
    lvi.Checked := token.Enabled;
    lvi.Caption := token.CardNumber;
    lvi.SubItems.Add(token.UserId);
    lvi.SubItems.Add(RoomerDateTimeToString(token.Created));
    lvi.SubItems.Add(IIF(token.RoomReservation > 0, lbRoom.Caption, ''));
    lvi.Data := token;
  end;
end;

procedure TFrmTokenChargeHistory.DoShow;
begin
  inherited;

  lbReservation.Caption := inttostr(Reservation);
  lbRoomReservation.Caption := inttostr(RoomReservation);

  mnuNewForRoom.Enabled := (RoomReservation > 0);
  if mnuNewForRoom.Enabled then
    mnuNewForRoom.Caption := mnuNewForRoom.Caption + format('[%s]', [lbRoom.Caption]);

  RefreshData;
end;

procedure TFrmTokenChargeHistory.btnChargeViewClick(Sender: TObject);
begin
  inherited;
  DisplayCharge(TTokenCharge(lvCharges.Selected.Data));
end;

procedure TFrmTokenChargeHistory.btnRefreshClick(Sender: TObject);
begin
  inherited;
  RefreshData;
end;

procedure TFrmTokenChargeHistory.btnTokenViewClick(Sender: TObject);
var token : TToken;
begin
  inherited;
  if NOT ASSIGNED(lvTokens.Selected) then exit;
  token := TToken(lvTokens.Selected.Data);
  ShowPayCardInformation(Reservation, token.id, ORD(glb.PCIContractOpenForChannel(-1)));
//  DisplayTokenDetails(token);
end;

procedure TFrmTokenChargeHistory.DisplayCharges;
var charge : TTokenCharge;
    lvi : TListItem;

    charged : Double;
    preAuthed : Double;
begin
  charged := 0.00;
  preAuthed := 0.00;
  lvCharges.Items.Clear;
  for charge IN FTokenChargeList do
  begin
    lvi := lvCharges.Items.Add;
    lvi.Caption := RoomerDateTimeToString(charge.created);
    lvi.SubItems.Add(charge.operationType);
    lvi.SubItems.Add(charge.operationResultCode);
    lvi.SubItems.Add(FloatToStr(charge.amount));
    lvi.SubItems.Add(charge.currency);
    lvi.Data := charge;

    if (LowerCase(charge.operationResultCode) = 'success') then
    begin
      if (LowerCase(charge.operationType) = 'charge') then
        charged := charged + charge.amount
      else if (LowerCase(charge.operationType) = 'capture') then
      begin
        charged := charged + charge.amount;
        preAuthed := preAuthed - charge.amount;
      end
      else if (LowerCase(charge.operationType) = 'refund') then
        charged := charged - charge.amount
      else if (LowerCase(charge.operationType) = 'preauth') then
        preAuthed := preAuthed + charge.amount
      else if (LowerCase(charge.operationType) = 'void') then
        preAuthed := preAuthed - charge.amount;
    end;
  end;
  lbCharged.Caption := trim(_floattostr(charged, 20, 2));
  lbPreAuth.Caption := trim(_floattostr(preAuthed, 20, 2));
end;

procedure TFrmTokenChargeHistory.DoLoadData;
var
  rSet: TRoomerDataSet;
  xml : String;
  s : String;
begin
  inherited;
  rSet := CreateNewDataSet;
  try
    if RoomReservation > 0 then
      s := 'SELECT rr.Room, p.Name FROM roomreservations rr JOIN persons p ON p.RoomReservation=rr.RoomReservation AND p.MainName=1 WHERE rr.RoomReservation=' + inttostr(RoomReservation)
    else
      s := 'SELECT ''[N/A]'' AS Room, Name FROM reservations WHERE Reservation=' + inttostr(Reservation);

    rSet_bySQL(rSet, s);
    rSet.First;
    if NOT rSet.Eof then
    begin
      lbRoom.Caption := rSet['Room'];
      lbGuest.Caption := rSet['Name'];
    end;
  finally
    rSet.Free;
  end;

  xml := d.roomerMainDataSet.downloadUrlAsString(d.roomerMainDataSet.RoomerUri + format('paycard/bookings/%d/tokens', [Reservation]));
  rSet := d.roomerMainDataSet.ActivateNewDataset(xml);
  try
    lvTokens.Items.BeginUpdate;
    try
      lvTokens.Items.Clear;
      FTokenList := LoadAllTokens(Reservation, RoomReservation);
    finally
      lvTokens.Items.EndUpdate;
    end;
  finally
    freeandNil(rSet);
  end;
  DisplayTokens;
end;


procedure TFrmTokenChargeHistory.lvChargesChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  inherited;
  btnChargeView.Enabled := ASSIGNED(item);
end;

procedure TFrmTokenChargeHistory.lvChargesDblClick(Sender: TObject);
begin
  inherited;
  if ASSIGNED(lvCharges.Selected) then
    btnChargeView.Click;
end;

procedure TFrmTokenChargeHistory.lvChargesSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  inherited;
  btnChargeView.Enabled := selected;
  btnRefundOrCapture.Enabled := selected;
end;

procedure TFrmTokenChargeHistory.lvTokensDblClick(Sender: TObject);
begin
  inherited;
  if ASSIGNED(lvTokens.Selected) then
    btnTokenView.Click;
end;

procedure TFrmTokenChargeHistory.lvTokensSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  rSet: TRoomerDataSet;
  xml : String;
  charge : TTokenCharge;
  token : TToken;
begin
  btnTokenView.Enabled := selected;
  btnCharge.Enabled := selected;

  lvCharges.Items.BeginUpdate;
  try
    lvCharges.Items.Clear;
    FTokenChargeList.Clear;
    if NOT ASSIGNED(lvTokens.Selected) then exit;

    token := TToken(lvTokens.Selected.Data);
    if token.id < 0 then
      xml := d.roomerMainDataSet.downloadUrlAsString(d.roomerMainDataSet.RoomerUri + format('paycard/bookings/%d/charges', [Reservation]))
    else
      xml := d.roomerMainDataSet.downloadUrlAsString(d.roomerMainDataSet.RoomerUri + format('paycard/bookings/%d/charges?tokenId=%d', [Reservation, token.id]));

    rSet := d.roomerMainDataSet.ActivateNewDataset(xml);
    try
      rSet.First;
      while NOT rSet.Eof do
      begin
        charge := TTokenCharge.Create(rSet['ID'],
                      token,
                      rSet['AMOUNT'],
                      rSet['CURRENCY'],
                      rSet['CURRENCY_RATE'],
                      rSet['AUTHORIZATION_CODE'],
                      rSet['OPERATION_TYPE'],
                      rSet['OPERATION_RESULT_CODE'],
                      rSet['OPERATION_RESULT_DESCRIPTION'],
                      rSet['GATEWAY_NAME'],
                      rSet['GATEWAY_REFERENCE'],

                      rSet['GATEWAY_RESULT_CODE'],
                      rSet['GATEWAY_RESULT_DESCRIPTION'],
                      rSet['TSTAMP']);

        FTokenChargeList.Add(charge);
        rSet.Next;
      end;
    finally
      freeandNil(rSet);
    end;
    DisplayCharges;
  finally
    lvCharges.Items.EndUpdate;
  end;
end;

procedure TFrmTokenChargeHistory.mnuCaptureClick(Sender: TObject);
var charge : TTokenCharge;
begin
  inherited;
  if NOT IsThereAnActiveContract then exit;

  if NOT ASSIGNED(lvCharges.Selected) then exit;
  charge := TTokenCharge(lvCharges.Selected.Data);
  ChargePayCard(charge,
                charge.token,
                charge.token.Reservation,
                charge.token.RoomReservation,
                charge.token.id,
                charge.amount,
                charge.currency,
                FTokenList,
                charge.gatewayReference,
                PCO_CAPTURE);
  lvTokensSelectItem(lvTokens, lvTokens.Selected, true);
end;

procedure TFrmTokenChargeHistory.mnuChargeClick(Sender: TObject);
var token : TToken;
begin
  inherited;
  if NOT IsThereAnActiveContract then exit;

  if NOT ASSIGNED(lvTokens.Selected) then exit;
  token := TToken(lvTokens.Selected.Data);
  ChargePayCard(nil,
                token,
                token.Reservation,
                token.RoomReservation,
                token.id,
                0.00,
                g.qNativeCurrency,
                FTokenList,
                '',
                PCO_CHARGE);
  lvTokensSelectItem(lvTokens, lvTokens.Selected, true);
end;

function TFrmTokenChargeHistory.IsThereAnActiveContract : Boolean;
begin
  result := ORD(glb.PCIContractOpenForChannel(-1)) = 1;
  if NOT result then
    OpenOptInDialog(OITPCI)
end;

procedure TFrmTokenChargeHistory.mnuNewForResClick(Sender: TObject);
begin
  inherited;
  if NOT IsThereAnActiveContract then exit;

  CreatePayCardInformation(Reservation, -1, ORD(glb.PCIContractOpenForChannel(-1)));
  btnRefresh.Click;
end;

procedure TFrmTokenChargeHistory.mnuNewForRoomClick(Sender: TObject);
begin
  inherited;
  if NOT IsThereAnActiveContract then exit;

  CreatePayCardInformation(Reservation, RoomReservation, ORD(glb.PCIContractOpenForChannel(-1)));
  btnRefresh.Click;
end;

procedure TFrmTokenChargeHistory.mnuPreAuthClick(Sender: TObject);
var token : TToken;
begin
  inherited;
  if NOT IsThereAnActiveContract then exit;

  if NOT ASSIGNED(lvTokens.Selected) then exit;
  token := TToken(lvTokens.Selected.Data);
  ChargePayCard(nil,
                token,
                token.Reservation,
                token.RoomReservation,
                token.id,
                0.00,
                g.qNativeCurrency,
                FTokenList,
                '',
                PCO_PRE_AUTH);
  lvTokensSelectItem(lvTokens, lvTokens.Selected, true);
end;

procedure TFrmTokenChargeHistory.mnuVoidClick(Sender: TObject);
var charge : TTokenCharge;
begin
  inherited;
  if NOT IsThereAnActiveContract then exit;

  if NOT ASSIGNED(lvCharges.Selected) then exit;
  charge := TTokenCharge(lvCharges.Selected.Data);
  ChargePayCard(charge,
                charge.token,
                charge.token.Reservation,
                charge.token.RoomReservation,
                charge.token.id,
                charge.amount,
                charge.currency,
                FTokenList,
                charge.gatewayReference,
                PCO_VOID);
  lvTokensSelectItem(lvTokens, lvTokens.Selected, true);
end;

procedure TFrmTokenChargeHistory.mnyRefundClick(Sender: TObject);
var charge : TTokenCharge;
begin
  inherited;
  if NOT IsThereAnActiveContract then exit;

  if NOT ASSIGNED(lvCharges.Selected) then exit;
  charge := TTokenCharge(lvCharges.Selected.Data);
  ChargePayCard(charge,
                charge.token,
                charge.token.Reservation,
                charge.token.RoomReservation,
                charge.token.id,
                charge.amount,
                charge.currency,
                FTokenList,
                charge.gatewayReference,
                PCO_REFUND);
  lvTokensSelectItem(lvTokens, lvTokens.Selected, true);
end;

procedure TFrmTokenChargeHistory.pupChargePopup(Sender: TObject);
var charge : TTokenCharge;
begin
  inherited;
  if NOT ASSIGNED(lvCharges.Selected) then exit;
  charge := TTokenCharge(lvCharges.Selected.Data);
  mnyRefund.Enabled := (LowerCase(charge.operationResultCode) = 'success') AND
                       ((LowerCase(charge.operationType) = 'charge') OR
                        (LowerCase(charge.operationType) = 'capture'));
  mnuVoid.Enabled := (LowerCase(charge.operationResultCode) = 'success') AND
                        (LowerCase(charge.operationType) = 'preauth') AND
                        (GetCardStatusByReference(charge.token.id, charge.gatewayReference) > 0.0);
  mnuCapture.Enabled := (LowerCase(charge.operationResultCode) = 'success') AND
                        (LowerCase(charge.operationType) = 'preauth') AND
                        (GetCardStatusByReference(charge.token.id, charge.gatewayReference) > 0.0);
end;

function TFrmTokenChargeHistory.GetCardStatusByReference(tokenId : Integer; GatewayReference : String) : Double;
var charge : TTokenCharge;
begin
  result := 0.0;
  for charge IN FTokenChargeList do
  begin
    if (charge.token.id = tokenId) AND
       (LowerCase(charge.operationResultCode) = 'success') AND
       (charge.gatewayReference = GatewayReference) then
    begin
      if LowerCase(charge.operationType) = 'preauth' then
         result := result + charge.amount
      else
      if LowerCase(charge.operationType) = 'void' then
         result := result - charge.amount
      else
      if LowerCase(charge.operationType) = 'capture' then
         result := result - charge.amount;
    end;

  end;
end;

procedure TFrmTokenChargeHistory.rgWhichTokensChange(Sender: TObject);
begin
  inherited;
  lvCharges.Items.Clear;
  FTokenChargeList.Clear;
  DisplayTokens;
end;

{
===================================================================
         TEST CREDIT CARDS ACCEPTED BY PCI BOOKING
===================================================================

The following testcards will go through more processing, expire date and cvc must be correct. They have a limited amount that is regenerated each night and can therefore be filled.
5587 4020 0001 2011          1809    415
5587 4020 0001 2029          1809    855
5587 4020 0001 2037          1809    310

These testcards will always return the actioncode on the right
4155 5200 0000 0002      121
4741 5200 0000 0003      000
3528 1000 2368 7010      000
3569 9900 1003 6423      000
3778 4608 0001 101       000
3541 0120 3422 1148      000
3614 8501 0414 82        000
3614 8001 3852 72        000
3778 4602 9992 063       000
4507 2800 0000 1         109
4000 0000 0000 0002      120
6799 9999 9959 3         111
4000 0000 0000 0000006   116
4507 2800 0005 9194      100
5033 9699 8900 0000496   208
6799 9999 9953 6         000
5414 8300 3760 8105      000
5414 8300 3760 9103      904
5414 8300 3761 0101      000
6011 1111 1111 1117      000
6270 6700 9999 9815      209

Typical authorization message
<?xml version='1.0' encoding='utf-8'?>
<getAuthorization>
  <Version>1000</Version>
  <Processor>52</Processor>
  <MerchantID>52</MerchantID>
  <TerminalID>1</TerminalID>
  <TransType>5</TransType>
  <TrAmount>12300</TrAmount>
  <TrCurrency>978</TrCurrency>
  <DateAndTime>110601083732</DateAndTime>
  <PAN>5555666655554444</PAN>
  <ExpDate>1212</ExpDate>
  <RRN>WC0000000001</RRN>
  <CVC2>123</CVC2>
</getAuthorization>
}

end.

