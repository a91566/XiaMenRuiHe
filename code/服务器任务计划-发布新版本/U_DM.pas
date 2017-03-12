unit U_DM;

interface

uses
  SysUtils, Classes, DB, DBClient, MConnect, SConnect,WinSock;


type
  TDataModule1 = class(TDataModule)
    SC: TSocketConnection;
    ClientDataSet2: TClientDataSet;
    ClientDataSet1: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

end.
