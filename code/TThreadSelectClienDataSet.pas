unit TThreadSelectClienDataSet;

interface

uses
  Classes, DBClient;

type
  ThreadSelectClienDataSet = class(TThread)
  private
    strsqlXXX: string;
    bOtherSysD: Boolean;
    ClientDataSetXXX: TClientDataSet;
    { Private declarations }
  protected
    procedure Execute; override;
  public
    constructor Create(ClientDataSet1: TClientDataSet; strSQL: string;bTemp:Boolean=False); //Ϊ�˴���
    procedure TSelectClienDataSet;
  end;

implementation

uses ZsbFunPro2, U_SelectPrintInfo;

constructor ThreadSelectClienDataSet.Create(ClientDataSet1: TClientDataSet; strSQL: string;bTemp:Boolean=False);
begin
  FreeonTerminate := true; //��ִ������Ƿ��Զ�����
  strsqlXXX := strSQL;
  ClientDataSetXXX := ClientDataSet1;
  bOtherSysD:=bTemp;
  inherited Create(False); //��ʾ�Ƿ����falseֱ��ִ��execure����
end;

procedure ThreadSelectClienDataSet.Execute;
begin
  Synchronize(TSelectClienDataSet);
end;

procedure ThreadSelectClienDataSet.TSelectClienDataSet;
begin
  if bOtherSysD then
  begin   
    with ClientDataSetXXX do
    begin
      data := RemoteServer.AppServer.HISFUN_GetDataSql(strsqlXXX);
      //RemoteServer.AppServer.HISFUN_peradd(strsqlXXX);
    end;
  end
  else
  begin
    SelectClientDataSetNoTips(ClientDataSetXXX, strsqlXXX);
  end;
end;

end.

