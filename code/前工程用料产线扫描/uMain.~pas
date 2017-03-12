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
    Label3: TLabel;
    LabeledEdit1: TLabeledEdit;
    Label5: TLabel;
    Label7: TLabel;
    Timer3: TTimer;
    ListBox1: TListBox;
    Timer4: TTimer;
    IdIPWatch1: TIdIPWatch;
    Timer5: TTimer;
    Timer6: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure Timer4Timer(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);
    procedure Timer6Timer(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SelectTop100;
    procedure InsertIntoTable;
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

uses UDM, ZsbFunPro2, ZsbDLL2, DateUtils, ZsbVariable2;

{$R *.dfm}

procedure TfrmMain.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TfrmMain.SelectTop100;
var
  strsql: string;
begin
  strsql := 'select top 20 * from QGCYLSM order by id desc';
  SelectClientDataSet(ClientDataSet1, strsql);
end;

procedure TfrmMain.InsertIntoTable;
var
  exsql, temp: string;
begin
  exsql := 'insert into QGCYLSM_Temp(Code2D,un) values(''' + ListBox1.Items.strings[0] + ''','''+ZStrUser+''');';
  if EXSQLClientDataSet(ClientDataSet10, exsql) then
  begin
    ListBox1.Items.Delete(0);
  end
  else
  begin    //如果不成功，则可能有个单引号，处理一下再次操作，若还不成功，将其删除，并且记录。
    temp := StringReplace(ListBox1.Items.strings[0], '''', '''''', [rfReplaceAll]);
    exsql := 'insert into QGCYLSM_Temp(Code2D,un) values(''' + temp + ''','''+ZStrUser+''');';
    if EXSQLClientDataSet(ClientDataSet10, exsql) then
    begin
      ListBox1.Items.Delete(0);
    end
    else
    begin
      //先写入数据库
      temp:='前工程用料扫描记录失败，IP:'+IdIPWatch1.LocalIP+'。条码内容将会在当时那工作站电脑记录，文件名为当时的时间，类型为txt文档';
      AddLog_ErrorText(temp);
      //将条码写入本地文件，以便查找
      temp:=ListBox1.Items.strings[0];
      SaveMessage(temp,'txt');   
      ListBox1.Items.Delete(0);
    end;
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
end;

procedure TfrmMain.Timer2Timer(Sender: TObject);
var
  temp: string;
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
    SelectTop100;
  finally

  end;
end;

procedure TfrmMain.Label5Click(Sender: TObject);
begin
  if ZsbMsgBoxOkNoApp(Self, '确认暂停扫描么？') = False then Exit;
  timer3.Enabled := False;
  LabeledEdit1.Enabled := False;
  label7.Enabled := True;
  label5.Enabled := False;
  label3.Visible:=False;
end;

procedure TfrmMain.Timer3Timer(Sender: TObject);
begin
  LabeledEdit1.SetFocus;
end;

procedure TfrmMain.Label7Click(Sender: TObject);
begin
  timer3.Enabled := True;
  LabeledEdit1.Enabled := True;
  label7.Enabled := False;
  label5.Enabled := True;  
  label3.Visible:=True;
end;

procedure TfrmMain.LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    ListBox1.Items.Add(LabeledEdit1.Text);
    LabeledEdit1.Text := '';
  end;
end;

procedure TfrmMain.Timer4Timer(Sender: TObject);
begin
  if ListBox1.Items.Count = 0 then Exit;
  InsertIntoTable;
end;

procedure TfrmMain.Image1DblClick(Sender: TObject);
begin
  ZsbShowMessageNoApp(Self, cReadMe);
end;

procedure TfrmMain.Timer5Timer(Sender: TObject);
begin
  SelectTop100;
end;

procedure TfrmMain.Timer6Timer(Sender: TObject);
begin
  EXSQLClientDataSet(CDSFF,'Exec ZP_QGCYLSM');
end;

end.

