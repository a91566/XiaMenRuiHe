library YuancailiaokucunSerach;

uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  Dialogs,
  U_YuancailiaokucunSerach in 'U_YuancailiaokucunSerach.pas' {F_YuancailiaokucunSerach},
  UDM in '..\UDM.pas' {FDM: TDataModule},
  ZsbDLL2 in '..\ZsbDLL2.pas',
  ZsbFunPro2 in '..\ZsbFunPro2.pas',
  ZsbVariable2 in '..\ZsbVariable2.pas';

{$R *.res}
var
  DLLApp: TApplication;

function ShowF_YuancailiaokucunSerachApp(var app:TApplication):Boolean; stdcall;
begin
  try  
    Application:=app;
    F_YuancailiaokucunSerach := TF_YuancailiaokucunSerach.Create(nil);
    F_YuancailiaokucunSerach.WindowState:=wsMaximized;
    F_YuancailiaokucunSerach.Show;
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
  ShowF_YuancailiaokucunSerachApp;

begin
  DLLApp := Application; {��DLL���Ԥ�ȴ���DLL��Application}
  DLLProc := @DLLUnloadProc; {DllProc��DLL��ں���ָ�롣Delphi����Ϊ DllProc: TDLLProc;} {�ڴ�ָ�������Լ�����ĺ���}
end.


