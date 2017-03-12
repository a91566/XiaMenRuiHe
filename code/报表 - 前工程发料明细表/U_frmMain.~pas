unit U_frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  ComCtrls;

type
  TfrmMain = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    Timer2: TTimer;
    Image1: TImage;
    TabSheet2: TRzTabSheet;
    RzPanel2: TRzPanel;
    SpeedButton1: TSpeedButton;
    RzPanel1: TRzPanel;
    SpeedButton999: TSpeedButton;
    Label1: TLabel;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    Label3: TLabel;
    DateTimePicker2: TDateTimePicker;
    DateTimePicker1: TDateTimePicker;
    CheckBox1: TCheckBox;
    SpeedButton2: TSpeedButton;
    SaveDialog1: TSaveDialog;
    SpeedButton3: TSpeedButton;
    DBGridEh1: TDBGridEh;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ColumnsVisable(b: Boolean);
    { Private declarations }
  public
    function EXSQLClientDataSet(ClientDataSet1: TClientDataSet; EXSQL: string): Boolean;
    function SelectClientDataSetResultCount(ClientDataSet1: TClientDataSet; strSQL: string): Integer;
    procedure SelectClientDataSet(ClientDataSet1: TClientDataSet; strSQL: string);

    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses UDM, ZsbFunPro2, DBGridEhImpExp, EhLibCDS;

{$R *.dfm}

procedure TfrmMain.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
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
  RzPageControl1.Visible := True;
  RzPageControl1.ActivePageIndex := 0;
  DateTimePicker1.Date := Now - 7;
  DateTimePicker2.Date := Now;
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
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 500, AW_CENTER); //窗口由小变大
end;

function TfrmMain.SelectClientDataSetResultCount(ClientDataSet1: TClientDataSet; strSQL: string): Integer;
begin
  with ClientDataSet1 do
  begin
    data := RemoteServer.AppServer.fun_getdatasql(strSQL);
  end;
  Result := ClientDataSet1.RecordCount;
end;

procedure TfrmMain.SelectClientDataSet(ClientDataSet1: TClientDataSet; strSQL: string);
begin
  with ClientDataSet1 do
  begin
    data := RemoteServer.AppServer.fun_getdatasql(strSQL);
  end;
end;

function TfrmMain.EXSQLClientDataSet(ClientDataSet1: TClientDataSet; EXSQL: string): Boolean;
var
  temp: string;
begin
  with ClientDataSet1 do
  begin
    temp := RemoteServer.AppServer.fun_peradd(EXSQL);
  end;
  if temp = 'false' then //返回的是字符串
  begin
    result := False;
  end
  else
  begin
    result := True;
  end;
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
  finally

  end;
end;

procedure TfrmMain.CheckBox1Click(Sender: TObject);
begin
  DateTimePicker1.Enabled := CheckBox1.Checked;
  DateTimePicker2.Enabled := DateTimePicker1.Enabled;
end;

procedure TfrmMain.SpeedButton999Click(Sender: TObject);
var
  temp, temp1, temp2: string;
begin
  //temp := 'select LZm_ML_MO_OutLog.*,ZT_ML_NO_FromERP.MO_NO from LZm_ML_MO_OutLog,ZT_ML_NO_FromERP where LZm_ML_MO_OutLog.ML_NO=ZT_ML_NO_FromERP.ML_NO';

  temp := 'select * from QGCFLHZMx_outlog where 1=1 ';

  if CheckBox1.Checked then
  begin
    temp1 := FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date) + ' 00:00:00';
    temp2 := FormatDateTime('yyyy-MM-dd', DateTimePicker2.Date) + ' 23:59:59';
    temp := temp + ' and dt>=''' + temp1 + ''' and dt<=''' + temp2 + '''';
  end;
  if LabeledEdit1.Text <> '' then
  begin
    temp := temp + ' and MatlCode like ''%' + LabeledEdit1.Text + '%''';
  end;
  if LabeledEdit2.Text <> '' then
  begin
    temp := temp + ' and MatlLot like ''%' + LabeledEdit2.Text + '%''';
  end;
  if LabeledEdit3.Text <> '' then
  begin
    temp := temp + ' and MatlCode in(select MatlCode from Material where SuprCode like ''%' + LabeledEdit3.Text + '%'')';
  end;
  if LabeledEdit4.Text <> '' then
  begin
    temp := temp + ' and MatlVer like ''%' + LabeledEdit4.Text + '%''';
  end;
  if LabeledEdit5.Text <> '' then
  begin
    temp := temp + ' and AutoLot like ''%' + LabeledEdit5.Text + '%''';
  end;

  if LabeledEdit6.Text <> '' then
  begin
    temp := temp + ' and QCNo like ''%' + LabeledEdit6.Text + '%''';
  end;
  if LabeledEdit7.Text <> '' then
  begin
    temp := temp + ' and QCNo like ''%' + LabeledEdit7.Text + '''';
  end;
  temp := temp + ' order by MatlCode';

  try
    RzPageControl1.ActivePageIndex := 1;
    SelectClientDataSetnotips(ClientDataSet1, temp);
    if ClientDataSet1.RecordCount > 0 then
    begin
      DBGridEh1.FooterRowCount := 1;
      DBGridEh1.FooterDisplayStyle := True;
    end;
    ColumnsVisable(True);
  except
    on e: Exception do
    begin
      SaveMessage(temp, '.sql');
      Application.MessageBox(PChar('abnormal：' + e.Message), '系统发生异常', MB_ICONERROR);
    end;
  end;
end;

procedure TfrmMain.SpeedButton2Click(Sender: TObject);
begin
  try
    SaveDialog1.FileName := '前工程发料明细表 ' + FormatDateTime('yyyyMMddHHmmss', Now) + '.xls';
    SaveDialog1.filter := 'Execl(*.xls)|*.xls';
    if SaveDialog1.Execute then
    begin
      SaveDBGridEhToExportFile(TDBGridEhExportAsXls, DBGridEh1, SaveDialog1.FileName, true);
      zsbSimpleMSNPopUpShow('文件导出成功！' + SaveDialog1.FileName);
    end;
  except
    on e: Exception do
    begin
      zsbSimpleMSNPopUpShow_2('操作失败,请联系管理员.' + e.Message, clRed, 500);
    end;
  end;
end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
begin
  ClientDataSet1.Close;
  RzPageControl1.ActivePageIndex := 0;
end;

procedure TfrmMain.ColumnsVisable(b: Boolean);
begin
  DBGridEh1.Columns[0].Visible := b;
  DBGridEh1.Columns[1].Visible := True;
  DBGridEh1.Columns[2].Visible := True;
  DBGridEh1.Columns[3].Visible := b;
  DBGridEh1.Columns[4].Visible := b;
  DBGridEh1.Columns[5].Visible := b;
  DBGridEh1.Columns[6].Visible := b;
  DBGridEh1.Columns[7].Visible := b;
end;

procedure TfrmMain.SpeedButton3Click(Sender: TObject);
var
  strsql, temp1, temp2: string;
begin
  strsql := 'select matlcode,sum(matlquat) matlquat from QGCFLHZMx_outlog';
  strsql := strsql + ' where 1=1';

  if CheckBox1.Checked then
  begin
    temp1 := FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date) + ' 00:00:00';
    temp2 := FormatDateTime('yyyy-MM-dd', DateTimePicker2.Date) + ' 23:59:59';
    strsql := strsql + ' and dt>=''' + temp1 + ''' and dt<=''' + temp2 + '''';
  end;
  if LabeledEdit1.Text <> '' then
  begin
    strsql := strsql + ' and MatlCode like ''%' + LabeledEdit1.Text + '%''';
  end;
  if LabeledEdit2.Text <> '' then
  begin
    strsql := strsql + ' and MatlLot like ''%' + LabeledEdit2.Text + '%''';
  end;
  if LabeledEdit3.Text <> '' then
  begin
    strsql := strsql + ' and MatlCode in(select MatlCode from Material where SuprCode like ''%' + LabeledEdit3.Text + '%'')';
  end;
  if LabeledEdit4.Text <> '' then
  begin
    strsql := strsql + ' and LZm_ML_MO_OutLog.MatlVer like ''%' + LabeledEdit4.Text + '%''';
  end;
  if LabeledEdit5.Text <> '' then
  begin
    strsql := strsql + ' and AutoLot like ''%' + LabeledEdit5.Text + '%''';
  end;
  if LabeledEdit6.Text <> '' then
  begin
    strsql := strsql + ' and QCNo like ''%' + LabeledEdit6.Text + '%''';
  end;
  if LabeledEdit7.Text <> '' then
  begin
    strsql := strsql + ' and QCNo like ''%' + LabeledEdit7.Text + '''';
  end;

  strsql := strsql + ' group by MatlCode';
  try
    RzPageControl1.ActivePageIndex := 1;
    SelectClientDataSetnotips(ClientDataSet1, strsql);
    if ClientDataSet1.RecordCount > 0 then
    begin
      DBGridEh1.FooterRowCount := 1;
      DBGridEh1.FooterDisplayStyle := True;
    end;
    ColumnsVisable(False);
  except
    on e: Exception do
    begin
      SaveMessage(strsql, '.sql');
      Application.MessageBox(PChar('abnormal：' + e.Message), '系统发生异常', MB_ICONERROR);
    end;
  end;
end;

end.

