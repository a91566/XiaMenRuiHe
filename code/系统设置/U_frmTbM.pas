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
    Button5: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RzPanel1: TRzPanel;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button4: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    OpenDialog1: TOpenDialog;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1DblClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure DBGridEh1ColWidthsChanged(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure Label1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private   
    PrRzPanel1Left: SmallInt;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SetPrRzPanel1Left;
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

procedure TfrmTbM.SetPrRzPanel1Left;
var
  i: SmallInt;
begin
  PrRzPanel1Left:=48;
  for i := 0 to DBGridEh1.Columns.Count - 1 do
  begin
    if DBGridEh1.Columns[i].Visible then
    begin
      PrRzPanel1Left := PrRzPanel1Left + DBGridEh1.Columns[i].Width;
    end;
  end;
  RzPanel1.Left := PrRzPanel1Left;
end;

procedure TfrmTbM.Button1Click(Sender: TObject);
var
  strsql: string;
begin
  strsql := 'select * from ZZZZZZZZZ_UserTableRemark order by';
  if RadioButton1.Checked then
  begin
    strsql := strsql + ' TB_Name,TB_Rows'
  end
  else if RadioButton2.Checked then
  begin
    strsql := strsql + ' TB_Rows desc,TB_Name'
  end;
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
  DBGridEh1.Columns[4].Visible := CheckBox1.Checked;
  DBGridEh1.Columns[5].Visible := CheckBox1.Checked;
  DBGridEh1.Columns[3].Visible := CheckBox1.Checked;
end;

procedure TfrmTbM.Button5Click(Sender: TObject);
var
  strsql, exsql: string;
begin
  strsql := 'SELECT object_name (i.id) TableName, rows as RowCnt FROM sysindexes i INNER JOIN sysObjects o  ON (o.id = i.id AND o.xType = ''U'')   WHERE indid < 2  ORDER BY TableName ';
  SelectClientDataSet(ClientDataSet11, strsql);
  if ClientDataSet11.RecordCount = 0 then Exit;
  with ClientDataSet11 do
  begin
    First;
    while not Eof do
    begin //TB_Name,TB_Tips,TB_Rows,TB_Creat_DT,un
      exsql := exsql + 'update ZZZZZZZZZ_UserTableRemark set TB_Rows=''' + FieldByName('RowCnt').AsString + ''' where TB_Name=''' + FieldByName('TableName').AsString + ''';';
      Next;
    end;
  end;
  if EXSQLClientDataSet(ClientDataSet11, exsql) then
  begin
    zsbSimpleMSNPopUpShow('is ok');
    Button1.Click;
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '初始化失败,请联系管理员.');
  end;
end;

procedure TfrmTbM.DBGridEh1ColWidthsChanged(Sender: TObject);
begin
  SetPrRzPanel1Left;
end;

procedure TfrmTbM.DBGridEh1CellClick(Column: TColumnEh);
begin
  if ClientDataSet1.FieldByName('TB_Name').AsString = '' then Exit;
  if DBGridEh1.Col<>3 then
  begin  
    RzPanel1.Visible := False;
    Exit;
  end;
  RzPanel1.Left := PrRzPanel1Left;
  RzPanel1.Visible := True;
  Memo1.Lines.Text := ClientDataSet1.FieldByName('TB_Tips').AsString;
  label2.Caption := ClientDataSet1.FieldByName('TB_Name').AsString;
end;

procedure TfrmTbM.Label1Click(Sender: TObject);
var
  exsql:string;
begin
  if Pos('*',Memo1.Lines.Text)>0 then
  begin
    zsbSimpleMSNPopUpShow_2('请不要输入   [*] 这个特殊字符.',clRed);
    Exit;
  end;
  exsql:='update ZZZZZZZZZ_UserTableRemark set TB_Tips='''+Memo1.Lines.Text+''' where TB_Name='''+label2.Caption+'''';
  if EXSQLClientDataSet(ClientDataSet11, exsql) then
  begin
    zsbSimpleMSNPopUpShow('is ok');
    ClientDataSet1.Edit;
    ClientDataSet1.FieldByName('TB_Tips').Value:=Memo1.Lines.Text;
  end
  else
  begin
    zsbSimpleMSNPopUpShow('操作失败,请联系管理员.');
  end;
end;

procedure TfrmTbM.Button4Click(Sender: TObject);
begin
  PopupMenu1.Popup(Button4.Left+1,Image1.Height+  RzPanel3.Height+15);
end;

procedure TfrmTbM.N2Click(Sender: TObject);
var
  TSList:TStringList;
  fn:string;
begin
  if ClientDataSet1.RecordCount=0 then Exit;
  TSList:=TStringList.Create;
  with ClientDataSet1 do
  begin
    First;
    while not eof do
    begin
      if FieldByName('TB_Tips').AsString<>'' then
      begin   
        TSList.Add(FieldByName('TB_Name').AsString+'*'+FieldByName('TB_Tips').AsString);
      end;
      Next;
    end;
  end;
  fn:=ExtractFilePath(Application.Exename) + '导出的文件\TBREMARK.ZSB';
  TSList.SaveToFile(fn);
  zsbSimpleMSNPopUpShow_2('导出文件-[ '+fn+' ]',clYellow,800);
end;

procedure TfrmTbM.N4Click(Sender: TObject);
var
  TSList,TSList2:TStringList;
  exsql:string;
  i:SmallInt;
begin
  OpenDialog1.Filter:='*.ZSB|*.ZSB';
  OpenDialog1.InitialDir:=ExtractFilePath(Application.Exename) + '导出的文件';
  if OpenDialog1.Execute=False then Exit;
  TSList:=TStringList.Create;
  TSList.LoadFromFile(OpenDialog1.FileName);
  for i:=0 to TSList.Count-1 do
  begin
    TSList2:=SplitString(TSList[i],'*');
    exsql:=exsql+'update ZZZZZZZZZ_UserTableRemark set TB_Tips='''+TSList2[1]+''' where TB_Name='''+TSList2[0]+''';';
  end;
  if EXSQLClientDataSet(ClientDataSet11, exsql) then
  begin
    zsbSimpleMSNPopUpShow('导入完成');
    Button1.Click;
  end
  else
  begin
    zsbSimpleMSNPopUpShow('操作失败,请联系管理员.');
  end;
end;

procedure TfrmTbM.Button2Click(Sender: TObject);
var
  strsql, exsql: string;
begin
  strsql := 'select name,crdate from sysobjects where xtype = ''U'' and name not in (select TB_Name from ZZZZZZZZZ_UserTableRemark)';
  SelectClientDataSet(ClientDataSet11, strsql);
  if ClientDataSet11.RecordCount = 0 then Exit;
  with ClientDataSet11 do
  begin
    First;
    while not Eof do
    begin //TB_Name,TB_Tips,TB_Rows,TB_Creat_DT,un
      exsql := exsql + 'insert into ZZZZZZZZZ_UserTableRemark(TB_Name,TB_Creat_DT,un) values(''' + FieldByName('Name').AsString +
        ''',''' + FieldByName('crdate').AsString + ''',''ZhengShaobao'');';
      Next;
    end;
  end;
  if EXSQLClientDataSet(ClientDataSet11, exsql) then
  begin
    zsbSimpleMSNPopUpShow('is ok');
    Button1.Click;
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '初始化失败,请联系管理员.');
  end;
end;

procedure TfrmTbM.Button3Click(Sender: TObject);
var
  exsql: string;
begin
  exsql := 'delete from ZZZZZZZZZ_UserTableRemark  where TB_Name not in (select name from sysobjects where xtype = ''U'')';

  if EXSQLClientDataSet(ClientDataSet11, exsql) then
  begin
    zsbSimpleMSNPopUpShow('is ok');
    Button1.Click;
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '初始化失败,请联系管理员.');
  end;
end;

end.

