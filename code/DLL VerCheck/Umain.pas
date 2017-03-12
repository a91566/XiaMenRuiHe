unit Umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, frxpngimage, ExtCtrls, RzPanel, XPMan, Buttons,
  IdBaseComponent, IdComponent, IdIPWatch,StrUtils;

type
  TF_main = class(TForm)
    RzPanel10: TRzPanel;
    Label99: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    IdIPWatch1: TIdIPWatch;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label5MouseLeave(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
  private
    { Private declarations }
  public
    ZStrUser,PuIp:string;
    { Public declarations }
  end;

var
  F_main: TF_main;

implementation

uses dateutils,Tlhelp32, funpro, U_DM;

{$R *.dfm}

function GetVersionString(FileName: WideString): WideString; stdcall;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  Dummy: DWORD;
  VerValue: PVSFixedFileInfo;
  strFileName:string;//用于转换格式
begin
  Result := '';
  strFileName:=PWideChar(FileName);
  VerInfoSize := GetFileVersionInfoSize(PChar(strFileName),Dummy);
  if VerInfoSize = 0 then Exit;
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(strFileName), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  Result := IntToStr(VerValue^.dwFileVersionMS shr 16) + '.' +
    IntToStr(VerValue^.dwFileVersionMS and $FFFF) + '.' +
    IntToStr(VerValue^.dwFileVersionLS shr 16) + '.' +
    IntToStr(VerValue^.dwFileVersionLS and $FFFF);
  FreeMem(VerInfo);
end;

function MakeFileList(Path, FileExt: string; bPathName: Boolean): TStringList;
var //是否完整路径
  sch: TSearchrec;
begin
  Result := TStringlist.Create;
  if rightStr(trim(Path), 1) <> '\' then
    Path := trim(Path) + '\'
  else
    Path := trim(Path);
  if not DirectoryExists(Path) then
  begin
    Result.Clear;
    exit;
  end;
  if FindFirst(Path + '*', faAnyfile, sch) = 0 then
  begin
    repeat
      Application.ProcessMessages;
      if ((sch.Name = '.') or (sch.Name = '..')) then Continue;
      if DirectoryExists(Path + sch.Name) then
      begin
        Result.AddStrings(MakeFileList(Path + sch.Name, FileExt, bPathName));
      end
      else
      begin
        if (UpperCase(extractfileext(Path + sch.Name)) = UpperCase(FileExt)) or (FileExt = '.*') then
        begin
          if bPathName then
          begin
            Result.Add(Path + sch.Name);
          end
          else
          begin
            Result.Add(sch.Name);
          end;
        end;
      end;
    until FindNext(sch) <> 0;
    SysUtils.FindClose(sch);
  end;
end;


procedure WaitTime(MSecs: integer);
var
  FirstTickCount, Now: Longint;
begin
  FirstTickCount := Windows.GetTickCount();
  repeat Application.ProcessMessages;
    Now := Windows.GetTickCount();
  until (Now - FirstTickCount >= MSecs) or (Now < FirstTickCount);
end;

procedure TF_main.FormShow(Sender: TObject);
begin
  //AnimateWindow(Self.Handle, 300, AW_HOR_POSITIVE or AW_SLIDE);
  AnimateWindow(Self.Handle, 500, AW_SLIDE + AW_HOR_NEGATIVE); //滑动由右 到左
end;

procedure TF_main.FormCreate(Sender: TObject);
var
  iHTaskBar:SmallInt;
begin
  SetWindowLong(Application.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW); //不在任务栏显示  
  iHTaskBar:=GetSystemMetrics(SM_CYSCREEN)-GetSystemMetrics(SM_CYFULLSCREEN)-GetSystemMetrics(SM_CYCAPTION);
  Self.Left := Screen.Width;
  Self.Top := Screen.Height-Self.Height - iHTaskBar;
end;

procedure TF_main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  AnimateWindow(Self.Handle, 300, AW_HOR_POSITIVE or AW_SLIDE + AW_HIDE); // 由左到右 退出
  //AnimateWindow(Self.Handle, 300, AW_SLIDE + AW_HOR_NEGATIVE + AW_HIDE); // 由右到左 退出
end;

procedure TF_main.Label5MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Label5.Font.Style:=[fsBold];
  Label5.Color:=clYellow;
end;

procedure TF_main.Label5MouseLeave(Sender: TObject);
begin
  Label5.Font.Style:=[];
  Label5.Color:=clWhite;
end;

procedure TF_main.Label5Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_main.Timer1Timer(Sender: TObject);
var
  exsql, TeVer,strsql: string;
  TSList: TStringList;
  i: SmallInt;
begin
  Timer1.Enabled:=False;
  TSList:=TStringList.Create;
  TSList.LoadFromFile(ExtractFilePath(Application.ExeName)+'LoginHistory.zsb');
  strsql:='select stafname from staff where usercode='''+TSList[0]+'''';  
  SelectClientDataSetNoTips(strsql);
  ZStrUser:=TSList[0]+'/'+DataModule1.ClientDataSet1.FieldByName('stafname').AsString;
  TSList.Clear;
  exsql := '';
  PuIp:=IdIPWatch1.LocalIP;
  TSList := MakeFileList(ExtractFilePath(Application.ExeName), '.dll', False);
  for i := 0 to TSList.Count - 1 do
  begin
    TeVer := GetVersionString(ExtractFilePath(Application.ExeName) + TSList[i]);
    exsql := exsql + 'insert into AppVer_DLL_FormUser(DLLNAME,DLLVER_Local,un,iType,ip) values(''' + TSList[i] +
      ''',''' + TeVer + ''',''' + ZStrUser + ''',''PC'',''' + PuIp + ''');';
  end;
  EXSQLClientDataSet('delete from AppVer_DLL_FormUser where un='''+ZStrUser+''' and iType=''PC''');
  if EXSQLClientDataSet(exsql) then
  begin
    Label1.Caption:='DLL is ok';
    Timer2.Enabled:=True;
  end
  else
  begin
    Label1.Caption:='DLL is error.';
  end;
end;

procedure TF_main.Timer2Timer(Sender: TObject);
var
  exsql, TeVer: string;
  TSList: TStringList;
  i: SmallInt;
begin
  Timer2.Enabled:=False;
  exsql := '';
  TSList := MakeFileList(ExtractFilePath(Application.ExeName), '.exe', False);
  for i := 0 to TSList.Count - 1 do
  begin
    TeVer := GetVersionString(ExtractFilePath(Application.ExeName) + TSList[i]);
    exsql := exsql + 'insert into AppVer_DLL_FormUser(DLLNAME,DLLVER_Local,un,iType,ip) values(''' + TSList[i] +
      ''',''' + TeVer + ''',''' + ZStrUser + ''',''PC'',''' + PuIp + ''');';

  end;
  if EXSQLClientDataSet(exsql) then
  begin
    Label1.Caption:='Exe is ok.';
  end
  else
  begin
    Label1.Caption:='Exe is error.';
  end;
end;

procedure TF_main.Timer3Timer(Sender: TObject);
begin
  Application.Terminate;
end;

end.

