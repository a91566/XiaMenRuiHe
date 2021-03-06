unit U_SelectPrintSupply;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, DBClient, Grids, DBGridEh, ComCtrls, StdCtrls;

type
  TF_SelectPrintSupply = class(TForm)
    Panel2: TPanel;
    Image1: TImage;
    Panel1: TPanel;
    Panel3: TPanel;
    Image2: TImage;
    Button1: TButton;
    Button2: TButton;
    Panel4: TPanel;
    Button3: TButton;
    DBGridEh1: TDBGridEh;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    Timer1: TTimer;
    LabeledEdit1: TLabeledEdit;
    procedure Button3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public
    strPuResult1,strPuResult2:string;
    { Public declarations }
  end;

var
  F_SelectPrintSupply: TF_SelectPrintSupply;

implementation

uses ZsbFunPro2;

{$R *.dfm}

procedure TF_SelectPrintSupply.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_SelectPrintSupply.Button3Click(Sender: TObject);
var
  strsql:string;
begin
  strsql := 'select suprcode,suprname from supplier where 1=1';
  if LabeledEdit1.Text <> '' then
  begin
    strsql := strsql + ' and suprname like ''%' + LabeledEdit1.Text + '%''';
  end;
  SelectClientDataSet(ClientDataSet1,strsql);
end;

procedure TF_SelectPrintSupply.Timer1Timer(Sender: TObject);
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
  Button3.Click;
end;

procedure TF_SelectPrintSupply.Button1Click(Sender: TObject);
begin
  if ClientDataSet1.RecordCount=0 then exit; 
  strPuResult1:=ClientDataSet1.fieldbyname('suprcode').AsString;
  strPuResult2:=ClientDataSet1.fieldbyname('suprname').AsString;
  Self.Close;
end;

procedure TF_SelectPrintSupply.Button2Click(Sender: TObject);
begin
  strPuResult1:='';
  strPuResult2:='';
  Self.Close;
end;

procedure TF_SelectPrintSupply.DBGridEh1DblClick(Sender: TObject);
begin
  Button1.Click;
end;

end.
