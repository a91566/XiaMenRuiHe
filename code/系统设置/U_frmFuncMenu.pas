unit U_frmFuncMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, DBClient, StdCtrls, Grids, DBGridEh, RzPanel,
  RzTabs, StrUtils, ComCtrls, Menus;

type
  TfrmFuncMenu = class(TForm)
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
    OpenDialog1: TOpenDialog;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    RzPanel1: TRzPanel;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    Button12: TButton;
    Button2: TButton;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    Label1: TLabel;
    ComboBox1: TComboBox;
    LabeledEdit8: TLabeledEdit;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1DblClick(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public
    { Public declarations }
  end;

const
  cReadMe = 'DLL 版本管理,功能说明:' +
    #13 + #10 + '存储程序中各个DLL的版本号.' +
    #13 + #10 + '针对于PDA不同的版本可以在客户端给出提醒，双击列【其他版本可用】即可转换值（只针对与PDA）.' +
    #13 + #10 + #13 + #10 + '2014年11月21日 11:46:33 郑少宝';

var
  frmFuncMenu: TfrmFuncMenu;

implementation

uses ZsbFunPro2, ZsbDLL2, ZsbVariable2;

{$R *.dfm}

function MakeFileList(Path, FileExt: string; bPathName: Boolean): TStringList;
var //是否完整路径
  sch: TSearchrec;
begin
  Result := TStringlist.Create;
  if rightStr(trim(Path), 1) <> '\' then
    Path := trim(Path) + '\'
  else
    Path := trim(Path);
  if not DirectoryExists(Path) then
  begin
    Result.Clear;
    exit;
  end;
  if FindFirst(Path + '*', faAnyfile, sch) = 0 then
  begin
    repeat
      Application.ProcessMessages;
      if ((sch.Name = '.') or (sch.Name = '..')) then Continue;
      if DirectoryExists(Path + sch.Name) then
      begin
        Result.AddStrings(MakeFileList(Path + sch.Name, FileExt, bPathName));
      end
      else
      begin
        if (UpperCase(extractfileext(Path + sch.Name)) = UpperCase(FileExt)) or (FileExt = '.*') then
        begin
          if bPathName then
          begin
            Result.Add(Path + sch.Name);
          end
          else
          begin
            Result.Add(sch.Name);
          end;
        end;
      end;
    until FindNext(sch) <> 0;
    SysUtils.FindClose(sch);
  end;
end;

procedure TfrmFuncMenu.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;



procedure TfrmFuncMenu.Button1Click(Sender: TObject);
var
  strsql: string;
begin
  strsql := 'select * from FuncMenu where 1=1';
  if labelededit1.text <> '' then
  begin
    strsql := strsql + ' and FuncCode like ''%' + labelededit1.text + '%''';
  end;
  if labelededit2.text <> '' then
  begin
    strsql := strsql + ' and FuncName like ''%' + labelededit2.text + '%''';
  end;
  if labelededit8.text <> '' then
  begin
    strsql := strsql + ' and FuncParent=''' + labelededit8.text + '''';
  end;
  if (CheckBox1.Checked = True) and (CheckBox2.Checked = False) then
  begin
    strsql := strsql + ' and FuncType=''PC''';
  end;
  if (CheckBox2.Checked = True) and (CheckBox1.Checked = False) then
  begin
    strsql := strsql + ' and FuncType=''PDA''';
  end;

  strsql := strsql + ' order by FuncType,FuncCode';
  SelectClientDataSet(ClientDataSet1, strsql);
  if Button4.Tag>0 then
  begin
    ClientDataSet1.Locate('id',Button4.Tag,[]);
  end;
end;


procedure TfrmFuncMenu.Timer1Timer(Sender: TObject);
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

procedure TfrmFuncMenu.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
end;

procedure TfrmFuncMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;




procedure TfrmFuncMenu.Image1DblClick(Sender: TObject);
begin
  ZsbShowMessageNoApp(Self, cReadMe);
end;




procedure TfrmFuncMenu.DBGridEh1DblClick(Sender: TObject);
begin
  Button4.Click;
end;

procedure TfrmFuncMenu.Button2Click(Sender: TObject);
var
  exsql: string;
begin
  if Button2.Tag = 0 then
  begin
    exsql := 'insert into FuncMenu(FuncCode,FuncName,FuncParent,FuncIndex,ButtonName,FuncType) values(''' + LabeledEdit3.Text +
      ''',''' + LabeledEdit4.Text + ''',''' + LabeledEdit5.Text + ''',''' + LabeledEdit6.Text +
      ''',''' + LabeledEdit7.Text + ''',''' + ComboBox1.Text + ''');';
  end
  else
  begin
    exsql:='update FuncMenu set FuncCode='''+LabeledEdit3.Text+''',FuncName=''' + LabeledEdit4.Text +
    ''',FuncParent=''' + LabeledEdit5.Text + ''',FuncIndex=''' + LabeledEdit6.Text + ''',ButtonName=''' + LabeledEdit7.Text +
    ''',FuncType='''+ComboBox1.Text+'''  where id='''+inttostr(Button4.Tag)+'''';
  end;
  if EXSQLClientDataSet(ClientDataSet11, exsql) then
  begin
    zsbSimpleMSNPopUpShow('is ok');  
    Button1.Click;
    Button12.Click;
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '操作失败,请联系管理员.');
  end;
end;

procedure TfrmFuncMenu.Button3Click(Sender: TObject);
begin
  RzPanel1.Visible := True;
  RzPanel3.Visible := False;
  label2.Caption:='新增';
  button2.Tag := 0;
end;

procedure TfrmFuncMenu.Button4Click(Sender: TObject);
begin
  if (ClientDataSet1.RecordCount=0) or (ClientDataSet1.fieldByName('ID').AsInteger=0) then
  begin
    ZsbShowMessageNoApp(Self,'没有可操作的数据.');
    Exit;
  end;
  Button4.Tag:=ClientDataSet1.fieldByName('ID').AsInteger;
  LabeledEdit3.Text:=ClientDataSet1.fieldByName('FuncCode').AsString;
  LabeledEdit4.Text:=ClientDataSet1.fieldByName('FuncName').AsString;
  LabeledEdit5.Text:=ClientDataSet1.fieldByName('FuncParent').AsString;
  LabeledEdit6.Text:=ClientDataSet1.fieldByName('FuncIndex').AsString;
  LabeledEdit7.Text:=ClientDataSet1.fieldByName('BUttonName').AsString;
  ComboBox1.ItemIndex:=ComboBox1.Items.IndexOf(ClientDataSet1.fieldByName('FuncType').AsString);
  DBGridEh1.Enabled:=False;
  RzPanel1.Visible := True;  
  RzPanel3.Visible := False; 
  label2.Caption:='修改';
  button2.Tag := 1;
end;

procedure TfrmFuncMenu.Button12Click(Sender: TObject);
begin
  RzPanel1.Visible := False;
  RzPanel3.Visible := True;
  DBGridEh1.Enabled:=True;
  button2.Tag := 0;
  Button4.Tag:=0;
end;

procedure TfrmFuncMenu.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if ClientDataSet1.FieldByName('ID').AsInteger = Button4.Tag then
  begin
    DBGridEh1.Canvas.Brush.Color := clYellow;
    DBGridEh1.Canvas.Font.Color := clRed;
    DBGridEh1.Canvas.Font.Style := [fsBold];
    DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

end.

