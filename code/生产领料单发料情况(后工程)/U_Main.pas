unit U_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  ComCtrls, DBGridEhImpExp;

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
    LabeledEdit4: TLabeledEdit;
    RzPanel1: TRzPanel;
    SpeedButton999: TSpeedButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    DBGridEh1: TDBGridEh;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    DateTimePicker2: TDateTimePicker;
    CheckBox2: TCheckBox;
    DBGridEh2: TDBGridEh;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SaveDialog1: TSaveDialog;
    ClientDataSet3: TClientDataSet;
    DataSource3: TDataSource;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    Button1: TButton;
    DBGridEh3: TDBGridEh;
    TabSheet1: TRzTabSheet;
    RzPanel3: TRzPanel;
    SpeedButton4: TSpeedButton;
    LabeledEdit7: TLabeledEdit;
    ComboBox1: TComboBox;
    Label5: TLabel;
    ClientDataSet4: TClientDataSet;
    DataSource4: TDataSource;
    DBGridEh4: TDBGridEh;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    CheckBox1: TCheckBox;
    DateTimePicker3: TDateTimePicker;
    Label1: TLabel;
    DateTimePicker4: TDateTimePicker;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses UDM, ZsbFunPro2;

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
  //DateTimePicker1.Date := StrToDate(FormatDateTime('yyyy-MM-', Now) + '01');
  DateTimePicker1.Date := Now-1;
  DateTimePicker2.Date := Now;   
  DateTimePicker3.Date := StrToDate(FormatDateTime('yyyy-MM-', Now) + '01');
  DateTimePicker4.Date := Now;

  RzPageControl1.Visible := True;
  RzPageControl1.ActivePageIndex := 0;
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
    SpeedButton999.Click;
  finally

  end;
end;

procedure TfrmMain.SpeedButton3Click(Sender: TObject);
begin
  try
    Exit;
    SaveDialog1.FileName := '原料库存查询' + FormatDateTime('yyyyMMddHHmmss', Now) + '.xls';
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

procedure TfrmMain.SpeedButton2Click(Sender: TObject);
begin
  try
    Exit;
    SaveDialog1.FileName := '原料库存查询' + FormatDateTime('yyyyMMddHHmmss', Now) + '.xls';
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
  temp, temp1, temp2: string;
begin
  temp := 'select LZm_ML_MO_OutLog.*,ZT_ML_NO_FromERP.MO_NO from LZm_ML_MO_OutLog,ZT_ML_NO_FromERP where LZm_ML_MO_OutLog.ML_NO=ZT_ML_NO_FromERP.ML_NO';
  if LabeledEdit1.Text <> '' then
  begin
    temp := temp + ' and LZm_ML_MO_OutLog.MatlCode like ''%' + LabeledEdit1.Text + '%''';
  end;
  if LabeledEdit2.Text <> '' then
  begin
    temp := temp + ' and LZm_ML_MO_OutLog.MatlLot like ''%' + LabeledEdit2.Text + '%''';
  end;
  if LabeledEdit3.Text <> '' then
  begin
    temp := temp + ' and LZm_ML_MO_OutLog.MatlCode in(select MatlCode from Material where SuprCode like ''%' + LabeledEdit3.Text + '%'')';
  end;
  if LabeledEdit5.Text <> '' then
  begin
    temp := temp + ' and LZm_ML_MO_OutLog.ML_NO like ''%' + LabeledEdit5.Text + '%''';
  end;
  if LabeledEdit6.Text <> '' then
  begin
    temp := temp + ' and LZm_ML_MO_OutLog.ML_NO in (select ML_NO from ZT_ML_NO_FromERP where MO_NO like ''%' + LabeledEdit6.Text + '%'')';
  end;
  if CheckBox2.Checked then
  begin
    temp1 := FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date) + ' 00:00:00';
    temp2 := FormatDateTime('yyyy-MM-dd', DateTimePicker2.Date) + ' 23:59:59';
    temp := temp + ' and LZm_ML_MO_OutLog.dt>=''' + temp1 + ''' and LZm_ML_MO_OutLog.dt<=''' + temp2 + '''';
  end;
  temp := temp + ' order by LZm_ML_MO_OutLog.MatlCode';
  SelectClientDataSet(ClientDataSet1, temp);
  if ClientDataSet1.RecordCount > 0 then
  begin
    DBGridEh1.FooterRowCount := 1;
    DBGridEh1.FooterDisplayStyle := True;
  end
  else
  begin
    DBGridEh1.FooterRowCount := 0;
  end;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  strsql: string;
begin
  if Button1.Caption = '返回' then
  begin
    ClientDataSet3.Close;
    DBGridEh3.Visible := False;
    Button1.Caption := '查看具体发料时间';
  end
  else
  begin
    if ClientDataSet1.Data = null then Exit;
    strsql := 'select * from LZm_ML_MO_OutLog where matlcode=''' + ClientDataSet1.FieldByName('matlcode').AsString + '''';
    SelectClientDataSet(ClientDataSet3, strsql);
    DBGridEh3.Visible := true;
    Button1.Caption := '返回';
  end;
end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
var
  temp: string;
begin
  temp := 'select LZm_ML_MO_OutLog.matlcode,sum(LZm_ML_MO_OutLog.matlquat) matlquat ,Material.MatlName from LZm_ML_MO_OutLog,Material';
  temp := temp + ' where LZm_ML_MO_OutLog.matlcode=Material.MatlCode';
  if LabeledEdit4.Text <> '' then
  begin
    temp := temp + ' and LZm_ML_MO_OutLog.matlcode like ''%' + LabeledEdit4.Text + '%''';
  end;
  temp := temp + ' group by LZm_ML_MO_OutLog.MatlCode,Material.MatlName';
  SelectClientDataSet(ClientDataSet2, temp);
  if ClientDataSet2.RecordCount > 0 then
  begin
    DBGridEh2.FooterRowCount := 1;
    DBGridEh2.FooterDisplayStyle := True;
  end
  else
  begin
    DBGridEh2.FooterRowCount := 0;
  end;
end;

procedure TfrmMain.SpeedButton4Click(Sender: TObject);
var
  strsql:string;
begin
  //strsql:='select LZm_ML_MO_FromERP.MO_NO,LZm_ML_MO_OutLog.* from LZm_ML_MO_FromERP left outer join LZm_ML_MO_OutLog ';
  //strsql:=strsql+'on LZm_ML_MO_FromERP.ML_NO=LZm_ML_MO_OutLog.ML_NO ';
  //strsql:=strsql+'and LZm_ML_MO_FromERP.MatlCode=LZm_ML_MO_OutLog.MatlCode ';
  //strsql:=strsql+'and LZm_ML_MO_FromERP.ML_NO in(select ML_NO from LZz_ML_MO_FromERP where ML_NO='''+ComboBox1.Text+''')';

  strsql:='select *,MatlQuat-MatlQuatAlreadyOut Temp from LZm_ML_MO_FromERP where 1=1';
  if LabeledEdit7.Text <> '' then
  begin
    strsql := strsql + ' and matlcode like ''%' + LabeledEdit7.Text + '%''';
  end;     
  if LabeledEdit8.Text <> '' then
  begin
    strsql := strsql + ' and MO_NO like ''%' + LabeledEdit8.Text + '%''';
  end;
  if LabeledEdit9.Text <> '' then
  begin
    strsql := strsql + ' and ML_NO like ''%' + LabeledEdit9.Text + '%''';
  end;
  case ComboBox1.ItemIndex of     
    //0:不处理
    1:strsql := strsql + ' and MatlQuatAlreadyOut=0';
    2:strsql := strsql + ' and MatlQuat<>MatlQuatAlreadyOut and MatlQuatAlreadyOut>0';
    3:strsql := strsql + ' and MatlQuat=MatlQuatAlreadyOut';
  end;
  strsql := strsql + ' and ML_NO in(select ML_NO from LZz_ML_MO_FromERP where OpeeDT>=''' + FormatDateTime('yyyy-MM-dd', DateTimePicker3.Date) +
  ''' and OpeeDT<='''+FormatDateTime('yyyy-MM-dd', DateTimePicker4.Date)+''')';
  strsql := strsql + ' order by MatlCode';
  SelectClientDataSet(ClientDataSet4, strsql);
end;

procedure TfrmMain.DBGridEh1CellClick(Column: TColumnEh);
var
  strsql: string;
begin
  if DBGridEh3.Visible=True then
  begin
    strsql := 'select * from LZm_ML_MO_OutLog where matlcode=''' + ClientDataSet1.FieldByName('matlcode').AsString + '''';
    SelectClientDataSet(ClientDataSet3, strsql);
  end;
end;

end.

