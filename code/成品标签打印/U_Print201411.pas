unit U_Print201411;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, DBClient, StdCtrls, Grids, DBGridEh, RzPanel,
  RzTabs, frxClass, StrUtils, frxBarcode, psBarcode, ComCtrls, Spin,
  RzLabel;

type
  TF_Print201411 = class(TForm)
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
    Button11: TButton;
    LabeledEdit1: TLabeledEdit;
    ClientDataSet3_1: TClientDataSet;
    ClientDataSet3_2: TClientDataSet;
    Label4: TLabel;
    SpinEdit1: TSpinEdit;
    Timer2: TTimer;
    ClientDataSet4_OtherDB: TClientDataSet;
    LabeledEdit21: TLabeledEdit;
    LabeledEdit22: TLabeledEdit;
    Timer3: TTimer;
    Label5: TLabel;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    psBarcode1: TpsBarcode;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1DblClick(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure LabeledEdit11Change(Sender: TObject);
    procedure LabeledEdit20Change(Sender: TObject);
    procedure LabeledEdit10Change(Sender: TObject);
    procedure LabeledEdit13Change(Sender: TObject);
    procedure LabeledEdit14Change(Sender: TObject);
    procedure LabeledEdit15Change(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure LabeledEdit12KeyPress(Sender: TObject; var Key: Char);
    procedure Timer2Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    iTotalQuat, iAlreadyQuat: Integer;
    TSListBarCode: TStringList;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SavePrintHistory;
    procedure GetEndProtQuat(strCode: string);
    procedure Made2DCode_2;
    procedure GetOtherInfo(MO_NO: string);
    procedure GetCONPANY;
    function PrintLabel(dt: string): SmallInt;
    { Private declarations }
  public
    { Public declarations }
  end;

const
  cReadMe = '成品标签打印,功能说明:' +
    #13 + #10 + '扫描发料单上的二维码进行打印标签.' +
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
    #13 + #10 + #13 + #10 + '2014年11月21日 13:37:36 郑少宝';

        {
        TSListBarCodeMX[0] = ERPPDNO
        TSListBarCodeMX[1] = EndProtCode
        TSListBarCodeMX[2] = EndProtQuat
        TSListBarCodeMX[3] = EndProtLot
        TSListBarCodeMX[4] = dep
        TSListBarCodeMX[5] = shefcode
        TSListBarCodeMX[6] = CustName
        TSListBarCodeMX[7] = ShippingD
        TSListBarCodeMX[8] = CUSTOMNO
        TSListBarCodeMX[9] = cn
        TSListBarCodeMX[10] = EndProtVer
        }

var
  F_Print201411: TF_Print201411;

implementation

uses ZsbFunPro2, ZsbDLL2, ZsbVariable2, U_PrintCodeNew, UDM;

{$R *.dfm} //LabeledEdit20

procedure TF_Print201411.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_Print201411.GetCONPANY;
begin
  LabeledEdit16.Text := SelectClientDataSetResultFieldCaption(ClientDataSet2, 'select tips from initinfo where id=2', 'Tips');
  label53.Caption:=LabeledEdit16.Text;
end;

procedure TF_Print201411.Made2DCode_2;
var
  BarCode2D: string;
begin
  BarCode2D := LabeledEdit12.Text + ',' + LabeledEdit11.Text + ',' + LabeledEdit10.Text +
    ',' + LabeledEdit17.Text + ',' + LabeledEdit18.Text + ',' + LabeledEdit19.Text;
  psBarcode19.BarCode := BarCode2D;
end;

procedure TF_Print201411.GetEndProtQuat(strCode: string);
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

procedure TF_Print201411.GetOtherInfo(MO_NO: string);
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

procedure TF_Print201411.SavePrintHistory;
var
  custname, temp8, exsql, temp, tnull, dc: string;
  i: SmallInt;
begin
  temp8 := FormatDateTime('yyyy-MM-dd HH:mm:ss', Now);
  tnull := '';
  custname := StringReplace(LabeledEdit16.Text, '''', '''''', [rfReplaceAll]); //一个引号替换成两个就可以了
  exsql := '';
  TSListBarCode.Clear;
  if LabeledEdit15.Text = '' then LabeledEdit15.Text := ' ';
  for i := 1 to SpinEdit1.Value do
  begin
    if iAlreadyQuat <> iTotalQuat then //判断打印数量是否足够
    begin
      if iAlreadyQuat + StrToInt(LabeledEdit10.Text) > iTotalQuat then
      begin
        LabeledEdit10.Text := IntToStr(iTotalQuat - iAlreadyQuat);
        iAlreadyQuat := iTotalQuat;
      end
      else
      begin
        iAlreadyQuat:=iAlreadyQuat+StrToInt(LabeledEdit10.Text);
      end;
    end
    else
    begin
      Break;
    end;

       {
        TSListBarCodeMX[0] = ERPPDNO
        TSListBarCodeMX[1] = EndProtCode
        TSListBarCodeMX[2] = EndProtQuat
        TSListBarCodeMX[3] = EndProtLot
        TSListBarCodeMX[4] = dep
        TSListBarCodeMX[5] = shefcode

        TSListBarCodeMX[6] = CustName
        TSListBarCodeMX[7] = ShippingD
        TSListBarCodeMX[8] = CUSTOMNO
        TSListBarCodeMX[9] = cn
        TSListBarCodeMX[10] = EndProtVer
         }
    dc := LabeledEdit12.Text + ',' + LabeledEdit11.Text + ',' + LabeledEdit10.Text + ',' +
      LabeledEdit17.Text + ',' + LabeledEdit18.Text + ',' + LabeledEdit19.Text + ',';

    dc := dc + LabeledEdit16.Text + ',' + LabeledEdit13.Text + ',' + LabeledEdit14.Text + ',' +
      LabeledEdit15.Text + ',' + LabeledEdit20.Text;

    TSListBarCode.Add(dc);

    exsql := exsql + 'insert into EndProtBarCode(EndProtCode,EndProtQuat,CustCode,EndProtVer,EndProtLot,' +
      'OrderNo,Tips,OpeeDT,ShippingD,DEP,ShefCode,CustName,ERPPDNO,ML_NO,CUSTOMNO,uName,cn,alreadyprint,pdt,pName)values(''' + LabeledEdit11.Text + ''',''' + LabeledEdit10.Text +
      ''',''' + tnull + ''',''' + LabeledEdit20.Text + ''',''' + LabeledEdit17.Text + ''',''' + tnull + ''',''' + tnull + ''',''' + temp8 +
      ''',''' + LabeledEdit13.Text + ''',''' + LabeledEdit18.Text + ''',''' + LabeledEdit19.Text +
      ''',''' + custname + ''',''' + LabeledEdit12.Text + ''',''' + LabeledEdit1.Text + ''',''' + LabeledEdit14.Text +
      ''',''' + ZStrUser + ''',''' + LabeledEdit15.Text + ''',''1'',''' + temp8 + ''',''' + ZStrUser + ''');';
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

      PrintLabel(temp8); //进行打印
    end;
  end
  else
  begin
    zsbSimpleMSNPopUpShow('标签已够，不允许生成标签.');
  end;
end;

function TF_Print201411.PrintLabel(dt: string): SmallInt;
var
  reportFilePath, pinfang, dc: string;
  iRt, iNo, i: SmallInt;
  bmp: TBitmap;
  TSListBarCodeMX:TStringList;
begin
  try
    iRt := 0;
    for i := 0 to TSListBarCode.Count - 1 do
    begin
      TSListBarCodeMX:=SplitString(TSListBarCode[i],',');
      dc := TSListBarCodeMX[0] + ',' + TSListBarCodeMX[1] + ',' + TSListBarCodeMX[2] +
        ',' + TSListBarCodeMX[3] + ',' + TSListBarCodeMX[4] + ',' + TSListBarCodeMX[5];

      dc:=dc+',EndPC'; //最后加一个标识  2014年11月28日 14:45:50
      
      psBarcode1.BarCode := dc;

      reportFilePath := ExtractFilePath(ParamStr(0)) + 'frxReport5.fr3';
      frxReport1.Clear;
      frxReport1.LoadFromFile(reportFilePath);
      pinfang := TSListBarCodeMX[1];
      pinfang := RightStr(pinfang, Length(pinfang) - 2); //去掉PW   -2014年3月3日 15:21:39
      iNo := Pos('(', pinfang); //去掉括号 -2014年5月15日 16:12:55
      if iNo > 0 then
      begin
        pinfang := LeftStr(pinfang, iNo - 1);
      end;

      TfrxMemoView(frxReport1.FindObject('Memo1')).Text := TSListBarCodeMX[6];
      TfrxMemoView(frxReport1.FindObject('Memo2')).Text := TSListBarCodeMX[7];
      TfrxMemoView(frxReport1.FindObject('Memo3')).Text := TSListBarCodeMX[8];
      TfrxMemoView(frxReport1.FindObject('Memo4')).Text := TSListBarCodeMX[9];
      TfrxMemoView(frxReport1.FindObject('memo5')).Memo.Text := TSListBarCodeMX[2] + 'PCS';
      TfrxMemoView(frxReport1.FindObject('memo14')).Memo.Text := pinfang;
      TfrxMemoView(frxReport1.FindObject('memo15')).Memo.Text := TSListBarCodeMX[0];
      TfrxMemoView(frxReport1.FindObject('memo16')).Memo.Text := TSListBarCodeMX[10];

      TfrxBarCodeView(frxReport1.FindObject('BarCode1')).Text := pinfang;
      TfrxBarCodeView(frxReport1.FindObject('BarCode2')).Text := TSListBarCodeMX[2];
      TfrxBarCodeView(frxReport1.FindObject('BarCode3')).Text := TSListBarCodeMX[0];
      TfrxBarCodeView(frxReport1.FindObject('BarCode4')).Text := TSListBarCodeMX[10];

      bmp := TBitmap.Create;
      bmp.Width := psBarcode1.Width;
      bmp.Height := psBarcode1.Height;
      psBarcode1.PaintBarCode(bmp.Canvas, Rect(0, 0, bmp.Width, bmp.Height));
      TfrxPictureView(frxReport1.FindObject('picture1')).Picture.Assign(bmp);
      bmp.Free;
      if CheckBox1.Checked then
      begin
        frxReport1.ShowReport();
      end
      else
      begin
        frxReport1.PrepareReport;
        frxReport1.PrintOptions.ShowDialog := False; //不显示打印机选择框
        frxReport1.Print; //打印
      end;
    end;
    Button11.Click;//清空
  except
    on e: Exception do
    begin
      ZsbMsgErrorInfoNoApp(Self, e.Message);
      //如果打印失败就删除原来的记录
      EXSQLClientDataSet(ClientDataSet12, 'delete from EndProtBarCode where pdt=''' + dt + ''' and pName=''' + ZStrUser + '''');
      iRt := 1;
    end;
  end;
  Result := iRt;
end;

procedure TF_Print201411.Timer1Timer(Sender: TObject);
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
  TSListBarCode := TStringList.Create;
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
    GetCONPANY;
    LabeledEdit13.Text := GetDateTimeDate;
  finally

  end;
end;

procedure TF_Print201411.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
  iTotalQuat := 0;
  iAlreadyQuat := 0;
end;

procedure TF_Print201411.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TF_Print201411.Image1DblClick(Sender: TObject);
begin
  ZsbShowMessageNoApp(Self, cReadMe);
end;

procedure TF_Print201411.Button9Click(Sender: TObject);
var
  temp: string;
begin
  zsbSimpleMSNPopUpShow('暂不支持');
  Exit;
  if LabeledEdit11.Text = '' then
  begin
    ShowInfoTips(LabeledEdit12.Handle, '请扫描发料单上的二维码.', 3);
    LabeledEdit12.SetFocus;
    Exit;
  end;
  if LabeledEdit14.Text = '' then
  begin
    ShowInfoTips(LabeledEdit14.Handle, '没有报关品番,无法继续打印,请联系管理员.', 3);
    LabeledEdit14.SetFocus;
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
  if iTotalQuat <=0 then
  begin
    ZsbMsgErrorInfoNoApp(Self,'没有监测到有打印数据');
    Exit;
  end;  
  if iAlreadyQuat >= iTotalQuat then
  begin
    ZsbMsgErrorInfoNoApp(Self,'标签打印的数量已经足够，不允许再生成标签.');
    Exit;
  end;

  temp := '确认生成【 ' + IntToStr(SpinEdit1.Value) + ' 】张标签么?' + #13 + #10 + #13 + #10;
  temp := temp + '制令单【 ' + LabeledEdit12.Text + ' 】.' + #13 + #10 + #13 + #10;
  temp := temp + '品番【 ' + LabeledEdit11.Text + ' 】.' + #13 + #10+ #13 + #10+ #13 + #10+ #13 + #10;
  temp := temp + '注意：系统会根据打印记录自动调整打印的张数,以及最后的包装数量.' + #13 + #10;
  if ZsbMsgBoxOkNoApp(Self, temp) = False then Exit;

  SavePrintHistory;
end;

procedure TF_Print201411.LabeledEdit11Change(Sender: TObject);
begin
  if LabeledEdit11.Text = '' then Exit;
  GetEndProtQuat(LabeledEdit11.Text);
  psBarcode16.BarCode := LabeledEdit11.Text;
end;

procedure TF_Print201411.LabeledEdit20Change(Sender: TObject);
begin
  psBarcode20.BarCode := LabeledEdit20.Text;
end;

procedure TF_Print201411.LabeledEdit10Change(Sender: TObject);
begin
  psBarcode17.BarCode := LabeledEdit10.Text;
  Made2DCode_2;
end;

procedure TF_Print201411.LabeledEdit13Change(Sender: TObject);
begin
  LabeledEdit13_1.Text := LabeledEdit13.Text;
end;

procedure TF_Print201411.LabeledEdit14Change(Sender: TObject);
begin
  LabeledEdit14_1.Text := LabeledEdit14.Text;
end;

procedure TF_Print201411.LabeledEdit15Change(Sender: TObject);
begin
  LabeledEdit15_1.Text := LabeledEdit15.Text;
end;

procedure TF_Print201411.Button11Click(Sender: TObject);
begin
  LabeledEdit10.Text := '0';
  LabeledEdit1.Text := '';
  LabeledEdit11.Text := '';
  LabeledEdit12.Text := ' ';
  LabeledEdit14.Text := '';
  LabeledEdit15.Text := '';
  LabeledEdit17.Text := '';
  LabeledEdit18.Text := '';
  LabeledEdit19.Text := '';
  LabeledEdit19.Text := ' ';
  LabeledEdit20.Text := ' ';
  psBarcode16.BarCode := ' ';
  SpinEdit1.Value := 1;
  iTotalQuat := 0;
  iAlreadyQuat := 0;
end;

procedure TF_Print201411.LabeledEdit12KeyPress(Sender: TObject;
  var Key: Char);
var
  TSList: TStringList;
begin
  if Key = #13 then
  begin
    if LeftStr(LabeledEdit12.Text, 2) = 'ML' then
    begin
      TSList := SplitString(LabeledEdit12.Text, ',');
      if LeftStr(TSList[1], 2) = 'MO' then
      begin
        LabeledEdit1.Text := TSList[0];
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
    if LabeledEdit17.Text = '' then
    begin
      LabeledEdit17.Text := GetSetSerialNo('成品');
    end;
    psBarcode18.BarCode := LabeledEdit12.Text;
    Made2DCode_2;
  end;
end;

procedure TF_Print201411.Timer2Timer(Sender: TObject);
begin
  //测试用
  LabeledEdit21.Text := IntToStr(iTotalQuat);
  LabeledEdit22.Text := IntToStr(iAlreadyQuat);
end;

procedure TF_Print201411.FormDestroy(Sender: TObject);
begin
  TSListBarCode.Free;
end;

end.

