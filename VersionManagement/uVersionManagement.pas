unit uVersionManagement;

interface

uses Windows,
     Dialogs,
     SysUtils,
     vcl.ExtCtrls,
     uFileDependencyManager,
     uRoomerLogger,

     uRoomerHttpClient;

type

  TVersionRec = record
    Version : String;
    TTL : Integer;
    EndDateTime : TDateTime;
  end;

  TOnAskUpgrade = procedure(Text : String; version : String; forced : Boolean; var upgrade : Boolean) of Object;

  TRoomerVersionManagement = class
  private
    httpCLient: TRoomerHttpClient;
    timer : TTimer;
    FileDependencyManager: TFileDependencymanager;
    RoomerUpgradeDaemonPath : String;
    FOnAskUpgrade: TOnAskUpgrade;

    VersionRec : TVersionRec;
    lastCounter : Integer;

    RoomerLogger : TRoomerLogger;

    PortToUse : Integer;

    procedure OnTimer(Sender: TObject);
    procedure Start(initialStart : Boolean = False);
    procedure Stop;

    procedure makeSureUpgradeDaemonIsActive;

    function newVersionAvailable(force : Boolean = false) : Boolean;
    procedure updateNow(force : boolean = false);
    procedure BreakDownVersionString(sStr: String);
    procedure PerformUpdateIfAvailable(initialStart : Boolean = False);
    procedure CheckIfUpgradeExists;
    function GetFromURI(uri: String; useGetUriPort : Boolean = True): String;
    function GetURIPort(SourceURI : String) : String;
    procedure startEngine;
  public
    VersionManagerActive : Boolean;

    constructor Create;
    destructor Destroy; override;

    procedure Prepare;
    procedure ForceUpdate;
    property OnAskUpgrade : TOnAskUpgrade read FOnAskUpgrade write FOnAskUpgrade;
  end;

implementation

uses uD,
     IOUtils,
     uRoomerDefinitions,
     uFileSystemUtils,
     uRunWithElevatedOption,
     Forms,
     uUtils,
     Classes,
     uDateUtils,
     DateUtils,
     idURI,
     PrjConst,
     uRoomerVersionInfo,
     uSocketHelpers,
     UITypes
    ;

const SECOND = 1000;
      MINUTE = 60 * SECOND;
      FIVE_MINUTES = 5 * MINUTE;
      TEN_MINUTES = 10 * MINUTE;

      HTTP_LOCAL_IP = '127.0.0.1';
      HTTP_DEFAULT_PORT = 62999;
      HTTP_DEFAULT_PORT_MIN = 62989;

      MAX_COUNT_FOR_NOTIFICATION = 6;
      HTTP_CONNECT_TIME_OUT = 10 * SECOND;
      HTTP_TRANSFER_TIME_OUT = FIVE_MINUTES;

      URI_UPGRADE_DAEMON = 'http://localhost:{port}/';
      URI_UPGRADE_DAEMON_WHO_ARE_YOU = URI_UPGRADE_DAEMON + 'WhoAreYou';
      URI_UPGRADE_DAEMON_CLOSE = URI_UPGRADE_DAEMON + 'Close';
      URI_UPGRADE_DAEMON_ACTIVE = URI_UPGRADE_DAEMON + 'Active';
      URI_UPGRADE_DAEMON_ACTIVATE = URI_UPGRADE_DAEMON + 'Activate/%s';
      URI_UPGRADE_DAEMON_UPGRADE_AVAILABLE = URI_UPGRADE_DAEMON + 'UpgradeAvailable/%s/%s';
      URI_UPGRADE_DAEMON_CHECK_UPGRADE = URI_UPGRADE_DAEMON + 'CheckForUpgrade/%s';
      URI_UPGRADE_DAEMON_UPDATE_NOW = URI_UPGRADE_DAEMON + 'UpdateNow/%s/%s/%s/%s';

{ TRoomerVersionManagement }


constructor TRoomerVersionManagement.Create;
begin
  PortToUse := 0;
  VersionManagerActive := NOT FileExists(ChangeFileExt(Application.ExeName, '-SharedResource.True'));
  RoomerLogger := ActivateRoomerLogger(ClassName);
  lastCounter := MAX_COUNT_FOR_NOTIFICATION;
  httpCLient := TRoomerHttpClient.Create(nil);
//  httpCLient.InternetOptions := [
//                                 wHttpIo_No_cache_write,
//                                 wHttpIo_No_cookies,
//                                 wHttpIo_No_ui,
//                                 wHttpIo_Pragma_nocache
//                                ];
//  httpClient.ConnectTimeout := HTTP_CONNECT_TIME_OUT;
//  httpClient.ReceiveTimeout := HTTP_TRANSFER_TIME_OUT;
//  httpClient.SendTimeout := HTTP_TRANSFER_TIME_OUT;
  FileDependencyManager := TFileDependencymanager.Create;

  RoomerUpgradeDaemonPath := TPath.Combine(RoomerAppDataPath, cUpgradeDaemon);

  timer := TTimer.Create(nil);
  timer.Enabled := False;
  timer.OnTimer := OnTimer;

end;

destructor TRoomerVersionManagement.Destroy;
begin
  timer.Free;
  httpClient.Free;
  FileDependencyManager.Free;
  DeactivateRoomerLogger(RoomerLogger);
  inherited;
end;


procedure TRoomerVersionManagement.ForceUpdate;
begin
  Stop;
  try
    if newVersionAvailable(true) then
      updateNow(true)
//    else
//      CheckIfUpgradeExists;
  finally
    Start;
  end;
end;

function TRoomerVersionManagement.GetFromURI(uri : String; useGetUriPort : Boolean = True) : String;
begin
  try
    if useGetUriPort then
      uri := GetURIPort(uri);
    RoomerLogger.AddToLog(format('Calling to %s', [uri]));
    Result := string(httpCLient.Get(AnsiString(uri)));
    RoomerLogger.AddToLog(format('Call to %s returned %s', [uri, result]));
  except
    ON E: Exception do
    begin
      result := '';
      RoomerLogger.AddToLog(format('Call to %s failed with %s', [uri, e.Message]));
    end;
  end;
end;

function TRoomerVersionManagement.GetURIPort(SourceURI: String): String;
begin
  result := replaceString(SourceURI, '{port}', inttostr(PortToUse));
end;

procedure TRoomerVersionManagement.makeSureUpgradeDaemonIsActive;
{$IFNDEF DEBUG}
var UpgradeActive : Boolean;
{$ENDIF}
begin
{$IFNDEF DEBUG}
  if VersionManagerActive then
    begin
    UpgradeActive := doesUpgradeWindowExist;
    if UpgradeActive AND FileDependencyManager.doesNewUpgradeDemonExist(RoomerUpgradeDaemonPath) then
      CloseDaemon;
    if NOT doesUpgradeWindowExist then
    begin
      openDaemon;
      PortToUse := FindServicePort;
    end;
  end;
{$ENDIF}
end;

procedure TRoomerVersionManagement.BreakDownVersionString(sStr : String);
var stlResult, stlValues : TStringList;
  i: Integer;
begin
  stlResult := Split(sStr, '|');
  try
  for i := 0 to stlResult.Count - 1 do
  begin
    stlValues := Split(stlResult[i], '=');
    try
      while stlValues.Count < 2 do stlValues.Add('');

      if stlValues[0] = 'VERSION' then
        VersionRec.Version := stlValues[1]
      else
      if stlValues[0] = 'TTL' then
        VersionRec.TTL := StrToInt(stlValues[1])
      else
      if stlValues[0] = 'END_TIME_STAMP' then
        VersionRec.EndDateTime := uDateUtils.XmlStringToDate(stlValues[1]);
    finally
      stlValues.Free;
    end;
  end;
  finally
    stlResult.Free;
  end;
end;

function TRoomerVersionManagement.newVersionAvailable(force : Boolean = false): Boolean;
var answer, exePath : String;
    uri : String;
begin
  exePath := d.roomerMainDataSet.URLEncode(Application.ExeName);
  uri := format(URI_UPGRADE_DAEMON_UPGRADE_AVAILABLE, ['Roomer.exe', exePath]);
  answer := GetFromURI(uri);
  BreakDownVersionString(answer);
  RoomerLogger.AddToLog('Upgrade Daemon returned: ' + answer);
  result := UpperCase(Trim(answer)).StartsWith('UPDATE_AVAILABLE');
  if result then
  begin
    RoomerLogger.AddToLog('     Update available: ' + VersionRec.Version);
    RoomerLogger.AddToLog('     Time-to-live: ' + IntToStr(VersionRec.TTL));
    RoomerLogger.AddToLog('     Ending at: ' + DateTimeToStr(VersionRec.EndDateTime));
    result := result AND (force OR (VersionRec.Version <> TRoomerVersionInfo.FileVersion));
    if result then
      RoomerLogger.AddToLog('Returning: accept-update')
    else
      RoomerLogger.AddToLog('Returning: update-not-needed');
  end;
end;

procedure TRoomerVersionManagement.OnTimer(Sender: TObject);
begin
  Stop;
  try
    if newVersionAvailable then
      updateNow
//    else
//      CheckIfUpgradeExists;
  finally
    Start;
  end;
end;

procedure TRoomerVersionManagement.Start(initialStart : Boolean = False);
begin
  timer.Interval := TEN_MINUTES;
  timer.Enabled := True;
  if initialStart then
    PerformUpdateIfAvailable(InitialStart);
end;

procedure TRoomerVersionManagement.Stop;
begin
  timer.Enabled := False;
end;

procedure TRoomerVersionManagement.PerformUpdateIfAvailable(initialStart : Boolean = False);
begin
  Stop;
  try
    if newVersionAvailable then
      updateNow
    else
    if initialStart then
      CheckIfUpgradeExists;
  finally
    Start;
  end;
end;

procedure TRoomerVersionManagement.Prepare;
begin
  makeSureUpgradeDaemonIsActive;
  StartEngine;
end;

procedure TRoomerVersionManagement.startEngine;
begin
{$IFNDEF DEBUG}
  if VersionManagerActive then
    activateDaemon;
{$ENDIF}
end;

procedure TRoomerVersionManagement.CheckIfUpgradeExists;
var s : String;
begin
  s := GetFromURI(format(URI_UPGRADE_DAEMON_CHECK_UPGRADE, ['Roomer.exe']));
end;

procedure GetHoursAndMinutes(TTL : Integer; var h, m : Integer);
begin
  h := TTL DIV 60;
  m := TTL MOD 60;
end;

procedure TRoomerVersionManagement.updateNow(force : boolean = false);
var forced, upgrade : Boolean;
    s, msg : String;
    h, m : Integer;

    procedure Update;
    var exePath, uri : String;
    begin
      RoomerLogger.AddToLog('Updating Roomer...');
      exePath := d.roomerMainDataSet.URLEncode(Application.ExeName);
      uri := format(URI_UPGRADE_DAEMON_UPDATE_NOW, ['Roomer.exe', exePath, 'true', 'true']);
      CopyToClipboard(uri);
      s := GetFromURI(uri);
      if s = 'UPDATING' then
      begin
        Application.MainForm.Close;
        RoomerLogger.AddToLog('Closing Roomer for update...');
      end else
        RoomerLogger.AddToLog('Update not continuing!');
    end;
begin
  RoomerLogger.AddToLog('Starting update check...');
  if force then
    update
  else
  begin
    forced := VersionRec.EndDateTime <= Now;
    inc(lastCounter);
    if forced OR
       (lastCounter > MAX_COUNT_FOR_NOTIFICATION) then
    begin
      if Assigned(FOnAskUpgrade) then
      begin
        upgrade := True;
        if forced then
          msg := format(GetTranslatedText('shTx_VersionManagement_ForceNewVersion'), [VersionRec.Version,
                 GetTranslatedText('shTx_AboutRoomer_NewVersionAvailableUpdateNow')])
        else begin
//          GetHoursAndMinutes(VersionRec.TTL, h, m);
          GetHoursAndMinutes(MinutesBetween(VersionRec.EndDateTime,Now), h, m);
          msg := format(GetTranslatedText('shTx_VersionManagement_NewVersionAvailable'), [VersionRec.Version,
                 h,
                 m,
                 GetTranslatedText('shTx_AboutRoomer_NewVersionAvailableUpdateNow'),
                 GetTranslatedText('shTx_AboutRoomer_NewVersionAvailableUpdateLater')])
        end;
        RoomerLogger.AddToLog('Asking user: ' + msg);
        FOnAskUpgrade(msg, VersionRec.Version, forced, upgrade);
        if forced OR upgrade then
          update
//        else
//          CheckIfUpgradeExists;
      end;
      lastCounter := 0;
    end;
  end;
  RoomerLogger.AddToLog('Finished update check.');
end;

end.
