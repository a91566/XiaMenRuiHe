library PrintBarcode;

{详情可见文档
（需求内容（供软件开发人员参考）.xls）
打印标签页
}

uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  Dialogs,
  U_PrintBarcode in 'U_PrintBarcode.pas' {F_PrintBarcode},
  UDM in '..\UDM.pas' {FDM: TDataModule},
  ZsbVariable2 in '..\ZsbVariable2.pas',
  ZsbDLL2 in '..\ZsbDLL2.pas',
  ZsbFunPro2 in '..\ZsbFunPro2.pas',
  U_SelectPrintInfo in 'U_SelectPrintInfo.pas' {F_SelectPrintInfo},
  U_SelectPrintSupply in 'U_SelectPrintSupply.pas' {F_SelectPrintSupply},
  TThreadSelectClienDataSet in '..\TThreadSelectClienDataSet.pas',
  U_PrintCodeNew in 'U_PrintCodeNew.pas' {F_PrintCodeNew},
  U_Print201411 in 'U_Print201411.pas' {F_Print201411},
  U_HandWork in 'U_HandWork.pas' {F_HandWork};

{$R *.res}

var
  DLLApp: TApplication;
  
function ShowF_PrintBarcodeApp(var App:TApplication):Boolean; stdcall;
begin
 { try
    Application:=App;
    F_Print201411 := TF_Print201411.Create(nil);
    F_Print201411.WindowState:=wsMaximized;
    F_Print201411.Show;
    Result:=True;
  finally

  end;}

  //2014年11月21日 13:36:55 进行以上的重新定位入口
 try
    Application:=App;
    F_PrintBarcode := TF_PrintBarcode.Create(nil);
    F_PrintBarcode.WindowState:=wsMaximized;
    F_PrintBarcode.Show;
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

{重写Dll入口函数，否则程序会出错} //不是所有的都适合 ，有主窗体的时候才需要
procedure DLLUnloadProc(Reason: Integer); register;
begin
{DLL取消调用时，发送DLL_PROCESS_DETACH消息，此时将DLL的Application返回为本身}
  if (Reason = DLL_PROCESS_DETACH) or (Reason = DLL_THREAD_DETACH) then Application := DLLApp;
end;  

exports
  SetUserDept,
  ShowF_PrintBarcodeApp;

begin
  DLLApp := Application; {在DLL入口预先储存DLL的Application}
  DLLProc := @DLLUnloadProc; {DllProc：DLL入口函数指针。Delphi定义为 DllProc: TDLLProc;} {在此指向我们自己定义的函数}
end.


