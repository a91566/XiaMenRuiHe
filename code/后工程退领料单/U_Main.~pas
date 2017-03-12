unit U_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  ComCtrls, DBGridEhImpExp,StrUtils;

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
    DBGridEh1: TDBGridEh;
    SpeedButton3: TSpeedButton;
    SaveDialog1: TSaveDialog;
    CDSFF: TClientDataSet;
    ClientDataSet10: TClientDataSet;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses UDM, ZsbFunPro2, Unit1;

{$R *.dfm}     //ML51010001

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
  finally
  end;
end;

procedure TfrmMain.SpeedButton3Click(Sender: TObject);
var
  strsql:string;
begin
  if ClientDataSet1.Data = null then Exit;
  if ClientDataSet1.RecordCount = 0 then Exit;

  
  strsql:='select id from TLz where TLNO like '''+LabeledEdit1.Text+'%''';
  if SelectClientDataSetResultCount(ClientDataSet10,strsql)>0 then
  begin
    zsbSimpleMSNPopUpShow_2('该单据已经退回过,无法再次退库.', clRed);
    Exit;
  end;

  CDSFF.Data := ClientDataSet1.Data;
  CDSFF.Filter := 'isselect=''1''';
  CDSFF.Filtered := True;
  if CDSFF.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可选择操作的记录.');
    Exit;
  end;
  try

    Form1 := TForm1.Create(nil);
    Form1.Edit1.Text:=LabeledEdit1.Text;
    strsql:='select top 1 EndProtCode,ProeDept from LZz_ML_MO_FromERP where ML_NO='''+LabeledEdit1.Text+''' and state<>''E.已作废''';
    SelectClientDataSet(ClientDataSet10,strsql);
    if ClientDataSet10.RecordCount=1 then
    begin   
      Form1.Edit3.Text:=ClientDataSet10.fieldByName('EndProtCode').AsString;
      Form1.Edit4.Text:=ClientDataSet10.fieldByName('ProeDept').AsString;     //退料部门 ，即原生产部门
    end;

    strsql:='select top 1 MO_NO,DepotCode from LZm_ML_MO_FromERP where ML_NO='''+LabeledEdit1.Text+'''';
    SelectClientDataSet(ClientDataSet10,strsql);
    if ClientDataSet10.RecordCount=1 then
    begin
      Form1.Edit2.Text:=ClientDataSet10.fieldByName('MO_NO').AsString;
      Form1.Edit5.Text:=ClientDataSet10.fieldByName('DepotCode').AsString;     //接收部门 ，即原发料部门
    end;

    Form1.Edit6.Text:=FormatDateTime('yyyy-MM-dd',Now);
    Form1.Label3.Tag:=0;
    Form1.WindowState:=wsMaximized;
    Form1.Show;
  except
    on e: Exception do
    begin
      zsbSimpleMSNPopUpShow_2('操作失败,请联系管理员.' + e.Message, clRed, 500);
    end;
  end;
end;

procedure TfrmMain.SpeedButton999Click(Sender: TObject);
var
  temp: string;
begin
  if LabeledEdit1.Text = '' then Exit;
  if LeftStr(LabeledEdit1.Text, 2) <> 'ML' then
  begin
    zsbSimpleMSNPopUpShow_2('不可识别的单号.', clRed);
    Exit;
  end;
  temp := 'select * from LZm_ML_MO_OutLog where ML_NO=''' + LabeledEdit1.Text + '''';
  temp := temp + ' order by MatlCode';
  SelectClientDataSet(ClientDataSet1, temp);
 { if ClientDataSet1.RecordCount > 0 then
  begin
    DBGridEh1.FooterRowCount := 1;
    DBGridEh1.FooterDisplayStyle := True;
  end
  else
  begin
    DBGridEh1.FooterRowCount := 0;
  end;  }
end;

procedure TfrmMain.LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
var
  TSList: TStringList;
  temp:string;
begin
  if Key = #13 then
  begin
    temp:=LabeledEdit1.Text;
    LabeledEdit1.Text:='';
    if LeftStr(temp, 2) = 'ML' then
    begin
      TSList := SplitString(temp, ',');
      LabeledEdit1.Text := TSList[0];
      TSList.Free;
    end;
    SpeedButton999.Click;
  end;
end;

end.

