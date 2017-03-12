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
    RzPanel1: TRzPanel;
    SpeedButton999: TSpeedButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    DBGridEh1: TDBGridEh;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    DateTimePicker2: TDateTimePicker;
    CheckBox2: TCheckBox;
    SpeedButton3: TSpeedButton;
    SaveDialog1: TSaveDialog;
    LabeledEdit5: TLabeledEdit;
    ClientDataSet4: TClientDataSet;
    DataSource4: TDataSource;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
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

procedure TfrmMain.SpeedButton999Click(Sender: TObject);
var
  temp, temp1, temp2: string;
begin
  temp := 'select * from TLm_OutLog where 1=1';
  if LabeledEdit1.Text <> '' then
  begin
    temp := temp + ' and MatlCode like ''%' + LabeledEdit1.Text + '%''';
  end;
  if LabeledEdit2.Text <> '' then
  begin
    temp := temp + ' and MatlLot like ''%' + LabeledEdit2.Text + '%''';
  end;
  if LabeledEdit5.Text <> '' then
  begin
    temp := temp + ' and TLNO like ''%' + LabeledEdit5.Text + '%''';
  end;
  if CheckBox2.Checked then
  begin
    temp1 := FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date) + ' 00:00:00';
    temp2 := FormatDateTime('yyyy-MM-dd', DateTimePicker2.Date) + ' 23:59:59';
    temp := temp + ' and dt>=''' + temp1 + ''' and dt<=''' + temp2 + '''';
  end;
  temp := temp + ' order by MatlCode';
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

end.

