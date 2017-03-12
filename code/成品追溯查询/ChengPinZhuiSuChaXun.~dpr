library ChengPinZhuiSuChaXun;

uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  Dialogs,
  U_frmMain in 'U_frmMain.pas' {frmMain},
  UDM in '..\UDM.pas' {FDM: TDataModule},
  ZsbDLL2 in '..\ZsbDLL2.pas',
  ZsbFunPro2 in '..\ZsbFunPro2.pas',
  ZsbVariable2 in '..\ZsbVariable2.pas',
  U_GetEndProtLot in 'U_GetEndProtLot.pas' {F_GetEndProtLot},
  U_ChengPinZhuiSuChaXun in 'U_ChengPinZhuiSuChaXun.pas' {F_ChengPinZhuiSuChaXun};

{$R *.res}
var
  DLLApp: TApplication;

//2015年6月7日 09:14:30 郑少宝 
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

function ShowF_ChengPinZhuiSuChaXunApp(var app:TApplication):Boolean; stdcall;
begin
  try  
    Application:=app;
    F_ChengPinZhuiSuChaXun := TF_ChengPinZhuiSuChaXun.Create(nil);
    F_ChengPinZhuiSuChaXun.WindowState:=wsMaximized;
    F_ChengPinZhuiSuChaXun.Show;
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
  ShowfrmMainApp,
  ShowF_ChengPinZhuiSuChaXunApp;

begin
  DLLApp := Application; {在DLL入口预先储存DLL的Application}
  DLLProc := @DLLUnloadProc; {DllProc：DLL入口函数指针。Delphi定义为 DllProc: TDLLProc;} {在此指向我们自己定义的函数}
end.


