unit sCurrencyEdit;
{$I sDefs.inc}

interface

uses
  Windows, SysUtils, Classes, Controls,
  sCurrEdit, sConst;


Type
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsCurrencyEdit = class(TsCustomNumEdit)
{$IFNDEF NOTFORHELP}
  protected
    procedure ButtonClick; override;
  public
    constructor Create(AOwner:TComponent); override;
    procedure CreateParams(var Params: TCreateParams); override;
  published
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property BeepOnError;
    property CheckOnExit;
    property DecimalPlaces;
    property DisplayFormat;
    property DragCursor;
    property DragMode;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxValue;
    property MinValue;
    property ParentShowHint;
    property PopupMenu;
    property ShowButton default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Value;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnContextPopup;

    property HelpContext;
    property OEMConvert;
    property ReadOnly;
    property Enabled;
    property Font;
    property Hint;
    property MaxLength;
    property ParentFont;
    property CharCase;

    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    property OnStartDrag;
{$ENDIF} // NOTFORHELP
  end;


implementation

uses sGlyphUtils;


procedure TsCurrencyEdit.ButtonClick;
begin
  if Assigned(FOnButtonClick) then
    FOnButtonClick(Self)
  else
    inherited;
end;


constructor TsCurrencyEdit.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  ShowButton := False;
  FDefBmpID := iBTN_CALC;
  SkinData.COC := COC_TsCurrencyEdit;
  Width := 80;
{  ControlState := ControlState + [csCreating];
  try
    Button.Parent := nil;
    Button.Width := 0;
    Button.Parent := Self;
  finally
    ControlState := ControlState - [csCreating];
  end;}
end;


procedure TsCurrencyEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
//  Params.Style := Params.Style and not ES_MULTILINE;
end;

end.
