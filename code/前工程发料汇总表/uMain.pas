unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  ComCtrls, DBGridEhImpExp, Menus, frxClass, psBarcode, frxCross, frxDBSet;

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
    TabSheet3: TRzTabSheet;
    RzPanel2: TRzPanel;
    SpeedButton1: TSpeedButton;
    RzPanel1: TRzPanel;
    DBGridEh1: TDBGridEh;
    DBGridEh2: TDBGridEh;
    SpeedButton2: TSpeedButton;
    SaveDialog1: TSaveDialog;
    SpeedButton4: TSpeedButton;
    ClientDataSet10: TClientDataSet;
    LabeledEdit1: TLabeledEdit;
    Button1: TButton;
    ComboBox1: TComboBox;
    Label5: TLabel;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    psBarcode1: TpsBarcode;
    frxReport1: TfrxReport;
    ClientDataSet11: TClientDataSet;
    frxDBDataset1: TfrxDBDataset;
    Button2: TButton;
    RzPanel3: TRzPanel;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    DateTimePicker2: TDateTimePicker;
    SpeedButton999: TSpeedButton;
    LabeledEdit2: TLabeledEdit;
    Label4: TLabel;
    ComboBox2: TComboBox;
    Label6: TLabel;
    CDSFF: TClientDataSet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure RzPageControl1Change(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    function getQCNo(dt1, dt2: TDate): string;
    procedure LoadQX;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation      //100001

uses UDM, ZsbFunPro2, ZsbDLL2, DateUtils, ZsbVariable2;

{$R *.dfm}

procedure TfrmMain.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //���� ��ʾ��������
end;

procedure TfrmMain.LoadQX;
var
  strsql: string;
begin
  if isSuprAdmin then Exit;
  strsql := 'select funccode from userpower where usercode=''' + ZStrUserCode + ''' and powertype=''PC'' and funccode=''020401''';
  SelectClientDataSetNoTips(ClientDataSet10, strsql);
  if ClientDataSet10.RecordCount = 0 then
  begin
    SpeedButton999.Enabled := False;
  end;
end;



procedure TfrmMain.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Self.Left := 50;
  Self.Top := 50;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //������С���
end;

function TfrmMain.getQCNo(dt1, dt2: TDate): string;
var
  i: Integer;
  temp: string;
begin
  i := DayOfTheYear(dt1);
  temp := Format('%.3d', [i]);
  Result := FormatDateTime('yy', dt1) + temp;

  i := DayOfTheYear(dt2);
  temp := Format('%.3d', [i]);
  Result := Result + FormatDateTime('yy', dt2) + temp;

  Result := 'QC' + Result;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
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
  RzPageControl1.Visible := True;
  RzPageControl1.ActivePageIndex := 0;
end;

procedure TfrmMain.Timer2Timer(Sender: TObject);
var
  temp: string;
begin
  Timer2.Enabled := False;
  try
    FDM := TFDM.Create(nil);
    FDM.RestartLink; //�������ݿ�����
    if FDM.booPuLinkDBSta = False then
    begin
      if Application.MessageBox(PChar(FDM.strPuLinkError), '������Ϣ', MB_ICONERROR + MB_RETRYCANCEL) = idRETRY then
      begin
        FDM.RestartLink;
      end
      else
      begin
        Self.Close;
      end;
    end;
    Button1.Click;
    LoadQX;
    temp := SelectClientDataSetResultFieldCaption(ClientDataSet10, 'select max(enddt) enddt from QGCFLHZ where state<>''E.������''', 'enddt');
    if temp <> '' then
    begin
      DateTimePicker1.Date := StrToDate(temp) + 1;
      DateTimePicker2.Date := Now;
    end
    else
    begin
      DateTimePicker1.Date := Now;
      DateTimePicker2.Date := Now;
    end;
    ComboBox2.Clear;
    ComboBox2.Items.Add('');
    temp := 'select distinct DEP from DB_DEMO.DBO.MF_ML where len(DEP)=3 order by DEP';
    SelectClientDataSet(ClientDataSet10, temp);
    with ClientDataSet10 do
    begin
      First;
      while not eof do
      begin
        ComboBox2.Items.Add(FieldByName('DEP').AsString);
        Next;
      end;
    end;
  finally

  end;
end;

procedure TfrmMain.SpeedButton2Click(Sender: TObject);
begin
  try
    if (ClientDataSet2.Data = null) or (ClientDataSet2.RecordCount = 0) then
    begin
      zsbSimpleMSNPopUpShow_2('û�пɲ���������.');
      Exit;
    end;
    SaveDialog1.FileName := 'ǰ���̷��ϻ��ܱ� - ��ϸ ' + FormatDateTime('yyyyMMddHHmmss', Now) + '.xls';
    SaveDialog1.filter := 'Execl(*.xls)|*.xls';
    if SaveDialog1.Execute then
    begin
      SaveDBGridEhToExportFile(TDBGridEhExportAsXls, DBGridEh2, SaveDialog1.FileName, true);
      zsbSimpleMSNPopUpShow('�ļ������ɹ���' + SaveDialog1.FileName);
    end;
  except
    on e: Exception do
    begin
      zsbSimpleMSNPopUpShow_2('����ʧ��,����ϵ����Ա.' + e.Message, clRed, 500);
    end;
  end;
end;

procedure TfrmMain.SpeedButton999Click(Sender: TObject);
var
  temp,  qcNo, exsql: string;
begin
  { //���ڿ������ѡ��
  temp := 'select max(enddt) enddt from QGCFLHZ where state<>''E.������''';
  temp1 := SelectClientDataSetResultFieldCaption(ClientDataSet10, temp, 'enddt');
  if temp1 <> '' then
  begin
    if FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date - 1) <> temp1 then
    begin
      ZsbMsgErrorInfoNoApp(Self, '����ѡ�����.');
      exit;
    end;
  end;
  }
  if FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date) > FormatDateTime('yyyy-MM-dd', DateTimePicker2.Date) then
  begin
    ZsbMsgErrorInfoNoApp(Self, '��ʼ���ڲ���С����ֹ����.');
    exit;
  end;
  if ComboBox2.Text = '' then
  begin
    temp := #13 + #10 + #13 + #10 + 'ȷ���������ڡ�' + FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date) + '��' +
      FormatDateTime('yyyy-MM-dd', DateTimePicker2.Date) + '����ǰ���̷��ϻ���ô?�˲������ܺ�ʱ�Ƚϳ���';
  end
  else
  begin
    temp := #13 + #10 + #13 + #10 + 'ȷ���������ڡ�' + FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date) + '��' +
      FormatDateTime('yyyy-MM-dd', DateTimePicker2.Date) + '����¥��Ϊ��' + ComboBox2.Text + '����ǰ���̷��ϻ���ô?�˲������ܺ�ʱ�Ƚϳ���';
  end;


  if ZsbMsgBoxOkNoApp(Self, temp) = False then Exit;

  qcNo := getQCNo(DateTimePicker1.DateTime, DateTimePicker2.DateTime) + FormatDateTime('HHmm',Now) + ComboBox2.Text;
  
  if qcNo = '' then
  begin
    ZsbMsgErrorInfoNoApp(Self, 'ǰ���̻��ܷ��ϵ���������ʧ��,����ϵ����Ա.');
    Exit;
  end;

  if ComboBox2.Text = '' then
  begin
    exsql := 'Exec ZP_QGCFLHZ ';
  end
  else
  begin
    exsql := 'Exec ZP_QGCFLHZ_ByDEP ';
  end;
  exsql := exsql + '''' + FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date) + ''',';
  exsql := exsql + '''' + FormatDateTime('yyyy-MM-dd', DateTimePicker2.Date) + ''',';
  exsql := exsql + '''' + qcNo + ''',';
  exsql := exsql + '''' + ZStrUser + '''';
  if ComboBox2.Text <> '' then
  begin
    exsql := exsql + ',''' + ComboBox2.Text + '''';
  end;

  if EXSQLClientDataSet(ClientDataSet10, exsql) = False then
  begin
    ZsbMsgErrorInfoNoApp(Self, 'Exec ZP_QGCFLHZ ����ʧ��,����ϵ����Ա.');
    Exit;
  end
  else
  begin
    zsbSimpleMSNPopUpShow('�����ɹ�.');
    Button1.Click;
  end;
end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
var
  strsql: string;
begin
  if ComboBox1.Text = 'E.������' then Exit;
  if (label3.Caption = '') or (label3.Visible = False) then
  begin
    zsbSimpleMSNPopUpShow('û��ѡ�񵥾�.');
    ClientDataSet2.Close;
    Exit;
  end;

  strsql := 'select * from QGCFLHZMx where QCNo=''' + label3.Caption + '''';
  if LabeledEdit1.Text <> '' then
  begin
    strSQL := strSQL + ' and MatlCode like ''%' + LabeledEdit1.Text + '%''';
  end;
  strsql := strsql + ' order by WH,MatlCode';
  SelectClientDataSet(ClientDataSet2, strsql);
  SpeedButton1.Tag := 1;
  RzPageControl1.ActivePageIndex := 1;
end;

procedure TfrmMain.SpeedButton4Click(Sender: TObject);
var
  strsql, exsql, temp: string;
  bmp: TBitmap;
  TempB: Boolean; //ClientDataSet10
begin
  if label3.Caption = '' then
  begin
    zsbSimpleMSNPopUpShow('û������.');
    Exit;
  end;
  if not FileExists(ExtractFilePath(ParamStr(0)) + '\frxReport7.fr3') then
  begin
    ZsbMsgErrorInfoNoApp(Self, '�Բ���,��ǩģ�治����,����ϵ����Ա��');
    exit;
  end;
  exsql := 'update QGCFLHZ set state=''2.������'' where QCNo=''' + label3.Caption + ''' and state=''1.����ӡ''';
  TempB := EXSQLClientDataSet(ClientDataSet10, exsql);
  if TempB = False then
  begin
    temp := '��' + label3.Caption + '��ӡʧ�ܡ�';
    AddLog_ErrorText(label3.Caption + '��ӡʧ��');
    zsbSimpleMSNPopUpShow('��ӡ��¼ʧ�ܣ�����ϵ����Ա.');
    Exit;
  end;

  strsql := 'select MatlCode,MatlName,BZBZ,SCLL,SFS,SFJS,SJKC,BCDBS,JSHS,WH ' +
    'from QGCFLHZMx where QCNo=''' + label3.Caption + ''' order by WH,MatlCode';
  SelectClientDataSet(ClientDataSet11, strSQL);

  try
    frxReport1.Clear;
    frxReport1.LoadFromFile(ExtractFilePath(ParamStr(0)) + '\frxReport7.fr3');


    TfrxMemoView(frxReport1.FindObject('Memo2')).Memo.Text := label3.Caption;
    TfrxMemoView(frxReport1.FindObject('Memo28')).Memo.Text := label3.Caption;
    TfrxMemoView(frxReport1.FindObject('Memo29')).Memo.Text := ClientDataSet1.FieldByName('DEP_MF').AsString;
    TfrxMemoView(frxReport1.FindObject('Memo1')).Memo.Text := IntToStr(ClientDataSet2.RecordCount);
    TfrxMemoView(frxReport1.FindObject('Memo3')).Memo.Text := FormatDateTime('yyyy-MM-dd', Now);

    psBarcode1.BarCode := label3.Caption;
    bmp := TBitmap.Create;
    bmp.Width := psBarcode1.Width;
    bmp.Height := psBarcode1.Height;
    psBarcode1.PaintBarCode(bmp.Canvas, Rect(0, 0, bmp.Width, bmp.Height));
    TfrxPictureView(frxReport1.FindObject('picture1')).Picture.Assign(bmp);
    bmp.Free;

    if CheckBox1.Checked = True then
    begin
      frxReport1.ShowReport;
    end
    else
    begin
      frxReport1.PrepareReport;
      frxReport1.PrintOptions.ShowDialog := False; //����ʾ��ӡ��ѡ���
      frxReport1.Print; //��ӡ
    end;
    AddLog_Operation(label3.Caption + '����ӡ(ǰ���̷��ϻ��ܱ�)');
  except
    on ex:Exception do
    begin
      ZsbMsgErrorInfoNoApp(Self, ex.Message);
    end;
  end;

end;

procedure TfrmMain.RzPageControl1Change(Sender: TObject);
begin
  if RzPageControl1.ActivePageIndex = 0 then Exit;
  if SpeedButton1.Tag = 1 then exit;
  if ClientDataSet1.Data = null then Exit;

  if ClientDataSet2.Data = null then
  begin
    SpeedButton1.Click;
    Exit;
  end;
  if ClientDataSet2.RecordCount = 0 then
  begin
    SpeedButton1.Click;
    Exit;
  end;
  if (ClientDataSet2.FieldByName('QCNo').AsString <> label3.Caption) then
  begin
    SpeedButton1.Click;
  end;
end;

procedure TfrmMain.DBGridEh1CellClick(Column: TColumnEh);
begin
  if (ClientDataSet1.Data = null) or (ClientDataSet1.FieldByName('QCNo').AsString = '') then Exit;

  label3.Caption := ClientDataSet1.FieldByName('QCNo').AsString;
  label3.Visible := True;
  SpeedButton1.Tag := 0;
end;

procedure TfrmMain.frxReport1BeforePrint(Sender: TfrxReportComponent);
var
  Cross: TfrxCrossView;
  i, j: Integer;
begin
  Exit;
  ClientDataSet11.Fields[0].DisplayLabel := '��Ϻ�';
  ClientDataSet11.Fields[1].DisplayLabel := '�Է��Ϻ�';
  ClientDataSet11.Fields[2].DisplayLabel := '��׼��װ';
  ClientDataSet11.Fields[3].DisplayLabel := '��������';
  ClientDataSet11.Fields[4].DisplayLabel := 'ʵ����';
  ClientDataSet11.Fields[5].DisplayLabel := 'ʵ������';
  ClientDataSet11.Fields[6].DisplayLabel := 'ʵ�ʿ��';
  ClientDataSet11.Fields[7].DisplayLabel := '���ε�����';
  ClientDataSet11.Fields[8].DisplayLabel := '��������';
  ClientDataSet11.Fields[9].DisplayLabel := '��λ';

  if Sender is TfrxCrossView then
  begin
    Cross := TfrxCrossView(Sender);
    ClientDataSet11.First;
    i := 0;
    while not ClientDataSet11.Eof do
    begin
      for j := 0 to ClientDataSet11.FieldCount - 1 do
      begin
        Cross.AddValue([i], [ClientDataSet11.Fields[j].DisplayLabel], [ClientDataSet11.Fields[j].AsString]);
      end;
      ClientDataSet11.Next;
      Inc(i);
    end;
  end;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  strsql: string;
begin
  strsql := 'select * from QGCFLHZ where 1=1';
  if ComboBox1.ItemIndex > 0 then
  begin
    strSQL := strSQL + ' and state=''' + ComboBox1.Text + '''';
  end;
  if LabeledEdit2.Text <> '' then
  begin
    strSQL := strSQL + ' and QCNo like ''%' + LabeledEdit2.Text + '%''';
  end;
  strsql := strsql + ' order by id desc';
  SelectClientDataSet(ClientDataSet1, strsql);

  label3.Visible := False;
  label3.Caption := '';
  SpeedButton1.Tag := 0;
  ClientDataSet2.Close;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
var
  exsql: string;
begin
  if ClientDataSet1.Data = null then Exit;
  if ClientDataSet1.RecordCount = 0 then Exit;

  CDSFF.Data := ClientDataSet1.Data;
  CDSFF.Filter := 'isselect=''1''';
  CDSFF.Filtered := True;
  if CDSFF.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('û�п�ѡ������ļ�¼.');
    Exit;
  end;
       
  if ZsbMsgBoxOkNoApp(Self, 'ȷ��������ѡ�ĵ���ô��') = false then exit;
  with CDSFF do
  begin
    First;
    while not Eof do
    begin
      exsql := exsql + 'update QGCFLHZ set State=''E.������'' where QCNo=''' + FieldByName('QCNo').AsString + ''';'; //1.����
      exsql := exsql + 'delete from QGCFLHZMx where QCNo=''' + FieldByName('QCNo').AsString + ''';'; //2.ɾ��
      exsql := exsql + 'delete from QGCFLHZMx_Outlog where QCNo=''' + FieldByName('QCNo').AsString + ''';'; //3.ɾ�� ������ϸ
      Next;
    end;
  end;

  
  exsql := ' begin ' + exsql + ' commit; end;';
  if EXSQLClientDataSet(ClientDataSet10, exsql) then
  begin
    zsbSimpleMSNPopUpShow('���ϳɹ���');
    Button1.Click;
    AddLog_Operation('��������ǰ���̷��ϻ��ܵ�');
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '�Բ��𣬲���ʧ�ܣ�');
  end;
end;

procedure TfrmMain.DateTimePicker1Change(Sender: TObject);
begin
 DateTimePicker2.Date:=DateTimePicker1.Date;
end;

end.

