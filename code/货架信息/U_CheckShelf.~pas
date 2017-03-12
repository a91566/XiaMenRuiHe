unit U_CheckShelf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, DBClient, Grids, DBGridEh, RzTabs, StdCtrls;

type
  TF_CheckShelf = class(TForm)
    Panel2: TPanel;
    Image1: TImage;
    Panel1: TPanel;
    Panel3: TPanel;
    Image2: TImage;
    Button1: TButton;
    Button2: TButton;
    RzPageControl1: TRzPageControl;
    TabSheet4: TRzTabSheet;
    DBGridEh1: TDBGridEh;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    Timer1: TTimer;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private     
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public
    strPuResult:string;
    { Public declarations }
  end;

var
  F_CheckShelf: TF_CheckShelf;

implementation

uses ZsbFunPro2;

{$R *.dfm}

procedure TF_CheckShelf.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;


procedure TF_CheckShelf.Timer1Timer(Sender: TObject);
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
  SelectClientDataSet(ClientDataSet1,'select * from Shelf where state=''Y''');
  RzPageControl1.ActivePageIndex:=0;
end;

procedure TF_CheckShelf.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
end;

procedure TF_CheckShelf.Button2Click(Sender: TObject);
begin
  strPuResult:='';
  Self.Close;
end;

procedure TF_CheckShelf.DBGridEh1DblClick(Sender: TObject);
begin
  Button1.Click;
end;

procedure TF_CheckShelf.Button1Click(Sender: TObject);
begin
  strPuResult:=ClientDataSet1.fieldbyname('ShefCode').AsString;
  if strPuResult='' then
  begin
    zsbSimpleMSNPopUpShow('没有选择.');
    Exit;
  end;
  if RadioButton2.Checked then
  begin   
    strPuResult:=strPuResult+'/'+ClientDataSet1.fieldbyname('ShefName').AsString;
  end;
  Self.Close;
end;

end.
