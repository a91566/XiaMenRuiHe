library LoginIn;

uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  Dialogs,
  UDM in '..\UDM.pas' {FDM: TDataModule},
  U_LoginIn in 'U_LoginIn.pas' {F_LoginIn},
  ZsbVariable2 in '..\ZsbVariable2.pas',
  ZsbDLL2 in '..\ZsbDLL2.pas',
  ZsbFunPro2 in '..\ZsbFunPro2.pas',
  U_TSCLinkDBThread in 'U_TSCLinkDBThread.pas';

{$R *.res}

var                         
  DLLApp: TApplication;

{

���¼һֱ�и�����ѽ,����ֵ����ΪPChar,PWideChar,��������յ����������� ,WideString ���ܲ����ַ�����
Integer��String����������
              }

function ShowF_LoginIn:string; stdcall;
begin
  try
    F_LoginIn := TF_LoginIn.Create(nil);
    F_LoginIn.ShowModal; 
    Result:=PCharPuOpercode;
  finally
    FreeAndNil(F_LoginIn);
  end;
end;

{��дDll��ں����������������} //�������еĶ��ʺ� �����������ʱ�����Ҫ
procedure DLLUnloadProc(Reason: Integer); register;
begin
{DLLȡ������ʱ������DLL_PROCESS_DETACH��Ϣ����ʱ��DLL��Application����Ϊ����}
  if (Reason = DLL_PROCESS_DETACH) or (Reason = DLL_THREAD_DETACH) then Application := DLLApp;
end;


exports
  ShowF_LoginIn;

begin
  DLLApp := Application; {��DLL���Ԥ�ȴ���DLL��Application}
  DLLProc := @DLLUnloadProc; {DllProc��DLL��ں���ָ�롣Delphi����Ϊ DllProc: TDLLProc;} {�ڴ�ָ�������Լ�����ĺ���}
end.


