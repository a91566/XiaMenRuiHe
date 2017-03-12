library ReportQianGongCheng;

uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  Dialogs,
  U_frmMain in 'U_frmMain.pas' {frmMain},
  UDM in '..\UDM.pas' {FDM: TDataModule},
  ZsbFunPro2 in '..\ZsbFunPro2.pas',
  ZsbVariable2 in '..\ZsbVariable2.pas',
  ZsbDLL2 in '..\ZsbDLL2.pas';

{$R *.res}

var
  DLLApp: TApplication;

function ShowfrmMainApp(var app:TApplication):Boolean; stdcall;
begin
  try
    Application:=app;
    frmMain := TfrmMain.Create(nil);
    frmMain.WindowState:=wsMaximized;
    frmMain.Show;
    Result:=True;
  finally

  end;
end;


{��дDll��ں����������������} //�������еĶ��ʺ� �����������ʱ�����Ҫ
procedure DLLUnloadProc(Reason: Integer); register;
begin
{DLLȡ������ʱ������DLL_PROCESS_DETACH��Ϣ����ʱ��DLL��Application����Ϊ����}
  if (Reason = DLL_PROCESS_DETACH) or (Reason = DLL_THREAD_DETACH) then Application := DLLApp;
end;


exports
  ShowfrmMainApp;

begin
  DLLApp := Application; {��DLL���Ԥ�ȴ���DLL��Application}
  DLLProc := @DLLUnloadProc; {DllProc��DLL��ں���ָ�롣Delphi����Ϊ DllProc: TDLLProc;} {�ڴ�ָ�������Լ�����ĺ���}
end.


