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
var                         //Exception   这个参数不知道怎么传  不用
  temp: string;
begin
  try
    Application := App;
    temp := #13 + #10 + '很抱歉,系统发生了异常,错误信息如下：'  + #13 + #10 + #13 + #10;
    temp := temp +#13 + #10 + '应用程序：' + app.Title + #13 + #10 + #13 + #10;
    temp := temp + '错误信息：' + e.Message  + #13 + #10 + #13 + #10;
    temp := temp + '错误类型：' + e.ClassName + #13 + #10 + #13 + #10;
    temp := temp + '错误对象：' + Sender.ClassName + #13 + #10 + #13 + #10;
    temp := temp + '发生时间：' + FormatDateTime('yyyy年MM月dd日 HH:mm:ss', Now) + #13 + #10 + #13 + #10;
    temp := temp + '请联系管理员 或者 更正后重试.'+ #13 + #10 + #13 + #10 ;
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
    temp := #13 + #10 + '很抱歉,系统发生了异常,错误信息如下：'  + #13 + #10 + #13 + #10;
    temp := temp + '应用程序：' + app.Title + #13 + #10 + #13 + #10;
    temp := temp + '错误信息：' + eMessage  + #13 + #10 + #13 + #10;
    temp := temp + '错误类型：' + eClassName + #13 + #10 + #13 + #10;
    temp := temp + '错误对象：' + Sender.ClassName + #13 + #10 + #13 + #10;
    temp := temp + '发生时间：' + FormatDateTime('yyyy年MM月dd日 HH:mm:ss', Now) + #13 + #10 + #13 + #10;  
    temp := temp + '请联系管理员 或者 更正后重试.' + #13 + #10 + #13 + #10;  

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
    F_Exception.Label12.Caption:='系统异常';
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
    temp := #13 + #10 + '很抱歉,系统发生了异常,错误信息如下：'  + #13 + #10 + #13 + #10;
    temp := temp + '应用程序：' + app.Title + #13 + #10 + #13 + #10;
    temp := temp + '错误信息：' + eMessage  + #13 + #10 + #13 + #10;
    temp := temp + '错误类型：' + eClassName + #13 + #10 + #13 + #10;
    temp := temp + '错误对象：' + Sender.ClassName + #13 + #10 + #13 + #10;
    temp := temp + '发生时间：' + FormatDateTime('yyyy年MM月dd日 HH:mm:ss', Now) + #13 + #10 + #13 + #10;  
    temp := temp + '请联系管理员 或者 更正后重试.' + #13 + #10 + #13 + #10;

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


{重写Dll入口函数，否则程序会出错}
//DLL取消调用时，发送DLL_PROCESS_DETACH消息，此时将DLL的Application返回为本身
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
  DLLApp := Application; {在DLL入口预先储存DLL的Application}
  DLLProc := @DLLUnloadProc; {DllProc：DLL入口函数指针。Delphi定义为 DllProc: TDLLProc;} {在此指向我们自己定义的函数}
end.

 