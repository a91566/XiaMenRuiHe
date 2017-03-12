unit ZsbDLL;

interface

uses Forms,Windows;

function Get16MD5ForString(str: WideString): WideString; stdcall; external 'MD5FromDelphi.dll'; 
function GetVersionString(FileName: WideString): WideString; stdcall; external 'GetVersion.dll';
function GetStringFromIni(FromFile,Section, Ident:WideString): WideString;stdcall; external 'OperIniFile.dll'; 
function SetStringToIni(ToFile,Section,Ident,strValue:WideString): Boolean;stdcall; external 'OperIniFile.dll';
function SimpleMSNPopUpShow(strText: string;iStartX,iStartY:SmallInt): Boolean; stdcall;external 'MSNPopUpHelper.dll';

function MSNPopUpShow(strText: string; strTitle: string = '提示信息'; iShowTime: SmallInt = 10;
  iHeight: SmallInt = 100; iWidth: SmallInt = 200): Boolean;stdcall;external 'MSNPopUpHelper.dll';

procedure ExceptionShowStrNoApp(eMessage: string; bBlack: Boolean = False); stdcall; external 'ExceptionShow.dll';
procedure ShowInfoTips(h: HWND; strShowMess: string; IconType: Integer = 1; strShowCaption: string = '提示信息'; bAutoClose: Boolean = True; iShowTime: Integer = 2000); stdcall; external 'InfoTips.dll';

//function ZsbMsgBoxOk(var App: TApplication; ParentForm: TForm; stsShow: string): Boolean; stdcall; external 'ZsbMessageBox.dll';
//procedure ZsbMsgErrorInfo(var App: TApplication; ParentForm: TForm; stsShow: string); stdcall; external 'ZsbMessageBox.dll';

//function ZsbMsgBoxOkNoBlackNoApp(ParentForm: TForm; stsShow: string): Boolean; stdcall; external 'ZsbMessageBox.dll';
//procedure ZsbMsgErrorInfoNoBlackNoApp(ParentForm: TForm; stsShow: string); stdcall; external 'ZsbMessageBox.dll';

//procedure ZsbMsgErrorInfo(var App: TApplication; ParentForm: TForm; stsShow: string); stdcall; external 'ZsbMessageBox.dll';
procedure ZsbMsgErrorInfoNoApp(ParentForm: TForm; stsShow: string); stdcall; external 'ZsbMessageBox.dll';

function ZsbMsgBoxOkNoApp(ParentForm: TForm; stsShow: string): Boolean; stdcall; external 'ZsbMessageBox.dll';
//function ZsbMsgBoxOk(var App: TApplication; ParentForm: TForm; stsShow: string): Boolean; stdcall; external 'ZsbMessageBox.dll';





implementation

uses U_main;

end.
