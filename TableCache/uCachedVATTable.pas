unit uCachedVATTable;

interface

uses
  uTableEntityList
  , Data.DB
  ;

type
  TCachedVATTable = class(TCachedTableEntity)
  private
    procedure BeforeDelete(DataSet: TDataSet);
  public
    constructor Create(const tableName : String; aTimestampHandler: ICachedTimestampHandler; const sqlExtension : String = ''); override;
  end;

implementation

{ TCachedVATTable }

uses
  hData
  , PrjConst
  , Dialogs
  , SysUtils
  ;

constructor TCachedVATTable.Create(const tableName: String; aTimestampHandler: ICachedTimestampHandler;
  const sqlExtension: String);
begin
  inherited;
  RSet.BeforeDelete := BeforeDelete;
end;

procedure TCachedVATTable.BeforeDelete(DataSet: TDataSet);
begin
  if hdata.vatCodeExistsInOther(Dataset.FieldByName('vatcode').asString) then
  begin
	  Showmessage(format(GetTranslatedText('shExistsInRelatedDataCannotDelete'), ['VATCode', Dataset.FieldByName('description').asString]));
    Abort;
  end;
end;

end.
