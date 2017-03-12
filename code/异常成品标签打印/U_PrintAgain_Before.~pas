unit U_PrintAgain_Before;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, DBClient, StdCtrls, Grids, DBGridEh, RzPanel,
  RzTabs, frxClass, StrUtils, frxBarcode, psBarcode, ComCtrls;

type
  TF_PrintAgain_Before = class(TForm)
    Image1: TImage;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPanel99: TRzPanel;
    RzPanel3: TRzPanel;
    ClientDataSet2: TClientDataSet;
    frxReport1: TfrxReport;
    psBarcode1: TpsBarcode;
    ClientDataSet12: TClientDataSet;
    RzPanel1: TRzPanel;
    Button2: TButton;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    DBGridEh1: TDBGridEh;
    RzPanel2: TRzPanel;
    DateTimePicker2: TDateTimePicker;
    DateTimePicker1: TDateTimePicker;
    Label7: TLabel;
    Label8: TLabel;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Button1: TButton;
    CheckBox2: TCheckBox;
    RzPanel4: TRzPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RzPanel5: TRzPanel;
    Memo1: TMemo;
    RzPanel6: TRzPanel;
    ComboBox2: TComboBox;
    Label9: TLabel;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    ClientDataSet11: TClientDataSet;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure CheckBox2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure Memo1Enter(Sender: TObject);
    procedure Memo1Exit(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure LabeledEdit10Change(Sender: TObject);
  private
    PrEndProtLot: string;
    procedure CreateParams(var Params: TCreateParams); override;
    function PrintLabel: SmallInt;
    function SavePrintHistory: Boolean;
    procedure AddCombobox2;
    { Private declarations }
  public
    { Public declarations }
  end;

const
  cReadMe = '异常标签重打-入库前,功能说明:' +
    //#13 + #10 + '新旧标签的区别：批次不一样，且是针对入库前的标签.' +
  #13 + #10 + #13 + #10 + '2014年5月21日 15:11:17 郑少宝';

var
  F_PrintAgain_Before: TF_PrintAgain_Before;

implementation

uses ZsbFunPro2, ZsbDLL2, ZsbVariable2;

{$R *.dfm}

procedure TF_PrintAgain_Before.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_PrintAgain_Before.AddCombobox2;
var
  strsql: string;
begin
  strsql := 'select distinct pName from EndProtBarCode where pName<>''''';
  SelectClientDataSet(ClientDataSet12, strsql);
  with ClientDataSet12 do
  begin
    First;
    ComboBox2.Items.Clear;
    ComboBox2.Items.Add('');
    while not eof do
    begin
      ComboBox2.Items.Add(FieldByName('pName').AsString);
      Next;
    end;
  end;
  ComboBox2.ItemIndex := ComboBox2.Items.IndexOf(ZStrUser);
end;

function TF_PrintAgain_Before.SavePrintHistory: Boolean;
var
  custname, exsql, strMessage: string;
begin
  custname := StringReplace(ClientDataSet11.FieldByName('CustName').AsString, '''', '''''', [rfReplaceAll]); //一个引号替换成两个就可以了
  PrEndProtLot := GetSetSerialNo('成品'); //获得下一个批次
  exsql := 'insert into EndProtBarCode(EndProtCode,EndProtQuat,CustCode,EndProtVer,EndProtLot,' +
    'OrderNo,Tips,OpeeDT,ShippingD,DEP,ShefCode,CustName,ERPPDNO,ML_NO,CUSTOMNO,uName,cn,alreadyprint,pdt,pName,iSecond)values(''' + ClientDataSet11.FieldByName('EndProtCode').AsString +
    ''',''' + LabeledEdit10.Text + ''',''' + ClientDataSet11.FieldByName('CustCode').AsString +
    ''',''' + LabeledEdit8.Text + ''',''' + PrEndProtLot +
    ''',''' + ClientDataSet11.FieldByName('OrderNo').AsString + ''',''' + ClientDataSet11.FieldByName('Tips').AsString +
    ''',''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) + ''',''' + LabeledEdit7.Text +
    ''',''' + ClientDataSet11.FieldByName('DEP').AsString + ''',''' + ClientDataSet11.FieldByName('ShefCode').AsString +
    ''',''' + custname + ''',''' + ClientDataSet11.FieldByName('ERPPDNO').AsString + ''',''' + ClientDataSet11.FieldByName('ML_NO').AsString +
    ''',''' + LabeledEdit9.Text + ''',''' + ZStrUser +
    ''',''' + ClientDataSet11.FieldByName('cn').AsString + ''',''1'',''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) +
    ''',''' + ZStrUser + ''',''1'');';

  exsql := exsql + 'update EndProtBarCode set iTime=iTime+1 where id=''' + ClientDataSet11.FieldByName('id').AsString + '''';
  ClientDataSet11.Edit;
  ClientDataSet11.FieldByName('iTime').Value := ClientDataSet1.FieldByName('iTime').Value + 1;
  ClientDataSet11.Post;

  strMessage := '入库前标签重打，原批号：' + ClientDataSet11.FieldByName('EndProtLot').AsString + '.标签新批号：' + PrEndProtLot;
  if LabeledEdit7.Text <> ClientDataSet11.FieldByName('ShippingD').AsString then
  begin
    strMessage := strMessage + ',装柜日期被更改';
  end;
  if LabeledEdit8.Text <> ClientDataSet11.FieldByName('EndProtVer').AsString then
  begin
    strMessage := strMessage + ',版次被更改';
  end;
  if LabeledEdit9.Text <> ClientDataSet11.FieldByName('CUSTOMNO').AsString then
  begin
    strMessage := strMessage + ',报关品番被更改';
  end;
  if LabeledEdit10.Text <> ClientDataSet11.FieldByName('EndProtQuat').AsString then
  begin
    strMessage := strMessage + ',包装数量被更改';
  end;
  AddLog_Operation(strMessage);

  Result := EXSQLClientDataSet(ClientDataSet12, exsql);
end;

function TF_PrintAgain_Before.PrintLabel: SmallInt;
var
  temp, reportFilePath, pinfang, dc: string;
  iRt, iNo: SmallInt;
  bmp: TBitmap;
begin
  try
    iRt := 0;
    dc := ClientDataSet11.FieldByName('ERPPDNO').AsString + ',' + ClientDataSet11.FieldByName('EndProtCode').AsString +
      ',' + LabeledEdit10.Text + ',' + PrEndProtLot +
      ',' + ClientDataSet11.FieldByName('dep').AsString + ',' + ClientDataSet11.FieldByName('shefcode').AsString;
    psBarcode1.BarCode := dc;

    reportFilePath := ExtractFilePath(ParamStr(0)) + 'frxReport5.fr3';
    frxReport1.Clear;
    frxReport1.LoadFromFile(reportFilePath);
    pinfang := ClientDataSet11.FieldByName('EndProtCode').AsString;
    pinfang := RightStr(pinfang, Length(pinfang) - 2); //去掉PW -2014年3月3日 15:21:39
    iNo := Pos('(', pinfang); //去掉括号 -2014年5月15日 16:12:55
    if iNo > 0 then
    begin
      pinfang := LeftStr(pinfang, iNo - 1);
    end;

    TfrxMemoView(frxReport1.FindObject('Memo1')).Text := ClientDataSet11.FieldByName('CustName').AsString;
    TfrxMemoView(frxReport1.FindObject('Memo2')).Text := LabeledEdit7.Text;
    TfrxMemoView(frxReport1.FindObject('Memo3')).Text := LabeledEdit9.Text;
    TfrxMemoView(frxReport1.FindObject('Memo4')).Text := ClientDataSet11.FieldByName('cn').AsString;
    TfrxMemoView(frxReport1.FindObject('memo5')).Memo.Text := LabeledEdit10.Text + 'PCS';
    TfrxMemoView(frxReport1.FindObject('memo14')).Memo.Text := pinfang;
    TfrxMemoView(frxReport1.FindObject('memo15')).Memo.Text := ClientDataSet11.FieldByName('ERPPDNO').AsString;
    TfrxMemoView(frxReport1.FindObject('memo16')).Memo.Text := LabeledEdit8.Text;

    TfrxBarCodeView(frxReport1.FindObject('BarCode1')).Text := pinfang;
    TfrxBarCodeView(frxReport1.FindObject('BarCode2')).Text := LabeledEdit10.Text;
    TfrxBarCodeView(frxReport1.FindObject('BarCode3')).Text := ClientDataSet11.FieldByName('ERPPDNO').AsString;
    TfrxBarCodeView(frxReport1.FindObject('BarCode4')).Text := LabeledEdit8.Text;

    bmp := TBitmap.Create;
    bmp.Width := psBarcode1.Width;
    bmp.Height := psBarcode1.Height;
    psBarcode1.PaintBarCode(bmp.Canvas, Rect(0, 0, bmp.Width, bmp.Height));
    TfrxPictureView(frxReport1.FindObject('picture1')).Picture.Assign(bmp);
    bmp.Free;

    frxReport1.PrepareReport;
    frxReport1.PrintOptions.ShowDialog := False; //不显示打印机选择框
    frxReport1.Print; //打印
    zsbSimpleMSNPopUpShow('打印完成.');
  except
    on e: Exception do
    begin
      temp := '在 TF_PrintAgain.PrintLabel 操作异常,请联系管理员.错误代码:' + e.Message;
      AddLog_ErrorText(temp);
      ZsbMsgErrorInfoNoApp(Self, e.Message);
      iRt := 1;
    end;
  end;
  Result := iRt;
end;


procedure TF_PrintAgain_Before.Timer1Timer(Sender: TObject);
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
  DateTimePicker1.Date := StrToDate(FormatDateTime('yyyy-mm-dd', Now() - 1));
  DateTimePicker2.Date := StrToDate(FormatDateTime('yyyy-mm-dd', Now));
  AddCombobox2;
  DBGridEhWidth(DBGridEh1, 'get', 'F_PrintAgain_Before_DBGridEh1.zsb');
end;

procedure TF_PrintAgain_Before.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
end;

procedure TF_PrintAgain_Before.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DBGridEhWidth(DBGridEh1, 'save', 'F_PrintAgain_Before_DBGridEh1.zsb');
  Action := caFree;
end;

procedure TF_PrintAgain_Before.Button1Click(Sender: TObject);
var
  strsql, temp1, temp2: string;
begin
  strsql := 'select * from EndProtBarCode where alreadyprint=''1'' and (InNo='''' or InNo is null)';

  temp1 := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date) + ' 00:00:00';
  temp2 := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date) + ' 23:59:59';

  strsql := strsql + ' and PDT>= ''' + temp1 + ''' and PDT<=''' + temp2 + '''';

  if LabeledEdit1.Text <> '' then
  begin
    strsql := strsql + ' and ERPPDNO like ''%' + LabeledEdit1.Text + '%''';
  end;
  if LabeledEdit2.Text <> '' then
  begin
    strsql := strsql + ' and EndProtCode like ''%' + LabeledEdit2.Text + '%''';
  end;
  if LabeledEdit5.Text <> '' then
  begin
    strsql := strsql + ' and ShippingD like ''%' + LabeledEdit5.Text + '%''';
  end;
  if LabeledEdit6.Text <> '' then
  begin
    strsql := strsql + ' and EndProtLot like ''%' + LabeledEdit6.Text + '%''';
  end;
  if ComboBox2.ItemIndex > 0 then
  begin
    strsql := strsql + ' and pName=''' + ComboBox2.Text + '''';
  end;
  strsql := strsql + ' and state=''N''';
  strsql := strsql + ' order by id desc';

  SelectClientDataSet(ClientDataSet1, strsql);
  LabeledEdit7.Text := '';
  LabeledEdit8.Text := '';
  LabeledEdit9.Text := '';
  LabeledEdit10.Text := '';
end;

procedure TF_PrintAgain_Before.Button2Click(Sender: TObject);
var
  reportFilePath, temp: string;
begin
  if ClientDataSet1.Data = null then Exit;
  if ClientDataSet1.RecordCount = 0 then Exit;
  if (LabeledEdit7.Text = '') or (LabeledEdit8.Text = '') or (LabeledEdit9.Text = '') or (LabeledEdit10.Text = '') then
  begin
    zsbSimpleMSNPopUpShow('信息不完整.');
    Exit;
  end;

  ClientDataSet11.Data := ClientDataSet1.Data;
  ClientDataSet11.Filter := 'isselect=''1''';
  ClientDataSet11.Filtered := True;
  if ClientDataSet11.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可选择操作的记录.');
    Exit;
  end;


  reportFilePath := ExtractFilePath(ParamStr(0)) + 'frxReport5.fr3';
  if not FileExists(reportFilePath) then
  begin
    ZsbMsgErrorInfoNoApp(Self, '对不起,标签模版不存在,请联系管理员！');
    Exit;
  end;
 { if ClientDataSet1.FieldByName('iTime').AsInteger >= 2 then
  begin
    ZsbMsgErrorInfoNoApp(Self, '此标签已经打印过一次了，无法再打印.');
    Exit;
  end;
  temp := '确认重新打印标签么?' + #13 + #10;
  temp := temp + '制令单：' + ClientDataSet1.FieldByName('ERPPDNO').AsString + #13 + #10;
  temp := temp + '品番：' + ClientDataSet1.FieldByName('EndProtCode').AsString + #13 + #10;
  temp := temp + '重新新生成批次.';  }

  temp := '确认重新打印所选的' + IntToStr(ClientDataSet11.RecordCount) + '张标签么?';

  if ZsbMsgBoxOkNoApp(Self, temp) = False then Exit;
  DBGridEh1.Enabled := False;

  with ClientDataSet11 do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('iTime').AsInteger >= 2 then
      begin
        ZsbMsgErrorInfoNoApp(Self, '批号:【'+FieldByName('EndProtLot').AsString+'】此标签已经打印过一次了，无法再打印.');
      end
      else
      begin
        if SavePrintHistory then
        begin
          PrintLabel;
        end
        else
        begin
          ZsbMsgErrorInfoNoApp(Self, '重新打印失败,可能是因为记录失败.请稍后重试或者联系管理员.');
        end;
      end;
      Next;
    end;
  end;
  DBGridEh1.Enabled := True;
  if RadioButton2.Checked then
  begin
    Button1.Click;
  end;
end;

procedure TF_PrintAgain_Before.Image1DblClick(Sender: TObject);
begin
  ZsbShowMessageNoApp(Self, cReadMe);
end;

procedure TF_PrintAgain_Before.DBGridEh1CellClick(Column: TColumnEh);
begin
  if ClientDataSet1.Data = null then Exit;
  if ClientDataSet1.RecordCount = 0 then Exit;
  LabeledEdit7.Text := ClientDataSet1.FieldByName('ShippingD').AsString;
  LabeledEdit8.Text := ClientDataSet1.FieldByName('EndProtVer').AsString;
  LabeledEdit9.Text := ClientDataSet1.FieldByName('CUSTOMNO').AsString;
  LabeledEdit10.Text := ClientDataSet1.FieldByName('EndProtQuat').AsString;
end;

procedure TF_PrintAgain_Before.CheckBox2Click(Sender: TObject);
begin
  LabeledEdit7.Enabled := CheckBox2.Checked;
  LabeledEdit8.Enabled := CheckBox2.Checked;
  LabeledEdit9.Enabled := CheckBox2.Checked;
  LabeledEdit10.Enabled := CheckBox2.Checked;
end;

procedure TF_PrintAgain_Before.RadioButton1Click(Sender: TObject);
begin
  RzPanel5.Visible := RadioButton1.Checked;
  RzPanel2.Visible := not RadioButton1.Checked;
  if RadioButton1.Checked then
  begin
    RadioButton1.Font.Style := [fsBold];
    RadioButton2.Font.Style := [];
  end
  else
  begin
    RadioButton1.Font.Style := [];
    RadioButton2.Font.Style := [fsBold];
  end;
end;

procedure TF_PrintAgain_Before.Memo1KeyPress(Sender: TObject;
  var Key: Char);
var
  TSList: TStringList;
  strsql: string;
begin
  if Key = #13 then
  begin
    TSList := Split2DCode(Memo1.Lines.Text);
    if TSList.Count <> 6 then
    begin
      zsbSimpleMSNPopUpShow('条码解析错误.');
      Memo1.Lines.Text := '';
      Exit;
    end;
    strsql := 'select * from EndProtBarCode where EndProtLot=''' + TSList[3] + ''' and state=''N''';
    if ComboBox2.ItemIndex > 0 then
    begin
      strsql := strsql + ' and pName=''' + ComboBox2.Text + '''';
    end;
    SelectClientDataSet(ClientDataSet1, strsql);
    if ClientDataSet1.RecordCount = 0 then
    begin
      zsbSimpleMSNPopUpShow_2('没有记录，可能是原标签没有作废.', clRed);
    end;
  end;
end;

procedure TF_PrintAgain_Before.Memo1Enter(Sender: TObject);
begin
  Memo1.Lines.Text := '';
  Memo1.Font.Color := clBlack;
end;

procedure TF_PrintAgain_Before.Memo1Exit(Sender: TObject);
begin
  if Memo1.Lines.Text <> '' then Exit;
  Memo1.Lines.Text := '请在此扫描二维码';
  Memo1.Font.Color := clSilver;
end;

procedure TF_PrintAgain_Before.CheckBox1Click(Sender: TObject);
var
  b: Boolean;
begin
  b := CheckBox1.Checked;
  DBGridEh1.Columns[11].Visible := b;
  DBGridEh1.Columns[12].Visible := b;
  DBGridEh1.Columns[13].Visible := b;
  DBGridEh1.Columns[14].Visible := b;
  DBGridEh1.Columns[15].Visible := b;
  DBGridEh1.Columns[16].Visible := b;
  DBGridEh1.Columns[17].Visible := b;
end;

procedure TF_PrintAgain_Before.LabeledEdit10Change(Sender: TObject);
begin
  if LabeledEdit10.Text = '' then Exit;
  if StrToInt(LabeledEdit10.Text) > ClientDataSet1.FieldByName('EndProtQuat').AsInteger then
  begin
    zsbSimpleMSNPopUpShow_2('数量不能超过包装数.', clRed, 300);
    LabeledEdit10.Text := ClientDataSet1.FieldByName('EndProtQuat').AsString;
  end;
end;

end.

