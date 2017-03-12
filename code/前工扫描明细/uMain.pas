unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  ComCtrls, DBGridEhImpExp, Menus, frxClass, psBarcode, frxCross, frxDBSet,
  IdBaseComponent, IdComponent, IdIPWatch;

type
  TfrmMain = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    Timer2: TTimer;
    Image1: TImage;
    TabSheet2: TRzTabSheet;
    RzPanel1: TRzPanel;
    DBGridEh1: TDBGridEh;
    ClientDataSet10: TClientDataSet;
    ClientDataSet11: TClientDataSet;
    CDSFF: TClientDataSet;
    LabeledEdit1: TLabeledEdit;
    IdIPWatch1: TIdIPWatch;
    LabeledEdit2: TLabeledEdit;
    Button1: TButton;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    CheckBox1: TCheckBox;
    Button2: TButton;
    SaveDialog1: TSaveDialog;
    Button3: TButton;
    RzPanel2: TRzPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Button4: TButton;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Button5: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public

    { Public declarations }
  end;
const cReadMe = '前工程用料扫描,功能说明:' +
  #13 + #10 + '因为此功能会涉及很多并发操作，故此模块功能用下列方法实现' +
    #13 + #10 + '扫描枪扫描传输过来的数据将不做任何判断对错，全部接受至ListBox（条码最长100位）' +
    #13 + #10 + '一个Timer每秒执行一个动作，取ListBox第一条数据(依然不做任何解析)，插入数据库表QGCYLSM_Temp' +
    #13 + #10 + '到此前台任务算是结束。' +
    #13 + #10 + '系统后台需要定义一个存储过程定时去执行，取QGCYLSM_Temp数据，将其解析至表QGCYLSM。' +
    #13 + #10 + '存储过程一分钟执行一次，一次取10条数据，插入成功后标记为已操作。' +
    #13 + #10 + #13 + #10 + '2015年4月11日 10:04:02 郑少宝';

var
  frmMain: TfrmMain;

implementation

uses UDM, ZsbFunPro2, ZsbDLL2, DateUtils, ZsbVariable2, unit2;

{$R *.dfm}

procedure TfrmMain.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
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
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
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
  RzPageControl1.Visible := True;
  RzPageControl1.ActivePageIndex := 0;
  DateTimePicker1.Date:=Now;   
  DateTimePicker2.Date:=Now;
end;

procedure TfrmMain.Timer2Timer(Sender: TObject);
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
    Button1.Click;
  finally

  end;
end;

procedure TfrmMain.Image1DblClick(Sender: TObject);
begin
  ZsbShowMessageNoApp(Self, cReadMe);
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  strsql, temp1, temp2: string;
begin
  strsql := 'select * from QGCYLSM where 1=1 ';
  if CheckBox1.Checked then
  begin
    temp1 := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date) + ' 00:00:00';
    temp2 := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date) + ' 23:59:59';
    strsql := strsql + ' and sysdt>=''' + temp1 + ''' and sysdt<=''' + temp2 + '''';
  end;
  if LabeledEdit1.Text<>'' then
  begin
     strsql:=strsql+' and MO_NO like ''%'+LabeledEdit1.Text+'%''';
  end;
  if LabeledEdit2.Text<>'' then
  begin
     strsql:=strsql+' and MatlCode like ''%'+LabeledEdit2.Text+'%''';
  end;
  if LabeledEdit3.Text<>'' then
  begin
     strsql:=strsql+' and MatlLot like ''%'+LabeledEdit3.Text+'%''';
  end;
  if LabeledEdit4.Text<>'' then
  begin
     strsql:=strsql+' and AutoLot like ''%'+LabeledEdit4.Text+'%''';
  end;
  if LabeledEdit5.Text<>'' then
  begin
     strsql:=strsql+' and DEP like ''%'+LabeledEdit5.Text+'%''';
  end;
  if LabeledEdit6.Text<>'' then
  begin
     strsql:=strsql+' and ScanNo like ''%'+LabeledEdit6.Text+'%''';
  end;     
  case ComboBox1.ItemIndex of
    1: strsql:=strsql+' and state=''1''';
    2: strsql:=strsql+' and state=''2''';
    3: strsql:=strsql+' and state=''9''';
  end;
  strsql := strsql + ' order by id desc';
  SelectClientDataSet(ClientDataSet1, strsql);
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  try
    SaveDialog1.FileName := '前工程用料扫描 ' + FormatDateTime('yyyyMMddHHmmss', Now) + '.xls';
    SaveDialog1.filter := 'Execl(*.xls)|*.xls';
    if SaveDialog1.Execute then
    begin
      SaveDBGridEhToExportFile(TDBGridEhExportAsXls, DBGridEh1, SaveDialog1.FileName, true);
      zsbSimpleMSNPopUpShow('文件导出成功！' + SaveDialog1.FileName);
    end;
  except
    on e: Exception do
    begin
      zsbSimpleMSNPopUpShow_2('操作失败,请联系管理员.' + e.Message, clRed, 500);
    end;
  end;
end;

procedure TfrmMain.Label5Click(Sender: TObject);
begin
  RzPanel2.Visible := False;
end;

procedure TfrmMain.Label4Click(Sender: TObject);
var
  exsql,TempID:string;
begin
  exsql:='update QGCYLSM set MO_NO='''+Edit1.Text+''' where id='''+inttostr(Label6.Tag)+'''';
  if EXSQLClientDataSet(ClientDataSet10,exsql) then
  begin
    RzPanel2.Visible := False;
    zsbSimpleMSNPopUpShow('is ok');
    Button1.Click;
    ClientDataSet1.Locate('id',inttostr(Label6.Tag),[]);
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self,'操作失败,请联系管理员.');
  end;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
  if Application.FindComponent('form2') = nil then
  begin
    Application.CreateForm(Tform2, form2);
  end;
  form2.Show;
end;

procedure TfrmMain.Button4Click(Sender: TObject);
begin
  label6.Caption :='调整ID:'+ ClientDataSet1.FieldByName('ID').AsString;
  label6.Tag := ClientDataSet1.FieldByName('ID').AsInteger;
  Edit1.Text:='';
  RzPanel2.Visible := True;
end;

procedure TfrmMain.Button5Click(Sender: TObject);
var
  exsql,TempID:string;
begin
  TempID:=ClientDataSet1.FieldByName('ID').AsString;
  exsql:='update QGCYLSM set State=''2'' where id='''+TempID+'''';
  ClientDataSet1.Next;
  TempID:=ClientDataSet1.FieldByName('ID').AsString;
  if EXSQLClientDataSet(ClientDataSet10,exsql) then
  begin
    RzPanel2.Visible := False;
    zsbSimpleMSNPopUpShow('is ok');
    Button1.Click;
    ClientDataSet1.Locate('id',TempID,[]);
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self,'操作失败,请联系管理员.');
  end;
end;

end.

