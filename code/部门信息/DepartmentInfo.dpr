library DepartmentInfo;

uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  Dialogs,
  U_DepartmentInfo in 'U_DepartmentInfo.pas' {F_DepartmentInfo},
  UDM in '..\UDM.pas' {FDM: TDataModule},
  ZsbDLL2 in '..\ZsbDLL2.pas',
  ZsbFunPro2 in '..\ZsbFunPro2.pas',
  ZsbVariable2 in '..\ZsbVariable2.pas',
  U_ChenkDept in 'U_ChenkDept.pas' {F_ChenkDept};

{$R *.res}

var
  DLLApp: TApplication;
  


function ShowF_DepartmentInfoApp(var App:TApplication):Boolean; stdcall;
begin
  try
    Application:=App;
    F_DepartmentInfo := TF_DepartmentInfo.Create(nil);
    F_DepartmentInfo.WindowState:=wsMaximized;
    F_DepartmentInfo.Show;
    Result:=True;
  finally

  end;
end;

{��дDll��ں����������������} //�������еĶ��ʺ� �����������ʱ�����Ҫ
procedure DLLUnloadProc(Reason: Integer); register;
begin
{DLLȡ������ʱ������DLL_PROCESS_DETACH��Ϣ����ʱ��DLL��Application����Ϊ����}
  if (Reason = DLL_PROCESS_DETACH) or (Reason = DLL_THREAD_DETACH) then Application := DLLApp;
end;


exports  
  ShowF_DepartmentInfoApp;

begin
  DLLApp := Application; {��DLL���Ԥ�ȴ���DLL��Application}
  DLLProc := @DLLUnloadProc; {DllProc��DLL��ں���ָ�롣Delphi����Ϊ DllProc: TDLLProc;} {�ڴ�ָ�������Լ�����ĺ���}
end.

