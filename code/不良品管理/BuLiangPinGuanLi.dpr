library BuLiangPinGuanLi;

uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  Dialogs,
  U_BuLiangPinGuanLi in 'U_BuLiangPinGuanLi.pas' {F_BuLiangPinGuanLi},
  UDM in '..\UDM.pas' {FDM: TDataModule},
  ZsbDLL2 in '..\ZsbDLL2.pas',
  ZsbFunPro2 in '..\ZsbFunPro2.pas',
  ZsbVariable2 in '..\ZsbVariable2.pas';

{$R *.res}
var
  DLLApp: TApplication;

function ShowF_BuLiangPinGuanLi(var app:TApplication):Boolean; stdcall;
begin
  try  
    Application:=app;
    F_BuLiangPinGuanLi := TF_BuLiangPinGuanLi.Create(nil);
    F_BuLiangPinGuanLi.WindowState:=wsMaximized;
    F_BuLiangPinGuanLi.Show;
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
  ShowF_BuLiangPinGuanLi;

begin
  DLLApp := Application; {在DLL入口预先储存DLL的Application}
  DLLProc := @DLLUnloadProc; {DllProc：DLL入口函数指针。Delphi定义为 DllProc: TDLLProc;} {在此指向我们自己定义的函数}
end.


