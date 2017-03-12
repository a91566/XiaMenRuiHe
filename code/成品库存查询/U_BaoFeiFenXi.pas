unit U_BaoFeiFenXi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  ComCtrls, DBGridEhImpExp, StrUtils, TeEngine, Series, TeeProcs, Chart,
  DbChart;

type
  TF_BaoFeiFenXi = class(TForm)
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    Timer2: TTimer;
    Image1: TImage;
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    RzPanel1: TRzPanel;
    SpeedButton999: TSpeedButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    DateTimePicker2: TDateTimePicker;
    CheckBox2: TCheckBox;
    SpeedButton3: TSpeedButton;
    SaveDialog1: TSaveDialog;
    DBGridEh1: TDBGridEh;
    ComboBox2: TComboBox;
    Label9: TLabel;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    CheckBox3: TCheckBox;
    DBChart1: TDBChart;
    TabSheet1: TRzTabSheet;
    DBGridEh2: TDBGridEh;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    ClientDataSet11: TClientDataSet;
    ClientDataSet12: TClientDataSet;
    RzPanel3: TRzPanel;
    Label19: TLabel;
    Label20: TLabel;
    Series1: TPieSeries;
    Label3: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    TabSheet4: TRzTabSheet;
    DBChart2: TDBChart;
    PieSeries1: TPieSeries;
    ClientDataSet3: TClientDataSet;
    DataSource3: TDataSource;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  F_BaoFeiFenXi: TF_BaoFeiFenXi;

implementation

uses UDM, ZsbFunPro2;

{$R *.dfm}

procedure TF_BaoFeiFenXi.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_BaoFeiFenXi.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_BaoFeiFenXi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05
  Action := caFree;
end;

procedure TF_BaoFeiFenXi.FormCreate(Sender: TObject);
begin
  Self.Left := 50;
  Self.Top := 50;
end;

procedure TF_BaoFeiFenXi.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
end;

procedure TF_BaoFeiFenXi.Timer1Timer(Sender: TObject);
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

procedure TF_BaoFeiFenXi.Timer2Timer(Sender: TObject);
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

procedure TF_BaoFeiFenXi.SpeedButton999Click(Sender: TObject);
var
  strsql, temp, temp1, temp2, temp3: string;
begin
  SpeedButton999.Enabled := False;
  strsql := 'select * from EndProtBarCode where state=''N''';
  if LabeledEdit1.Text <> '' then
  begin
    strsql := strsql + ' and EndProtCode like ''%' + LabeledEdit1.Text + '%''';
  end;
  if LabeledEdit2.Text <> '' then
  begin
    strsql := strsql + ' and ML_NO like ''%' + LabeledEdit2.Text + '%''';
  end;
  if LabeledEdit3.Text <> '' then
  begin
    strsql := strsql + ' and ERPPDNO like ''%' + LabeledEdit3.Text + '%''';
  end;

  if ComboBox2.ItemIndex > 0 then
  begin
    temp3 := ComboBox2.Text;
    temp3 := LeftStr(temp3, 8);
    strsql := strsql + ' and pName like ''%' + temp3 + '%''';
  end;
  if CheckBox2.Checked then
  begin
    temp1 := FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date) + ' 00:00:00';
    temp2 := FormatDateTime('yyyy-MM-dd', DateTimePicker2.Date) + ' 23:59:59';
    strsql := strsql + ' and PDT>= ''' + temp1 + ''' and PDT<=''' + temp2 + '''';
  end;
  strsql := strsql + ' order by ScrapReason';
  SelectClientDataSet(ClientDataSet1, strsql);

  if ClientDataSet1.RecordCount > 0 then
  begin
    DBGridEh1.FooterRowCount := 1;
    DBGridEh1.FooterDisplayStyle := True;
  end
  else
  begin
    DBGridEh1.FooterRowCount := 0;
  end;
  SpeedButton999.Enabled := True;
end;

procedure TF_BaoFeiFenXi.CheckBox3Click(Sender: TObject);
var
  b: Boolean;
begin
  b := CheckBox3.Checked;
  DBGridEh1.Columns[13].Visible := b;
  DBGridEh1.Columns[14].Visible := b;
  DBGridEh1.Columns[15].Visible := b;
  DBGridEh1.Columns[16].Visible := b;
  DBGridEh1.Columns[17].Visible := b;
  DBGridEh1.Columns[18].Visible := b;
  DBGridEh1.Columns[19].Visible := b;
  DBGridEh1.Columns[20].Visible := b;
  DBGridEh1.Columns[21].Visible := b;
end;

procedure TF_BaoFeiFenXi.SpeedButton3Click(Sender: TObject);
var
  strsql, temp, temp1, temp2, temp3, SqlWhere: string;
  TSList: TStringList;
  i: SmallInt;
  dTemp: Double;
begin
  PleaseWait(0);
  WaitTime(100);
  strsql := 'select count(id) ids from EndProtBarCode where 1=1';
  if LabeledEdit1.Text <> '' then
  begin
    SqlWhere := SqlWhere + ' and EndProtCode like ''%' + LabeledEdit1.Text + '%''';
  end;
  if LabeledEdit2.Text <> '' then
  begin
    SqlWhere := SqlWhere + ' and ML_NO like ''%' + LabeledEdit2.Text + '%''';
  end;
  if LabeledEdit3.Text <> '' then
  begin
    SqlWhere := SqlWhere + ' and ERPPDNO like ''%' + LabeledEdit3.Text + '%''';
  end;

  if ComboBox2.ItemIndex > 0 then
  begin
    temp3 := ComboBox2.Text;
    temp3 := LeftStr(temp3, 8);
    SqlWhere := SqlWhere + ' and pName like ''%' + temp3 + '%''';
  end;
  if CheckBox2.Checked then
  begin
    temp1 := FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date) + ' 00:00:00';
    temp2 := FormatDateTime('yyyy-MM-dd', DateTimePicker2.Date) + ' 23:59:59';
    SqlWhere := SqlWhere + ' and PDT>= ''' + temp1 + ''' and PDT<=''' + temp2 + '''';
  end;
  label19.Caption := SelectClientDataSetResultFieldCaption(ClientDataSet11, strsql + sqlwhere, 'ids');
  if Label19.Caption = '0' then
  begin
    WaitTime(2000);
    zsbSimpleMSNPopUpShow('没有相关报废');
    PleaseWait(1);
    Exit;
  end;

  label10.Caption := SelectClientDataSetResultFieldCaption(ClientDataSet11, strsql + sqlwhere + ' and state=''N''', 'ids');
  label14.Caption := IntToStr(StrToInt(label19.Caption) - StrToInt(label10.Caption));

  strsql := 'select A ScrapReason,B iCount,C from DBChart where 1=2';
  SelectClientDataSet(ClientDataSet2, strsql); //初始化
  SelectClientDataSet(ClientDataSet3, strsql); //初始化



  ClientDataSet2.Edit;
  ClientDataSet2.Append;
  ClientDataSet2.FieldByName('ScrapReason').Value := '正常';
  ClientDataSet2.FieldByName('iCount').Value := Label14.Caption;
  dTemp := StrToInt(Label14.Caption) / StrToInt(Label19.Caption);
  Temp := FormatFloat('0.0000', dTemp * 100);
  ClientDataSet2.FieldByName('C').Value := Temp;

  strsql := 'select distinct ScrapReason from EndProtBarCode where state=''N''' + sqlWHere;
  SelectClientDataSet(ClientDataSet11, strsql);
  with ClientDataSet11 do
  begin
    First;
    TSList := TStringList.Create;
    while not Eof do
    begin
      TSList.Add(FieldByName('ScrapReason').AsString);
      Application.ProcessMessages;
      Next;
    end;
  end;
  for i := 0 to TSList.Count - 1 do
  begin
    strsql := 'select count(id) ids from EndProtBarCode where state=''N''' + sqlWhere;
    strsql := strsql + ' and ScrapReason=''' + TSList[i] + '''';
    temp := SelectClientDataSetResultFieldCaption(ClientDataSet11, strsql, 'ids');
    ClientDataSet2.Edit;
    ClientDataSet2.Append;
    ClientDataSet2.FieldByName('ScrapReason').Value := TSList[i];
    ClientDataSet2.FieldByName('iCount').Value := Temp;
    dTemp := StrToInt(Temp) / StrToInt(Label19.Caption);
    Temp := FormatFloat('0.0000', dTemp * 100);
    ClientDataSet2.FieldByName('C').Value := Temp;


    ClientDataSet3.Edit;
    ClientDataSet3.Append;
    ClientDataSet3.FieldByName('ScrapReason').Value := TSList[i];
    ClientDataSet3.FieldByName('iCount').Value := Temp;

    Application.ProcessMessages;
    Next;
  end;

  TSList.Free;

  RzPageControl1.ActivePageIndex := 1;
  DBChart1.Series[0].DataSource := ClientDataSet2;
  DBChart1.Series[0].Title := '说明';
  DBChart1.Series[0].YValues.valuesource := 'iCount';
  DBChart1.Series[0].XLabelsSource := 'ScrapReason';

  DBChart2.Series[0].DataSource := ClientDataSet3;
  DBChart2.Series[0].Title := '说明';
  DBChart2.Series[0].YValues.valuesource := 'iCount';
  DBChart2.Series[0].XLabelsSource := 'ScrapReason';
  DBChart2.Refresh;


  PleaseWait(1);
end;

end.

