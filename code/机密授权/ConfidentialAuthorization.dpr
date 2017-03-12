library ConfidentialAuthorization;

uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  Dialogs,
  U_MainSet in 'U_MainSet.pas' {frmMainSet},
  UDM in '..\UDM.pas' {FDM: TDataModule},
  ZsbVariable2 in '..\ZsbVariable2.pas',
  ZsbDLL2 in '..\ZsbDLL2.pas',
  ZsbFunPro2 in '..\ZsbFunPro2.pas',
  U_Main in 'U_Main.pas' {frmMain};

{$R *.res}

var
  DLLApp: TApplication;

function ShowConfidentialAuthorization(var App:TApplication):Boolean; stdcall;
begin
  try
    Application:=App;
    frmMain := TfrmMain.Create(nil);
    frmMain.ShowModal;
    if frmMain.ModalResult=1 then
    begin
      Result:=True;
    end
    else
    begin
      Result:=False;
    end;
  finally

  end;
end;

function ShowConfidentialAuthorization_Set(var App:TApplication):Boolean; stdcall;
begin
  try
    Application:=App;
    frmMainSet := TfrmMainSet.Create(nil);
    frmMainSet.ShowModal;
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
  ShowConfidentialAuthorization,
  ShowConfidentialAuthorization_Set;

begin
  DLLApp := Application; {在DLL入口预先储存DLL的Application}
  DLLProc := @DLLUnloadProc; {DllProc：DLL入口函数指针。Delphi定义为 DllProc: TDLLProc;} {在此指向我们自己定义的函数}
end.




