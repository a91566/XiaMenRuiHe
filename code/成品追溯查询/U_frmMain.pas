{

根据输入的品番，查 QGCYLSM（前工程用料扫描表），查到【料号】、【供应商代号】、【批次】、
                   【流水号】、【扫描枪号】、【扫描员】、【扫描时间】。

                查 LZm_ML_MO_FromERP（ERP 后工程待发料明细表），查出发料单号【ML_NO】，
                再根据这个ML_NO，查 LZm_ML_MO_OutLog （后工程发料明细表），查询出
                【料号】、【数量】、【批次】、【版次】、【流水号】、【操作时间】、【发料员】

}
unit U_frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask, ComObj,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect, StrUtils;

type
  TfrmMain = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    Timer2: TTimer;
    Image1: TImage;
    ClientDataSet10: TClientDataSet;
    ClientDataSet11: TClientDataSet;
    ClientDataSet12: TClientDataSet;
    RzPanel99: TRzPanel;
    Label4: TLabel;
    Label1: TLabel;
    RzPanel1: TRzPanel;
    SpeedButton999: TSpeedButton;
    SpeedButton2: TSpeedButton;
    LabeledEdit1: TLabeledEdit;
    RzPageControl2: TRzPageControl;
    RzTabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    DBGridEh1: TDBGridEh;
    DBGridEh2: TDBGridEh;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    TabSheet1: TRzTabSheet;
    DBGridEh3: TDBGridEh;
    ClientDataSet3: TClientDataSet;
    DataSource3: TDataSource;
    LabeledEdit2: TLabeledEdit;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton2Click(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ChaXun(strEndProtLot: string);
    procedure ClearText;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses UDM, ZsbFunPro2, ZsbDLL2, U_GetEndProtLot;

{$R *.dfm}

procedure TfrmMain.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TfrmMain.ClearText;
begin
  ClientDataSet2.Close;
end;

procedure TfrmMain.ChaXun(strEndProtLot: string);
var
  strsql, temp, temp1: string;
begin
  strsql := 'select * from EndProtBarCode where EndProtLot=''' + strEndProtLot + '''';
  SelectClientDataSet(ClientDataSet10, strsql);

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
  RzPanel99.Visible := True;
  RzPageControl2.ActivePageIndex := 0;
  LabeledEdit1.SetFocus;
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

procedure TfrmMain.SpeedButton999Click(Sender: TObject);
var
  strsql, ML_NO, showTemp: string;
  i: SmallInt;
begin
  ClearText;
  SpeedButton999.Enabled := False;
  if LabeledEdit1.Text = '' then
  begin
    ShowInfoTips(LabeledEdit1.Handle, '请输入制令单号.', 3);
    LabeledEdit1.SetFocus;
    SpeedButton999.Enabled := True;
    Exit;
  end;
  if UpperCase(LeftStr(LabeledEdit1.Text, 2)) <> 'MO' then
  begin
    ShowInfoTips(LabeledEdit1.Handle, '请输入正确的制令单号,MO开头.', 3);
    LabeledEdit1.SetFocus;
    SpeedButton999.Enabled := True;
    Exit;
  end;

  strsql := 'select * from EndProtBarCode where ERPPDNO like ''' + LabeledEdit1.Text +'%''';
  if CheckBox1.Checked = True then
  begin
    strsql := strsql + ' and state=''Y''';
  end;
  SelectClientDataSetNoTips(ClientDataSet3, strsql);

  strsql := 'select * from QGCYLSM where MO_NO like ''' + LabeledEdit1.Text +
  '%''  and  MatlCode<>''''';
  if LabeledEdit2.Text <> '' then
  begin
    strsql := strsql + ' and MatlCode like ''' + LabeledEdit2.Text + '%''';
  end;
  if LabeledEdit3.Text <> '' then
  begin
    strsql := strsql + ' and MatlLot like ''' + LabeledEdit3.Text + '%''';
  end;
  if LabeledEdit4.Text <> '' then
  begin
    strsql := strsql + ' and AutoLot like ''' + LabeledEdit4.Text + '%''';
  end;
  strsql := strsql + ' order by MatlLot';
  SelectClientDataSetNoTips(ClientDataSet1, strsql);

  if ClientDataSet1.RecordCount = 0 then
  begin
    showTemp := '没有前工程的相关信息,';
    RzPageControl2.ActivePageIndex := 1;
  end;
  strsql := 'select  distinct ML_NO from LZm_ML_MO_FromERP where MO_No like ''' + LabeledEdit1.Text + '%''';
  SelectClientDataSet(ClientDataSet10, strsql);
  if ClientDataSet10.RecordCount > 0 then
  begin
    with ClientDataSet10 do
    begin
      First;
      while not Eof do
      begin
        if ML_NO = '' then
        begin
          ML_NO := '''' + FieldByName('ML_NO').AsString + '''';
        end
        else
        begin
          ML_NO := ML_NO + ',' + '''' + FieldByName('ML_NO').AsString + '''';
        end;
        Next;
      end;
    end;
    ML_NO := '(' + ML_NO + ')';
    //strsql:= 'select * from LZm_ML_MO_OutLog where ML_NO in ' + ML_NO;

    strsql := 'select LZm_ML_MO_OutLog.*,MatlInDepotZ.SuprCode from LZm_ML_MO_OutLog,MatlInDepotZ,MatlInDepotMx' +
      ' where LZm_ML_MO_OutLog.AutoLot=MatlInDepotMx.AutoLot and MatlInDepotMx.MIDDONO=MatlInDepotZ.MIDDONO and' +
      ' LZm_ML_MO_OutLog.MatlCode<>'''' and LZm_ML_MO_OutLog.ML_NO in' + ML_NO;
    if LabeledEdit2.Text <> '' then
    begin
      strsql := strsql + ' and LZm_ML_MO_OutLog.MatlCode like ''' + LabeledEdit2.Text + '%''';
    end;
    if LabeledEdit3.Text <> '' then
    begin
      strsql := strsql + ' and LZm_ML_MO_OutLog.MatlLot like ''' + LabeledEdit3.Text + '%''';
    end;
    if LabeledEdit4.Text <> '' then
    begin
      strsql := strsql + ' and LZm_ML_MO_OutLog.AutoLot like ''' + LabeledEdit4.Text + '%''';
    end;   
    strsql := strsql + ' order by LZm_ML_MO_OutLog.MatlLot';
    SelectClientDataSetNoTips(ClientDataSet2, strsql);
  end;
  if (ClientDataSet2.Data = null) or (ClientDataSet2.RecordCount = 0) then
  begin
    showTemp := showTemp + '没有后工程的相关信息.';
    RzPageControl2.ActivePageIndex := 0;
  end;
  showTemp := showTemp + '请确认制令单号.';
  zsbSimpleMSNPopUpShow_2(showTemp, clYellow, 500);
  SpeedButton999.Enabled := True;
end;

procedure TfrmMain.LabeledEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then SpeedButton999.Click;
end;

procedure TfrmMain.SpeedButton2Click(Sender: TObject);
var
  vexcel, workbook, sheet: OleVariant; //导出excel
  temp: string;
  i: SmallInt;
begin
  zsbSimpleMSNPopUpShow_2('暂不支持');
  Exit;
  if ClientDataSet1.Data = null then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据');
    Exit;
  end;
  if ClientDataSet1.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据');
    Exit;
  end;
  temp := ExtractFilePath(Application.Exename) + 'SPSPS.xls';
  if FileExists(temp) = False then
  begin
    zsbSimpleMSNPopUpShow('模版文件不存在.');
    Exit;
  end;
  vExcel := CreateOleObject('Excel.application');
  vExcel.Visible := True; //显示
  vExcel.workbooks.Add(temp);
  workbook := vExcel.workbooks[1];
  sheet := workbook.worksheets[1];


  sheet.name := '力真追溯管理系统';

  sheet.cells[1, 1] := '成品相关信息';
  sheet.cells[2, 1] := '品番';
  //sheet.cells[3, 1].value := LabeledEdit2.Text;

  sheet.cells[2, 2] := '品名';
  //sheet.cells[3, 2].value := LabeledEdit3.Text;

  sheet.cells[2, 3] := '批次';
  //sheet.cells[3, 3].value := LabeledEdit1.Text;

  sheet.cells[2, 4] := '版次';
  //sheet.cells[3, 4].value := LabeledEdit4.Text;

  sheet.cells[2, 5] := '数量';
  //sheet.cells[3, 5].value := LabeledEdit5.Text;

  sheet.cells[2, 6] := '客户';
  //sheet.cells[3, 6].value := LabeledEdit6.Text;

  sheet.cells[2, 7] := '状态';
  //sheet.cells[3, 7].value := LabeledEdit7.Text;


  sheet.cells[5, 1] := '原材料相关信息';
  sheet.cells[6, 1] := '供应商';
  sheet.cells[6, 2] := '料号';
  sheet.cells[6, 3] := '批次';
  sheet.cells[6, 4] := '版次';
  sheet.cells[6, 5] := '数量';


  ClientDataSet10.Data := ClientDataSet1.Data;
  with ClientDataSet10 do
  begin
    First;
    i := 7;
    while not Eof do
    begin
      sheet.cells[i, 1] := FieldByName('SuprCodeName').AsString;
      sheet.cells[i, 2] := FieldByName('MatlCode').AsString;
      sheet.cells[i, 3] := FieldByName('MatlLot').AsString;
      sheet.cells[i, 4] := FieldByName('MatlVer').AsString;
      sheet.cells[i, 5] := FieldByName('MatlQuat').AsString;
      i := i + 1;
      Next;
    end;
  end;


  //VExcel.quit;

end;

end.

