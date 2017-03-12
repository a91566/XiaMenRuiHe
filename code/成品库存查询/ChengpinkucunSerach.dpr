library ChengpinkucunSerach;

{详情可见文档
（需求内容（供软件开发人员参考）.xls）
打印标签页
}

uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  Dialogs,
  U_ChengpinkucunSerach in 'U_ChengpinkucunSerach.pas' {F_ChengpinkucunSerach},
  UDM in '..\UDM.pas' {FDM: TDataModule},
  ZsbVariable2 in '..\ZsbVariable2.pas',
  ZsbDLL2 in '..\ZsbDLL2.pas',
  ZsbFunPro2 in '..\ZsbFunPro2.pas',
  U_ScrapReason in 'U_ScrapReason.pas' {F_ScrapReason},
  U_BaoFeiFenXi in 'U_BaoFeiFenXi.pas' {F_BaoFeiFenXi};

{$R *.res}

var
  DLLApp: TApplication;

function ShowF_ChengpinkucunSerachApp(var App:TApplication):Boolean; stdcall;
begin
  try
    Application:=App;
    F_ChengpinkucunSerach := TF_ChengpinkucunSerach.Create(nil);
    F_ChengpinkucunSerach.WindowState:=wsMaximized;
    F_ChengpinkucunSerach.Show;
    Result:=True;
  finally

  end;
end;

Procedure SetUserDept(strUserCode,strUser,strDept:PChar); stdcall;
begin
  ZStrUserCode:=StrPas(strUserCode);
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
  ShowF_ChengpinkucunSerachApp;

begin
  DLLApp := Application; {在DLL入口预先储存DLL的Application}
  DLLProc := @DLLUnloadProc; {DllProc：DLL入口函数指针。Delphi定义为 DllProc: TDLLProc;} {在此指向我们自己定义的函数}
end.




