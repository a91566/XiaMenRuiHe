library BigBarCode;

uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  Dialogs,
  U_frmAlreadyPrint in 'U_frmAlreadyPrint.pas' {frmAlreadyPrint},
  UDM in '..\UDM.pas' {FDM: TDataModule},
  ZsbVariable2 in '..\ZsbVariable2.pas',
  ZsbDLL2 in '..\ZsbDLL2.pas',
  ZsbFunPro2 in '..\ZsbFunPro2.pas',
  U_ChangeCARTON in 'U_ChangeCARTON.pas' {F_ChangeCARTON},
  U_frmMain in 'U_frmMain.pas' {frmMain},
  U_Print in 'U_Print.pas' {F_Print};

{$R *.res}

var
  DLLApp: TApplication;
  
function ShowfrmMianApp(var App:TApplication):Boolean; stdcall;
begin
  try
    Application:=App;
    frmMain := TfrmMain.Create(nil);
    frmMain.WindowState:=wsMaximized;
    frmMain.Show;
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
  ShowfrmMianApp;

begin
  DLLApp := Application; {��DLL���Ԥ�ȴ���DLL��Application}
  DLLProc := @DLLUnloadProc; {DllProc��DLL��ں���ָ�롣Delphi����Ϊ DllProc: TDLLProc;} {�ڴ�ָ�������Լ�����ĺ���}
end.


