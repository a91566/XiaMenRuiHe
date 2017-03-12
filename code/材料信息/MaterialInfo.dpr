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
  U_SuprCheck in '..\��Ӧ����Ϣ\U_SuprCheck.pas' {F_SuprCheck},
  U_ChenkDept in '..\������Ϣ\U_ChenkDept.pas' {F_ChenkDept},
  U_CheckShelf in '..\������Ϣ\U_CheckShelf.pas' {F_CheckShelf};

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


{��дDll��ں����������������} //�������еĶ��ʺ� �����������ʱ�����Ҫ
procedure DLLUnloadProc(Reason: Integer); register;
begin
{DLLȡ������ʱ������DLL_PROCESS_DETACH��Ϣ����ʱ��DLL��Application����Ϊ����}
  if (Reason = DLL_PROCESS_DETACH) or (Reason = DLL_THREAD_DETACH) then Application := DLLApp;
end;


exports
  ShowF_MaterialInfoApp;

begin
  DLLApp := Application; {��DLL���Ԥ�ȴ���DLL��Application}
  DLLProc := @DLLUnloadProc; {DllProc��DLL��ں���ָ�롣Delphi����Ϊ DllProc: TDLLProc;} {�ڴ�ָ�������Լ�����ĺ���}
end.


