unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, frxpngimage, ExtCtrls, RzPanel, XPMan, RzBckgnd, DB,
  ADODB, Buttons,ShellAPI;

type
  TForm1 = class(TForm)
    RzPanel10: TRzPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Image0: TImage;
    Panel3: TPanel;
    Memo1: TMemo;
    XPManifest1: TXPManifest;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  function GetStringFromIni(FromFile, Section, Ident: WideString): WideString; stdcall; external 'OperIniFile.dll';


implementation

{$R *.dfm}



procedure WaitTime(MSecs: integer);
var
  FirstTickCount, Now: Longint;
begin
  FirstTickCount := Windows.GetTickCount();
  repeat Application.ProcessMessages;
    Now := Windows.GetTickCount();
  until (Now - FirstTickCount >= MSecs) or (Now < FirstTickCount);
end;

procedure TForm1.FormShow(Sender: TObject);
var
  temp: string;
begin
  AnimateWindow(Self.Handle, 500, AW_SLIDE + AW_VER_NEGATIVE); //滑动由下到上
  temp := ExtractFilePath(Application.Exename) + 'ZsbNewVer.zsb';
  if FileExists(temp) then
  begin
    Memo1.Lines.LoadFromFile(temp);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SetWindowLong(Application.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW); //不在任务栏显示
  Self.Left := Screen.Width - Self.Width - 10;
  Self.Top := Screen.Height - Self.Height - 40;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  AnimateWindow(Self.Handle, 200, AW_VER_POSITIVE or AW_SLIDE + AW_HIDE); // 由下到上 退出
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  ExeMainPath: string; 
  HWndCalculator: HWnd;
begin
  ExeMainPath := GetStringFromIni(ExtractFilePath(ParamStr(0)) + 'updateconfig.ini', 'SYSTEM', 'CloseHWndCalculator'); //关闭的句柄
  HWndCalculator := Windows.FindWindow(nil, PChar(ExeMainPath)); //关闭主程序
  if HWndCalculator <> 0 then
  begin
    SendMessage(HWndCalculator, WM_CLOSE, 0, 0);
  end;

  ExeMainPath := GetStringFromIni(ExtractFilePath(ParamStr(0)) + 'updateconfig.ini', 'SYSTEM', 'OpenExeMainPath');
  ShellExecute(Handle, 'open', pchar(ExtractFilePath(ParamStr(0)) +ExeMainPath), '-s', nil, SW_SHOWNORMAL);
  Self.Close;
end;

end.

