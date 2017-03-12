{
2015年6月7日 09:10:42 停用 郑少宝

根据输入的批次、品番，   查 EndProtInDepotZ、EndProtInDepotMX，查到【生产单号】与【品番】、【批次】。
                         查 EndProtInCustZ、EndProtInCustMX，  查【客户】

根据查询到的【生产单号】 查 MartlInProeZ   查到【出库单号】
根据查询到的【出库单号】 查 MartlInProeMX  查到【原材料的料号、批次、版次】
根据查询到的【料号】     查 Material       查询到【供应商】

最终需要的数据

成品   （品番、品名、批次、版次、数量、客户）
原材料 （料号、品名、批次、版次、数量、供应商）
}
unit U_ChengPinZhuiSuChaXun;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask, ComObj,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect, StrUtils;

type
  TF_ChengPinZhuiSuChaXun = class(TForm)
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
    SpeedButton123: TSpeedButton;
    LabeledEdit1: TLabeledEdit;
    RzPageControl2: TRzPageControl;
    RzTabSheet1: TRzTabSheet;
    Label3: TLabel;
    RzPanel2: TRzPanel;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    TabSheet2: TRzTabSheet;
    DBGridEh1: TDBGridEh;
    LabeledEdit3: TLabeledEdit;
    Label2: TLabel;
    RzPanel3: TRzPanel;
    LabeledEdit6: TLabeledEdit;
    Label5: TLabel;
    RzPanel4: TRzPanel;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    LabeledEdit13: TLabeledEdit;
    LabeledEdit15: TLabeledEdit;
    LabeledEdit14: TLabeledEdit;
    LabeledEdit12: TLabeledEdit;
    LabeledEdit16: TLabeledEdit;
    Label6: TLabel;
    RzPanel5: TRzPanel;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    LabeledEdit17: TLabeledEdit;
    LabeledEdit18: TLabeledEdit;
    LabeledEdit19: TLabeledEdit;
    LabeledEdit20: TLabeledEdit;
    LabeledEdit21: TLabeledEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton123Click(Sender: TObject);
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
  F_ChengPinZhuiSuChaXun: TF_ChengPinZhuiSuChaXun;

implementation

uses UDM, ZsbFunPro2, ZsbDLL2, U_GetEndProtLot;

{$R *.dfm}

procedure TF_ChengPinZhuiSuChaXun.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_ChengPinZhuiSuChaXun.ClearText;
begin
  LabeledEdit2.Text := '';
  LabeledEdit3.Text := '';
  LabeledEdit4.Text := '';
  LabeledEdit5.Text := '';
  LabeledEdit6.Text := '';
  LabeledEdit7.Text := '';
  LabeledEdit8.Text := '';
end;

procedure TF_ChengPinZhuiSuChaXun.ChaXun(strEndProtLot: string);
var
  strsql, temp, temp1: string;
begin
  strsql := 'select * from EndProtBarCode where EndProtLot=''' + strEndProtLot + '''';
  SelectClientDataSet(ClientDataSet10, strsql);
  LabeledEdit2.Text := ClientDataSet10.FieldByName('EndProtCode').AsString; //品番
  //LabeledEdit3.Text := SelectEndProtNameForCode(LabeledEdit2.Text); //品名
  LabeledEdit3.Text := ClientDataSet10.FieldByName('customno').AsString; //报关品番
  LabeledEdit4.Text := ClientDataSet10.FieldByName('EndProtVer').AsString; //版次
  LabeledEdit5.Text := ClientDataSet10.FieldByName('EndProtQuat').AsString; //数量
  LabeledEdit6.Text := ClientDataSet10.FieldByName('custname').AsString; //客户
  LabeledEdit8.Text := ClientDataSet10.FieldByName('ERPPDNO').AsString; //MO
  LabeledEdit9.Text := ClientDataSet10.FieldByName('ML_NO').AsString; //ML

  LabeledEdit10.Text := ClientDataSet10.FieldByName('uName').AsString + ' ' + ClientDataSet10.FieldByName('OpeeDT').AsString; //生成标签
  LabeledEdit11.Text := ClientDataSet10.FieldByName('pName').AsString + ' ' + ClientDataSet10.FieldByName('pDT').AsString; //打印标签
  LabeledEdit12.Text := ClientDataSet10.FieldByName('DEP').AsString; //制造部门
  LabeledEdit13.Text := ClientDataSet10.FieldByName('ShefCode').AsString; //库位
  LabeledEdit14.Text := ClientDataSet10.FieldByName('shippingd').AsString; //装柜日期

  if ClientDataSet10.FieldByName('HandWork').AsString = '1' then //手工生成
  begin   
    LabeledEdit15.Text := '是';
  end
  else
  begin
    LabeledEdit15.Text := '否';
  end;

  LabeledEdit16.Text := ClientDataSet10.FieldByName('iTime').AsString;

  if ClientDataSet10.FieldByName('state').AsString = 'Y' then //手工生成
  begin
    LabeledEdit17.Text := '否';
    LabeledEdit18.Text := '';
    LabeledEdit18.Visible := False;
  end
  else
  begin
    LabeledEdit17.Text := '是';
    LabeledEdit18.Text := ClientDataSet10.FieldByName('ScrapReason').AsString;
    LabeledEdit18.Visible := True;
  end;

  if ClientDataSet10.FieldByName('iSecond').AsString = '1' then //手工生成
  begin
    LabeledEdit21.Text := '是';
  end
  else
  begin
    LabeledEdit21.Text := '否';
  end;

  temp := ClientDataSet10.FieldByName('inNo').AsString;
  temp1 := ClientDataSet10.FieldByName('OutNo').AsString;
  if temp = '' then
  begin
    LabeledEdit7.Text := '未入库';
    LabeledEdit19.Text := '';
    LabeledEdit20.Text := '';
  end
  else if (temp <> '') and (temp1 = '') then
  begin
    LabeledEdit7.Text := '在库';
    SelectClientDataSet(ClientDataSet11,'select opeedt,usercode from EndProtInDepotZ where InNo='''+temp+'''');
    LabeledEdit19.Text := ClientDataSet11.FieldByName('usercode').AsString + ' ' + ClientDataSet11.FieldByName('opeedt').AsString;
    LabeledEdit20.Text := '';
  end
  else if temp1 <> '' then
  begin
    LabeledEdit7.Text := '已出库';
    SelectClientDataSet(ClientDataSet11,'select opeedt,usercode from EndProtInDepotZ where InNo='''+temp+'''');
    LabeledEdit19.Text := ClientDataSet11.FieldByName('usercode').AsString + ' ' + ClientDataSet11.FieldByName('opeedt').AsString;
    SelectClientDataSet(ClientDataSet11,'select dt,usercode from EndProtOutDepotZ where outno='''+temp1+'''');
    LabeledEdit20.Text := ClientDataSet11.FieldByName('usercode').AsString + ' ' + ClientDataSet11.FieldByName('dt').AsString;
  end;



  strsql := 'select * from LZm_ML_MO_OutLog where ML_NO=''' + LabeledEdit9.Text + '''';

  // 2015年6月4日 21:14:42 多差一个供应商代号
  strsql:='select LZm_ML_MO_OutLog.*,MatlInDepotZ.SuprCode from LZm_ML_MO_OutLog,MatlInDepotZ,MatlInDepotMx'+
  ' where LZm_ML_MO_OutLog.ML_NO=''' + LabeledEdit9.Text + '''  and'+
  ' LZm_ML_MO_OutLog.AutoLot=MatlInDepotMx.AutoLot and MatlInDepotMx.MIDDONO=MatlInDepotZ.MIDDONO';
  SelectClientDataSet(ClientDataSet1, strsql);
  SpeedButton999.Enabled:=True; 
end;

procedure TF_ChengPinZhuiSuChaXun.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_ChengPinZhuiSuChaXun.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05
  Action := caFree;
end;

procedure TF_ChengPinZhuiSuChaXun.FormCreate(Sender: TObject);
begin
  Self.Left := 50;
  Self.Top := 50;
end;

procedure TF_ChengPinZhuiSuChaXun.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
end;

procedure TF_ChengPinZhuiSuChaXun.Timer1Timer(Sender: TObject);
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

procedure TF_ChengPinZhuiSuChaXun.Timer2Timer(Sender: TObject);
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

procedure TF_ChengPinZhuiSuChaXun.SpeedButton123Click(Sender: TObject);
var
  temp: string;
begin //临时建表
  temp := 'if not exists (select name  from sysobjects where [name] = ''TempChengPinZhuiSuChaXun'' and xtype=''U'')' +
    ' begin' +
    ' CREATE TABLE [dbo].[TempChengPinZhuiSuChaXun] (' +
    ' [ID] [int] IDENTITY (1, 1) NOT NULL ,' +
    ' [a] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[b] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[c] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[d] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[e] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[f] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[g] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[h] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[i] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[j] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[k] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[l] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[m] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[n] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[o] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[p] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[q] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[r] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[s] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[t] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[u] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[v] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[w] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[x] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[y] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[z] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL' +
    ' ) ON [PRIMARY]' +
    ' end;';

  if EXSQLClientDataSet(ClientDataSet10, temp) then
  begin
    zsbSimpleMSNPopUpShow('建临时表  成功.');
  end
  else
  begin
    zsbSimpleMSNPopUpShow('建临时表  失败.');
  end;
end;

procedure TF_ChengPinZhuiSuChaXun.SpeedButton999Click(Sender: TObject);
var
  strsql: string;
  i: SmallInt;
begin
  ClearText;
  SpeedButton999.Enabled:=False;
  if LabeledEdit1.Text = '' then
  begin
    ShowInfoTips(LabeledEdit1.Handle, '请输入批次查询.', 3);
    LabeledEdit1.SetFocus;
    SpeedButton999.Enabled:=True;
    Exit;
  end;
  strsql := 'select EndProtLot from EndProtBarCode where EndProtLot like ''%' + LabeledEdit1.Text + '%''';
  i := SelectClientDataSetResultCount(ClientDataSet11, strsql);
  if i = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有相关记录.');
    ClientDataSet1.Close;   
    SpeedButton999.Enabled:=True;
    Exit;
  end
  else if i = 1 then
  begin
    LabeledEdit1.Text := ClientDataSet11.FieldByName('EndProtLot').AsString;
    ChaXun(LabeledEdit1.Text);
  end
  else if i > 1 then
  begin
    MSNPopUpShow('批次[' + LabeledEdit1.Text + ']存在多条类似记录,请确定批次.');
    if Application.FindComponent('F_GetEndProtLot') = nil then
    begin
      F_GetEndProtLot := TF_GetEndProtLot.Create(nil);
    end;
    F_GetEndProtLot.strPuEndProtLot := LabeledEdit1.Text;
    F_GetEndProtLot.ShowModal;
    if F_GetEndProtLot.strPuResult <> '' then
    begin
      LabeledEdit1.Text := F_GetEndProtLot.strPuResult;
      ChaXun(LabeledEdit1.Text);
    end;
  end;
end;

procedure TF_ChengPinZhuiSuChaXun.LabeledEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then SpeedButton999.Click;
end;

procedure TF_ChengPinZhuiSuChaXun.SpeedButton2Click(Sender: TObject);
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
  sheet.cells[3, 1].value := LabeledEdit2.Text;

  sheet.cells[2, 2] := '品名';
  sheet.cells[3, 2].value := LabeledEdit3.Text;

  sheet.cells[2, 3] := '批次';
  sheet.cells[3, 3].value := LabeledEdit1.Text;

  sheet.cells[2, 4] := '版次';
  sheet.cells[3, 4].value := LabeledEdit4.Text;

  sheet.cells[2, 5] := '数量';
  sheet.cells[3, 5].value := LabeledEdit5.Text;

  sheet.cells[2, 6] := '客户';
  sheet.cells[3, 6].value := LabeledEdit6.Text;

  sheet.cells[2, 7] := '状态';
  sheet.cells[3, 7].value := LabeledEdit7.Text;


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

