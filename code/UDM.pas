unit UDM;

interface

uses
  SysUtils, Classes, DB, DBClient, MConnect, SConnect, Windows, Messages,
  Forms, ShellAPI, IniFiles, WinSock,Dialogs;

type
  TFDM = class(TDataModule)
    SC: TSocketConnection;
    ClientDataSet1: TClientDataSet; //通用查询不显示
    ClientDataSet2: TClientDataSet; //通用 增删改
    ClientDataSet3: TClientDataSet; //用于窗体间返回数据集
    GetDatetime: TClientDataSet;    //获取时间
    GetNewAppVer: TClientDataSet;   // 新版本
    ClientDataSet4: TClientDataSet; //通用 增删改
    procedure DataModuleCreate(Sender: TObject);
    procedure OnMessage(var msg: Tmsg; var Handled: Boolean);
    procedure RestartLink;   
  private
    { Private declarations }
  public
    booPuLinkDBSta: Boolean;
    strPuLinkError:string;
    { Public declarations }
  end;

var
  FDM: TFDM;

implementation

uses ZsbFunPro2;

{$R *.dfm}

procedure TFDM.RestartLink;
var
  ini1: TIniFile;
  path1, ServerIP1, ServerPost1, SGUID1, SName1: string; {ini 文件路径}
  WSAData: TWSAData;
  HostEnt: PHostEnt;
  sComputerName, sIP, fs: string;
begin
  booPuLinkDBSta:=False;
  fs := '0';
  path1 := ExtractFilePath(Application.Exename) + 'client.ini';
  ini1 := TIniFile.Create(path1); {ini 对象建立需要文件路径参数, 如果缺少路径会默认Windows目录}
  ServerIP1 := ini1.ReadString('SYSTEM', 'ServerIP', ''); {最后一个参数是默认值}
  SGUID1 := ini1.ReadString('SYSTEM', 'SGUID', '');
  ServerPost1 := ini1.ReadString('SYSTEM', 'ServerPost', '');
  SName1 := ini1.ReadString('SYSTEM', 'SName', '');
  fs := ini1.ReadString('SYSTEM', 'fs', '');
  if fs = '1' then
  begin //域名解析IP
    sComputername := ServerIP1;
    WSAStartup(2, WSAData);
    HostEnt := gethostbyname(PChar(sComputerName));
    if HostEnt <> nil then
    begin
      with HostEnt^ do
        sIP := Format('%d.%d.%d.%d', [Byte(h_addr^[0]), Byte(h_addr^[1]), Byte(h_addr^[2]), Byte(h_addr^[3])]);
    end;
    WSACleanup;
    ServerIP1 := sIP;
  end;

  try  
    with SC do
    begin
      connected := false;
      SC.Address := ServerIP1;
      port := strtoint(ServerPost1);
      serverguid := SGUID1;
      servername := SName1;
      connected := true;
      booPuLinkDBSta:=True;
    end;
  except
    on E: Exception do
    begin
      strPuLinkError := '服务器链接失败!' + #13#10 + #13#10 +
        '异常类名称:' + e.ClassName + #13#10 + #13#10 +
        '异常信息:' + e.Message + #13#10 + #13#10 +
        '单击【重试】尝试重新连接,单击【取消】退出登录';
    end;
  end; 
end;

procedure TFDM.OnMessage(var msg: Tmsg; var Handled: Boolean);
begin
  booPuLinkDBSta := True;
  if msg.message = thread_exception then
  begin
    booPuLinkDBSta := False;
    Handled := True;
    strPuLinkError := '远程服务器连接失败!' + #13 + #10 + #13 + #10 +
      '错误代码:' + #13 + #10 + #13 + #10 +
      '    ' + exception(msg.lparam).message + #13 + #10 + #13 + #10 +
      '单击【重试】尝试重新连接,单击【取消】退出登录';
    if Application.MessageBox(PChar(strPuLinkError), '服务器连接被中断.', MB_ICONERROR + MB_RETRYCANCEL) = idRETRY then
    begin
      RestartLink;
    end;
  end;
end;

procedure TFDM.DataModuleCreate(Sender: TObject);
begin
  Application.OnMessage := OnMessage;
end;

end.

