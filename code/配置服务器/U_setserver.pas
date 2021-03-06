unit U_setserver;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, StdCtrls, IniFiles, Buttons, ExtCtrls, RzPanel;

type
  TF_setserver = class(TForm)
    XPManifest1: TXPManifest;
    Timer1: TTimer;
    Panel1: TRzPanel;
    Label7: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label8: TLabel;
    Panel2: TPanel;
    RadioButton2: TRadioButton;
    RadioButton1: TRadioButton;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    E5: TEdit;
    E4: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    CheckBox1: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Label8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_setserver: TF_setserver;
  procedure ShowInfoTips(h: HWND; strShowMess: string; IconType: Integer = 1;strShowCaption: string='提示信息';bAutoClose:Boolean=True;iShowTime: Integer = 2000); stdcall;external 'InfoTips.dll';
  

implementation

{$R *.dfm}

function DoIt:Boolean;
type
  Func = function(var App: TApplication; ParentForm: TForm; strShow: string): Boolean; stdcall;
var
  Th: Thandle;
  Tf: Func;
  Tp: TFarProc;
begin
  Th := LoadLibrary('OperSmaleCipherForMd5.dll'); {装载DLL}
  Result:=False;
  if Th > 0 then ///大于0为DLL装载成功
  try
    Tp := GetProcAddress(Th, PChar('VerityMMForFileHaveShowCaptionNoBlack')); ///取得DLL中TestC函数在内存中的地址
    if Tp <> nil then
    begin
      Tf := Func(Tp);
      if Tf(Application, F_setserver, '如果要保存配置信息,请输入正确密码噢！') then
      begin
        Result:=True;
      end;
    end;
  finally
    FreeLibrary(Th); {释放DLL}
  end
  else
  begin
    Application.MessageBox('OperSmaleCipherForMd5.dll没有找到','错误信息', MB_ICONERROR);
  end;
end;

procedure TF_setserver.FormShow(Sender: TObject);
var
  ReadIniFile: TIniFile;
  IniFileName: string;
  linkfs: string;
begin
  //SuperPSW := 'wzglbyfjsy';   
  AnimateWindow(Handle, 100, AW_CENTER); //窗口由小变大
  IniFileName := ExtractFilePath(Application.Exename) + 'client.ini';
  ReadIniFile := TIniFile.Create(IniFileName);
  ComboBox1.ItemIndex:=ComboBox1.Items.IndexOf(ReadIniFile.ReadString('SYSTEM', 'ServerIP', ''));
  ComboBox2.ItemIndex:=ComboBox2.Items.IndexOf(ReadIniFile.ReadString('SYSTEM', 'Servername', '')); 
  ComboBox3.ItemIndex:=ComboBox3.Items.IndexOf(ReadIniFile.ReadString('SYSTEM', 'ServerPost', ''));
  E4.Text := ReadIniFile.ReadString('SYSTEM', 'SGUID', '');
  E5.Text := ReadIniFile.ReadString('SYSTEM', 'SName', '');
  linkfs := ReadIniFile.ReadString('SYSTEM', 'fs', '');
  ReadIniFile.Free;
  if linkfs = '0' then
  begin
    RadioButton1.Checked := True;
  end;
  if linkfs = '1' then
  begin
    RadioButton2.Checked := True;
  end;
end;

procedure TF_setserver.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  AnimateWindow(Self.Handle, 250, AW_CENTER+ AW_HIDE); // 变小 退出
end;

procedure TF_setserver.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:=False;
  Panel1.Visible:=True;
end;

procedure TF_setserver.SpeedButton1Click(Sender: TObject);
var
  ReadIniFile: TIniFile;
  IniFileName: string;
  filepath,linkfs: string;
begin
  if Trim(ComboBox1.Text) = '' then
  begin  
    ShowInfoTips(ComboBox1.Handle,'对不起,请输入服务器地址！',3);
    ComboBox1.SetFocus;
    Exit;
  end;
  if Trim(ComboBox2.Text) = '' then
  begin
    ShowInfoTips(ComboBox2.Handle,'对不起,请输入数据库名称！',3);
    ComboBox2.SetFocus;
    Exit;
  end;
  if Trim(ComboBox3.Text) = '' then
  begin
    ShowInfoTips(ComboBox3.Handle,'对不起,请输入数据库用户地址！',3);
    ComboBox3.SetFocus;
    Exit;
  end;   
  if Trim(E4.Text) = '' then
  begin
    ShowInfoTips(E4.Handle,'对不起,请输入连接GUID！',3);
    E5.SetFocus;
    Exit;
  end;
  if Trim(E5.Text) = '' then
  begin
    ShowInfoTips(E5.Handle,'对不起,请输入连接组件名！',3);
    E5.SetFocus;
    Exit;
  end;
  if RadioButton1.Checked = True then
  begin
    linkfs := '0';
  end;
  if RadioButton2.Checked = True then
  begin
    linkfs := '1';
  end;
  //if doit then   // 密码验证
  begin
    filepath := ExtractFilePath(Application.Exename) + 'client.INI';
    if FileExists(filepath) then
    begin
      SetFileAttributes(PChar(filepath), FILE_ATTRIBUTE_NORMAL); //正常
    end;
    IniFileName := ExtractFilePath(Application.Exename) + 'client.ini';
    ReadIniFile := TIniFile.Create(IniFileName);
    ReadIniFile.WriteString('SYSTEM', 'ServerIP', ComboBox1.Text);
    ReadIniFile.WriteString('SYSTEM', 'Servername', ComboBox2.Text);
    ReadIniFile.WriteString('SYSTEM', 'ServerPost', ComboBox3.Text);
    ReadIniFile.WriteString('SYSTEM', 'SGUID', E4.Text);
    ReadIniFile.WriteString('SYSTEM', 'SName', E5.Text);
    ReadIniFile.WriteString('SYSTEM', 'fs', linkfs);
    ReadIniFile.Free;
    if CheckBox1.Checked = True then
    begin
      Close;
    end;
    Self.ModalResult:=IDOK;
  end;
end;

procedure TF_setserver.SpeedButton2Click(Sender: TObject);
begin
  Panel1.Visible:=False;
  Self.ModalResult:=IDCANCEL;
end;

procedure TF_setserver.Label8MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (ssleft in Shift) then
  begin
    ReleaseCapture;
    Perform(WM_syscommand, $F012, 0);
  end;
end;

procedure TF_setserver.ComboBox1Change(Sender: TObject);
begin
  ComboBox2.ItemIndex:=ComboBox1.ItemIndex;
  ComboBox3.ItemIndex:=ComboBox1.ItemIndex;
end;

end.

