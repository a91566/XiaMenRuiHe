unit U_frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect, ComObj;

type
  TfrmMain = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    ScrollBox1: TScrollBox;
    RzPanel99: TRzPanel;
    DBGridEh1: TDBGridEh;
    RzPanel1: TRzPanel;
    SpeedButton999: TSpeedButton;
    Timer2: TTimer;
    Image1: TImage;
    ClientDataSet10: TClientDataSet;
    SpeedButton2: TSpeedButton;
    SpeedButton4: TSpeedButton;
    LabeledEdit1: TLabeledEdit;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    LabeledEdit3: TLabeledEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public
    { Public declarations }
  end;

const
  cReadMe = '����Ʒ����Ϣ,����˵��:' +
    #13 + #10 + '��ӡ��ǩ��ѡ���ӡƷ��ʱ����ʾ.' +
    #13 + #10 + #13 + #10 + '2014��5��15�� 16:15:12 ֣�ٱ�';

var
  frmMain: TfrmMain;

implementation //Lz_Zsb_China_Product

uses UDM, ZsbFunPro2, ZsbDLL2, ZsbVariable2;

{$R *.dfm}

procedure TfrmMain.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //���� ��ʾ��������
end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmMain.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // ûЧ������2013��3��18�� 11:38:05
  Action := caFree;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Self.Top := 50;
  Self.Top := 50;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 250, AW_CENTER); //������С���
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
end;

procedure TfrmMain.Timer2Timer(Sender: TObject);
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
    SpeedButton999.Click;
  finally

  end;
end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
var
  temp, exsql: string;
begin
  if LabeledEdit3.Text = '' then
  begin
    ShowInfoTips(LabeledEdit3.Handle, '������������Ʒ����.', 3);
    LabeledEdit3.SetFocus;
    Exit;
  end;
  if ClientDataSet10.Tag = 0 then
  begin
    with ClientDataSet10 do //�����������ݿ�
    begin
      RemoteServer.AppServer.LinkHISData('1');
      ClientDataSet10.Tag := 1;
    end;
  end;

  if SpeedButton1.Tag = 1 then //�޸�
  begin
    exsql := 'update Lz_Zsb_China_Product set pw=''' + LabeledEdit3.Text + ''' where id=''' + ClientDataSet1.FieldByName('id').AsString + '''';
  end
  else
  begin //����
    temp := 'select id from Lz_Zsb_China_Product where pw=''' + LabeledEdit3.Text + '''';
    with ClientDataSet10 do
    begin
      data := RemoteServer.AppServer.HISFUN_GetDataSql(temp);
    end;
    if ClientDataSet10.RecordCount <> 0 then
    begin
      ZsbMsgErrorInfoNoApp(Self, 'Ʒ���Ѵ���,����������');
      LabeledEdit3.SetFocus;
      Exit;
    end
    else
    begin
      exsql := 'insert into Lz_Zsb_China_Product(pw)values(''' + LabeledEdit3.Text + ''')';
    end;
  end;

  if exsql <> '' then
  begin
    with ClientDataSet10 do
    begin
      temp := RemoteServer.AppServer.HISFUN_peradd(EXSQL);
    end;
    if temp = 'false' then //���ص����ַ���
    begin
      ZsbMsgErrorInfoNoApp(Self, '�Բ��𣬲���ʧ�ܣ�');
    end
    else
    begin
      zsbSimpleMSNPopUpShow('�����ɹ���');
      SpeedButton999.Click;
    end;
  end;

end;

procedure TfrmMain.SpeedButton999Click(Sender: TObject);
var
  temp: string;
begin
  temp := 'select * from Lz_Zsb_China_Product where 1=1 ';
  if LabeledEdit1.Text <> '' then
  begin
    temp := temp + ' and pw like ''%' + LabeledEdit1.Text + '%''';
  end;
  temp := temp + ' order by pw';


  if ClientDataSet1.Tag = 0 then
  begin
    with ClientDataSet1 do //�����������ݿ�
    begin
      RemoteServer.AppServer.LinkHISData('1');
      ClientDataSet1.Tag := 1;
    end;
  end;
  with ClientDataSet1 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(temp);
  end;
  SpeedButton3.Click;
end;

procedure TfrmMain.SpeedButton4Click(Sender: TObject);
var
  temp, exsql: string;
begin
  if isSuprAdmin = False then
  begin
    zsbSimpleMSNPopUpShow('��������.');
    exit;
  end;
  temp := ClientDataSet1.FieldByName('pw').AsString;
  if ZsbMsgBoxOkNoApp(Self, 'ȷ��ɾ��Ʒ��[' + temp + ']�ļ�¼ô��') = False then Exit;
  if ClientDataSet10.Tag = 0 then
  begin
    with ClientDataSet10 do //�����������ݿ�
    begin
      RemoteServer.AppServer.LinkHISData('1');
      ClientDataSet10.Tag := 1;
    end;
  end;
  exsql := 'delete Lz_Zsb_China_Product where id=' + ClientDataSet1.FieldByName('id').AsString;

  with ClientDataSet10 do
  begin
    temp := RemoteServer.AppServer.HISFUN_peradd(EXSQL);
  end;
  if temp = 'false' then //���ص����ַ���
  begin
    ZsbMsgErrorInfoNoApp(Self, '�Բ��𣬲���ʧ��,����ϵ����Ա��');
  end
  else
  begin
    zsbSimpleMSNPopUpShow('�ѳɹ�ɾ��.');
    SpeedButton999.Click;
  end;
end;

procedure TfrmMain.LabeledEdit1Change(Sender: TObject);
begin
  SpeedButton999.Click;
end;

procedure TfrmMain.SpeedButton2Click(Sender: TObject);
begin
  if ClientDataSet1.RecordCount = 0 then Exit;
  SpeedButton1.Tag := 1;
  DBGridEh1.Enabled := False;
  LabeledEdit3.Text := ClientDataSet1.FieldByName('pw').AsString;
  Panel1.Visible := True;
  LabeledEdit3.SetFocus;
end;

procedure TfrmMain.SpeedButton3Click(Sender: TObject);
begin
  LabeledEdit3.Text := '';
  Panel1.Visible := False;
  DBGridEh1.Enabled := True;
  DBGridEh1.Repaint;
end;

procedure TfrmMain.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if Panel1.Visible then
  begin
    if ClientDataSet1.FieldByName('pw').AsString = LabeledEdit3.Text then
    begin
      DBGridEh1.Canvas.Brush.Color := clYellow;
      DBGridEh1.Canvas.Font.Color := clRed;
      DBGridEh1.Canvas.Font.Style := [fsBold];
      DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
  end;
end;

procedure TfrmMain.SpeedButton5Click(Sender: TObject);
begin
  SpeedButton3.Click;
  SpeedButton1.Tag := 0;
  Panel1.Visible := True;
  LabeledEdit3.SetFocus;
end;

procedure TfrmMain.SpeedButton6Click(Sender: TObject);
var
  vexcel, workbook, sheet: OleVariant; //����excel
  filename: string;
  i: SmallInt;
begin
  if (ClientDataSet1.Data = null) or (ClientDataSet1.RecordCount = 0) then
  begin
    zsbSimpleMSNPopUpShow('û�пɲ���������');
    Exit;
  end;
  filename := ExtractFilePath(Application.Exename) + '������Ϣ�ͻ������Ϣ��.xls';
  if FileExists(filename) = False then
  begin
    ZsbMsgErrorInfoNoApp(Self, 'ģ���ļ��� ������Ϣ�ͻ������Ϣ��.xls ��������,�޷���ɵ���,����ϵ����Ա.');
    Exit;
  end;
  vExcel := CreateOleObject('Excel.application');
  vExcel.Visible := True; //��ʾ
  vExcel.workbooks.Add(filename);
  workbook := vExcel.workbooks[1];
  sheet := workbook.worksheets[1];
  with ClientDataSet1 do
  begin
    First;
    i := 2;
    while not Eof do
    begin
      sheet.cells[i, 1] := FieldByName('id').AsString;
      sheet.cells[i, 2] := FieldByName('pw').AsString;
      i := i + 1;
      sheet.cells[i, 5].select; //�������
      Next;
    end;
  end;
  zsbSimpleMSNPopUpShow('�������.');
end;

procedure TfrmMain.Image1DblClick(Sender: TObject);
begin
  ZsbShowMessageNoApp(Self, cReadMe);
end;

end.

