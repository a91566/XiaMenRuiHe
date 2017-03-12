library CangKuJinHuoDanYanZhen;

uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  Dialogs,
  U_CangKuJinHuoDanYanZhen in 'U_CangKuJinHuoDanYanZhen.pas' {F_CangKuJinHuoDanYanZhen},
  UDM in '..\UDM.pas' {FDM: TDataModule},
  ZsbVariable2 in '..\ZsbVariable2.pas',
  ZsbDLL2 in '..\ZsbDLL2.pas',
  ZsbFunPro2 in '..\ZsbFunPro2.pas',
  U_YanZhenResult in 'U_YanZhenResult.pas' {F_YanZhenResult};

{$R *.res}

var
  DLLApp: TApplication;

function ShowF_CangKuJinHuoDanYanZhenApp(var app:TApplication):Boolean; stdcall;
begin
  try 
    Application:=app;
    F_CangKuJinHuoDanYanZhen := TF_CangKuJinHuoDanYanZhen.Create(nil);
    F_CangKuJinHuoDanYanZhen.WindowState:=wsMaximized;
    F_CangKuJinHuoDanYanZhen.Show;
    Result:=True;
  finally

  end;
end;

Procedure SetUserDept(strUser,strDept:PChar); stdcall;
begin
  ZStrUser:=StrPas(strUser);
  ZStrUserDept:=StrPas(strDept);
end;


{重写Dll入口函数，否则程序会出错} //不是所有的都适合 ，有主窗体的时候才需要
procedure DLLUnloadProc(Reason: Integer); register;
begin
{DLL取消调用时，发送DLL_PROCESS_DETACH消息，此时将DLL的Application返回为本身}
  if (Reason = DLL_PROCESS_DETACH) or (Reason = DLL_THREAD_DETACH) then Application := DLLApp;
end;


exports
  SetUserDept,
  ShowF_CangKuJinHuoDanYanZhenApp;

begin
  DLLApp := Application; {在DLL入口预先储存DLL的Application}
  DLLProc := @DLLUnloadProc; {DllProc：DLL入口函数指针。Delphi定义为 DllProc: TDLLProc;} {在此指向我们自己定义的函数}
end.


