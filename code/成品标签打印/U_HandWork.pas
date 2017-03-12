unit U_HandWork;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, DBClient, StdCtrls, Grids, DBGridEh, RzPanel,
  RzTabs, frxClass, StrUtils, frxBarcode, psBarcode, ComCtrls, Spin,
  RzLabel;

type
  TF_HandWork = class(TForm)
    Image1: TImage;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPanel99: TRzPanel;
    ClientDataSet2: TClientDataSet;
    frxReport1: TfrxReport;
    ClientDataSet12: TClientDataSet;
    RzPanel8: TRzPanel;
    RzPanel9: TRzPanel;
    Label45: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label60: TLabel;
    psBarcode16: TpsBarcode;
    psBarcode17: TpsBarcode;
    psBarcode18: TpsBarcode;
    psBarcode19: TpsBarcode;
    LabeledEdit13_1: TLabeledEdit;
    LabeledEdit14_1: TLabeledEdit;
    LabeledEdit15_1: TLabeledEdit;
    psBarcode20: TpsBarcode;
    RzPanel10: TRzPanel;
    Label62: TLabel;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    LabeledEdit12: TLabeledEdit;
    LabeledEdit13: TLabeledEdit;
    LabeledEdit14: TLabeledEdit;
    LabeledEdit15: TLabeledEdit;
    LabeledEdit16: TLabeledEdit;
    LabeledEdit17: TLabeledEdit;
    LabeledEdit18: TLabeledEdit;
    LabeledEdit19: TLabeledEdit;
    LabeledEdit20: TLabeledEdit;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    LabeledEdit1: TLabeledEdit;
    ClientDataSet3_1: TClientDataSet;
    ClientDataSet3_2: TClientDataSet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpinEdit1: TSpinEdit;
    Timer2: TTimer;
    ClientDataSet4_OtherDB: TClientDataSet;
    LabeledEdit21: TLabeledEdit;
    LabeledEdit22: TLabeledEdit;
    Timer3: TTimer;
    Label5: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1DblClick(Sender: TObject);
    procedure LabeledEdit17Enter(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure LabeledEdit16Enter(Sender: TObject);
    procedure LabeledEdit11Change(Sender: TObject);
    procedure LabeledEdit20Change(Sender: TObject);
    procedure LabeledEdit10Change(Sender: TObject);
    procedure LabeledEdit13Change(Sender: TObject);
    procedure LabeledEdit14Change(Sender: TObject);
    procedure LabeledEdit15Change(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Label62Click(Sender: TObject);
    procedure Label62MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label1MouseLeave(Sender: TObject);
    procedure Label1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label62MouseLeave(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure LabeledEdit12Change(Sender: TObject);
    procedure LabeledEdit12KeyPress(Sender: TObject; var Key: Char);
  private
    PrEndProtLot: string;
    iTotalQuat, iAlreadyQuat: Integer;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SavePrintHistory;
    procedure GetEndProtQuat(strCode: string);
    procedure Made2DCode_2;
    procedure GetOtherInfo(MO_NO: string);
    { Private declarations }
  public
    { Public declarations }
  end;

const
  cReadMe = '手工生成标签,功能说明:' +
    #13 + #10 + '为了防止程序的 bug 导致打印不出标签，特开此功能.' +
    #13 + #10 + #13 + #10 + 'CONPANY-客户名称' +
    #13 + #10 + 'PART NO-睿和品番' +
    #13 + #10 + 'QUANTITY-数量' +
    #13 + #10 + 'LOT NO-制令单号' +
    #13 + #10 + 'SHIPPING DATE-装柜日期' +
    #13 + #10 + 'CUSTOM NO-客户自己的号' +
    #13 + #10 + 'C/N' +
    #13 + #10 + 'Serial NO-流水号' +
    #13 + #10 + 'REVISION-版次' +
    #13 + #10 + '2014年5月7日 16:52:26 郑少宝' +
    #13 + #10 + #13 + #10 + '增加获取数据功能,' +
    #13 + #10 + '增加连续生成多张标签功能,' +
    #13 + #10 + #13 + #10 + '2014年5月8日 11:11:11 郑少宝';

var
  F_HandWork: TF_HandWork;

implementation

uses ZsbFunPro2, ZsbDLL2, ZsbVariable2, U_PrintCodeNew;

{$R *.dfm}

procedure TF_HandWork.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;



procedure TF_HandWork.Made2DCode_2;
var
  BarCode2D: string;
begin
  BarCode2D := LabeledEdit12.Text + ',' + LabeledEdit11.Text + ',' + LabeledEdit10.Text +
    ',' + LabeledEdit17.Text + ',' + LabeledEdit18.Text + ',' + LabeledEdit19.Text;
  psBarcode19.BarCode := BarCode2D;
end;

procedure TF_HandWork.GetEndProtQuat(strCode: string);
var
  strsql, temp: string;
begin
  strsql := 'select quat,sname,ver from endprotquat where endprotcode=''' + strCode + '''';
  SelectClientDataSetNoTips(ClientDataSet2, strsql);
  if ClientDataSet2.RecordCount = 0 then Exit;
  temp := ClientDataSet2.FieldByName('quat').AsString;
  LabeledEdit10.Text := ClientDataSet2.FieldByName('quat').AsString;
  LabeledEdit14.Text := ClientDataSet2.FieldByName('sname').AsString;
  LabeledEdit20.Text := ClientDataSet2.FieldByName('ver').AsString;
  if LabeledEdit10.Text = '' then LabeledEdit10.Text := '0';
end;

procedure TF_HandWork.GetOtherInfo(MO_NO: string);
var
  strsql, temp: string;
begin
  with ClientDataSet3_1 do //连接其他数据库
  begin
    RemoteServer.AppServer.LinkHISData('1');
  end;
  strsql := 'select DEP,WH,MRP_NO,QTY from MF_MO where MO_NO=''' + MO_NO + ''' ';

  with ClientDataSet3_1 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strsql);
  end;
  LabeledEdit11.Text := ClientDataSet3_1.fieldbyname('MRP_NO').AsString;
  LabeledEdit19.Text := ClientDataSet3_1.fieldbyname('WH').AsString;
  LabeledEdit18.Text := ClientDataSet3_1.fieldbyname('DEP').AsString;
  iTotalQuat := ClientDataSet3_1.fieldbyname('QTY').AsInteger;


  strsql := 'select sum(endprotquat) endprotquat from EndProtBarCode where ERPPDNO=''' + LabeledEdit12.Text +
    ''' and state=''Y''';
  temp := SelectClientDataSetResultFieldCaption(ClientDataSet3_1, strsql, 'endprotquat');
  if temp = '' then temp := '0';
  iAlreadyQuat := StrToInt(temp);

 { strsql:='select DEP,ML_NO from MF_ML where MO_NO='''+MO_NO+''' ';
  with ClientDataSet3_1 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strsql);
  end;
  LabeledEdit1.Text := ClientDataSet3_1.fieldbyname('ML_NO').AsString;   }
end;

procedure TF_HandWork.SavePrintHistory;
var
  custname, temp8, exsql, temp, tnull: string;
  i: SmallInt;
  bRt: Boolean;
begin
  temp8 := FormatDateTime('yyyy-MM-dd HH:mm:ss', Now);
  tnull := '';
  custname := StringReplace(LabeledEdit16.Text, '''', '''''', [rfReplaceAll]); //一个引号替换成两个就可以了
  exsql := '';
  for i := 1 to SpinEdit1.Value do
  begin
    if iTotalQuat > 0 then //没有选择
    begin
      iAlreadyQuat := iAlreadyQuat + StrToInt(LabeledEdit10.Text);
      if iAlreadyQuat > iTotalQuat then
      begin
        iAlreadyQuat := iAlreadyQuat - StrToInt(LabeledEdit10.Text);
        Break;
      end;
    end;
    exsql := exsql + 'insert into EndProtBarCode(EndProtCode,EndProtQuat,CustCode,EndProtVer,EndProtLot,' +
      'OrderNo,Tips,OpeeDT,ShippingD,DEP,ShefCode,CustName,ERPPDNO,ML_NO,CUSTOMNO,uName,cn,HandWork)values(''' + LabeledEdit11.Text + ''',''' + LabeledEdit10.Text +
      ''',''' + tnull + ''',''' + LabeledEdit20.Text + ''',''' + LabeledEdit17.Text + ''',''' + tnull + ''',''' + tnull + ''',''' + temp8 +
      ''',''' + LabeledEdit13.Text + ''',''' + LabeledEdit18.Text + ''',''' + LabeledEdit19.Text +
      ''',''' + custname + ''',''' + LabeledEdit12.Text + ''',''' + LabeledEdit1.Text + ''',''' + LabeledEdit14.Text +
      ''',''' + ZStrUser + ''',''' + LabeledEdit15.Text + ''',''1'');';
    LabeledEdit17.Text := GetSetSerialNo('成品');
  end;
  if exsql <> '' then
  begin
    if EXSQLClientDataSet(ClientDataSet12, exsql) = False then
    begin
      temp := '操作失败.在TF_HandWork.SavePrintHistory';
      AddLog_ErrorText(temp);
      ZsbMsgErrorInfoNoApp(Self, temp);
    end
    else
    begin
      temp := '添加成功.生成标签【 ' + Inttostr(i - 1) + ' 】张';
      zsbSimpleMSNPopUpShow(temp);
      AddLog_Operation('手工生成若干标签,制令单：' + LabeledEdit12.Text + ';品番：' + LabeledEdit11.Text);
    end;
  end
  else
  begin
    zsbSimpleMSNPopUpShow('标签已够，不允许生成标签.');
  end;
end;

procedure TF_HandWork.Timer1Timer(Sender: TObject);
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
end;

procedure TF_HandWork.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
  iTotalQuat := 0;
  iAlreadyQuat := 0;
end;

procedure TF_HandWork.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TF_HandWork.Image1DblClick(Sender: TObject);
begin
  ZsbShowMessageNoApp(Self, cReadMe);
end;

procedure TF_HandWork.LabeledEdit17Enter(Sender: TObject);
begin
  if LabeledEdit17.Text = '' then
  begin
    LabeledEdit17.Text := GetSetSerialNo('成品');
  end;
end;

procedure TF_HandWork.Button9Click(Sender: TObject);
var
  temp: string;
begin
  if LabeledEdit16.Text = '' then
  begin
    ShowInfoTips(LabeledEdit16.Handle, '请在这里输入 CONPANY 噢.', 3);
    LabeledEdit16.SetFocus;
    Exit;
  end;
  if LabeledEdit17.Text = '' then
  begin
    ShowInfoTips(LabeledEdit17.Handle, '没有批次，请点击文本框获取.或者手工输入.', 3);
    LabeledEdit17.SetFocus;
    Exit;
  end;
  if (LabeledEdit10.Text = '') or (LabeledEdit10.Text = '0') then
  begin
    ShowInfoTips(LabeledEdit10.Handle, '请在这里输入 QTY 噢.', 3);
    LabeledEdit10.SetFocus;
    Exit;
  end;

  temp := '确认生成【 ' + IntToStr(SpinEdit1.Value) + ' 】张标签么?' + #13 + #10 + #13 + #10;
  temp := temp + '制令单【 ' + LabeledEdit12.Text + ' 】.' + #13 + #10 + #13 + #10;
  temp := temp + '品番【 ' + LabeledEdit11.Text + ' 】.' + #13 + #10;
  if ZsbMsgBoxOkNoApp(Self, temp) = False then Exit;

  SavePrintHistory;
end;

procedure TF_HandWork.LabeledEdit16Enter(Sender: TObject);
begin
  if LabeledEdit16.Tag = 0 then //获取初始数据
  begin
    LabeledEdit16.Text := SelectClientDataSetResultFieldCaption(ClientDataSet2, 'select tips from initinfo where id=2', 'Tips');
    LabeledEdit16.Tag := 1;
  end;
end;

procedure TF_HandWork.LabeledEdit11Change(Sender: TObject);
begin
  if LabeledEdit11.Text = '' then Exit;
  GetEndProtQuat(LabeledEdit11.Text);
  psBarcode16.BarCode := LabeledEdit11.Text;
end;

procedure TF_HandWork.LabeledEdit20Change(Sender: TObject);
begin
  psBarcode20.BarCode := LabeledEdit20.Text;
end;

procedure TF_HandWork.LabeledEdit10Change(Sender: TObject);
begin
  psBarcode17.BarCode := LabeledEdit10.Text;
  Made2DCode_2;
end;

procedure TF_HandWork.LabeledEdit13Change(Sender: TObject);
begin
  LabeledEdit13_1.Text := LabeledEdit13.Text;
end;

procedure TF_HandWork.LabeledEdit14Change(Sender: TObject);
begin
  LabeledEdit14_1.Text := LabeledEdit14.Text;
end;

procedure TF_HandWork.LabeledEdit15Change(Sender: TObject);
begin
  LabeledEdit15_1.Text := LabeledEdit15.Text;
end;

procedure TF_HandWork.Button11Click(Sender: TObject);
begin
  LabeledEdit10.Text := '0';
  LabeledEdit1.Text := '';
  LabeledEdit11.Text := '';
  LabeledEdit12.Text := ' ';
  LabeledEdit13.Text := '';
  LabeledEdit14.Text := '';
  LabeledEdit15.Text := '';
  LabeledEdit17.Text := '';
  LabeledEdit18.Text := '';
  LabeledEdit19.Text := '';
  LabeledEdit19.Text := ' ';
  LabeledEdit20.Text := ' ';
  psBarcode16.BarCode := ' ';
end;

procedure TF_HandWork.Button10Click(Sender: TObject);
begin
  if Application.FindComponent('F_PrintCodeNew') = nil then
  begin
    Application.CreateForm(TF_PrintCodeNew, F_PrintCodeNew);
  end;
  F_PrintCodeNew.CheckBox3.Checked := True;
  F_PrintCodeNew.show;
end;

procedure TF_HandWork.Label62Click(Sender: TObject);
begin
  if LabeledEdit11.Text = '' then Exit;
  GetEndProtQuat(LabeledEdit11.Text);
end;

procedure TF_HandWork.Label62MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  Label62.Font.Style := [fsBold];
end;

procedure TF_HandWork.Label62MouseLeave(Sender: TObject);
begin
  Label62.Font.Style := [];
end;

procedure TF_HandWork.Label1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  Label1.Font.Style := [fsBold];
end;

procedure TF_HandWork.Label1MouseLeave(Sender: TObject);
begin
  Label1.Font.Style := [];
end;

procedure TF_HandWork.Label1Click(Sender: TObject);
var
  temp: string;
  TSList: TStringList;
begin
  if LeftStr(LabeledEdit12.Text, 2) = 'ML' then
  begin
    TSList := SplitString(LabeledEdit12.Text, ',');
    if LeftStr(TSList[1], 2) = 'MO' then
    begin
      LabeledEdit12.Text := TSList[1];
    end;  
    Application.ProcessMessages;
  end;
  if LeftStr(LabeledEdit12.Text, 2) <> 'MO' then
  begin
    zsbSimpleMSNPopUpShow_2('不可识别的制令单号.', clRed);
    Exit;
  end;
  GetOtherInfo(LabeledEdit12.Text);
  psBarcode18.BarCode := LabeledEdit12.Text;
  Made2DCode_2;
end;

procedure TF_HandWork.Timer2Timer(Sender: TObject);
begin
  //Label1MouseLeave(Sender: TObject);  这个事件不执行，郁闷

  Label1.Font.Style := [];
  Label62.Font.Style := [];
end;

procedure TF_HandWork.Timer3Timer(Sender: TObject);
begin
  //测试用
  LabeledEdit21.Text := IntToStr(iTotalQuat);
  LabeledEdit22.Text := IntToStr(iAlreadyQuat);
end;

procedure TF_HandWork.LabeledEdit12Change(Sender: TObject);
begin
  psBarcode18.BarCode := LabeledEdit12.Text;
  Made2DCode_2;
end;

procedure TF_HandWork.LabeledEdit12KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Label1Click(Sender);
  end;
end;

end.

