program ZsbUpdateForFtp;

uses
  Forms,
  XPMan,
  Windows,
  U_main in 'U_main.pas' {Form1};


var
  hExe: hWnd;

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ZsbUpdateForFtp';
  hExe:=CreateMutex(nil,false,'ZsbUpdateForFtp');
  if GetLastError<>Error_Already_Exists then
  begin
    Application.CreateForm(TForm1, Form1);
    Application.Run;
  end
  else
  begin   
   // Application.MessageBox('����һ����ͬ�����������У�','ϵͳ��ʾ',MB_ICONERROR);
    ReleaseMutex(hExe);
  end;
end.
