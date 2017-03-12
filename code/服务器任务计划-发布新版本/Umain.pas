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
    Timer3: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label5MouseLeave(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
  private
    { Private declarations }
  public
    ZStrUser:string;
    { Public declarations }
  end;

var
  F_main: TF_main;

implementation

uses dateutils,funpro, U_DM;

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
  exsql,Exefn,temp, ExeVer_local,ExeVer_db,strsql: string;
begin
  Timer1.Enabled:=False;
  strsql:='select top 1 ver from appver where iType=''PC'' order by id desc';
  SelectClientDataSetNoTips(strsql);
  ExeVer_db:=DataModule1.ClientDataSet1.FieldByName('ver').AsString;

  Exefn:=GetStringFromIni(ExtractFilePath(ParamStr(0)) + 'AutoAddAppNewVerConfig.ini', 'SYSTEM', 'ExeMainPath');
  ExeVer_local:=GetVersionString(Exefn);
  if ExeVer_local=ExeVer_db then
  begin  
    Label1.Caption:=' Exit';
    Exit;
  end;

  temp:='发现新版本，请更新！';
  exsql:='insert into AppVer(ver,tips,dt,notice,iType,un)values(''' + ExeVer_local + ''',''' + temp +
      ''',''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) + ''',''1'',''PC'',''system'')';
  if EXSQLClientDataSet(exsql) then
  begin
    Label1.Caption:=' is ok';
  end
  else
  begin
    Label1.Caption:=' is error.';
  end;
end;

procedure TF_main.Timer3Timer(Sender: TObject);
begin
  Application.Terminate;
end;

end.

