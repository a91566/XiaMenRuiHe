library BuLiangPinGuanLi;

uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  Dialogs,
  U_BuLiangPinGuanLi in 'U_BuLiangPinGuanLi.pas' {F_BuLiangPinGuanLi},
  UDM in '..\UDM.pas' {FDM: TDataModule},
  ZsbDLL2 in '..\ZsbDLL2.pas',
  ZsbFunPro2 in '..\ZsbFunPro2.pas',
  ZsbVariable2 in '..\ZsbVariable2.pas';

{$R *.res}
var
  DLLApp: TApplication;

function ShowF_BuLiangPinGuanLi(var app:TApplication):Boolean; stdcall;
begin
  try  
    Application:=app;
    F_BuLiangPinGuanLi := TF_BuLiangPinGuanLi.Create(nil);
    F_BuLiangPinGuanLi.WindowState:=wsMaximized;
    F_BuLiangPinGuanLi.Show;
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
  ShowF_BuLiangPinGuanLi;

begin
  DLLApp := Application; {��DLL���Ԥ�ȴ���DLL��Application}
  DLLProc := @DLLUnloadProc; {DllProc��DLL��ں���ָ�롣Delphi����Ϊ DllProc: TDLLProc;} {�ڴ�ָ�������Լ�����ĺ���}
end.


