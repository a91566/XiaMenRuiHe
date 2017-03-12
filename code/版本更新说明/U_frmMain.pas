unit U_frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect;

type
  TfrmMain = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    Timer2: TTimer;
    Image1: TImage;
    ClientDataSet10: TClientDataSet;
    RzPanel99: TRzPanel;
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton5: TSpeedButton;
    SpeedButton2: TSpeedButton;
    LabeledEdit1: TLabeledEdit;
    Memo1: TMemo;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    ComboBox1: TComboBox;
    OpenDialog1: TOpenDialog;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SelectShow;
    procedure SaveNerVer(bAdd: Boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation //ZsbMsgBoxOkNoBlack

uses UDM, ZsbFunPro2, ZsbDLL2, ZsbVariable2;

{$R *.dfm}

procedure TfrmMain.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //���� ��ʾ��������
end;

procedure TfrmMain.SelectShow;
var
  temp: string;
begin
  temp := 'select * from AppVer where iType='''+Combobox1.Text+''' order by id desc';
  SelectClientDataSet(ClientDataSet1, temp);
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
    SelectShow;
  finally

  end;
end;

procedure TfrmMain.SaveNerVer(bAdd: Boolean);
var
  temp, exsql: string;
begin
  if LabeledEdit1.Text = '' then
  begin
    ShowInfoTips(LabeledEdit1.Handle, '������������汾����.', 3);
    LabeledEdit1.SetFocus;
    Exit;
  end;
  if bAdd = False then //�޸�
  begin
    exsql := 'update AppVer set tips=''' + Memo1.Lines.Text + ''' where ver=''' + LabeledEdit1.Text + ''' and iType='''+Combobox1.Text+'''';
  end
  else
  begin //����
    temp := 'select id from AppVer where ver=''' + LabeledEdit1.Text + ''' and iType='''+Combobox1.Text+'''';
    if SelectClientDataSetResultCount(ClientDataSet10, temp) <> 0 then
    begin
      ZsbMsgErrorInfoNoApp(Self, '�ð汾���Ѵ���,���跢��.');
      LabeledEdit1.SetFocus;
      Exit;
    end
    else
    begin
      if CheckBox1.Checked then
      begin
        temp:='1';
      end
      else
      begin
        temp:='0';
      end;
      exsql := 'insert into AppVer(ver,tips,dt,notice,iType,un)values(''' + LabeledEdit1.Text + ''',''' + Memo1.Lines.Text +
      ''',''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) + ''',''' + temp + ''','''+Combobox1.Text+''','''+ZStrUser+''')';
    end;

  end;
  if exsql <> '' then
  begin
    if EXSQLClientDataSet(ClientDataSet10, exsql) then
    begin
      zsbSimpleMSNPopUpShow('�����ɹ���');
      SelectShow;
    end
    else
    begin
      ZsbMsgErrorInfoNoApp(Self, '�Բ��𣬲���ʧ�ܣ�');
    end;
  end;
end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
begin
  SaveNerVer(True);
end;

procedure TfrmMain.DBGridEh1CellClick(Column: TColumnEh);
begin
  if ClientDataSet1.RecordCount = 0 then Exit;
  LabeledEdit1.Text := ClientDataSet1.FieldByName('ver').AsString;
  Memo1.Lines.Text := ClientDataSet1.FieldByName('tips').AsString;
end;

procedure TfrmMain.SpeedButton5Click(Sender: TObject);
begin
  SaveNerVer(False);
end;

procedure TfrmMain.SpeedButton2Click(Sender: TObject);
var
  exsql,temp: string;
begin
  temp:=ClientDataSet1.FieldByName('ver').AsString;
  if temp='' then Exit;
  if ZsbMsgBoxOkNoApp(Self, 'ȷ�Ϸ����°汾'+temp) = False then Exit;
  exsql := 'update AppVer set notice=''1'' where ver=''' + temp + ''' and iType='''+ClientDataSet1.FieldByName('iType').AsString+'''';
  if EXSQLClientDataSet(ClientDataSet10, exsql) then
  begin
    zsbSimpleMSNPopUpShow('�����ɹ���');
    SelectShow;
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '�Բ��𣬲���ʧ�ܣ�');
  end;
end;

procedure TfrmMain.Label2Click(Sender: TObject);
begin
  if ComboBox1.Text='PC' then
  begin
    LabeledEdit1.Text:=GetVersionString(Application.ExeName);
  end
  else
  begin
    OpenDialog1.Filter := '����(PDA)׷�ݹ���ϵͳ.exe|����(PDA)׷�ݹ���ϵͳ.exe';
    if OpenDialog1.Execute = False then Exit;
    LabeledEdit1.Text:=GetVersionString(OpenDialog1.FileName);
    if LabeledEdit1.Text='' then
    begin
      zsbSimpleMSNPopUpShow('�汾�Ż�ȡʧ��,���ֶ�����.');
      LabeledEdit1.SetFocus;
    end;
  end;
end;

procedure TfrmMain.Label3Click(Sender: TObject);
var
  temp:string;
begin
  temp:='1.���뵱ǰ���³���İ汾�š�'+#13+#10;
  temp:=temp+'2.��д�°汾��˵����'+#13+#10;
  temp:=temp+'3.���档'+#13+#10;
  temp:=temp+'4.������'+#13+#10; 
  temp:=temp+'�����ͻ��˻��յ�����֪ͨ��';
  ZsbMsgErrorInfoNoApp(Self,temp);
end;

procedure TfrmMain.ComboBox1Change(Sender: TObject);
begin
  SelectShow;
  if ComboBox1.Text='PC' then
  begin
    LabeledEdit1.ReadOnly:=True;
  end
  else
  begin  
    LabeledEdit1.ReadOnly:=False;
  end;
end;

end.

