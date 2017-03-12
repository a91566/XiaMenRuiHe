library DepotInfo;

uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  Dialogs,
  U_DepotInfo in 'U_DepotInfo.pas' {F_DepotInfo},
  UDM in '..\UDM.pas' {FDM: TDataModule},
  ZsbVariable2 in '..\ZsbVariable2.pas',
  ZsbDLL2 in '..\ZsbDLL2.pas',
  ZsbFunPro2 in '..\ZsbFunPro2.pas';

{$R *.res}

var
  DLLApp: TApplication;
  
function ShowF_DepotInfoApp(var App:TApplication):Boolean; stdcall;
begin
  try
    Application:=App;
    F_DepotInfo := TF_DepotInfo.Create(nil);
    F_DepotInfo.WindowState:=wsMaximized;
    F_DepotInfo.Show;
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
  ShowF_DepotInfoApp;

begin
  DLLApp := Application; {��DLL���Ԥ�ȴ���DLL��Application}
  DLLProc := @DLLUnloadProc; {DllProc��DLL��ں���ָ�롣Delphi����Ϊ DllProc: TDLLProc;} {�ڴ�ָ�������Լ�����ĺ���}
end.



