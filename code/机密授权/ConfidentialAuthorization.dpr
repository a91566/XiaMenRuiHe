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


  {��дDll��ں����������������} //�������еĶ��ʺ� �����������ʱ�����Ҫ
procedure DLLUnloadProc(Reason: Integer); register;
begin
{DLLȡ������ʱ������DLL_PROCESS_DETACH��Ϣ����ʱ��DLL��Application����Ϊ����}
  if (Reason = DLL_PROCESS_DETACH) or (Reason = DLL_THREAD_DETACH) then Application := DLLApp;
end;


exports
  SetUserDept,
  ShowConfidentialAuthorization,
  ShowConfidentialAuthorization_Set;

begin
  DLLApp := Application; {��DLL���Ԥ�ȴ���DLL��Application}
  DLLProc := @DLLUnloadProc; {DllProc��DLL��ں���ָ�롣Delphi����Ϊ DllProc: TDLLProc;} {�ڴ�ָ�������Լ�����ĺ���}
end.




