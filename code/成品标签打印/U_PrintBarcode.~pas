unit U_PrintBarcode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  psBarcode, RzLine, frxClass, frxBarcode, Clipbrd, StrUtils, frxDesgn,
  Spin;

type
  TF_PrintBarcode = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    Timer2: TTimer;
    TabSheet3: TRzTabSheet;
    RzPanel1: TRzPanel;
    SpeedButton999: TSpeedButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    RzPanel3: TRzPanel;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    RzLine1: TRzLine;
    RzLine2: TRzLine;
    psBarcode1: TpsBarcode;
    psBarcode2: TpsBarcode;
    psBarcode3: TpsBarcode;
    psBarcode4: TpsBarcode;
    psBarcode5: TpsBarcode;
    psBarcode6: TpsBarcode;
    psBarcode7: TpsBarcode;
    Image1: TImage;
    DBGridEh1: TDBGridEh;
    ClientDataSet10: TClientDataSet;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    CheckBox1: TCheckBox;
    RzPageControl3: TRzPageControl;
    RzPageControl2: TRzPageControl;
    RzTabSheet1: TRzTabSheet;
    RzLine4: TRzLine;
    RzLine5: TRzLine;
    RzLine6: TRzLine;
    RzLine7: TRzLine;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    RzLine8: TRzLine;
    Label19: TLabel;
    Label20: TLabel;
    Label16: TLabel;
    Label21: TLabel;
    RzLine9: TRzLine;
    RzLine10: TRzLine;
    RzLine11: TRzLine;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    psBarcode8: TpsBarcode;
    psBarcode9: TpsBarcode;
    psBarcode10: TpsBarcode;
    psBarcode11: TpsBarcode;
    RzTabSheet2: TRzTabSheet;
    RzLine13: TRzLine;
    RzLine14: TRzLine;
    RzLine15: TRzLine;
    RzLine16: TRzLine;
    RzLine17: TRzLine;
    Label26: TLabel;
    Label28: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label27: TLabel;
    Label25: TLabel;
    psBarcode12: TpsBarcode;
    psBarcode13: TpsBarcode;
    psBarcode14: TpsBarcode;
    psBarcode15: TpsBarcode;
    TabSheet33: TRzTabSheet;
    TabSheet44: TRzTabSheet;
    LabeledEdit111: TLabeledEdit;
    LabeledEdit112: TLabeledEdit;
    LabeledEdit113: TLabeledEdit;
    LabeledEdit114: TLabeledEdit;
    LabeledEdit115: TLabeledEdit;
    Label29: TLabel;
    Memo1: TMemo;
    SpeedButton2: TSpeedButton;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    Memo2: TMemo;
    Label42: TLabel;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    SpeedButton1: TSpeedButton;
    LabeledEdit9: TLabeledEdit;
    frxReport1: TfrxReport;
    TabSheet2: TRzTabSheet;
    RzPanel2: TRzPanel;
    RzPanel6: TRzPanel;
    Label46: TLabel;
    Label48: TLabel;
    psBarcode201: TpsBarcode;
    psBarcode202: TpsBarcode;
    Label43: TLabel;
    frxReport2: TfrxReport;
    RzPanel7: TRzPanel;
    CheckBox4: TCheckBox;
    Button1: TButton;
    LabeledEdit202: TLabeledEdit;
    LabeledEdit201: TLabeledEdit;
    Label44: TLabel;
    LabeledEdit203: TLabeledEdit;
    LabeledEdit204: TLabeledEdit;
    LabeledEdit205: TLabeledEdit;
    Label200: TLabel;
    Label47: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    psBarcode204: TpsBarcode;
    psBarcode203: TpsBarcode;
    psBarcode205: TpsBarcode;
    psBarcode200: TpsBarcode;
    CheckBox5: TCheckBox;
    TabSheet4: TRzTabSheet;
    RzPanel8: TRzPanel;
    RzPanel9: TRzPanel;
    Label45: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    psBarcode16: TpsBarcode;
    psBarcode17: TpsBarcode;
    psBarcode18: TpsBarcode;
    psBarcode19: TpsBarcode;
    RzPanel10: TRzPanel;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    LabeledEdit12: TLabeledEdit;
    LabeledEdit13: TLabeledEdit;
    LabeledEdit14: TLabeledEdit;
    CheckBox7: TCheckBox;
    Label57: TLabel;
    LabeledEdit15: TLabeledEdit;
    LabeledEdit13_1: TLabeledEdit;
    LabeledEdit14_1: TLabeledEdit;
    LabeledEdit15_1: TLabeledEdit;
    frxReport3: TfrxReport;
    LabeledEdit16: TLabeledEdit;
    LabeledEdit17: TLabeledEdit;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    LabeledEdit206: TLabeledEdit;
    Label55: TLabel;
    psBarcode206: TpsBarcode;
    Button8: TButton;
    Timer4: TTimer;
    Label56: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    LabeledEdit18: TLabeledEdit;
    LabeledEdit19: TLabeledEdit;
    LabeledEdit20: TLabeledEdit;
    psBarcode20: TpsBarcode;
    Label60: TLabel;
    Timer5: TTimer;
    Button9: TButton;
    Button10: TButton;
    Label62: TLabel;
    Button11: TButton;
    Button12: TButton;
    SpinEdit1: TSpinEdit;
    Label61: TLabel;
    LabeledEdit22: TLabeledEdit;
    LabeledEdit21: TLabeledEdit;
    LabeledEdit23: TLabeledEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure RzPageControl3Change(Sender: TObject);
    procedure RzPageControl2Change(Sender: TObject);
    procedure LabeledEdit111Change(Sender: TObject);
    procedure LabeledEdit112Change(Sender: TObject);
    procedure LabeledEdit113Change(Sender: TObject);
    procedure LabeledEdit115Change(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure LabeledEdit114Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure LabeledEdit201Change(Sender: TObject);
    procedure LabeledEdit202Change(Sender: TObject);
    procedure LabeledEdit203Change(Sender: TObject);
    procedure LabeledEdit204Change(Sender: TObject);
    procedure LabeledEdit205Change(Sender: TObject);
    procedure LabeledEdit205KeyPress(Sender: TObject; var Key: Char);
    procedure CheckBox5Click(Sender: TObject);
    procedure LabeledEdit13Change(Sender: TObject);
    procedure LabeledEdit16Change(Sender: TObject);
    procedure LabeledEdit11Change(Sender: TObject);
    procedure LabeledEdit10Change(Sender: TObject);
    procedure LabeledEdit12Change(Sender: TObject);
    procedure LabeledEdit17Change(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure LabeledEdit10Enter(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure LabeledEdit206Change(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure LabeledEdit203Enter(Sender: TObject);
    procedure LabeledEdit16Exit(Sender: TObject);
    procedure LabeledEdit16Enter(Sender: TObject);
    procedure Label52Click(Sender: TObject);
    procedure LabeledEdit13Enter(Sender: TObject);
    procedure LabeledEdit15Change(Sender: TObject);
    procedure LabeledEdit20Change(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);
    procedure LabeledEdit17Enter(Sender: TObject);
    procedure LabeledEdit11Exit(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure LabeledEdit14Change(Sender: TObject);
    procedure Label62Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
  private
    iTotalQuat, iAlreadyQuat: Integer; //制令单生产总数，已经打印的总数
    iPackingQty:Integer;//包装数
    bPrintNext: Boolean;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Made2DCode;
    procedure Made2DCode_2;
    procedure GetEndProtQuat(strCode: string); //获取包装数量
    function CheckPrint: Boolean; // 打印前的检查
    function GetSavePrintHistorySql: string; //保存 标签生成的sql
    function PrintMoreOrNo: Boolean; //打印超数
    procedure FormatLastBarCode;
    { Private declarations }
  public
    function SavePrintHistory(iPage: SmallInt): Boolean;
    { Public declarations }
  end;

var
  F_PrintBarcode: TF_PrintBarcode;

const
  cReadMe='新打印标签,功能说明:'+
  #13+#10+#13+#10+'CONPANY-客户名称'+
  #13+#10+'PART NO-睿和品番'+
  #13+#10+'QUANTITY-数量'+
  #13+#10+'LOT NO-制令单号'+
  #13+#10+'SHIPPING DATE-装柜日期'+
  #13+#10+'CUSTOM NO-客户自己的号'+
  #13+#10+'C/N'+
  #13+#10+'Serial NO-流水号'+
  #13+#10+'REVISION-版次'+
  #13+#10+#13+#10+'2014年5月7日 17:19:19 郑少宝';
  
implementation

uses UDM, ZsbDLL2, ZsbFunPro2, U_SelectPrintInfo, U_SelectPrintSupply,
  ZsbVariable2, U_PrintCodeNew, U_HandWork;

{$R *.dfm} //EndPot  zsbSimpleMSNPopUpShow();    

procedure TF_PrintBarcode.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_PrintBarcode.Made2DCode;
var
  BarCode2D: string;
begin //代号+睿和料号+数量+批号+版次
  BarCode2D := LabeledEdit201.Text + ',' + LabeledEdit203.Text + ',' + LabeledEdit205.Text + ',' + LabeledEdit204.Text + ',' + LabeledEdit206.Text;
  psBarcode200.BarCode := BarCode2D;
end;

procedure TF_PrintBarcode.Made2DCode_2;
var
  BarCode2D: string;
begin
  BarCode2D := LabeledEdit12.Text + ',' + LabeledEdit11.Text + ',' + LabeledEdit10.Text +
    ',' + LabeledEdit17.Text + ',' + LabeledEdit18.Text + ',' + LabeledEdit19.Text;
  psBarcode19.BarCode := BarCode2D;
end;

procedure TF_PrintBarcode.FormatLastBarCode;
var
  temp:string;
begin
  if StrToInt(LabeledEdit10.Text)<=iPackingQty then  Exit; //数量小于包装数不处理

  temp:='select id from SysSomeSet where iName=''FormatLastBarCode'' and iValue=''Y''';
  if SelectClientDataSetResultCount(ClientDataSet10,temp) = 0 then      Exit;
  temp:=RightStr(LabeledEdit10.Text,1);
  if temp='0' then Exit;

  temp:=LeftStr(LabeledEdit10.Text,Length(LabeledEdit10.Text)-1);
  LabeledEdit10.Text:=temp+'0';
  AddLog_Operation(LabeledEdit17.Text+' FormatLastBarCode');
end;

function TF_PrintBarcode.PrintMoreOrNo: Boolean;
var
  bRt: Boolean;
  iTemp: Integer;
begin
  bRt := False;
  if CheckBox7.Checked then  //自动打印才检测  5762
  begin
    iTemp := iAlreadyQuat + StrToInt(LabeledEdit10.Text);  //5760 +480 =6240
    iTemp := iTemp - itotalquat;   //6240-5762= 478
    if iTemp > 0 then //打印超数
    begin
      if iTemp >= StrToInt(LabeledEdit10.Text) then //还大于包装数
      begin
        bRt := True;   //终止打印
      end
      else
      begin  //2014年4月23日 16:42:02 不提醒 免得提醒过多  
        LabeledEdit10.Text := IntToStr(itotalquat-iAlreadyQuat); //继续打印，自动更改包装数
        bPrintNext := False;
      end;
    end;
  end;
  Result := bRt;
end;

procedure TF_PrintBarcode.GetEndProtQuat(strCode: string);
var
  strsql: string;
begin
  strsql := 'select quat,sname,ver from endprotquat where endprotcode=''' + strCode + '''';
  SelectClientDataSetNoTips(ClientDataSet10, strsql);
  LabeledEdit10.Text := ClientDataSet10.FieldByName('quat').AsString;
  LabeledEdit14.Text := ClientDataSet10.FieldByName('sname').AsString;
  LabeledEdit20.Text := ClientDataSet10.FieldByName('ver').AsString;
  if LabeledEdit10.Text='' then LabeledEdit10.Text:='0';
  iPackingQty:=StrToInt(LabeledEdit10.Text);
end;

function TF_PrintBarcode.GetSavePrintHistorySql: string;
var
  custname, temp3, temp6, temp7, temp8, exsql: string;
begin
  temp8 := FormatDateTime('yyyy-MM-dd HH:mm:ss', Now);
  temp3 := '';
  temp6 := '';
  temp7 := '';
  custname := StringReplace(LabeledEdit16.Text, '''', '''''', [rfReplaceAll]); //一个引号替换成两个就可以了

  exsql := 'insert into EndProtBarCode(EndProtCode,EndProtQuat,CustCode,EndProtVer,EndProtLot,' +
    'OrderNo,Tips,OpeeDT,ShippingD,DEP,ShefCode,CustName,ERPPDNO,ML_NO,CUSTOMNO,uName,cn)values(''' + LabeledEdit11.Text + ''',''' + LabeledEdit10.Text +
    ''',''' + temp3 + ''',''' + LabeledEdit20.Text + ''',''' + LabeledEdit17.Text + ''',''' + temp6 + ''',''' + temp7 + ''',''' + temp8 +
    ''',''' + LabeledEdit13.Text + ''',''' + LabeledEdit18.Text + ''',''' + LabeledEdit19.Text +
    ''',''' + custname + ''',''' + LabeledEdit12.Text + ''',''' + LabeledEdit23.Text + ''',''' + LabeledEdit14.Text +
    ''',''' + ZStrUser + ''',''' + LabeledEdit15.Text + ''');';



  LabeledEdit17.Text := GetSetSerialNo('成品'); //获得下一个批次

  iAlreadyQuat := iAlreadyQuat + strtoint(LabeledEdit10.Text);

  Result := exsql;
end;

function TF_PrintBarcode.SavePrintHistory(iPage: SmallInt): Boolean;
var
  custname, temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, exsql: string;
  bmpName, bmpFileName: string;
  bTemp: Boolean;
begin
  bTemp := False;
  temp8 := FormatDateTime('yyyy-MM-dd HH:mm:ss', Now);
  if iPage = 0 then
  begin
    temp1 := LabeledEdit111.Text;
    temp2 := LabeledEdit112.Text;
    temp3 := LabeledEdit113.Text;
    temp4 := LabeledEdit114.Text;
    temp5 := LabeledEdit115.Text;
    temp6 := '';
    temp7 := Memo1.Text;
    exsql := 'insert into EndProtBarCode(EndProtCode,EndProtQuat,CustCode,EndProtVer,EndProtLot,' +
      'OrderNo,Tips,OpeeDT)values(''' + temp1 + ''',''' + temp2 + ''',''' + temp3 + ''',''' + temp4 +
      ''',''' + temp5 + ''',''' + temp6 + ''',''' + temp7 + ''',''' + temp8 + ''')';
  end
  else if iPage = 3 then
  begin
    temp1 := LabeledEdit11.Text;
    temp2 := LabeledEdit10.Text;
    temp3 := '';
    temp4 := LabeledEdit20.Text;
    temp5 := LabeledEdit17.Text;
    temp6 := '';
    temp7 := '';
    custname := StringReplace(LabeledEdit16.Text, '''', '''''', [rfReplaceAll]); //一个引号替换成两个就可以了

    exsql := 'insert into EndProtBarCode(EndProtCode,EndProtQuat,CustCode,EndProtVer,EndProtLot,' +
      'OrderNo,Tips,OpeeDT,ShippingD,DEP,ShefCode,CustName,ERPPDNO,ML_NO,bmpName,CUSTOMNO)values(''' + temp1 + ''',''' + temp2 +
      ''',''' + temp3 + ''',''' + temp4 + ''',''' + temp5 + ''',''' + temp6 + ''',''' + temp7 + ''',''' + temp8 +
      ''',''' + LabeledEdit13.Text + ''',''' + LabeledEdit18.Text + ''',''' + LabeledEdit19.Text +
      ''',''' + custname + ''',''' + LabeledEdit12.Text + ''',''' + LabeledEdit23.Text + ''',''' + bmpName + ''',''' + LabeledEdit14.Text + ''')';

   // SaveMessage(exsql, 'sql');

    LabeledEdit17.Text := GetSetSerialNo('成品'); //获得下一个批次
  end;
  if exsql <> '' then
  begin
    bTemp := EXSQLClientDataSet(ClientDataSet10, exsql);
  end;
  if bTemp = False then
  begin
    deletefile(bmpFileName); //删除保存的文件
  end;
  Result := bTemp;
end;

procedure TF_PrintBarcode.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_PrintBarcode.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05
  Timer5.Enabled:=False;
  Action := caFree;
end;

procedure TF_PrintBarcode.FormCreate(Sender: TObject);
begin
  Self.Top := 0;
  Self.Top := 0;
end;

procedure TF_PrintBarcode.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
end;

procedure TF_PrintBarcode.Timer1Timer(Sender: TObject);
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
end;

procedure TF_PrintBarcode.Timer2Timer(Sender: TObject);
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
    //SpeedButton999.Click;
    Timer4.Enabled := True;
  finally

  end;
end;

procedure TF_PrintBarcode.SpeedButton999Click(Sender: TObject);
var
  temp: string;
begin
  temp := 'select MatlInDepotMX.MatlCode,MatlInDepotMX.MatlLot,MatlInDepotMX.MatlVer,MatlInDepotMX.StockQuat' +
    ',Supplier.SuprCode,Supplier.SuprName, Material.MatlName from MatlInDepotMX,Supplier,Material where MatlInDepotMX.MatlCode=Material.MatlCode ' +
    'and Material.SuprCode=Supplier.SuprCode';
  if LabeledEdit1.Text <> '' then
  begin
    temp := temp + ' and MatlInDepotMX.MatlCode like ''%' + LabeledEdit1.Text + '%''';
  end;
  if LabeledEdit2.Text <> '' then
  begin
    temp := temp + ' and MatlInDepotMX.MatlLot like ''%' + LabeledEdit2.Text + '%''';
  end;
  if LabeledEdit3.Text <> '' then
  begin
    temp := temp + ' and MatlInDepotMX.MatlCode in(select MatlCode from Material where SuprCode like ''%' + LabeledEdit3.Text + '%'')';
  end;
  if CheckBox1.Checked = False then
  begin
    temp := temp + ' and MatlInDepotMX.StockQuat>0';
  end;
  SelectClientDataSet(ClientDataSet1, temp);
end;

procedure TF_PrintBarcode.DBGridEh1CellClick(Column: TColumnEh);
var
  BarCode2D: string;
begin
  label1.Caption := ClientDataSet1.fieldbyname('SuprName').AsString;
  psBarcode1.BarCode := ClientDataSet1.fieldbyname('SuprCode').AsString;
  psBarcode2.BarCode := ClientDataSet1.fieldbyname('MatlCode').AsString;
  psBarcode3.BarCode := ClientDataSet1.fieldbyname('MatlCode').AsString;
  psBarcode4.BarCode := ClientDataSet1.fieldbyname('StockQuat').AsString;
  psBarcode5.BarCode := ClientDataSet1.fieldbyname('MatlLot').AsString;
  psBarcode6.BarCode := ClientDataSet1.fieldbyname('MatlVer').AsString;
  BarCode2D := ClientDataSet1.fieldbyname('SuprCode').AsString + ',' + ClientDataSet1.fieldbyname('MatlCode').AsString + ',' +
    ClientDataSet1.fieldbyname('MatlCode').AsString + ',' +
    ClientDataSet1.fieldbyname('StockQuat').AsString + ',' +
    ClientDataSet1.fieldbyname('MatlLot').AsString + ',' +
    ClientDataSet1.fieldbyname('MatlVer').AsString;
  psBarcode7.BarCode := BarCode2D;
end;

procedure TF_PrintBarcode.RzPageControl3Change(Sender: TObject);
begin
  RzPageControl2.ActivePageIndex := RzPageControl3.ActivePageIndex;
end;

procedure TF_PrintBarcode.RzPageControl2Change(Sender: TObject);
begin
  RzPageControl3.ActivePageIndex := RzPageControl2.ActivePageIndex;
end;

procedure TF_PrintBarcode.LabeledEdit111Change(Sender: TObject);
begin
  label1.Caption := LabeledEdit111.Text;
  label10.Caption := LabeledEdit111.Text;
  psBarcode8.BarCode := LabeledEdit111.Text;
end;

procedure TF_PrintBarcode.LabeledEdit112Change(Sender: TObject);
begin
  label14.Caption := LabeledEdit112.Text;
  psBarcode9.BarCode := LabeledEdit112.Text;
end;

procedure TF_PrintBarcode.LabeledEdit113Change(Sender: TObject);
begin
  label18.Caption := LabeledEdit113.Text;
  psBarcode10.BarCode := LabeledEdit113.Text;
end;

procedure TF_PrintBarcode.LabeledEdit115Change(Sender: TObject);
begin
  label21.Caption := LabeledEdit115.Text;
  psBarcode11.BarCode := LabeledEdit115.Text;
end;

procedure TF_PrintBarcode.Memo1Change(Sender: TObject);
begin
  label15.Caption := Memo1.Text;
end;

procedure TF_PrintBarcode.SpeedButton2Click(Sender: TObject);
var
  reportFilePath, strsql: string;
begin
  if LabeledEdit111.Text = '' then
  begin
    ShowInfoTips(LabeledEdit111.Handle, '请在这里输入品番噢.', 3);
    LabeledEdit111.SetFocus;
    Exit;
  end;
  if LabeledEdit112.Text = '' then
  begin
    ShowInfoTips(LabeledEdit112.Handle, '请在这里输入数量噢.', 3);
    LabeledEdit112.SetFocus;
    Exit;
  end;
  if LabeledEdit113.Text = '' then
  begin
    ShowInfoTips(LabeledEdit113.Handle, '请在这里输入供应商代码噢.', 3);
    LabeledEdit113.SetFocus;
    Exit;
  end;
  if LabeledEdit114.Text = '' then
  begin
    ShowInfoTips(LabeledEdit114.Handle, '请在这里输入版次噢.', 3);
    LabeledEdit114.SetFocus;
    Exit;
  end;
  if LabeledEdit115.Text = '' then
  begin
    ShowInfoTips(LabeledEdit115.Handle, '请在这里输入批次噢.', 3);
    LabeledEdit115.SetFocus;
    Exit;
  end;
  strsql := 'select id from EndProtBarCode where EndProtCode=''' + LabeledEdit111.Text + ''' and EndProtLot=''' + LabeledEdit115.Text + '''';
  strsql := 'select id from EndProtBarCode where EndProtLot=''' + LabeledEdit115.Text + '''';
  if SelectClientDataSetResultCount(ClientDataSet10, strsql) > 0 then
  begin
    ShowInfoTips(LabeledEdit115.Handle, '该批号已经存在,请重新输入.', 3);
    LabeledEdit115.SetFocus;
    Exit;
  end;

  reportFilePath := ExtractFilePath(ParamStr(0)) + 'frxReport2.fr3';
  if not FileExists(reportFilePath) then
  begin
    ZsbMsgErrorInfoNoApp(Self, '对不起,标签模版不存在,请联系管理员！');
    Exit;
  end;
  frxReport1.Clear;
  frxReport1.LoadFromFile(reportFilePath);



  TfrxBarCodeView(frxReport1.FindObject('BarCode1')).Text := LabeledEdit111.Text;
  TfrxMemoView(frxReport1.FindObject('Memo1')).Memo.Text := LabeledEdit111.Text;

  TfrxBarCodeView(frxReport1.FindObject('BarCode2')).Text := LabeledEdit112.Text;
  TfrxMemoView(frxReport1.FindObject('Memo2')).Memo.Text := LabeledEdit112.Text;

  TfrxBarCodeView(frxReport1.FindObject('BarCode3')).Text := LabeledEdit113.Text;
  TfrxMemoView(frxReport1.FindObject('Memo3')).Memo.Text := LabeledEdit113.Text;

  TfrxMemoView(frxReport1.FindObject('Memo4')).Memo.Text := LabeledEdit114.Text;

  TfrxBarCodeView(frxReport1.FindObject('BarCode5')).Text := LabeledEdit115.Text;
  TfrxMemoView(frxReport1.FindObject('Memo5')).Memo.Text := LabeledEdit115.Text;


  TfrxMemoView(frxReport1.FindObject('Memo6')).Memo.Text := Memo1.Text;


  if CheckBox2.Checked then
  begin
    frxReport1.ShowReport();
  end
  else
  begin
    frxReport1.PrepareReport;
    frxReport1.PrintOptions.ShowDialog := False; //不显示打印机选择框
   // frxReport1.PrintOptions.Printer := PrStrPrinterName; //选择打印机名称
    frxReport1.Print; //打印
  end;
  if SavePrintHistory(0) = False then
  begin
    zsbSimpleMSNPopUpShow('打印信息记录失败。');
  end;
end;

procedure TF_PrintBarcode.LabeledEdit114Change(Sender: TObject);
begin
  label19.Caption := LabeledEdit114.Text;
end;

procedure TF_PrintBarcode.Button1Click(Sender: TObject);
var
  reportFilePath: string;
begin
  if LabeledEdit201.Text = '' then
  begin
    ShowInfoTips(LabeledEdit201.Handle, '请在这里输入代码噢.', 3);
    LabeledEdit201.SetFocus;
    Exit;
  end;
  if LabeledEdit203.Text = '' then
  begin
    ShowInfoTips(LabeledEdit203.Handle, '请在这里输入料号噢.', 3);
    LabeledEdit203.SetFocus;
    Exit;
  end;
  if LabeledEdit205.Text = '' then
  begin
    ShowInfoTips(LabeledEdit205.Handle, '请在这里输入数量噢.', 3);
    LabeledEdit205.SetFocus;
    Exit;
  end;

  if LabeledEdit202.Text = '' then
  begin
    ShowInfoTips(LabeledEdit202.Handle, '没有对方料号，请重新操作.或者手工输入.', 3);
    LabeledEdit202.SetFocus;
    Exit;
  end;
  if LabeledEdit204.Text = '' then
  begin
    ShowInfoTips(LabeledEdit204.Handle, '没有批次，请重新操作.或者手工输入.', 3);
    LabeledEdit204.SetFocus;
    Exit;
  end;

  reportFilePath := ExtractFilePath(ParamStr(0)) + 'frxReport4.fr3';
  if not FileExists(reportFilePath) then
  begin
    ZsbMsgErrorInfoNoApp(Self, '对不起,标签模版不存在,请联系管理员！');
    Exit;
  end;
  frxReport2.Clear;
  frxReport2.LoadFromFile(reportFilePath);
  TfrxMemoView(frxReport2.FindObject('Memo0')).Text := Label200.Caption;
  TfrxBarCodeView(frxReport2.FindObject('BarCode1')).Text := LabeledEdit201.Text;
  TfrxBarCodeView(frxReport2.FindObject('BarCode2')).Text := LabeledEdit202.Text;
  TfrxBarCodeView(frxReport2.FindObject('BarCode3')).Text := LabeledEdit203.Text;
  TfrxBarCodeView(frxReport2.FindObject('BarCode4')).Text := LabeledEdit204.Text;
  TfrxBarCodeView(frxReport2.FindObject('BarCode5')).Text := LabeledEdit205.Text;
  if LabeledEdit206.Text = '' then LabeledEdit206.Text := ' ';
  TfrxBarCodeView(frxReport2.FindObject('BarCode6')).Text := LabeledEdit206.Text;
  Clipboard.Clear;
  psBarcode200.CopyToClipboard; //复制到剪贴板
  TfrxPictureView(frxReport2.FindObject('picture0')).Picture.LoadFromClipboardFormat(CF_BITMAP, ClipBoard.GetAsHandle(CF_BITMAP), 0); //读取剪贴板

  if CheckBox4.Checked then
  begin
    frxReport2.ShowReport();
  end
  else
  begin
    frxReport2.PrepareReport;
    frxReport2.PrintOptions.ShowDialog := False; //不显示打印机选择框
   // frxReport1.PrintOptions.Printer := PrStrPrinterName; //选择打印机名称
    frxReport2.Print; //打印
  end;
  LabeledEdit204.Text := IntToStr(StrToInt64(LabeledEdit204.Text) + 1); //获得下一个批次
end;

procedure TF_PrintBarcode.LabeledEdit201Change(Sender: TObject);
begin
  Label200.Caption := GetSuprName(LabeledEdit201.Text);
  psBarcode201.BarCode := LabeledEdit201.Text;
  Made2DCode;
end;

procedure TF_PrintBarcode.LabeledEdit202Change(Sender: TObject);
begin
  psBarcode202.BarCode := LabeledEdit202.Text;
end;

procedure TF_PrintBarcode.LabeledEdit203Change(Sender: TObject);
begin
  LabeledEdit202.Text := GetMatlName(LabeledEdit203.Text);
  psBarcode203.BarCode := LabeledEdit203.Text;
  Made2DCode;
end;

procedure TF_PrintBarcode.LabeledEdit204Change(Sender: TObject);
begin
  psBarcode204.BarCode := LabeledEdit204.Text;
  Made2DCode;
end;

procedure TF_PrintBarcode.LabeledEdit205Change(Sender: TObject);
begin
  psBarcode205.BarCode := LabeledEdit205.Text;
  Made2DCode;
end;

procedure TF_PrintBarcode.LabeledEdit205KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in ['0'..'9', #8, '.'])) then Key := #0;
end;

procedure TF_PrintBarcode.CheckBox5Click(Sender: TObject);
var
  b: Boolean;
begin
  b := CheckBox5.Checked;
  LabeledEdit202.ReadOnly := b;
  LabeledEdit204.ReadOnly := b;
  if b then
  begin
    LabeledEdit202.Color := clSkyBlue;
    LabeledEdit204.Color := clSkyBlue;
  end
  else
  begin
    LabeledEdit202.Color := clWhite;
    LabeledEdit204.Color := clWhite;
  end;
end;

procedure TF_PrintBarcode.LabeledEdit13Change(Sender: TObject);
begin
  LabeledEdit13_1.Text := LabeledEdit13.Text;
end;

procedure TF_PrintBarcode.LabeledEdit16Change(Sender: TObject);
begin
  Label53.Caption := LabeledEdit16.Text;
end;

procedure TF_PrintBarcode.LabeledEdit11Change(Sender: TObject);
begin
  if LabeledEdit11.Text = '' then Exit;
  psBarcode16.BarCode := LabeledEdit11.Text;
  GetEndProtQuat(LabeledEdit11.Text);
  Made2DCode_2;
end;

procedure TF_PrintBarcode.LabeledEdit10Change(Sender: TObject);
begin
  psBarcode17.BarCode := LabeledEdit10.Text;
  Made2DCode_2;
end;

procedure TF_PrintBarcode.LabeledEdit12Change(Sender: TObject);
begin
  psBarcode18.BarCode := LabeledEdit12.Text;
  Made2DCode_2;
end;

procedure TF_PrintBarcode.LabeledEdit17Change(Sender: TObject);
begin
  Made2DCode_2;
end;

function TF_PrintBarcode.CheckPrint: Boolean;
var
  bTemp: Boolean;
begin
  bTemp := False;
  if SpinEdit1.Value = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有检测到要打印的数量.');
  end
  else if LabeledEdit16.Text = '' then
  begin
    ShowInfoTips(LabeledEdit16.Handle, '请在这里输入 CONPANY 噢.', 3);
    LabeledEdit16.SetFocus;
  end
  else if (LabeledEdit10.Text = '') or (LabeledEdit10.Text = '0') then
  begin
    ShowInfoTips(LabeledEdit10.Handle, '请在这里输入 QTY 噢.', 3);
    LabeledEdit10.SetFocus;
  end
  else if LabeledEdit11.Text = '' then
  begin
    ShowInfoTips(LabeledEdit11.Handle, '请在这里输入 PN 噢.', 3);
    LabeledEdit11.SetFocus;
  end
  else if LabeledEdit12.Text = '' then
  begin
    ShowInfoTips(LabeledEdit12.Handle, '请在这里输入 LOT NO 噢.', 3);
    LabeledEdit12.SetFocus;
  end
  else if LabeledEdit13.Text = '' then
  begin
    ShowInfoTips(LabeledEdit13.Handle, '请在这里输入 SHIPPING DATE 噢.', 3);
    LabeledEdit13.SetFocus;
  end
  else if LabeledEdit14.Text = '' then
  begin
    ShowInfoTips(LabeledEdit14.Handle, '请在这里输入 CUSTOM NO 噢.', 3);
    LabeledEdit14.SetFocus;
  end
  else if LabeledEdit17.Text = '' then
  begin
    ShowInfoTips(LabeledEdit17.Handle, '没有批次，请重新操作.或者手工输入.', 3);
    LabeledEdit17.SetFocus;
  end 
  else if LabeledEdit20.Text = '' then
  begin
    ShowInfoTips(LabeledEdit20.Handle, '没有版次，请重新操作.或者手工输入.', 3);
    LabeledEdit20.SetFocus;
  end
  else
  begin
    bTemp := True; //放在最后一个
  end;
  Result := bTemp;
end;

procedure TF_PrintBarcode.CheckBox7Click(Sender: TObject);
var
  b: Boolean;
begin
  b := CheckBox7.Checked;
  LabeledEdit11.ReadOnly := b;
  LabeledEdit12.ReadOnly := b;
  LabeledEdit14.ReadOnly := b;
  LabeledEdit17.ReadOnly := b;
  LabeledEdit18.ReadOnly := b;
  LabeledEdit19.ReadOnly := b;
  if b then
  begin
    LabeledEdit11.Color := clSkyBlue;
    LabeledEdit12.Color := clSkyBlue;
    LabeledEdit14.Color := clSkyBlue;
    LabeledEdit17.Color := clSkyBlue;
    LabeledEdit18.Color := clSkyBlue;
    LabeledEdit19.Color := clSkyBlue;
  end
  else
  begin
    LabeledEdit11.Color := clWhite;
    LabeledEdit12.Color := clWhite;
    LabeledEdit14.Color := clWhite;
    LabeledEdit17.Color := clWhite;
    LabeledEdit18.Color := clWhite;
    LabeledEdit19.Color := clWhite;
    SpinEdit1.Value := 1;
  end;
end;

procedure TF_PrintBarcode.Button4Click(Sender: TObject);
var
  temp, temp1: string;
begin
  if LabeledEdit16.Tag = 0 then //获取初始数据
  begin
    LabeledEdit16.Text := SelectClientDataSetResultFieldCaption(ClientDataSet10, 'select tips from initinfo where id=2', 'Tips');
    if LabeledEdit16.Text = '' then
    begin
      LabeledEdit16.Text := 'OMNI CONNECTION INT''L';
      Button3.Click;
    end;
    LabeledEdit16.Tag := 1;
  end;
  if Application.FindComponent('F_SelectPrintInfo') = nil then
  begin
    Application.CreateForm(TF_SelectPrintInfo, F_SelectPrintInfo);
  end;
  F_SelectPrintInfo.ShowModal;
  if F_SelectPrintInfo.strPuResult1 <> '' then
  begin
    LabeledEdit11.Text := F_SelectPrintInfo.strPuResult1;
    LabeledEdit12.Text := F_SelectPrintInfo.strPuResult2;
    LabeledEdit18.Text := F_SelectPrintInfo.strPuResult3;
    LabeledEdit19.Text := F_SelectPrintInfo.strPuResult4;
    LabeledEdit13.Text := F_SelectPrintInfo.strPuResult5;
    LabeledEdit23.Text := F_SelectPrintInfo.strPuResult6;
    SpinEdit1.Value := F_SelectPrintInfo.iPuPrintCount;
    iTotalQuat := F_SelectPrintInfo.iPuQTY;
    temp1 := 'select sum(endprotquat) endprotquat from EndProtBarCode where ERPPDNO=''' + LabeledEdit12.Text +
      ''' and  state=''Y''';
    temp := SelectClientDataSetResultFieldCaption(ClientDataSet10, temp1, 'endprotquat');
    if temp = '' then temp := '0';
    iAlreadyQuat := StrToInt(temp);
  end;
end;

procedure TF_PrintBarcode.LabeledEdit10Enter(Sender: TObject);
begin
  if LabeledEdit17.Text = '' then
  begin
    LabeledEdit17.Text := GetSetSerialNo('成品');
  end;
end;

procedure TF_PrintBarcode.Button6Click(Sender: TObject);
begin
  frxReport2.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'frxReport4.fr3'); //uses  frxDesgn
  frxReport2.DesignReport();
end;

procedure TF_PrintBarcode.Button5Click(Sender: TObject);
begin
  frxReport3.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'frxReport5.fr3'); //uses  frxDesgn
  frxReport3.DesignReport();
end;

procedure TF_PrintBarcode.Button7Click(Sender: TObject);
begin
  if Application.FindComponent('F_SelectPrintSupply') = nil then
  begin
    Application.CreateForm(TF_SelectPrintSupply, F_SelectPrintSupply);
  end;
  F_SelectPrintSupply.ShowModal;
  if F_SelectPrintSupply.strPuResult1 <> '' then
  begin
    LabeledEdit201.Text := F_SelectPrintSupply.strPuResult1;
  end;
end;

procedure TF_PrintBarcode.LabeledEdit206Change(Sender: TObject);
begin
  psBarcode206.BarCode := LabeledEdit206.Text;
  Made2DCode;
end;

procedure TF_PrintBarcode.Timer4Timer(Sender: TObject);
var
  strsql: string;
begin
  Timer4.Enabled := false;
  if ZStrUserCode = 'admin' then
  begin
    RzPageControl1.ActivePageIndex := 3;
    RzPageControl1.Visible := True;
    Exit;
  end;
  strsql := 'select funccode from userpower where usercode=''' + ZStrUserCode + ''' and powertype=''PC'' and funccode like ''06010%''';
  SelectClientDataSetNoTips(ClientDataSet10, strsql);
  if ClientDataSet10.RecordCount = 0 then
  begin
    Label56.Visible := True;
    Label56.Align := alClient;
    RzPageControl1.Visible := false;
   // RzPageControl1.ActivePageIndex := 1;
  end
  else
  begin
    RzPageControl1.Visible := True;
   // RzPageControl1.ActivePageIndex := 0;
    if ClientDataSet10.Locate('funccode', '060101', []) then
    begin
      TabSheet1.TabVisible := True;
    end
    else
    begin
      TabSheet1.TabVisible := False;
    end;
    if ClientDataSet10.Locate('funccode', '060102', []) then
    begin
      TabSheet2.TabVisible := True;
    end
    else
    begin
      TabSheet2.TabVisible := False;
    end;
    if ClientDataSet10.Locate('funccode', '060103', []) then
    begin
      TabSheet3.TabVisible := True;
    end
    else
    begin
      TabSheet3.TabVisible := False;
    end;
    if ClientDataSet10.Locate('funccode', '060104', []) then
    begin
      TabSheet4.TabVisible := True;
    end
    else
    begin
      TabSheet4.TabVisible := False;
    end;
  end;
  if isAdmin = False then
  begin
    Button5.Visible := False;
    Button6.Visible := False;
  end;
end;

procedure TF_PrintBarcode.LabeledEdit203Enter(Sender: TObject);
begin
  if LabeledEdit204.Text = '' then
  begin
    LabeledEdit204.Text := GetSetSerialNo('原料');
  end;
end;

procedure TF_PrintBarcode.LabeledEdit16Exit(Sender: TObject);
begin
  if LabeledEdit16.Tag = 0 then //获取初始数据
  begin
    LabeledEdit16.Text := SelectClientDataSetResultFieldCaption(ClientDataSet10, 'select tips from initinfo where id=2', 'Tips');
    if LabeledEdit16.Text = '' then
    begin
      LabeledEdit16.Text := 'OMNI CONNECTION INT’L';
      Button3.Click;
    end;
    LabeledEdit16.Tag := 1;
  end;
end;

procedure TF_PrintBarcode.LabeledEdit16Enter(Sender: TObject);
begin
  if LabeledEdit16.Tag = 0 then //获取初始数据
  begin
    LabeledEdit16.Text := SelectClientDataSetResultFieldCaption(ClientDataSet10, 'select tips from initinfo where id=2', 'Tips');
    if LabeledEdit16.Text = '' then
    begin
      LabeledEdit16.Text := 'OMNI CONNECTION INT’L';
      Button3.Click;
    end;
    LabeledEdit16.Tag := 1;
  end;
end;

procedure TF_PrintBarcode.Label52Click(Sender: TObject);
begin
  Clipboard.AsText := psBarcode19.BarCode;
  zsbSimpleMSNPopUpShow('已复制到剪贴板');
end;

procedure TF_PrintBarcode.LabeledEdit13Enter(Sender: TObject);
begin
  if LabeledEdit17.Text = '' then
  begin
    LabeledEdit17.Text := GetSetSerialNo('成品');
  end;
end;

procedure TF_PrintBarcode.LabeledEdit15Change(Sender: TObject);
begin
  LabeledEdit15_1.Text := LabeledEdit15.Text;
end;

procedure TF_PrintBarcode.LabeledEdit20Change(Sender: TObject);
begin
  psBarcode20.BarCode := LabeledEdit20.Text;
end;

procedure TF_PrintBarcode.Timer5Timer(Sender: TObject);
begin
  //测试用
  LabeledEdit21.Text := IntToStr(iTotalQuat);
  LabeledEdit22.Text := IntToStr(iAlreadyQuat);
end;

procedure TF_PrintBarcode.LabeledEdit17Enter(Sender: TObject);
begin
  if LabeledEdit17.Text = '' then
  begin
    LabeledEdit17.Text := GetSetSerialNo('成品');
  end;
end;

procedure TF_PrintBarcode.LabeledEdit11Exit(Sender: TObject);
begin
  if LabeledEdit11.Text = '' then Exit;
  GetEndProtQuat(LabeledEdit11.Text);
end;

procedure TF_PrintBarcode.Button9Click(Sender: TObject);
var
  i, iCount: SmallInt;
  temp, exsql: string;
begin
  if CheckPrint = False then Exit;

  if (iAlreadyQuat >= iTotalQuat) and (CheckBox7.Checked=True) then
  begin
    temp := '请注意，打印超数，根据当前设置无法继续打印，请手动打印。' + #13 + #10 + #13 + #10;
    temp := temp + 'ERP 生产总数量【 ' + IntToStr(iTotalQuat) + ' 】,' + #13 + #10;
    temp := temp + '力真已打印数量【 ' + IntToStr(iAlreadyQuat) + ' 】';
    ZsbMsgErrorInfoNoApp(Self, temp);
    Exit;
  end;

  if CheckBox7.Checked=False then
  begin   
    temp := '当前是手动打印。';
  end;  
  temp := temp+'确认生成【 ' + inttostr(SpinEdit1.Value) + ' 】张成品标签么？';
  if ZsbMsgBoxOkNoApp(Self, temp) = False then Exit;

  exsql := '';
  iCount := 0;
  bPrintNext := True;
  for i := 1 to SpinEdit1.Value do //最后一张 检查尾数
  begin
    if PrintMoreOrNo then
    begin
      Break;
    end
    else
    begin
      if i=SpinEdit1.Value then
      begin
        FormatLastBarCode;
      end;
      exsql := exsql + GetSavePrintHistorySql;
      inc(iCount);
      if bPrintNext = False then
      begin
        Break;
      end;
    end;
  end;


  if exsql <> '' then
  begin
    if EXSQLClientDataSet(ClientDataSet10, exsql) then
    begin
      zsbSimpleMSNPopUpShow('生成标签【 ' + IntToStr(iCount) + ' 】张.');
      if iCount <> SpinEdit1.Value then //打印数量不符
      begin
        temp := '打印完成。打印数与生产数';
        if iAlreadyQuat <> iTotalQuat then
        begin
          temp := temp + '不';
        end;
        temp := temp + '相同.' + #13 + #10 + #13 + #10;

        temp := temp + '请注意,您看到此提示说明是由于打印超数造成实际打印的标签张数' +
          '与刚才预计生成张数不符,系统自动做出了处理.' + #13 + #10;
        temp := temp + '实际打印【 ' + IntToStr(icount) + ' 】张.' + #13 + #10;
        temp := temp + '预计打印【 ' + IntToStr(SpinEdit1.Value) + ' 】张.' + #13 + #10 + #13 + #10;
        temp := temp + '如有疑问请联系管理员.';
        AddLog_ErrorText(temp);
        ZsbMsgErrorInfoNoApp(Self, temp);
      end;
      Button11.Click;
    end
    else
    begin
      ZsbMsgErrorInfoNoApp(Self, '生成失败，请更正操作或者联系管理员.');
    end;
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '未知错误，请更正操作或者联系管理员.');
  end;
end;

procedure TF_PrintBarcode.Button10Click(Sender: TObject);
begin
  if Application.FindComponent('F_PrintCodeNew') = nil then
  begin
    Application.CreateForm(TF_PrintCodeNew, F_PrintCodeNew);
  end;
  F_PrintCodeNew.CheckBox3.Checked:=False;
  F_PrintCodeNew.show;
end;

procedure TF_PrintBarcode.LabeledEdit14Change(Sender: TObject);
begin
  LabeledEdit14_1.Text := LabeledEdit14.Text;
end;

procedure TF_PrintBarcode.Label62Click(Sender: TObject);
begin
  if LabeledEdit11.Text = '' then Exit;
  GetEndProtQuat(LabeledEdit11.Text);
end;

procedure TF_PrintBarcode.Button3Click(Sender: TObject);
var
  exsql, strsql, custname: string;
begin
  custname := StringReplace(LabeledEdit16.Text, '''', '''''', [rfReplaceAll]);
  strsql := 'select id from initinfo where id=2';
  if SelectClientDataSetResultCount(ClientDataSet10, strsql) = 0 then
  begin
    exsql := 'insert into(initinfo,id)values(''' + custname + ''',''2'')';
  end
  else
  begin
    exsql := 'update initinfo set tips=''' + custname + ''' where id=2';
  end;
  if EXSQLClientDataSet(ClientDataSet10, exsql) then
  begin
    zsbSimpleMSNPopUpShow('操作成功.');
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '操作失败,请联系管理员.');
    //操作失败的话可能要手动更改数据库字段的值
  end;
end;

procedure TF_PrintBarcode.Button11Click(Sender: TObject);
begin
  LabeledEdit10.Text := '0';
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
  LabeledEdit23.Text := '';
  SpinEdit1.Value := 0;
  iTotalQuat := 0;
  iAlreadyQuat := 0;
end;

procedure TF_PrintBarcode.Button12Click(Sender: TObject);
begin
  if Application.FindComponent('F_HandWork') = nil then
  begin
    Application.CreateForm(TF_HandWork, F_HandWork);
  end;
  F_HandWork.show;
end;

procedure TF_PrintBarcode.Image1DblClick(Sender: TObject);
begin
  ZsbShowMessageNoApp(Self,cReadMe);
end;

end.

