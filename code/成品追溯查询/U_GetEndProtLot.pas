unit U_GetEndProtLot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, ExtCtrls, RzTabs, StdCtrls;

type
  TF_GetEndProtLot = class(TForm)
    Panel2: TPanel;
    Image1: TImage;
    Panel1: TPanel;
    Panel3: TPanel;
    Image2: TImage;
    Button1: TButton;
    Button2: TButton;
    RzPageControl1: TRzPageControl;
    TabSheet3: TRzTabSheet;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    Timer1: TTimer;
    DBGridEh2: TDBGridEh;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
  private   
    procedure CreateParams(var Params: TCreateParams);override;
    { Private declarations }
  public
    strPuEndProtLot,strPuResult:string;
    procedure OnShow;
    { Public declarations }
  end;

var
  F_GetEndProtLot: TF_GetEndProtLot;

implementation

uses UDM, ZsbFunPro2, ZsbDLL2;

{$R *.dfm}

procedure TF_GetEndProtLot.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_GetEndProtLot.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
end;

procedure TF_GetEndProtLot.OnShow;
var
  strsql:string;
begin
  strsql:='select * from EndProtBarCode where EndProtLot like ''%'+strPuEndProtLot+'%''';
  SelectClientDataSet(ClientDataSet1,strsql);
end;

procedure TF_GetEndProtLot.Timer1Timer(Sender: TObject);
var
  h: THandle;
  bit,bit2: TBitmap;
begin
  Timer1.Enabled := False;
  if FileExists(ExtractFilePath(Application.Exename) + 'BitBtnImageFormZsbDll2.dll') then
  begin
    h := LoadLibrary('BitBtnImageFormZsbDll2.dll'); //载入 DLL
    bit := TBitmap.Create;  
    bit2 := TBitmap.Create;
    bit.LoadFromResourceName(h, 'imgLZLeft'); //提取资源
    bit2.LoadFromResourceName(h, 'imgSkyBlue'); //提取资源
    Image1.Picture.Assign(bit); 
    Image2.Picture.Assign(bit2);
    FreeLibrary(h); //载卸 DLL
    bit.Free;  
    bit2.Free;
  end;
  Panel2.Visible:=True;
  OnShow;
end;

procedure TF_GetEndProtLot.Button1Click(Sender: TObject);
begin     
  if ClientDataSet1.fieldbyname('EndProtLot').AsString='' then Exit;
  strPuResult:=ClientDataSet1.fieldbyname('EndProtLot').AsString;
  Self.Close;
end;

procedure TF_GetEndProtLot.Button2Click(Sender: TObject);
begin
  strPuResult:='';
  Self.Close;
end;

procedure TF_GetEndProtLot.DBGridEh2DblClick(Sender: TObject);
begin
  Button1.Click;
end;

end.
