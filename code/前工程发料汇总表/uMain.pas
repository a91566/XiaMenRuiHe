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
    DBGridEh2: TDBGridEh;
    SpeedButton2: TSpeedButton;
    SaveDialog1: TSaveDialog;
    SpeedButton4: TSpeedButton;
    ClientDataSet10: TClientDataSet;
    LabeledEdit1: TLabeledEdit;
    Button1: TButton;
    ComboBox1: TComboBox;
    Label5: TLabel;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    psBarcode1: TpsBarcode;
    frxReport1: TfrxReport;
    ClientDataSet11: TClientDataSet;
    frxDBDataset1: TfrxDBDataset;
    Button2: TButton;
    RzPanel3: TRzPanel;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    DateTimePicker2: TDateTimePicker;
    SpeedButton999: TSpeedButton;
    LabeledEdit2: TLabeledEdit;
    Label4: TLabel;
    ComboBox2: TComboBox;
    Label6: TLabel;
    CDSFF: TClientDataSet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure RzPageControl1Change(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    function getQCNo(dt1, dt2: TDate): string;
    procedure LoadQX;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation      //100001

uses UDM, ZsbFunPro2, ZsbDLL2, DateUtils, ZsbVariable2;

{$R *.dfm}

procedure TfrmMain.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TfrmMain.LoadQX;
var
  strsql: string;
begin
  if isSuprAdmin then Exit;
  strsql := 'select funccode from userpower where usercode=''' + ZStrUserCode + ''' and powertype=''PC'' and funccode=''020401''';
  SelectClientDataSetNoTips(ClientDataSet10, strsql);
  if ClientDataSet10.RecordCount = 0 then
  begin
    SpeedButton999.Enabled := False;
  end;
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

function TfrmMain.getQCNo(dt1, dt2: TDate): string;
var
  i: Integer;
  temp: string;
begin
  i := DayOfTheYear(dt1);
  temp := Format('%.3d', [i]);
  Result := FormatDateTime('yy', dt1) + temp;

  i := DayOfTheYear(dt2);
  temp := Format('%.3d', [i]);
  Result := Result + FormatDateTime('yy', dt2) + temp;

  Result := 'QC' + Result;
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
    LoadQX;
    temp := SelectClientDataSetResultFieldCaption(ClientDataSet10, 'select max(enddt) enddt from QGCFLHZ where state<>''E.已作废''', 'enddt');
    if temp <> '' then
    begin
      DateTimePicker1.Date := StrToDate(temp) + 1;
      DateTimePicker2.Date := Now;
    end
    else
    begin
      DateTimePicker1.Date := Now;
      DateTimePicker2.Date := Now;
    end;
    ComboBox2.Clear;
    ComboBox2.Items.Add('');
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
end;

procedure TfrmMain.SpeedButton2Click(Sender: TObject);
begin
  try
    if (ClientDataSet2.Data = null) or (ClientDataSet2.RecordCount = 0) then
    begin
      zsbSimpleMSNPopUpShow_2('没有可操作的数据.');
      Exit;
    end;
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

procedure TfrmMain.SpeedButton999Click(Sender: TObject);
var
  temp,  qcNo, exsql: string;
begin
  { //日期可以随便选择
  temp := 'select max(enddt) enddt from QGCFLHZ where state<>''E.已作废''';
  temp1 := SelectClientDataSetResultFieldCaption(ClientDataSet10, temp, 'enddt');
  if temp1 <> '' then
  begin
    if FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date - 1) <> temp1 then
    begin
      ZsbMsgErrorInfoNoApp(Self, '日期选择错误.');
      exit;
    end;
  end;
  }
  if FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date) > FormatDateTime('yyyy-MM-dd', DateTimePicker2.Date) then
  begin
    ZsbMsgErrorInfoNoApp(Self, '起始日期不能小于终止日期.');
    exit;
  end;
  if ComboBox2.Text = '' then
  begin
    temp := #13 + #10 + #13 + #10 + '确认生成日期【' + FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date) + '至' +
      FormatDateTime('yyyy-MM-dd', DateTimePicker2.Date) + '】的前工程发料汇总么?此操作可能耗时比较长。';
  end
  else
  begin
    temp := #13 + #10 + #13 + #10 + '确认生成日期【' + FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date) + '至' +
      FormatDateTime('yyyy-MM-dd', DateTimePicker2.Date) + '】且楼层为【' + ComboBox2.Text + '】的前工程发料汇总么?此操作可能耗时比较长。';
  end;


  if ZsbMsgBoxOkNoApp(Self, temp) = False then Exit;

  qcNo := getQCNo(DateTimePicker1.DateTime, DateTimePicker2.DateTime) + FormatDateTime('HHmm',Now) + ComboBox2.Text;
  
  if qcNo = '' then
  begin
    ZsbMsgErrorInfoNoApp(Self, '前工程汇总发料单单号生成失败,请联系管理员.');
    Exit;
  end;

  if ComboBox2.Text = '' then
  begin
    exsql := 'Exec ZP_QGCFLHZ ';
  end
  else
  begin
    exsql := 'Exec ZP_QGCFLHZ_ByDEP ';
  end;
  exsql := exsql + '''' + FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date) + ''',';
  exsql := exsql + '''' + FormatDateTime('yyyy-MM-dd', DateTimePicker2.Date) + ''',';
  exsql := exsql + '''' + qcNo + ''',';
  exsql := exsql + '''' + ZStrUser + '''';
  if ComboBox2.Text <> '' then
  begin
    exsql := exsql + ',''' + ComboBox2.Text + '''';
  end;

  if EXSQLClientDataSet(ClientDataSet10, exsql) = False then
  begin
    ZsbMsgErrorInfoNoApp(Self, 'Exec ZP_QGCFLHZ 操作失败,请联系管理员.');
    Exit;
  end
  else
  begin
    zsbSimpleMSNPopUpShow('操作成功.');
    Button1.Click;
  end;
end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
var
  strsql: string;
begin
  if ComboBox1.Text = 'E.已作废' then Exit;
  if (label3.Caption = '') or (label3.Visible = False) then
  begin
    zsbSimpleMSNPopUpShow('没有选择单据.');
    ClientDataSet2.Close;
    Exit;
  end;

  strsql := 'select * from QGCFLHZMx where QCNo=''' + label3.Caption + '''';
  if LabeledEdit1.Text <> '' then
  begin
    strSQL := strSQL + ' and MatlCode like ''%' + LabeledEdit1.Text + '%''';
  end;
  strsql := strsql + ' order by WH,MatlCode';
  SelectClientDataSet(ClientDataSet2, strsql);
  SpeedButton1.Tag := 1;
  RzPageControl1.ActivePageIndex := 1;
end;

procedure TfrmMain.SpeedButton4Click(Sender: TObject);
var
  strsql, exsql, temp: string;
  bmp: TBitmap;
  TempB: Boolean; //ClientDataSet10
begin
  if label3.Caption = '' then
  begin
    zsbSimpleMSNPopUpShow('没有数据.');
    Exit;
  end;
  if not FileExists(ExtractFilePath(ParamStr(0)) + '\frxReport7.fr3') then
  begin
    ZsbMsgErrorInfoNoApp(Self, '对不起,标签模版不存在,请联系管理员！');
    exit;
  end;
  exsql := 'update QGCFLHZ set state=''2.待发料'' where QCNo=''' + label3.Caption + ''' and state=''1.待打印''';
  TempB := EXSQLClientDataSet(ClientDataSet10, exsql);
  if TempB = False then
  begin
    temp := '【' + label3.Caption + '打印失败】';
    AddLog_ErrorText(label3.Caption + '打印失败');
    zsbSimpleMSNPopUpShow('打印记录失败，请联系管理员.');
    Exit;
  end;

  strsql := 'select MatlCode,MatlName,BZBZ,SCLL,SFS,SFJS,SJKC,BCDBS,JSHS,WH ' +
    'from QGCFLHZMx where QCNo=''' + label3.Caption + ''' order by WH,MatlCode';
  SelectClientDataSet(ClientDataSet11, strSQL);

  try
    frxReport1.Clear;
    frxReport1.LoadFromFile(ExtractFilePath(ParamStr(0)) + '\frxReport7.fr3');


    TfrxMemoView(frxReport1.FindObject('Memo2')).Memo.Text := label3.Caption;
    TfrxMemoView(frxReport1.FindObject('Memo28')).Memo.Text := label3.Caption;
    TfrxMemoView(frxReport1.FindObject('Memo29')).Memo.Text := ClientDataSet1.FieldByName('DEP_MF').AsString;
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
    on ex:Exception do
    begin
      ZsbMsgErrorInfoNoApp(Self, ex.Message);
    end;
  end;

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

procedure TfrmMain.Button1Click(Sender: TObject);
var
  strsql: string;
begin
  strsql := 'select * from QGCFLHZ where 1=1';
  if ComboBox1.ItemIndex > 0 then
  begin
    strSQL := strSQL + ' and state=''' + ComboBox1.Text + '''';
  end;
  if LabeledEdit2.Text <> '' then
  begin
    strSQL := strSQL + ' and QCNo like ''%' + LabeledEdit2.Text + '%''';
  end;
  strsql := strsql + ' order by id desc';
  SelectClientDataSet(ClientDataSet1, strsql);

  label3.Visible := False;
  label3.Caption := '';
  SpeedButton1.Tag := 0;
  ClientDataSet2.Close;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
var
  exsql: string;
begin
  if ClientDataSet1.Data = null then Exit;
  if ClientDataSet1.RecordCount = 0 then Exit;

  CDSFF.Data := ClientDataSet1.Data;
  CDSFF.Filter := 'isselect=''1''';
  CDSFF.Filtered := True;
  if CDSFF.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可选择操作的记录.');
    Exit;
  end;
       
  if ZsbMsgBoxOkNoApp(Self, '确定作废所选的单据么？') = false then exit;
  with CDSFF do
  begin
    First;
    while not Eof do
    begin
      exsql := exsql + 'update QGCFLHZ set State=''E.已作废'' where QCNo=''' + FieldByName('QCNo').AsString + ''';'; //1.作废
      exsql := exsql + 'delete from QGCFLHZMx where QCNo=''' + FieldByName('QCNo').AsString + ''';'; //2.删除
      exsql := exsql + 'delete from QGCFLHZMx_Outlog where QCNo=''' + FieldByName('QCNo').AsString + ''';'; //3.删除 发料明细
      Next;
    end;
  end;

  
  exsql := ' begin ' + exsql + ' commit; end;';
  if EXSQLClientDataSet(ClientDataSet10, exsql) then
  begin
    zsbSimpleMSNPopUpShow('作废成功！');
    Button1.Click;
    AddLog_Operation('作废若干前工程发料汇总单');
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '对不起，操作失败！');
  end;
end;

procedure TfrmMain.DateTimePicker1Change(Sender: TObject);
begin
 DateTimePicker2.Date:=DateTimePicker1.Date;
end;

end.

