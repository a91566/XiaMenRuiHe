unit U_Exception;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, frxpngimage, ExtCtrls, Buttons, RzPanel, IniFiles, ShellAPI,
  imagebutton;

type
  TF_Exception = class(TForm)
    Timer1: TTimer;
    Panel1: TRzPanel;
    Panel5: TPanel;
    Label12: TLabel;
    Panel4: TPanel;
    Memo1: TMemo;
    Panel3: TPanel;
    Image1: TImage;
    Panel2: TPanel;
    Label1: TLabel;
    Button1: TButton;
    Image2: TImage;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private
    { Private declarations }
  public
    booBlack: boolean;
    function GetStringFromIni(FromFile, Section, Ident: WideString): WideString;
    { Public declarations }
  end;

var
  F_Exception: TF_Exception;

implementation

uses U_ZsbBlack,  Tlhelp32;

{$R *.dfm}



procedure TF_Exception.FormShow(Sender: TObject);
begin
 // AnimateWindow(Self.Handle, 100, AW_CENTER); //���
  MessageBeep(MB_ICONERROR);
end;

function TF_Exception.GetStringFromIni(FromFile, Section, Ident: WideString): WideString;
var
  ReadIniFile: TIniFile;
begin
  ReadIniFile := TIniFile.Create(FromFile);
  Result := ReadIniFile.ReadString(Section, Ident, '');
  ReadIniFile.Free;
end;

//�жϽ����Ƿ����

function FindProcess(AFileName: string): boolean;
var
  hSnapshot: THandle; //���ڻ�ý����б�
  lppe: TProcessEntry32; //���ڲ��ҽ���
  Found: Boolean; //�����жϽ��̱����Ƿ����
begin
  Result := False;
  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0); //���ϵͳ�����б�
  lppe.dwSize := SizeOf(TProcessEntry32); //�ڵ���Process32First   API֮ǰ����Ҫ��ʼ��lppe��¼�Ĵ�С
  Found := Process32First(hSnapshot, lppe); //�������б�ĵ�һ��������Ϣ����ppe��¼��
  while Found do
  begin
    if ((UpperCase(ExtractFileName(lppe.szExeFile)) = UpperCase(AFileName)) or (UpperCase(lppe.szExeFile) = UpperCase(AFileName))) then
    begin
      Result := True;
    end;
    Found := Process32Next(hSnapshot, lppe); //�������б����һ��������Ϣ����lppe��¼��
  end;
end;

///Delphi����ָ�����̺���

function KillTask(ExeFileName: string): integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOLean;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result := Integer(
        TerminateProcess(OpenProcess(PROCESS_TERMINATE,
        BOOL(0), FProcessEntry32.th32ProcessID), 0));
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

procedure TF_Exception.Timer1Timer(Sender: TObject);
var
  i: Integer;
  t: Integer;
  l: Integer;
  seed: Integer;
begin
  Timer1.Enabled := False;
  t := Self.Top;
  l := self.Left;
  seed := 0;
  for i := 0 to 10 do
  begin
    Application.ProcessMessages;
    case seed of
      0: begin
          self.Top := t + 1;
          Self.Left := l + 1;
          seed := 1;
        end;
      1: begin
          self.Top := t - 1;
          Self.Left := l - 1;
          seed := 0;
        end;
    end;
    SleepEx(50, True);
  end;
  self.Top := t;
  Self.Left := l;
end;

procedure TF_Exception.FormCreate(Sender: TObject);
begin
  SetWindowLong(Application.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW); //������������ʾ
  F_Exception.Left := (Screen.Width - F_Exception.Width) div 2;
  F_Exception.Top := (Screen.Height - F_Exception.Height) div 3;
end;

procedure TF_Exception.Button1Click(Sender: TObject);
begin
  if booBlack then
  begin
    F_Zsbblack.Close;
  end;
  F_Exception.Close;
end;

procedure TF_Exception.Image2Click(Sender: TObject);
var
  ToFolderPath, ExeMainPath, OpExeName: string;
  i: SmallInt;
begin
  ToFolderPath := ExtractFilePath(Application.Exename); //Ŀ���ļ���
  OpExeName:=GetStringFromIni(ExtractFilePath(ParamStr(0)) + 'updateconfig.ini', 'SYSTEM', 'OpenExeMainPath'); //���������ĳ���
  ExeMainPath :=ToFolderPath+OpExeName;



  ShellExecute(Handle, 'open', pchar(ExeMainPath), '-s', nil, SW_SHOWNORMAL);

  for i := 0 to 5 do
  begin
    if FindProcess(OpExeName)=False then
    begin
      Break;
    end
    else
    begin
      KillTask(OpExeName);
    end;
  end;
end;

end.

