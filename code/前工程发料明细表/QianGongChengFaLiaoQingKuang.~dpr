library QianGongChengFaLiaoQingKuang;

uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  Dialogs,
  unit2 in 'unit2.pas' {Form2},
  UDM in '..\UDM.pas' {FDM: TDataModule},
  ZsbDLL2 in '..\ZsbDLL2.pas',
  ZsbFunPro2 in '..\ZsbFunPro2.pas',
  ZsbVariable2 in '..\ZsbVariable2.pas',
  uMain in 'uMain.pas' {frmMain};

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

function ShowForm2App(var app:TApplication):Boolean; stdcall;
begin
  try  
    Application:=app;
    Form2 := TForm2.Create(nil);
    Form2.WindowState:=wsMaximized;
    Form2.Show;
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
  ShowForm2App,
  ShowfrmMainApp;

begin
  DLLApp := Application; {在DLL入口预先储存DLL的Application}
  DLLProc := @DLLUnloadProc; {DllProc：DLL入口函数指针。Delphi定义为 DllProc: TDLLProc;} {在此指向我们自己定义的函数}
end.


