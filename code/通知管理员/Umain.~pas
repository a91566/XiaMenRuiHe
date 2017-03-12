unit Umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, frxpngimage, ExtCtrls, RzPanel, XPMan, Buttons,
  IdBaseComponent, IdComponent, IdIPWatch;

type
  TF_main = class(TForm)
    RzPanel10: TRzPanel;
    Label99: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure Label5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label5MouseLeave(Sender: TObject);
    procedure Label5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_main: TF_main;    
  procedure StartHook(pid: DWORD); stdcall; external 'hookdll.dll';
  procedure EndHook; stdcall; external 'hookdll.dll';

implementation

uses dateutils,Tlhelp32, funpro;

{$R *.dfm}

function FindProcess(AFileName: string): boolean;
var
  hSnapshot: THandle; //用于获得进程列表
  lppe: TProcessEntry32; //用于查找进程
  Found: Boolean; //用于判断进程遍历是否完成
begin
  Result := False;
  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0); //获得系统进程列表
  lppe.dwSize := SizeOf(TProcessEntry32); //在调用Process32First   API之前，需要初始化lppe记录的大小
  Found := Process32First(hSnapshot, lppe); //将进程列表的第一个进程信息读入ppe记录中
  while Found do
  begin
    if ((UpperCase(ExtractFileName(lppe.szExeFile)) = UpperCase(AFileName)) or (UpperCase(lppe.szExeFile) = UpperCase(AFileName))) then
    begin
      Result := True;
    end;
    Found := Process32Next(hSnapshot, lppe); //将进程列表的下一个进程信息读入lppe记录中
  end;
end;

///Delphi结束指定进程函数

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
  StartHook(GetCurrentProcessId);
  Label1.Caption:=PuIDSHOW;
end;

procedure TF_main.FormCreate(Sender: TObject);
var
  iHTaskBar:SmallInt;
begin
  SetWindowLong(Application.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW); //不在任务栏显示  
  iHTaskBar:=GetSystemMetrics(SM_CYSCREEN)-GetSystemMetrics(SM_CYFULLSCREEN)-GetSystemMetrics(SM_CYCAPTION);
  Self.Left := Screen.Width-Self.Width;
  Self.Top := Screen.Height-Self.Height - iHTaskBar;
end;

procedure TF_main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  AnimateWindow(Self.Handle, 300, AW_HOR_POSITIVE or AW_SLIDE + AW_HIDE); // 由左到右 退出
  //AnimateWindow(Self.Handle, 300, AW_SLIDE + AW_HOR_NEGATIVE + AW_HIDE); // 由右到左 退出
end;

procedure TF_main.FormDestroy(Sender: TObject);
begin
  EndHook;
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
  EXSQLClientDataSet('update NoticeToSysAdmin set AlreadyRead=1 where id in '+PuID);
  Self.Close;
end;

end.

