unit U_TSCLinkDBThread;

interface

uses
  Classes,SysUtils,WinSock;

type
  TSCLinkDBThread = class(TThread)
  protected
    procedure Execute; override;
  end;

implementation

uses ZsbDLL2, UDM, U_LoginIn;

procedure TSCLinkDBThread.Execute; //2013年8月19日 11:13:15 使用线程去连接数据库  可行
var
  temp, strServerIP: string;
  WSAData: TWSAData;
  HostEnt: PHostEnt;
begin
  FreeOnTerminate := True;
  OnTerminate := F_LoginIn.ExecuteOnTerminate; //线程执行完之后执行的代码
  strServerIP := GetStringFromIni(ExtractFilePath(ParamStr(0)) + 'client.ini', 'SYSTEM', 'ServerIP');
  temp := GetStringFromIni(ExtractFilePath(ParamStr(0)) + 'client.ini', 'SYSTEM', 'fs');
  if temp = '1' then //域名解析IP
  begin
    WSAStartup(2, WSAData);
    HostEnt := gethostbyname(PChar(strServerIP));
    if HostEnt <> nil then
    begin
      with HostEnt^ do
        temp := Format('%d.%d.%d.%d', [Byte(h_addr^[0]), Byte(h_addr^[1]), Byte(h_addr^[2]), Byte(h_addr^[3])]);
    end;
    WSACleanup;
    strServerIP := temp;
  end;
  try
    FDM.booPuLinkDBSta := False;
    with FDM.SC do
    begin
      connected := false;
      Address := strServerIP;
      port := strtoint(GetStringFromIni(ExtractFilePath(ParamStr(0)) + 'client.ini', 'SYSTEM', 'ServerPost'));
      serverguid := GetStringFromIni(ExtractFilePath(ParamStr(0)) + 'client.ini', 'SYSTEM', 'SGUID');
      servername := GetStringFromIni(ExtractFilePath(ParamStr(0)) + 'client.ini', 'SYSTEM', 'SName');
      connected := true;
      FDM.booPuLinkDBSta := True;
    end;
  except
   { on E: Exception do
    begin
      DbEnablead(False);
      temp := 'LinkException:' + e.Message + '.';
      ExceptionShowStr(Application, Sender, e.Message, e.ClassName);
    end;  }
  end;
end;

end.
 