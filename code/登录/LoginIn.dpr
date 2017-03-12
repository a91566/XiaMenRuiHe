library LoginIn;

uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  Dialogs,
  UDM in '..\UDM.pas' {FDM: TDataModule},
  U_LoginIn in 'U_LoginIn.pas' {F_LoginIn},
  ZsbVariable2 in '..\ZsbVariable2.pas',
  ZsbDLL2 in '..\ZsbDLL2.pas',
  ZsbFunPro2 in '..\ZsbFunPro2.pas',
  U_TSCLinkDBThread in 'U_TSCLinkDBThread.pas';

{$R *.res}

var                         
  DLLApp: TApplication;

{

这登录一直有个问题呀,返回值类型为PChar,PWideChar,主程序接收到的总是乱码 ,WideString 接受不到字符串，
Integer与String都正常接收
              }

function ShowF_LoginIn:string; stdcall;
begin
  try
    F_LoginIn := TF_LoginIn.Create(nil);
    F_LoginIn.ShowModal; 
    Result:=PCharPuOpercode;
  finally
    FreeAndNil(F_LoginIn);
  end;
end;

{重写Dll入口函数，否则程序会出错} //不是所有的都适合 ，有主窗体的时候才需要
procedure DLLUnloadProc(Reason: Integer); register;
begin
{DLL取消调用时，发送DLL_PROCESS_DETACH消息，此时将DLL的Application返回为本身}
  if (Reason = DLL_PROCESS_DETACH) or (Reason = DLL_THREAD_DETACH) then Application := DLLApp;
end;


exports
  ShowF_LoginIn;

begin
  DLLApp := Application; {在DLL入口预先储存DLL的Application}
  DLLProc := @DLLUnloadProc; {DllProc：DLL入口函数指针。Delphi定义为 DllProc: TDLLProc;} {在此指向我们自己定义的函数}
end.


