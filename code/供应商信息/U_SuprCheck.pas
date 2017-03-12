unit U_SuprCheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, dxTL, dxDBCtrl, dxCntner, dxDBTL, ExtCtrls, DB,
  DBClient, StdCtrls, Grids, DBGridEh;

type
  TF_SuprCheck = class(TForm)
    Panel2: TPanel;
    Image1: TImage;
    Panel1: TPanel;
    Panel3: TPanel;
    Image2: TImage;
    Button1: TButton;
    Button2: TButton;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    Timer1: TTimer;
    DBGridEh1: TDBGridEh;
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public
    strSuprType:string;//类别
    strPuResult:string;
    { Public declarations }
  end;

var
  F_SuprCheck: TF_SuprCheck;

implementation

uses ZsbFunPro2;

{$R *.dfm}

procedure TF_SuprCheck.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_SuprCheck.Timer1Timer(Sender: TObject);
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
  SelectClientDataSet(ClientDataSet1,'select * from Supplier where suprType like ''%'+strSuprType+'%''');
end;

procedure TF_SuprCheck.Button2Click(Sender: TObject);
begin
  strPuResult:='';
  Self.Close;
end;

procedure TF_SuprCheck.Button1Click(Sender: TObject);
begin
  strPuResult:=ClientDataSet1.fieldbyname('SuprCode').AsString;
  if strPuResult='' then
  begin
    zsbSimpleMSNPopUpShow('没有选择厂商.');
    Exit;
  end; 
  strPuResult:=strPuResult+'/'+ClientDataSet1.fieldbyname('SuprName').AsString;
  Self.Close;
end;

procedure TF_SuprCheck.DBGridEh1DblClick(Sender: TObject);
begin
  Button1.Click;
end;

procedure TF_SuprCheck.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
end;

end.
