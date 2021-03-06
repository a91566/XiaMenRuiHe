unit unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  ComCtrls, DBGridEhImpExp, Menus, frxClass, psBarcode, frxCross, frxDBSet;

type
  TForm2 = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    Timer2: TTimer;
    Image1: TImage;
    TabSheet2: TRzTabSheet;
    RzPanel1: TRzPanel;
    DBGridEh1: TDBGridEh;
    ClientDataSet10: TClientDataSet;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Button1: TButton;
    ClientDataSet11: TClientDataSet;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses UDM, ZsbFunPro2, ZsbDLL2, DateUtils, ZsbVariable2;

{$R *.dfm}

procedure TForm2.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TForm2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Self.Left := 50;
  Self.Top := 50;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
end;



procedure TForm2.Timer1Timer(Sender: TObject);
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
  RzPageControl1.Visible := True;
  RzPageControl1.ActivePageIndex := 0;
end;

procedure TForm2.Timer2Timer(Sender: TObject);
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
    Button1.Click;
  finally

  end;

end;

procedure TForm2.N2Click(Sender: TObject);
var
  SHOW, strsql: string;
begin
  if ClientDataSet1.FieldByName('AutoLot').AsString = '' then Exit;
  N2.Caption := '查询该流水号[ ' + ClientDataSet1.FieldByName('AutoLot').AsString + ' ]的详细入库信息&';
  strsql := 'select MIDDONO,sysdt,MatlQuat,StockQuat from MatlInDepotMX where autolot=''' + ClientDataSet1.FieldByName('AutoLot').AsString + '''';
  SelectClientDataSetNoTips(ClientDataSet10, strsql);
  SHOW := '流水号:' + ClientDataSet1.FieldByName('AutoLot').AsString + #13 + #10 + #13 + #10;
  SHOW := SHOW + '入库单号:' + ClientDataSet10.FieldByName('MIDDONO').AsString + #13 + #10;
  SHOW := SHOW + '入库时间:' + ClientDataSet10.FieldByName('sysdt').AsString + #13 + #10;
  SHOW := SHOW + '入库数量:' + ClientDataSet10.FieldByName('MatlQuat').AsString + #13 + #10;
  SHOW := SHOW + '库存数量:' + ClientDataSet10.FieldByName('StockQuat').AsString + #13 + #10;
  ZsbShowMessageNoApp(Self, SHOW);
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  strsql: string;
begin
  if Button1.Tag = 0 then
  begin
    strsql := 'select top 50 * from QGCFLHZMx_outlog';
    zsbSimpleMSNPopUpShow_2('初始只显示前面50条记录。');
  end
  else
  begin
    strsql := 'select * from QGCFLHZMx_outlog where 1=1 ';
    if LabeledEdit1.Text <> '' then
    begin
      strSQL := strSQL + ' and QcNo=''' + LabeledEdit1.Text + '''';
    end;
    if LabeledEdit2.Text <> '' then
    begin
      strSQL := strSQL + ' and MatlCode=''' + LabeledEdit2.Text + '''';
    end;
  end;
  strsql := strsql + ' order by dt desc';
  SelectClientDataSet(ClientDataSet1, strsql);
  Button1.Tag := 1;
end;

end.

