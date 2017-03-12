library SysSet;

uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  Dialogs,
  U_SysSet in 'U_SysSet.pas' {F_SysSet},
  UDM in '..\UDM.pas' {FDM: TDataModule},
  ZsbVariable2 in '..\ZsbVariable2.pas',
  ZsbDLL2 in '..\ZsbDLL2.pas',
  ZsbFunPro2 in '..\ZsbFunPro2.pas',
  U_frmFuncMenu in 'U_frmFuncMenu.pas' {frmFuncMenu},
  U_frmTbM in 'U_frmTbM.pas' {frmTbM},
  U_frmScaner in 'U_frmScaner.pas' {frmScaner},
  U_frmDLLVER in 'U_frmDLLVER.pas' {frmDLLVer};

{$R *.res}

var
  DLLApp: TApplication;

function ShowF_SysSetApp(var App:TApplication):Boolean; stdcall;
begin
  try
    Application:=App;
    F_SysSet := TF_SysSet.Create(nil);
    F_SysSet.WindowState:=wsMaximized;
    F_SysSet.Show;
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


  {��дDll��ں����������������} //�������еĶ��ʺ� �����������ʱ�����Ҫ
procedure DLLUnloadProc(Reason: Integer); register;
begin
{DLLȡ������ʱ������DLL_PROCESS_DETACH��Ϣ����ʱ��DLL��Application����Ϊ����}
  if (Reason = DLL_PROCESS_DETACH) or (Reason = DLL_THREAD_DETACH) then Application := DLLApp;
end;


exports
  SetUserDept,
  ShowF_SysSetApp;

begin
  DLLApp := Application; {��DLL���Ԥ�ȴ���DLL��Application}
  DLLProc := @DLLUnloadProc; {DllProc��DLL��ں���ָ�롣Delphi����Ϊ DllProc: TDLLProc;} {�ڴ�ָ�������Լ�����ĺ���}
end.




