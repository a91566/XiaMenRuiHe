library Quanxianshezhi;

uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  Dialogs,
  U_Quanxianshezhi in 'U_Quanxianshezhi.pas' {F_Quanxianshezhi},
  UDM in '..\UDM.pas' {FDM: TDataModule},
  ZsbVariable2 in '..\ZsbVariable2.pas',
  ZsbDLL2 in '..\ZsbDLL2.pas',
  ZsbFunPro2 in '..\ZsbFunPro2.pas';

{$R *.res}

var
  DLLApp: TApplication;
  
function ShowF_QuanxianshezhiApp(var App:TApplication):Boolean; stdcall;
begin
  try
    Application:=App;
    F_Quanxianshezhi := TF_Quanxianshezhi.Create(nil);
    //F_Quanxianshezhi.WindowState:=wsMaximized;
    F_Quanxianshezhi.Show;
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
  ShowF_QuanxianshezhiApp;

begin
  DLLApp := Application; {��DLL���Ԥ�ȴ���DLL��Application}
  DLLProc := @DLLUnloadProc; {DllProc��DLL��ں���ָ�롣Delphi����Ϊ DllProc: TDLLProc;} {�ڴ�ָ�������Լ�����ĺ���}
end.


