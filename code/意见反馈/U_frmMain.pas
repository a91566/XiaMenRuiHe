unit U_frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  ComCtrls;

type
  TfrmMain = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    Timer2: TTimer;
    Image1: TImage;
    ClientDataSet10: TClientDataSet;
    RzPanel99: TRzPanel;
    DBGridEh1: TDBGridEh;
    Panel4: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Panel1: TPanel;
    Memo1: TMemo;
    Button5: TButton;
    LabeledEdit1: TLabeledEdit;
    Button6: TButton;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    LabeledEdit2: TLabeledEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label2: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    procedure TypeShow(iType:SmallInt);
    procedure getiNo;
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
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TfrmMain.getiNo;
var
  strsql,dt,iNo:string;
begin
  dt:=FormatDateTime('yyMMdd',Now);
  strsql:='select top 1 iNo from GuZhangShenGao where iNo like '''+dt+'%'' order by id desc';
  iNo:=SelectClientDataSetResultFieldCaption(ClientDataSet10, strsql,'iNo');
  if iNo='' then
  begin
    LabeledEdit1.Text:= dt+'01';
  end
  else
  begin
    LabeledEdit1.Text:= IntToStr(StrToInt(iNo)+1);
  end;
end;

procedure TfrmMain.TypeShow(iType:SmallInt);
begin
  case iType of
    0:
    begin                   
      Button1.Enabled:=True;
      Button2.Enabled:=True;
      Button3.Enabled:=False;
      Button4.Enabled:=False;
      Button5.Enabled:=True;
      Panel1.Visible:=False;
    end; 
    1:
    begin                   
      Button1.Enabled:=False;
      Button2.Enabled:=False;
      Button3.Enabled:=True;
      Button4.Enabled:=True;   
      Button5.Enabled:=False;
      Panel1.Visible:=True;
    end;
  end;
end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmMain.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05
  Action := caFree;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Self.Top := 50;
  Self.Top := 50;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 250, AW_CENTER); //窗口由小变大
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
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

procedure TfrmMain.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled := False;
  DateTimePicker1.Date:=Now-10;
  DateTimePicker2.Date:=Now;
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
    button6.Click;
  finally

  end;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
var
  exsql:string;
begin
  if Memo1.Lines.Text='' then Exit;
  if Button3.Tag=1 then   //增加
  begin
    getiNo;
    exsql:='insert into GuZhangShenGao(iNo,question,un) values ('''+labelededit1.Text+
    ''','''+Memo1.Lines.Text+''','''+ZStrUser+''')';
  end
  else if Button3.Tag=2 then  //修改
  begin
    exsql:='update GuZhangShenGao set question='''+Memo1.Lines.Text+
    ''',editdt='''+FormatDateTime('yyyy-MM-dd HH:mm:ss',Now)+''' where iNo='''+labelededit1.Text+'''';
  end
  else if Button3.Tag=3 then  //解答
  begin 
    exsql:='update GuZhangShenGao set answer='''+Memo1.Lines.Text+
    ''',answerdt='''+FormatDateTime('yyyy-MM-dd HH:mm:ss',Now)+''' where iNo='''+labelededit1.Text+'''';
  end;
  if EXSQLClientDataSet(ClientDataSet10,exsql) then
  begin
    zsbSimpleMSNPopUpShow('is ok');
    Button4.Click;
    Button6.Click;
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self,'操作失败。');
  end;
end;

procedure TfrmMain.Button6Click(Sender: TObject);
var
  strsql,temp1,temp2: string;
begin
  strsql := 'select * from GuZhangShenGao where 1=1';
  if CheckBox1.Checked then
  begin  
    temp1 := FormatDateTime('yyyy-mm-dd 00:00:00', DateTimePicker1.Date);
    temp2 := FormatDateTime('yyyy-mm-dd 23:59:59', DateTimePicker2.Date);
    strsql := strsql+' and sysdt>=''' + temp1 + ''' and sysdt<=''' + temp2 + '''';
  end;
  if LabeledEdit2.Text<>'' then
  begin
    strsql := strsql+' and question like ''%' + LabeledEdit2.Text + '%'' ';
  end;
  if CheckBox2.Checked then
  begin  
    strsql := strsql+' and answer is null ';
  end;
  strsql := strsql+ ' order by iNo desc';
  SelectClientDataSet(ClientDataSet1, strsql);
end;

procedure TfrmMain.CheckBox1Click(Sender: TObject);
begin
  DateTimePicker1.Enabled:=CheckBox1.Checked;
  DateTimePicker2.Enabled:=CheckBox1.Checked;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  label2.Caption:= '请输入问题描述';
  label2.Color:=clRed;
  Button3.Tag:=1;
  Memo1.Lines.Text:='';
  TypeShow(1);
end;

procedure TfrmMain.Button4Click(Sender: TObject);
begin
  Button3.Tag:=0;
  TypeShow(Button3.Tag);
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  if ClientDataSet1.RecordCount=0 then Exit;
  LabeledEdit1.Text:=ClientDataSet1.fieldByName('iNo').AsString;
  label2.Caption:= '请输入问题描述：'+LabeledEdit1.Text;
  label2.Color:=clRed;
  memo1.Lines.Text:=ClientDataSet1.fieldByName('question').AsString;
  Button3.Tag:=2;
  TypeShow(1);
end;

procedure TfrmMain.Button5Click(Sender: TObject);
begin  
  if ClientDataSet1.RecordCount=0 then Exit;
  LabeledEdit1.Text:=ClientDataSet1.fieldByName('iNo').AsString;
  label2.Caption:= '请输入问题解答：'+LabeledEdit1.Text;
  label2.Color:=clGreen;
  memo1.Lines.Text:=ClientDataSet1.fieldByName('answer').AsString;
  Button3.Tag:=3;
  TypeShow(1);
end;

procedure TfrmMain.DBGridEh1DblClick(Sender: TObject);
begin
  Button2.Click;
end;

end.

