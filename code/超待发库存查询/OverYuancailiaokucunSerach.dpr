library OverYuancailiaokucunSerach;

uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  Dialogs,
  U_OverYuancailiaokucunSerach in 'U_OverYuancailiaokucunSerach.pas' {F_OverYuancailiaokucunSerach},
  UDM in '..\UDM.pas' {FDM: TDataModule},
  ZsbVariable2 in '..\ZsbVariable2.pas',
  ZsbDLL2 in '..\ZsbDLL2.pas',
  ZsbFunPro2 in '..\ZsbFunPro2.pas';

{$R *.res}
var
  DLLApp: TApplication;

function ShowF_OverYuancailiaokucunSerachApp(var app:TApplication):Boolean; stdcall;
begin
  try  
    Application:=app;
    F_OverYuancailiaokucunSerach := TF_OverYuancailiaokucunSerach.Create(nil);
    F_OverYuancailiaokucunSerach.WindowState:=wsMaximized;
    F_OverYuancailiaokucunSerach.Show;
    Result:=True;
  finally

  end;
end;


{重写Dll入口函数，否则程序会出错} //不是所有的都适合 ，有主窗体的时候才需要
procedure DLLUnloadProc(Reason: Integer); register;
begin
{DLL取消调用时，发送DLL_PROCESS_DETACH消息，此时将DLL的Application返回为本身}
  if (Reason = DLL_PROCESS_DETACH) or (Reason = DLL_THREAD_DETACH) then Application := DLLApp;
end;


exports
  ShowF_OverYuancailiaokucunSerachApp;

begin
  DLLApp := Application; {在DLL入口预先储存DLL的Application}
  DLLProc := @DLLUnloadProc; {DllProc：DLL入口函数指针。Delphi定义为 DllProc: TDLLProc;} {在此指向我们自己定义的函数}
end.


