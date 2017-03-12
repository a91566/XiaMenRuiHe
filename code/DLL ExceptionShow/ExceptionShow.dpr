library ExceptionShow;


uses
  SysUtils,
  System,
  Forms,
  Classes,
  Windows,
  U_Exception in 'U_Exception.pas' {F_Exception},
  U_ZsbBlack in 'U_ZsbBlack.pas' {F_Zsbblack};

{$R *.res}

var
  DLLApp: TApplication;

procedure ExceptionShowE(var app: TApplication; Sender: TObject; E: Exception); stdcall;
var                         //Exception   ���������֪����ô��  ����
  temp: string;
begin
  try
    Application := App;
    temp := #13 + #10 + '�ܱ�Ǹ,ϵͳ�������쳣,������Ϣ���£�'  + #13 + #10 + #13 + #10;
    temp := temp +#13 + #10 + 'Ӧ�ó���' + app.Title + #13 + #10 + #13 + #10;
    temp := temp + '������Ϣ��' + e.Message  + #13 + #10 + #13 + #10;
    temp := temp + '�������ͣ�' + e.ClassName + #13 + #10 + #13 + #10;
    temp := temp + '�������' + Sender.ClassName + #13 + #10 + #13 + #10;
    temp := temp + '����ʱ�䣺' + FormatDateTime('yyyy��MM��dd�� HH:mm:ss', Now) + #13 + #10 + #13 + #10;
    temp := temp + '����ϵ����Ա ���� ����������.'+ #13 + #10 + #13 + #10 ;
    if Application.FindComponent('F_Exception') = nil then
    begin
      Application.CreateForm(TF_Exception, F_Exception);
      Application.CreateForm(TF_Zsbblack, F_Zsbblack);
    end;
    F_Exception.Memo1.Lines.Add(temp); 
    F_Exception.Label12.Caption:=App.Title;
    MessageBeep(MB_ICONERROR);
    F_Exception.ShowModal;
  finally
    FreeAndNil(F_Exception);
  end;
end;

procedure ExceptionShowStr(var app: TApplication;Sender: TObject; eMessage,eClassName:string); stdcall;
var
  temp: string;
begin
  try
    Application := App;
    temp := #13 + #10 + '�ܱ�Ǹ,ϵͳ�������쳣,������Ϣ���£�'  + #13 + #10 + #13 + #10;
    temp := temp + 'Ӧ�ó���' + app.Title + #13 + #10 + #13 + #10;
    temp := temp + '������Ϣ��' + eMessage  + #13 + #10 + #13 + #10;
    temp := temp + '�������ͣ�' + eClassName + #13 + #10 + #13 + #10;
    temp := temp + '�������' + Sender.ClassName + #13 + #10 + #13 + #10;
    temp := temp + '����ʱ�䣺' + FormatDateTime('yyyy��MM��dd�� HH:mm:ss', Now) + #13 + #10 + #13 + #10;  
    temp := temp + '����ϵ����Ա ���� ����������.' + #13 + #10 + #13 + #10;  

    if Application.FindComponent('F_Exception') = nil then
    begin
      Application.CreateForm(TF_Exception, F_Exception);
    end;
    F_Exception.Label12.Caption:=App.Title;
    F_Exception.Memo1.Lines.Add(temp);
    F_Exception.booBlack:=false;
    F_Exception.ShowModal;
  finally
    FreeAndNil(F_Exception);
  end;
end;

procedure ExceptionShowStrNoApp(eMessage:string;bBlack:Boolean=False); stdcall;
begin
  try
    if bBlack then
    begin
      Application.CreateForm(TF_Zsbblack, F_Zsbblack);
      F_Zsbblack.Left := 0;
      F_Zsbblack.Width := Screen.Width;
      F_Zsbblack.top := 0;
      F_Zsbblack.Height := Screen.Height-30;
      F_Zsbblack.Show;
    end;
    
    if Application.FindComponent('F_Exception') = nil then
    begin
      Application.CreateForm(TF_Exception, F_Exception);
    end;
    F_Exception.booBlack:=bBlack;
    F_Exception.Label12.Caption:='ϵͳ�쳣';
    F_Exception.Memo1.Lines.Add(eMessage);
    F_Exception.booBlack:=bBlack;
    F_Exception.ShowModal;
  finally
    FreeAndNil(F_Exception);
  end;
end;

procedure ExceptionShowStrHaveBlack(var app: TApplication;Sender: TObject; eMessage,eClassName:string); stdcall;
var
  temp: string;
begin
  try
    Application := App;
    temp := #13 + #10 + '�ܱ�Ǹ,ϵͳ�������쳣,������Ϣ���£�'  + #13 + #10 + #13 + #10;
    temp := temp + 'Ӧ�ó���' + app.Title + #13 + #10 + #13 + #10;
    temp := temp + '������Ϣ��' + eMessage  + #13 + #10 + #13 + #10;
    temp := temp + '�������ͣ�' + eClassName + #13 + #10 + #13 + #10;
    temp := temp + '�������' + Sender.ClassName + #13 + #10 + #13 + #10;
    temp := temp + '����ʱ�䣺' + FormatDateTime('yyyy��MM��dd�� HH:mm:ss', Now) + #13 + #10 + #13 + #10;  
    temp := temp + '����ϵ����Ա ���� ����������.' + #13 + #10 + #13 + #10;

    Application.CreateForm(TF_Zsbblack, F_Zsbblack);
    F_Zsbblack.Left := 0;
    F_Zsbblack.Width := Screen.Width;
    F_Zsbblack.top := 0;
    F_Zsbblack.Height := Screen.Height;
    F_Zsbblack.Show;

    if Application.FindComponent('F_Exception') = nil then
    begin
      Application.CreateForm(TF_Exception, F_Exception);
    end;                    
    F_Exception.booBlack:=True;
    F_Exception.Label12.Caption:=App.Title;
    F_Exception.Memo1.Lines.Add(temp);
    F_Exception.ShowModal;
  finally
    FreeAndNil(F_Exception);
  end;
end;


{��дDll��ں����������������}
//DLLȡ������ʱ������DLL_PROCESS_DETACH��Ϣ����ʱ��DLL��Application����Ϊ����
procedure DLLUnloadProc(Reason: Integer); register;
begin
  if (Reason = DLL_PROCESS_DETACH) or (Reason = DLL_THREAD_DETACH) then
  begin
    Application := DLLApp;
  end;
end;

exports
  ExceptionShowE,
  ExceptionShowStr,
  ExceptionShowStrNoApp,   //ExceptionShowStrNoApp
  ExceptionShowStrHaveBlack;      

begin
  DLLApp := Application; {��DLL���Ԥ�ȴ���DLL��Application}
  DLLProc := @DLLUnloadProc; {DllProc��DLL��ں���ָ�롣Delphi����Ϊ DllProc: TDLLProc;} {�ڴ�ָ�������Լ�����ĺ���}
end.

 