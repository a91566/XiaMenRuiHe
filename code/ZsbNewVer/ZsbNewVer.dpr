program ZsbNewVer;

uses
  Forms,
  Windows,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

var   
  hExe: hWnd;

begin
  Application.Initialize;
  Application.Title:='ZsbNewVer';
    
  hExe:=CreateMutex(nil,false,'ZsbNewVer');
  if GetLastError<>Error_Already_Exists then
  begin
    Application.CreateForm(TForm1, Form1);
    Application.Run;
  end
end.
