library MaterialInfo;

uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  Dialogs,
  U_MaterialInfo in 'U_MaterialInfo.pas' {F_MaterialInfo},
  UDM in '..\UDM.pas' {FDM: TDataModule},
  ZsbDLL2 in '..\ZsbDLL2.pas',
  ZsbFunPro2 in '..\ZsbFunPro2.pas',
  ZsbVariable2 in '..\ZsbVariable2.pas',
  U_SuprCheck in '..\供应商信息\U_SuprCheck.pas' {F_SuprCheck},
  U_ChenkDept in '..\部门信息\U_ChenkDept.pas' {F_ChenkDept},
  U_CheckShelf in '..\货架信息\U_CheckShelf.pas' {F_CheckShelf};

{$R *.res}

var
  DLLApp: TApplication;

function ShowF_MaterialInfoApp(var App:TApplication): Boolean; stdcall;
begin
  try
    Application:=App;
    F_MaterialInfo := TF_MaterialInfo.Create(nil);
    F_MaterialInfo.WindowState := wsMaximized;
    F_MaterialInfo.Show;
    Result := True;
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
  ShowF_MaterialInfoApp;

begin
  DLLApp := Application; {在DLL入口预先储存DLL的Application}
  DLLProc := @DLLUnloadProc; {DllProc：DLL入口函数指针。Delphi定义为 DllProc: TDLLProc;} {在此指向我们自己定义的函数}
end.


