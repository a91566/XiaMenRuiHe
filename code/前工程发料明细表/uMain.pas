unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  ComCtrls, DBGridEhImpExp, Menus, frxClass, psBarcode, frxCross, frxDBSet;

type
  TfrmMain = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    Timer2: TTimer;
    Image1: TImage;
    TabSheet2: TRzTabSheet;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    TabSheet3: TRzTabSheet;
    RzPanel2: TRzPanel;
    SpeedButton1: TSpeedButton;
    RzPanel1: TRzPanel;
    DBGridEh1: TDBGridEh;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    DateTimePicker2: TDateTimePicker;
    DBGridEh2: TDBGridEh;
    SpeedButton2: TSpeedButton;
    SaveDialog1: TSaveDialog;
    SpeedButton4: TSpeedButton;
    ClientDataSet10: TClientDataSet;
    LabeledEdit1: TLabeledEdit;
    Label1: TLabel;
    Button1: TButton;
    ComboBox1: TComboBox;
    Label5: TLabel;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    psBarcode1: TpsBarcode;
    frxReport1: TfrxReport;
    ClientDataSet11: TClientDataSet;
    frxDBDataset1: TfrxDBDataset;
    Label4: TLabel;
    ComboBox2: TComboBox;
    CheckBox2: TCheckBox;
    LabeledEdit2: TLabeledEdit;
    CheckBox3: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RzPageControl1Change(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure CheckBox2Click(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses UDM, ZsbFunPro2, ZsbDLL2, DateUtils, ZsbVariable2, unit2;

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
  Action := caFree;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Self.Left := 50;
  Self.Top := 50;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
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
end;

procedure TfrmMain.Timer2Timer(Sender: TObject);
var
  temp: string;
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

    temp := 'select distinct DEP from DB_DEMO.DBO.MF_ML where len(DEP)=3 order by DEP';
    SelectClientDataSet(ClientDataSet10, temp);
    with ClientDataSet10 do
    begin
      First;
      while not eof do
      begin
        ComboBox2.Items.Add(FieldByName('DEP').AsString);
        Next;
      end;
    end;
  finally

  end;


  DateTimePicker1.Date := Now;
  DateTimePicker2.Date := Now;
end;

procedure TfrmMain.SpeedButton2Click(Sender: TObject);
begin
  try
    SaveDialog1.FileName := '前工程发料汇总表 - 明细 ' + FormatDateTime('yyyyMMddHHmmss', Now) + '.xls';
    SaveDialog1.filter := 'Execl(*.xls)|*.xls';
    if SaveDialog1.Execute then
    begin
      SaveDBGridEhToExportFile(TDBGridEhExportAsXls, DBGridEh2, SaveDialog1.FileName, true);
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
var
  strsql: string;
  dtemp, dtemp2: Double;
begin
  if (label3.Caption = '') or (label3.Visible = False) then
  begin
    zsbSimpleMSNPopUpShow('没有选择单据.');
    ClientDataSet2.Close;
    Exit;
  end;
  if LabeledEdit2.Text<>'' then
  begin  
    LabeledEdit1.Text := LabeledEdit2.Text;
  end;
  strsql := 'select * from QGCFLHZMx where 1=1';
  if LabeledEdit1.Text <> '' then
  begin
    strSQL := strSQL + ' and MatlCode like ''' + LabeledEdit1.Text + '%''';
    if CheckBox3.Checked then
    begin
      strsql := strSQL + ' and QCNo=''' + label3.Caption + '''';
    end;
  end
  else
  begin   
    strsql := strSQL + ' and QCNo=''' + label3.Caption + '''';
  end;
  strsql := strsql + ' order by MatlCode';
  //ShowMessage(strsql);
  SelectClientDataSet(ClientDataSet10, strsql);

  with ClientDataSet10 do
  begin
    First;
    while not Eof do
    begin
      dtemp := FieldByName('SCLL').AsFloat - FieldByName('MatlQuatAlreadyOut').AsFloat;
      if dtemp < 0 then
      begin
        dtemp := 0;
      end;

      dtemp2 := FieldByName('MatlQuatAlreadyOut').AsFloat - FieldByName('SCLL').AsFloat;
      if dtemp2 < 0 then
      begin
        dtemp2 := 0;
      end;

      Edit;
      FieldByName('dd').AsString := FloatToStr(dtemp);
      FieldByName('ddd').AsString := FloatToStr(dtemp2);
      Next;
    end;
  end;

  ClientDataSet2.Data := ClientDataSet10.Data;
  SpeedButton1.Tag := 1;
  RzPageControl1.ActivePageIndex := 1;
end;

procedure TfrmMain.SpeedButton4Click(Sender: TObject);
var
  strsql: string;
  bmp: TBitmap;
begin
  strsql := 'select MatlCode,MatlName,BZBZ,SCLL,SFS,SFJS,SJKC,BCDBS,JSHS,WH ' +
    'from QGCFLHZMx where QCNo=''' + label3.Caption + ''' order by iNo';
  SelectClientDataSet(ClientDataSet11, strSQL);
  try
    frxReport1.Clear;
    frxReport1.LoadFromFile(ExtractFilePath(ParamStr(0)) + '\frxReport7.fr3');


    TfrxMemoView(frxReport1.FindObject('Memo2')).Memo.Text := label3.Caption;
    TfrxMemoView(frxReport1.FindObject('Memo28')).Memo.Text := label3.Caption;
    TfrxMemoView(frxReport1.FindObject('Memo1')).Memo.Text := IntToStr(ClientDataSet2.RecordCount);
    TfrxMemoView(frxReport1.FindObject('Memo3')).Memo.Text := FormatDateTime('yyyy-MM-dd', Now);

    psBarcode1.BarCode := label3.Caption;
    bmp := TBitmap.Create;
    bmp.Width := psBarcode1.Width;
    bmp.Height := psBarcode1.Height;
    psBarcode1.PaintBarCode(bmp.Canvas, Rect(0, 0, bmp.Width, bmp.Height));
    TfrxPictureView(frxReport1.FindObject('picture1')).Picture.Assign(bmp);
    bmp.Free;

    if CheckBox1.Checked = True then
    begin
      frxReport1.ShowReport;
    end
    else
    begin
      frxReport1.PrepareReport;
      frxReport1.PrintOptions.ShowDialog := False; //不显示打印机选择框
      frxReport1.Print; //打印
    end;
    AddLog_Operation(label3.Caption + '被打印(前工程发料汇总表)');
  except
  end;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  strsql: string;
begin
  strsql := 'select * from QGCFLHZ where 1=1';
  if ComboBox1.ItemIndex > 0 then
  begin
    strSQL := strSQL + ' and state=''' + ComboBox1.Text + '''';
  end;
  if ComboBox2.ItemIndex > 0 then
  begin
    strSQL := strSQL + ' and DEP_MF=''' + ComboBox2.Text + '''';
  end;
  if LabeledEdit2.Text <> '' then
  begin
    strSQL := strSQL + ' and QCNo in (select QCNo from QGCFLHZMx where MatlCode like ''' + LabeledEdit2.Text + '%'')';
  end;
  strsql := strsql + ' order by id desc';
  SelectClientDataSet(ClientDataSet1, strsql);

  label3.Visible := False;
  label3.Caption := '';
  SpeedButton1.Tag := 0;
  ClientDataSet2.Close;
end;

procedure TfrmMain.RzPageControl1Change(Sender: TObject);
begin
  if RzPageControl1.ActivePageIndex = 0 then Exit;
  if SpeedButton1.Tag = 1 then exit;
  if ClientDataSet1.Data = null then Exit;

  if ClientDataSet2.Data = null then
  begin
    SpeedButton1.Click;
    Exit;
  end;
  if ClientDataSet2.RecordCount = 0 then
  begin
    SpeedButton1.Click;
    Exit;
  end;
  if (ClientDataSet2.FieldByName('QCNo').AsString <> label3.Caption) then
  begin
    SpeedButton1.Click;
  end;
end;

procedure TfrmMain.DBGridEh1CellClick(Column: TColumnEh);
begin
  if (ClientDataSet1.Data = null) or (ClientDataSet1.FieldByName('QCNo').AsString = '') then Exit;

  label3.Caption := ClientDataSet1.FieldByName('QCNo').AsString;
  label3.Visible := True;
  SpeedButton1.Tag := 0;
end;

procedure TfrmMain.frxReport1BeforePrint(Sender: TfrxReportComponent);
var
  Cross: TfrxCrossView;
  i, j: Integer;
begin
  Exit;
  ClientDataSet11.Fields[0].DisplayLabel := '睿和料号';
  ClientDataSet11.Fields[1].DisplayLabel := '对方料号';
  ClientDataSet11.Fields[2].DisplayLabel := '标准包装';
  ClientDataSet11.Fields[3].DisplayLabel := '生产领料';
  ClientDataSet11.Fields[4].DisplayLabel := '实发数';
  ClientDataSet11.Fields[5].DisplayLabel := '实发卷数';
  ClientDataSet11.Fields[6].DisplayLabel := '实际库存';
  ClientDataSet11.Fields[7].DisplayLabel := '本次调拨数';
  ClientDataSet11.Fields[8].DisplayLabel := '卷数换算';
  ClientDataSet11.Fields[9].DisplayLabel := '库位';

  if Sender is TfrxCrossView then
  begin
    Cross := TfrxCrossView(Sender);
    ClientDataSet11.First;
    i := 0;
    while not ClientDataSet11.Eof do
    begin
      for j := 0 to ClientDataSet11.FieldCount - 1 do
      begin
        Cross.AddValue([i], [ClientDataSet11.Fields[j].DisplayLabel], [ClientDataSet11.Fields[j].AsString]);
      end;
      ClientDataSet11.Next;
      Inc(i);
    end;
  end;
end;

procedure TfrmMain.CheckBox2Click(Sender: TObject);
begin
  DBGridEh2.Columns[7].Visible := CheckBox2.Checked;
  DBGridEh2.Columns[8].Visible := CheckBox2.Checked;
  DBGridEh2.Columns[9].Visible := CheckBox2.Checked;
  DBGridEh2.Columns[10].Visible := CheckBox2.Checked;
  DBGridEh2.Columns[11].Visible := CheckBox2.Checked;
  DBGridEh2.Columns[12].Visible := CheckBox2.Checked;
  DBGridEh2.Columns[13].Visible := CheckBox2.Checked;
end;

procedure TfrmMain.DBGridEh2DblClick(Sender: TObject);
begin
  if Application.FindComponent('form2') = nil then
  begin
    Application.CreateForm(TForm2, Form2);
  end;
  Form2.LabeledEdit1.Text := label3.Caption;
  Form2.LabeledEdit2.Text := ClientDataSet2.fieldByName('Matlcode').AsString;
  Form2.Show;
end;

end.

