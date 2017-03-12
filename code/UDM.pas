unit UDM;

interface

uses
  SysUtils, Classes, DB, DBClient, MConnect, SConnect, Windows, Messages,
  Forms, ShellAPI, IniFiles, WinSock,Dialogs;

type
  TFDM = class(TDataModule)
    SC: TSocketConnection;
    ClientDataSet1: TClientDataSet; //ͨ�ò�ѯ����ʾ
    ClientDataSet2: TClientDataSet; //ͨ�� ��ɾ��
    ClientDataSet3: TClientDataSet; //���ڴ���䷵�����ݼ�
    GetDatetime: TClientDataSet;    //��ȡʱ��
    GetNewAppVer: TClientDataSet;   // �°汾
    ClientDataSet4: TClientDataSet; //ͨ�� ��ɾ��
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
  path1, ServerIP1, ServerPost1, SGUID1, SName1: string; {ini �ļ�·��}
  WSAData: TWSAData;
  HostEnt: PHostEnt;
  sComputerName, sIP, fs: string;
begin
  booPuLinkDBSta:=False;
  fs := '0';
  path1 := ExtractFilePath(Application.Exename) + 'client.ini';
  ini1 := TIniFile.Create(path1); {ini ��������Ҫ�ļ�·������, ���ȱ��·����Ĭ��WindowsĿ¼}
  ServerIP1 := ini1.ReadString('SYSTEM', 'ServerIP', ''); {���һ��������Ĭ��ֵ}
  SGUID1 := ini1.ReadString('SYSTEM', 'SGUID', '');
  ServerPost1 := ini1.ReadString('SYSTEM', 'ServerPost', '');
  SName1 := ini1.ReadString('SYSTEM', 'SName', '');
  fs := ini1.ReadString('SYSTEM', 'fs', '');
  if fs = '1' then
  begin //��������IP
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
      strPuLinkError := '����������ʧ��!' + #13#10 + #13#10 +
        '�쳣������:' + e.ClassName + #13#10 + #13#10 +
        '�쳣��Ϣ:' + e.Message + #13#10 + #13#10 +
        '���������ԡ�������������,������ȡ�����˳���¼';
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
    strPuLinkError := 'Զ�̷���������ʧ��!' + #13 + #10 + #13 + #10 +
      '�������:' + #13 + #10 + #13 + #10 +
      '    ' + exception(msg.lparam).message + #13 + #10 + #13 + #10 +
      '���������ԡ�������������,������ȡ�����˳���¼';
    if Application.MessageBox(PChar(strPuLinkError), '���������ӱ��ж�.', MB_ICONERROR + MB_RETRYCANCEL) = idRETRY then
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
