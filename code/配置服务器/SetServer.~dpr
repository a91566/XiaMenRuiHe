library SetServer;


uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  U_setserver in 'U_setserver.pas' {F_setserver};

{$R *.res}
var
  DLLApp: TApplication;


procedure ProSetServer; stdcall;
begin
  try
    F_setserver := TF_setserver.Create(nil); //创建子窗体，子窗体随着ParentForm存在、释放。
    F_setserver.ShowModal;
  finally
    FreeAndNil(F_setserver);
  end;
end;  

{重写Dll入口函数，否则程序会出错}
procedure DLLUnloadProc(Reason: Integer); register;
begin
{DLL取消调用时，发送DLL_PROCESS_DETACH消息，此时将DLL的Application返回为本身} 
  if (Reason = DLL_PROCESS_DETACH) or (Reason = DLL_THREAD_DETACH) then Application := DLLApp;
end;

exports
  ProSetServer;

begin
  DLLApp := Application; {在DLL入口预先储存DLL的Application}
  DLLProc := @DLLUnloadProc; {DllProc：DLL入口函数指针。Delphi定义为 DllProc: TDLLProc;} {在此指向我们自己定义的函数}
end.
 