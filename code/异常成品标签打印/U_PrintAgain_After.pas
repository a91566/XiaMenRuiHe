unit U_PrintAgain_After;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, DBClient, StdCtrls, Grids, DBGridEh, RzPanel,
  RzTabs, frxClass, StrUtils, frxBarcode, psBarcode, ComCtrls;

type
  TF_PrintAgain_After = class(TForm)
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
    CheckBox1: TCheckBox;
    DBGridEh1: TDBGridEh;
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
    PrEndProtLotA, PrEndProtLotB: string;
    procedure CreateParams(var Params: TCreateParams); override;
    function PrintLabel: SmallInt;
    function PrintLabelTwo: SmallInt;
    function SavePrintHistory: Boolean;
    procedure AddCombobox2;
    { Private declarations }
  public
    { Public declarations }
  end;

const
  cReadMe = '�쳣��ǩ�ش�-����,����˵��:' +
    #13 + #10 + '�¾ɱ�ǩ���������β���һ������֮ǰ��������201405230001�����µı�ǩ���ž���' +
    '201405230001A , 201405230001B,�������ɶ��ٸ�Ҫ����������İ�װ��.' +
    #13 + #10 + #13 + #10 + '2014��5��21�� 15:11:17 ֣�ٱ�';

var
  F_PrintAgain_After: TF_PrintAgain_After;

implementation

uses ZsbFunPro2, ZsbDLL2, ZsbVariable2;

{$R *.dfm}

procedure TF_PrintAgain_After.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //���� ��ʾ��������
end;

procedure TF_PrintAgain_After.AddCombobox2;
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

function TF_PrintAgain_After.SavePrintHistory: Boolean;
var
  custname, exsql,strMessage: string;
begin
  custname := StringReplace(ClientDataSet1.FieldByName('CustName').AsString, '''', '''''', [rfReplaceAll]); //һ�������滻�������Ϳ�����

  exsql := 'insert into EndProtBarCode(EndProtCode,EndProtQuat,CustCode,EndProtVer,EndProtLot,' +
    'OrderNo,Tips,OpeeDT,ShippingD,DEP,ShefCode,CustName,ERPPDNO,ML_NO,CUSTOMNO,uName,cn,' +
    'alreadyprint,pdt,pName,iSecond,InNo,OutNo)values(''' + ClientDataSet1.FieldByName('EndProtCode').AsString +
    ''',''' + LabeledEdit10.Text + ''',''' + ClientDataSet1.FieldByName('CustCode').AsString +
    ''',''' + LabeledEdit8.Text + ''',''' + PrEndProtLotA +
    ''',''' + ClientDataSet1.FieldByName('OrderNo').AsString + ''',''' + ClientDataSet1.FieldByName('Tips').AsString +
    ''',''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) + ''',''' + LabeledEdit7.Text +
    ''',''' + ClientDataSet1.FieldByName('DEP').AsString + ''',''' + ClientDataSet1.FieldByName('ShefCode').AsString +
    ''',''' + custname + ''',''' + ClientDataSet1.FieldByName('ERPPDNO').AsString + ''',''' + ClientDataSet1.FieldByName('ML_NO').AsString +
    ''',''' + LabeledEdit9.Text + ''',''' + ZStrUser +
    ''',''' + ClientDataSet1.FieldByName('cn').AsString + ''',''1'',''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) +
    ''',''' + ZStrUser + ''',''1'',''' + ClientDataSet1.FieldByName('InNo').AsString +
    ''',''' + ClientDataSet1.FieldByName('OutNo').AsString + ''');';

  strMessage:='�����ǩ�ش�ԭ���ţ�' + ClientDataSet1.FieldByName('EndProtLot').AsString + '.��ǩ�����ţ�' + PrEndProtLotA;

  if LabeledEdit10.Tag <> 0 then
  begin
    exsql := exsql + 'insert into EndProtBarCode(EndProtCode,EndProtQuat,CustCode,EndProtVer,EndProtLot,' +
      'OrderNo,Tips,OpeeDT,ShippingD,DEP,ShefCode,CustName,ERPPDNO,ML_NO,CUSTOMNO,uName,cn,' +
      'alreadyprint,pdt,pName,iSecond,InNo,OutNo)values(''' + ClientDataSet1.FieldByName('EndProtCode').AsString +
      ''',''' + IntToStr(LabeledEdit10.Tag) + ''',''' + ClientDataSet1.FieldByName('CustCode').AsString +
      ''',''' + LabeledEdit8.Text + ''',''' + PrEndProtLotB +
      ''',''' + ClientDataSet1.FieldByName('OrderNo').AsString + ''',''' + ClientDataSet1.FieldByName('Tips').AsString +
      ''',''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) + ''',''' + LabeledEdit7.Text +
      ''',''' + ClientDataSet1.FieldByName('DEP').AsString + ''',''' + ClientDataSet1.FieldByName('ShefCode').AsString +
      ''',''' + custname + ''',''' + ClientDataSet1.FieldByName('ERPPDNO').AsString + ''',''' + ClientDataSet1.FieldByName('ML_NO').AsString +
      ''',''' + LabeledEdit9.Text + ''',''' + ZStrUser +
      ''',''' + ClientDataSet1.FieldByName('cn').AsString + ''',''1'',''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) +
      ''',''' + ZStrUser + ''',''1'',''' + ClientDataSet1.FieldByName('InNo').AsString +
      ''',''' + ClientDataSet1.FieldByName('OutNo').AsString + ''');';
    strMessage:=strMessage+'/'+PrEndProtLotB;
  end;

  exsql := exsql + 'update EndProtBarCode set iTime=iTime+1 where id=''' + ClientDataSet1.FieldByName('id').AsString + '''';
  ClientDataSet1.Edit;
  ClientDataSet1.FieldByName('iTime').Value := ClientDataSet1.FieldByName('iTime').Value + 1;
  ClientDataSet1.Post;


  if LabeledEdit7.Text<>ClientDataSet1.FieldByName('ShippingD').AsString then
  begin
    strMessage:=strMessage+',װ�����ڱ�����';
  end;
  if LabeledEdit8.Text<>ClientDataSet1.FieldByName('EndProtVer').AsString then
  begin
    strMessage:=strMessage+',��α�����';
  end;
  if LabeledEdit9.Text<>ClientDataSet1.FieldByName('CUSTOMNO').AsString then
  begin
    strMessage:=strMessage+',����Ʒ��������';
  end;
  if LabeledEdit10.Text<>ClientDataSet1.FieldByName('EndProtQuat').AsString then
  begin
    strMessage:=strMessage+',��װ����������';
  end;
  AddLog_Operation(strMessage);

  Result := EXSQLClientDataSet(ClientDataSet12, exsql);
end;

function TF_PrintAgain_After.PrintLabel: SmallInt;
var
  temp, reportFilePath, pinfang, dc: string;
  iRt, iNo: SmallInt;
  bmp: TBitmap;
begin
  try
    iRt := 0;
    dc := ClientDataSet1.FieldByName('ERPPDNO').AsString + ',' + ClientDataSet1.FieldByName('EndProtCode').AsString +
      ',' + LabeledEdit10.Text + ',' + PrEndProtLotA +
      ',' + ClientDataSet1.FieldByName('dep').AsString + ',' + ClientDataSet1.FieldByName('shefcode').AsString;
    psBarcode1.BarCode := dc;

    reportFilePath := ExtractFilePath(ParamStr(0)) + 'frxReport5.fr3';
    frxReport1.Clear;
    frxReport1.LoadFromFile(reportFilePath);
    pinfang := ClientDataSet1.FieldByName('EndProtCode').AsString;
    pinfang := RightStr(pinfang, Length(pinfang) - 2); //ȥ��PW -2014��3��3�� 15:21:39
    iNo := Pos('(', pinfang); //ȥ������ -2014��5��15�� 16:12:55
    if iNo > 0 then
    begin
      pinfang := LeftStr(pinfang, iNo - 1);
    end;

    TfrxMemoView(frxReport1.FindObject('Memo1')).Text := ClientDataSet1.FieldByName('CustName').AsString;
    TfrxMemoView(frxReport1.FindObject('Memo2')).Text := LabeledEdit7.Text;
    TfrxMemoView(frxReport1.FindObject('Memo3')).Text := LabeledEdit9.Text;
    TfrxMemoView(frxReport1.FindObject('Memo4')).Text := ClientDataSet1.FieldByName('cn').AsString;
    TfrxMemoView(frxReport1.FindObject('memo5')).Memo.Text := LabeledEdit10.Text + 'PCS';
    TfrxMemoView(frxReport1.FindObject('memo14')).Memo.Text := pinfang;
    TfrxMemoView(frxReport1.FindObject('memo15')).Memo.Text := ClientDataSet1.FieldByName('ERPPDNO').AsString;
    TfrxMemoView(frxReport1.FindObject('memo16')).Memo.Text := LabeledEdit8.Text;

    TfrxBarCodeView(frxReport1.FindObject('BarCode1')).Text := pinfang;
    TfrxBarCodeView(frxReport1.FindObject('BarCode2')).Text := LabeledEdit10.Text;
    TfrxBarCodeView(frxReport1.FindObject('BarCode3')).Text := ClientDataSet1.FieldByName('ERPPDNO').AsString;
    TfrxBarCodeView(frxReport1.FindObject('BarCode4')).Text := LabeledEdit8.Text;

    bmp := TBitmap.Create;
    bmp.Width := psBarcode1.Width;
    bmp.Height := psBarcode1.Height;
    psBarcode1.PaintBarCode(bmp.Canvas, Rect(0, 0, bmp.Width, bmp.Height));
    TfrxPictureView(frxReport1.FindObject('picture1')).Picture.Assign(bmp);
    bmp.Free;

    frxReport1.PrepareReport;
    frxReport1.PrintOptions.ShowDialog := False; //����ʾ��ӡ��ѡ���
    frxReport1.Print; //��ӡ
  except
    on e: Exception do
    begin
      temp := '�� TF_PrintAgain.PrintLabel �����쳣,����ϵ����Ա.�������:' + e.Message;
      AddLog_ErrorText(temp);
      ZsbMsgErrorInfoNoApp(Self, e.Message);
      iRt := 1;
    end;
  end;
  Result := iRt;
end;

function TF_PrintAgain_After.PrintLabelTwo: SmallInt;
var
  temp, reportFilePath, pinfang, dc: string;
  iRt, iNo: SmallInt;
  bmp: TBitmap;
begin
  try
    iRt := 0;
    dc := ClientDataSet1.FieldByName('ERPPDNO').AsString + ',' + ClientDataSet1.FieldByName('EndProtCode').AsString +
      ',' + IntToStr(LabeledEdit10.Tag) + ',' + PrEndProtLotB +
      ',' + ClientDataSet1.FieldByName('dep').AsString + ',' + ClientDataSet1.FieldByName('shefcode').AsString;
    psBarcode1.BarCode := dc;

    reportFilePath := ExtractFilePath(ParamStr(0)) + 'frxReport5.fr3';
    frxReport1.Clear;
    frxReport1.LoadFromFile(reportFilePath);
    pinfang := ClientDataSet1.FieldByName('EndProtCode').AsString;
    pinfang := RightStr(pinfang, Length(pinfang) - 2); //ȥ��PW -2014��3��3�� 15:21:39
    iNo := Pos('(', pinfang); //ȥ������ -2014��5��15�� 16:12:55
    if iNo > 0 then
    begin
      pinfang := LeftStr(pinfang, iNo - 1);
    end;

    TfrxMemoView(frxReport1.FindObject('Memo1')).Text := ClientDataSet1.FieldByName('CustName').AsString;
    TfrxMemoView(frxReport1.FindObject('Memo2')).Text := LabeledEdit7.Text;
    TfrxMemoView(frxReport1.FindObject('Memo3')).Text := LabeledEdit9.Text;
    TfrxMemoView(frxReport1.FindObject('Memo4')).Text := ClientDataSet1.FieldByName('cn').AsString;
    TfrxMemoView(frxReport1.FindObject('memo5')).Memo.Text := IntToStr(LabeledEdit10.Tag) + 'PCS';
    TfrxMemoView(frxReport1.FindObject('memo14')).Memo.Text := pinfang;
    TfrxMemoView(frxReport1.FindObject('memo15')).Memo.Text := ClientDataSet1.FieldByName('ERPPDNO').AsString;
    TfrxMemoView(frxReport1.FindObject('memo16')).Memo.Text := LabeledEdit8.Text;

    TfrxBarCodeView(frxReport1.FindObject('BarCode1')).Text := pinfang;
    TfrxBarCodeView(frxReport1.FindObject('BarCode2')).Text := IntToStr(LabeledEdit10.Tag);
    TfrxBarCodeView(frxReport1.FindObject('BarCode3')).Text := ClientDataSet1.FieldByName('ERPPDNO').AsString;
    TfrxBarCodeView(frxReport1.FindObject('BarCode4')).Text := LabeledEdit8.Text;

    bmp := TBitmap.Create;
    bmp.Width := psBarcode1.Width;
    bmp.Height := psBarcode1.Height;
    psBarcode1.PaintBarCode(bmp.Canvas, Rect(0, 0, bmp.Width, bmp.Height));
    TfrxPictureView(frxReport1.FindObject('picture1')).Picture.Assign(bmp);
    bmp.Free;

    frxReport1.PrepareReport;
    frxReport1.PrintOptions.ShowDialog := False; //����ʾ��ӡ��ѡ���
    frxReport1.Print; //��ӡ
  except
    on e: Exception do
    begin
      temp := '�� TF_PrintAgain.PrintLabelTwo �����쳣,����ϵ����Ա.�������:' + e.Message;
      AddLog_ErrorText(temp);
      ZsbMsgErrorInfoNoApp(Self, e.Message);
      iRt := 1;
    end;
  end;
  Result := iRt;
end;

procedure TF_PrintAgain_After.Timer1Timer(Sender: TObject);
var
  h: THandle;
  bit: TBitmap;
begin
  Timer1.Enabled := False;
  if FileExists(ExtractFilePath(Application.Exename) + 'BitBtnImageFormZsbDll2.dll') then
  begin
    h := LoadLibrary('BitBtnImageFormZsbDll2.dll'); //���� DLL
    bit := TBitmap.Create;
    bit.LoadFromResourceName(h, 'imgLZtopForZhuiSuSYS2'); //��ȡ��Դ
    Image1.Picture.Assign(bit);
    FreeLibrary(h); //��ж DLL
    bit.Free;
  end;
  RzPanel99.Visible := True;
  DateTimePicker1.Date := StrToDate(FormatDateTime('yyyy-mm-dd', Now() - 1));
  DateTimePicker2.Date := StrToDate(FormatDateTime('yyyy-mm-dd', Now));
  AddCombobox2;
  DBGridEhWidth(DBGridEh1, 'get', 'F_PrintAgain_After_DBGridEh1.zsb');
end;

procedure TF_PrintAgain_After.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //������С���
end;

procedure TF_PrintAgain_After.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DBGridEhWidth(DBGridEh1, 'save', 'F_PrintAgain_After_DBGridEh1.zsb');
  Action := caFree;
end;

procedure TF_PrintAgain_After.Button1Click(Sender: TObject);
var
  strsql, temp1, temp2: string;
begin
  strsql := 'select * from EndProtBarCode where alreadyprint=''1'' and InNo<>''''';

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
  LabeledEdit10.Tag := 0;
end;

procedure TF_PrintAgain_After.Button2Click(Sender: TObject);
var
  reportFilePath, temp: string;
  iRt: SmallInt;
begin
  {
    ��Ҫ�ѱ��ϱ�ǩ����ⵥ��д���µı�ǩ
  }
  if ClientDataSet1.Data = null then Exit;
  if ClientDataSet1.RecordCount = 0 then Exit;
  if (LabeledEdit7.Text = '') or (LabeledEdit8.Text = '') or (LabeledEdit9.Text = '') or (LabeledEdit10.Text = '') then
  begin
    zsbSimpleMSNPopUpShow('��Ϣ������.');
    Exit;
  end;
  reportFilePath := ExtractFilePath(ParamStr(0)) + 'frxReport5.fr3';
  if not FileExists(reportFilePath) then
  begin
    ZsbMsgErrorInfoNoApp(Self, '�Բ���,��ǩģ�治����,����ϵ����Ա��');
    Exit;
  end;
  if ClientDataSet1.FieldByName('iTime').AsInteger >= 2 then
  begin
    ZsbMsgErrorInfoNoApp(Self, '�˱�ǩ�Ѿ���ӡ��һ���ˣ��޷��ٴ�ӡ.');
    Exit;
  end;
  temp := 'ȷ�����´�ӡ��ǩô?' + #13 + #10;
  temp := temp + '�����' + ClientDataSet1.FieldByName('ERPPDNO').AsString + #13 + #10;
  temp := temp + 'Ʒ����' + ClientDataSet1.FieldByName('EndProtCode').AsString + #13 + #10 + #13 + #10;

  LabeledEdit10.Tag := ClientDataSet1.FieldByName('EndProtQuat').AsInteger - StrToInt(LabeledEdit10.Text);
  PrEndProtLotA := ClientDataSet1.FieldByName('EndProtLot').AsString + 'A';

  if LabeledEdit10.Tag <> 0 then
  begin
    PrEndProtLotB := ClientDataSet1.FieldByName('EndProtLot').AsString + 'B';
    temp := temp + '���ɱ�ǩ����[1]��' + PrEndProtLotA + ',��װ����' + LabeledEdit10.Text + #13 + #10;
    temp := temp + '���ɱ�ǩ����[2]��' + PrEndProtLotB + ',��װ����' + IntToStr(LabeledEdit10.Tag) + #13 + #10;
  end
  else
  begin
    temp := temp + '���ɱ�ǩ���Σ�' + PrEndProtLotA + ',��װ����' + LabeledEdit10.Text + #13 + #10;
  end;


  if ZsbMsgBoxOkNoApp(Self, temp) = False then Exit;
  
  DBGridEh1.Enabled:=False;

  if SavePrintHistory then
  begin
    iRt := 0;
    if PrintLabel = 0 then
    begin
      Inc(iRt);
      if LabeledEdit10.Tag <> 0 then  //���´�ӡ
      begin
        if PrintLabelTwo = 0 then
        begin
          Inc(iRt);
        end;
      end;
    end;
    zsbSimpleMSNPopUpShow('��ӡ ' + IntToStr(iRt) + ' ��.');
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '���´�ӡʧ��,��������Ϊ��¼ʧ��.���Ժ����Ի�����ϵ����Ա.');
  end;
  
  DBGridEh1.Enabled:=True;
end;

procedure TF_PrintAgain_After.Image1DblClick(Sender: TObject);
begin
  ZsbShowMessageNoApp(Self, cReadMe);
end;

procedure TF_PrintAgain_After.DBGridEh1CellClick(Column: TColumnEh);
begin
  if ClientDataSet1.Data = null then Exit;
  if ClientDataSet1.RecordCount = 0 then Exit;
  LabeledEdit7.Text := ClientDataSet1.FieldByName('ShippingD').AsString;
  LabeledEdit8.Text := ClientDataSet1.FieldByName('EndProtVer').AsString;
  LabeledEdit9.Text := ClientDataSet1.FieldByName('CUSTOMNO').AsString;
  LabeledEdit10.Text := ClientDataSet1.FieldByName('EndProtQuat').AsString;
end;

procedure TF_PrintAgain_After.CheckBox2Click(Sender: TObject);
begin
  LabeledEdit7.Enabled := CheckBox2.Checked;
  LabeledEdit8.Enabled := CheckBox2.Checked;
  LabeledEdit9.Enabled := CheckBox2.Checked;
  LabeledEdit10.Enabled := CheckBox2.Checked;
end;

procedure TF_PrintAgain_After.RadioButton1Click(Sender: TObject);
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

procedure TF_PrintAgain_After.Memo1KeyPress(Sender: TObject;
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
      zsbSimpleMSNPopUpShow('�����������.');
      Memo1.Lines.Text := '';
      Exit;
    end;
    strsql := 'select * from EndProtBarCode where EndProtLot=''' + TSList[3] + '''  and state=''N''';
    if ComboBox2.ItemIndex > 0 then
    begin
      strsql := strsql + ' and pName=''' + ComboBox2.Text + '''';
    end;
    SelectClientDataSet(ClientDataSet1, strsql);
    if ClientDataSet1.RecordCount = 0 then
    begin
      zsbSimpleMSNPopUpShow_2('û�м�¼��������ԭ��ǩû������.', clRed);
    end;
  end;
end;

procedure TF_PrintAgain_After.Memo1Enter(Sender: TObject);
begin
  Memo1.Lines.Text := '';
  Memo1.Font.Color := clBlack;
end;

procedure TF_PrintAgain_After.Memo1Exit(Sender: TObject);
begin
  if Memo1.Lines.Text <> '' then Exit;
  Memo1.Lines.Text := '���ڴ�ɨ���ά��';
  Memo1.Font.Color := clSilver;
end;

procedure TF_PrintAgain_After.CheckBox1Click(Sender: TObject);
var
  b: Boolean;
begin
  b := CheckBox1.Checked;
  DBGridEh1.Columns[12].Visible := b;
  DBGridEh1.Columns[13].Visible := b;
  DBGridEh1.Columns[14].Visible := b;
  DBGridEh1.Columns[15].Visible := b;
  DBGridEh1.Columns[16].Visible := b;
  DBGridEh1.Columns[17].Visible := b;  
  DBGridEh1.Columns[18].Visible := b;
  DBGridEh1.Columns[19].Visible := b;
end;

procedure TF_PrintAgain_After.LabeledEdit10Change(Sender: TObject);
begin
  if StrToInt(LabeledEdit10.Text)>ClientDataSet1.FieldByName('EndProtQuat').AsInteger then
  begin
    zsbSimpleMSNPopUpShow_2('�������ܳ�����װ��.',clRed,300);
    LabeledEdit10.Text := ClientDataSet1.FieldByName('EndProtQuat').AsString;
  end;
end;

end.

