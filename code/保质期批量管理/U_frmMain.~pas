unit U_frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect, ComObj, StrUtils,
  psBarcode, frxClass, frxBarcode, Clipbrd, frxDesgn, RzEdit, ComCtrls;

type
  TfrmMain = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    Timer2: TTimer;
    Image1: TImage;
    ClientDataSet10: TClientDataSet;
    TabSheet2: TRzTabSheet;
    RzPanel77: TRzPanel;
    RzPanel8: TRzPanel;
    DBGridEh1: TDBGridEh;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    SpeedButton2: TSpeedButton;
    Button1: TButton;
    ClientDataSet33: TClientDataSet;
    RzPanel1: TRzPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Edit1: TEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Label17Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Label16Click(Sender: TObject);
  private
    sqlWhere:string;
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public
    { Public declarations }
  end;

const
  cReadMe = '保质期批量管理,功能说明:' +
    #13 + #10 + #13 + #10 + '2015年5月12日 21:33:57 郑少宝';

var
  frmMain: TfrmMain;

implementation //ZsbMsgBoxOkNoBlack

uses UDM, ZsbFunPro2, ZsbDLL2, ZsbVariable2;

{$R *.dfm}

procedure TfrmMain.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmMain.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05
  Action := caFree;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Self.Top := 0;
  Self.Top := 0;
  self.Height := Screen.Height;
  Self.Width := Screen.Width;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  //AnimateWindow(Handle, 250, AW_CENTER); //窗口由小变大
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
var
  h: THandle;
  bit: TBitmap;
begin
  Timer1.Enabled := False;
  if FileExists(ExtractFilePath(Application.Exename) + 'BitBtnImageFormZsbDll2.dll') then
  begin
    h := LoadLibrary('BitBtnImageFormZsbDll2.dll'); //载入 DLL
    bit := TBitmap.Create;
    bit.LoadFromResourceName(h, 'imgLZtopForZhuiSuSYS2'); //提取资源
    Image1.Picture.Assign(bit);
    FreeLibrary(h); //载卸 DLL
    bit.Free;
  end;
  RzPageControl1.ActivePageIndex:=0;
  RzPageControl1.Visible := True;
end;

procedure TfrmMain.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled := False;
  try
    FDM := TFDM.Create(nil);
    FDM.RestartLink; //创建数据库连接
    if FDM.booPuLinkDBSta = False then
    begin
      if Application.MessageBox(PChar(FDM.strPuLinkError), '错误信息', MB_ICONERROR + MB_RETRYCANCEL) = idRETRY then
      begin
        FDM.RestartLink;
      end
      else
      begin
        Self.Close;
      end;
    end;
    LabeledEdit1.SetFocus;
  finally
  end;
end;

procedure TfrmMain.SpeedButton2Click(Sender: TObject);
var
  strsql: string;
begin
  strsql := 'select Material.MatlCode,Material.MatlName,Material.ValidDate,Material.SuprCode,Supplier.SuprName'+
  ' from Material,Supplier where Material.SuprCode=Supplier.SuprCode';

  sqlWhere:='';
  if LabeledEdit1.Text <> '' then
  begin
    sqlWhere := ' and Material.MatlCode like ''' + LabeledEdit1.Text + '%''';
  end;
  if LabeledEdit2.Text <> '' then
  begin
    sqlWhere := sqlWhere + ' and Material.SuprCode like ''' + LabeledEdit2.Text + '%''';
  end;
  if LabeledEdit3.Text <> '' then
  begin
    sqlWhere := sqlWhere + ' and Supplier.SuprName like ''' + LabeledEdit3.Text + '%''';
  end;   
  if LabeledEdit4.Text <> '' then
  begin
    sqlWhere := sqlWhere + ' and Material.ValidDate=''' + LabeledEdit4.Text + '''';
  end;
  strsql := strsql + sqlWhere+' order by Material.MatlCode';
  SelectClientDataSet(ClientDataSet1, strsql);
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  RzPanel1.Visible:=True;
  Edit1.SetFocus;
end;

procedure TfrmMain.Label17Click(Sender: TObject);
begin
  RzPanel1.Visible:=False;
end;

procedure TfrmMain.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in ['0'..'9', #8, '.'])) then Key := #0;
end;

procedure TfrmMain.Label16Click(Sender: TObject);
var
  exsql:string;
begin
  exsql:='update Material set ValidDate='''+Edit1.Text+''' where 1=1 '+sqlWhere;
  if EXSQLClientDataSet(ClientDataSet10,exsql)=false then
  begin
    ZsbMsgBoxInfoNoApp(Self,'操作失败！！！');
  end
  else
  begin
    zsbSimpleMSNPopUpShow('操作成功.');
    RzPanel1.Visible:=False;
    SpeedButton2.Click;
  end;
end;

end.
