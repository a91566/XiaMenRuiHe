{

根据输入的批次、品番，   查 EndProtInDepotZ、EndProtInDepotMX，查到【生产单号】与【品番】、【批次】。
                         查 EndProtInCustZ、EndProtInCustMX，  查【客户】

根据查询到的【生产单号】 查 MartlInProeZ   查到【出库单号】
根据查询到的【出库单号】 查 MartlInProeMX  查到【原材料的料号、批次、版次】
根据查询到的【料号】     查 Material       查询到【供应商】

最终需要的数据

成品   （品番、品名、批次、版次、数量、客户）
原材料 （料号、品名、批次、版次、数量、供应商）
}
unit U_BuLiangPinGuanLi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask, ComObj,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  ComCtrls;

type
  TF_BuLiangPinGuanLi = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    ScrollBox1: TScrollBox;
    RzPanel99: TRzPanel;
    RzPanel1: TRzPanel;
    SpeedButton999: TSpeedButton;
    Timer2: TTimer;
    LabeledEdit1: TLabeledEdit;
    Image1: TImage;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    ClientDataSet10: TClientDataSet;
    RzPanel2: TRzPanel;
    RzPageControl3: TRzPageControl;
    RzTabSheet2: TRzTabSheet;
    DBGridEh1: TDBGridEh;
    ClientDataSet11: TClientDataSet;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    DateTimePicker2: TDateTimePicker;
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
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_BuLiangPinGuanLi: TF_BuLiangPinGuanLi;

implementation

uses UDM, ZsbFunPro2, ZsbDLL2;

{$R *.dfm}

procedure TF_BuLiangPinGuanLi.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;




procedure TF_BuLiangPinGuanLi.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_BuLiangPinGuanLi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05
  Action := caFree;
end;

procedure TF_BuLiangPinGuanLi.FormCreate(Sender: TObject);
begin
  Self.Left := 50;
  Self.Top := 50;
end;

procedure TF_BuLiangPinGuanLi.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大  
  DateTimePicker1.Date:=StrToDate(FormatDateTime('yyyy-MM-',Now)+'01');
  DateTimePicker2.Date:=Now;
end;

procedure TF_BuLiangPinGuanLi.Timer1Timer(Sender: TObject);
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
  LabeledEdit1.SetFocus;
end;

procedure TF_BuLiangPinGuanLi.Timer2Timer(Sender: TObject);
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

procedure TF_BuLiangPinGuanLi.SpeedButton999Click(Sender: TObject);
var
  strsql,temp1,temp2: string;
begin
  temp1:=FormatDateTime('yyyy-mm-dd',DateTimePicker1.Date)+' 00:00:00';
  temp2:=FormatDateTime('yyyy-mm-dd',DateTimePicker2.Date)+' 23:59:59';
  strsql := 'select * from UMRecord where OpeeDT>='''+temp1+''' and OpeeDT<='''+temp2+'''';
  if LabeledEdit1.Text<>'' then
  begin
    strsql:=strsql+' and MatlCode like ''%'+LabeledEdit1.Text+'%''';
  end;   
  if LabeledEdit2.Text<>'' then
  begin
    strsql:=strsql+' and MatlLot like ''%'+LabeledEdit2.Text+'%''';
  end;
  if LabeledEdit3.Text<>'' then
  begin
    strsql:=strsql+' and SuprCode like ''%'+LabeledEdit3.Text+'%''';
  end;
  SelectClientDataSet(ClientDataSet1,strsql);
end;

procedure TF_BuLiangPinGuanLi.LabeledEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then SpeedButton999.Click;
end;

procedure TF_BuLiangPinGuanLi.SpeedButton2Click(Sender: TObject);
var
  vexcel, workbook,sheet: OleVariant; //导出excel
  temp:string;
  i:SmallInt;
begin  
  if ClientDataSet1.Data=null then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据');
    Exit;
  end;
  if ClientDataSet1.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据');
    Exit;
  end;
  temp:=ExtractFilePath(Application.Exename) + 'SPSPS.xls';
  if FileExists(temp)=False then
  begin  
    zsbSimpleMSNPopUpShow('模版文件不存在.');
    Exit;
  end;
  vExcel := CreateOleObject('Excel.application');
  vExcel.Visible := True;//显示
  vExcel.workbooks.Add(temp);
  workbook := vExcel.workbooks[1];
  sheet := workbook.worksheets[1];


  sheet.name := '力真追溯管理系统';

  sheet.cells[1, 1] := '成品相关信息';
  sheet.cells[2, 1] := '品番';
  sheet.cells[3, 1].value := LabeledEdit2.Text;

  sheet.cells[2, 2] := '品名';
  sheet.cells[3, 2].value := LabeledEdit3.Text;

  sheet.cells[2, 3] := '批次';
  sheet.cells[3, 3].value := LabeledEdit1.Text;

  sheet.cells[2, 4] := '版次';
 // sheet.cells[3, 4].value := LabeledEdit4.Text;

  sheet.cells[2, 5] := '数量';
 // sheet.cells[3, 5].value := LabeledEdit5.Text;

  sheet.cells[2, 6] := '客户';
 // sheet.cells[3, 6].value := LabeledEdit6.Text;

  sheet.cells[2, 7] := '状态';
//  sheet.cells[3, 7].value := LabeledEdit7.Text;


  sheet.cells[5, 1] := '原材料相关信息';
  sheet.cells[6, 1] := '供应商';
  sheet.cells[6, 2] := '料号';
  sheet.cells[6, 3] := '批次';
  sheet.cells[6, 4] := '版次';
  sheet.cells[6, 5] := '数量';


  ClientDataSet10.Data:=ClientDataSet1.Data;
  with ClientDataSet10 do
  begin
    First;
    i:=7;
    while not Eof do
    begin
      sheet.cells[i, 1] := FieldByName('SuprCodeName').AsString;
      sheet.cells[i, 2] := FieldByName('MatlCode').AsString;
      sheet.cells[i, 3] := FieldByName('MatlLot').AsString;
      sheet.cells[i, 4] := FieldByName('MatlVer').AsString;
      sheet.cells[i, 5] := FieldByName('MatlQuat').AsString;
      i:=i+1;
      Next;
    end;
  end;


  //VExcel.quit;

end;

end.

