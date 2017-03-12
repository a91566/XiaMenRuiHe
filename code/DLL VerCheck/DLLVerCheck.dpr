program DLLVerCheck;

uses
  Forms,
  Windows,
  Dialogs,
  Umain in 'Umain.pas' {F_main},
  funpro in 'funpro.pas',
  U_DM in 'U_DM.pas' {DataModule1: TDataModule};

var
  hExe: hWnd;

{$R *.res}
begin
  Application.Initialize;
  Application.Title := 'DLLVerCheck';

  hExe := CreateMutex(nil, false, 'DLLVerCheck');
  if GetLastError <> Error_Already_Exists then
  begin
    Application.CreateForm(TDataModule1, DataModule1); 
    if LinkDBServer then
    begin
      if SelectShowOrNot = True then
      begin
        Application.CreateForm(TF_main, F_main);
        Application.Run;
      end
      else
      begin
        DataModule1.Free;
      end;
    end;
  end
  else
  begin
    ReleaseMutex(hExe);
  end;


end.

