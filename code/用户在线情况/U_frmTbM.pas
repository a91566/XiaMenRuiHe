unit U_frmTbM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, DBClient, StdCtrls, Grids, DBGridEh, RzPanel,
  RzTabs,  StrUtils,   ComCtrls, Menus;

type
  TfrmTbM = class(TForm)
    Image1: TImage;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPanel99: TRzPanel;
    DBGridEh1: TDBGridEh;
    RzPanel3: TRzPanel;
    Button1: TButton;
    ClientDataSet11: TClientDataSet;
    ClientDataSet12: TClientDataSet;
    Button2: TButton;
    CheckBox1: TCheckBox;
    OpenDialog1: TOpenDialog;
    CheckBox2: TCheckBox;
    LabeledEdit1: TLabeledEdit;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1DblClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public
    { Public declarations }
  end;

const
  cReadMe = '数据库用户表管理,功能说明:' +
    #13 + #10 + '解释各个表的含义.' +
    #13 + #10 + #13 + #10 + '2014年11月19日 10:55:07 郑少宝';

var
  frmTbM: TfrmTbM;
  
implementation

uses ZsbFunPro2, ZsbDLL2, ZsbVariable2;

{$R *.dfm}

procedure TfrmTbM.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;


procedure TfrmTbM.Button1Click(Sender: TObject);
var
  strsql: string;
begin
  strsql := 'select * from ZT_AppVer_DLL_FormUser where 1=1';
  if CheckBox2.Checked then
  begin
    strsql := strsql+' and ADMINDLLVER_LOCAL<>DLLVER_LOCAL';
  end;     
  if LabeledEdit1.Text<>'' then
  begin
    strsql := strsql+' and DLLNAME  like ''%'+LabeledEdit1.Text+'%''';
  end;
  strsql := strsql+' order by un,DLLNAME';

  SelectClientDataSet(ClientDataSet1, strsql);
end;


procedure TfrmTbM.Timer1Timer(Sender: TObject);
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
  Button1.Click;
end;

procedure TfrmTbM.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
end;

procedure TfrmTbM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;




procedure TfrmTbM.Image1DblClick(Sender: TObject);
begin
  ZsbShowMessageNoApp(Self, cReadMe);
end;




procedure TfrmTbM.CheckBox1Click(Sender: TObject);
begin
  DBGridEh1.Columns[5].Visible := CheckBox1.Checked;
  DBGridEh1.Columns[6].Visible := CheckBox1.Checked;
  DBGridEh1.Columns[7].Visible := CheckBox1.Checked;
  DBGridEh1.Columns[8].Visible := CheckBox1.Checked;
  DBGridEh1.Columns[9].Visible := CheckBox1.Checked;
  DBGridEh1.Columns[10].Visible := CheckBox1.Checked;
end;

procedure TfrmTbM.Button2Click(Sender: TObject);
var
  exsql: string;
begin  
  exsql:='Exec ZP_V_UserVer';
  if EXSQLClientDataSet(ClientDataSet11, exsql) then
  begin
    zsbSimpleMSNPopUpShow('is ok');
    Button1.Click;
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '操作失败,请联系管理员.');
  end;
end;

end.

