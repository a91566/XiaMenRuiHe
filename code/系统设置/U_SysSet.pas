unit U_SysSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  ComCtrls;

type
  TF_SysSet = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    Timer2: TTimer;
    Image1: TImage;
    TabSheet2: TRzTabSheet;
    RzPanel2: TRzPanel;
    SpeedButton1: TSpeedButton;
    Memo1: TMemo;
    TabSheet3: TRzTabSheet;
    ClientDataSet10: TClientDataSet;
    Memo2: TMemo;
    RzPanel3: TRzPanel;
    SpeedButton2: TSpeedButton;
    RzPanel1: TRzPanel;
    SpeedButton999: TSpeedButton;
    RzPanel4: TRzPanel;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    GroupBox1: TGroupBox;
    CheckBox3: TCheckBox;
    Label1: TLabel;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    ClientDataSet3: TClientDataSet;
    ClientDataSet4: TClientDataSet;
    DataSource4: TDataSource;
    GroupBox2: TGroupBox;
    Label10: TLabel;
    CheckBox4: TCheckBox;
    TabSheet8: TRzTabSheet;
    RzPageControl2: TRzPageControl;
    RzTabSheet4: TRzTabSheet;
    RzTabSheet5: TRzTabSheet;
    RzTabSheet6: TRzTabSheet;
    RzTabSheet7: TRzTabSheet;
    RzPanel5: TRzPanel;
    SpeedButton3: TSpeedButton;
    Label7: TLabel;
    Label8: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DateTimePicker3: TDateTimePicker;
    DateTimePicker4: TDateTimePicker;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    DBGridEh1: TDBGridEh;
    DBGridEh2: TDBGridEh;
    DBGridEh3: TDBGridEh;
    DBGridEh4: TDBGridEh;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    RzPanel6: TRzPanel;
    Button1: TButton;
    Button2: TButton;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Edit1: TEdit;
    CheckBox5: TCheckBox;
    TabSheet4: TRzTabSheet;
    RzPanel7: TRzPanel;
    SpeedButton6: TSpeedButton;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Button3: TButton;
    SpeedButton7: TSpeedButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh3DblClick(Sender: TObject);
    procedure DBGridEh4DblClick(Sender: TObject);
    procedure RzPageControl1Change(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
  private
    booInit0, booInit1, booInit2: Boolean; //每个界面的初始化状态
    procedure CreateParams(var Params: TCreateParams); override;
    procedure LoadCheckBox3;
    procedure LoadCheckBox4;
    procedure LoadEdit1;
    { Private declarations }
  public
    procedure SelectLogInfo(iType: SmallInt);
    { Public declarations }
  end;

var
  F_SysSet: TF_SysSet;
function ShowConfidentialAuthorization(var App: TApplication): Boolean; stdcall; external 'ConfidentialAuthorization.dll';
function ShowConfidentialAuthorization_Set(var App: TApplication): Boolean; stdcall; external 'ConfidentialAuthorization.dll';

implementation

uses UDM, ZsbFunPro2, ZsbDLL2, U_frmTbM, U_frmDLLVER, U_frmFuncMenu,
  U_frmScaner;

{$R *.dfm}

procedure TF_SysSet.SelectLogInfo(iType: SmallInt);
var
  strsql, temp1, temp2: string;
begin
  temp1 := FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date) + ' ' + FormatDateTime('HH:mm:ss', DateTimePicker3.Date);
  temp2 := FormatDateTime('yyyy-MM-dd', DateTimePicker2.Date) + ' ' + FormatDateTime('HH:mm:ss', DateTimePicker4.Date);
  if iType = 1 then
  begin
    if ClientDataSet1.Tag = 1 then Exit;
    strsql := 'select * from Log_ExSQLText where OpeeDT>=''' + temp1 + ''' and OpeeDT<=''' + temp2 + '''';
    if LabeledEdit1.Text <> '' then
    begin
      strsql := strsql + ' and UserName like ''%' + LabeledEdit1.Text + '%''';
    end;
    if LabeledEdit2.Text <> '' then
    begin
      strsql := strsql + ' and SQLText like ''%' + LabeledEdit2.Text + '%''';
    end;
    strsql := strsql + ' order by id desc';
    SelectClientDataSet(ClientDataSet1, strsql);
    ClientDataSet1.Tag := 1;
  end
  else if iType = 2 then
  begin
    if ClientDataSet2.Tag = 1 then Exit;
    strsql := 'select * from Log_Exception where edt>=''' + temp1 + ''' and edt<=''' + temp2 + '''';
    if LabeledEdit1.Text <> '' then
    begin
      strsql := strsql + ' and un like ''%' + LabeledEdit1.Text + '%''';
    end;
    if LabeledEdit2.Text <> '' then
    begin
      strsql := strsql + ' and emessage like ''%' + LabeledEdit2.Text + '%''';
    end;
    strsql := strsql + ' order by id desc';
    SelectClientDataSet(ClientDataSet2, strsql);
    ClientDataSet2.Tag := 1;
  end
  else if iType = 3 then
  begin
    if ClientDataSet3.Tag = 1 then Exit;
    strsql := 'select * from Log_Operation where dt>=''' + temp1 + ''' and dt<=''' + temp2 + '''';
    if LabeledEdit1.Text <> '' then
    begin
      strsql := strsql + ' and un like ''%' + LabeledEdit1.Text + '%''';
    end;
    if LabeledEdit2.Text <> '' then
    begin
      strsql := strsql + ' and Text like ''%' + LabeledEdit2.Text + '%''';
    end;
    strsql := strsql + ' order by id desc';
    SelectClientDataSet(ClientDataSet3, strsql);
    ClientDataSet3.Tag := 1;
  end
  else if iType = 4 then
  begin
    if ClientDataSet4.Tag = 1 then Exit;
    strsql := 'select * from Log_ErrorText where dt>=''' + temp1 + ''' and dt<=''' + temp2 + '''';
    if LabeledEdit1.Text <> '' then
    begin
      strsql := strsql + ' and un like ''%' + LabeledEdit1.Text + '%''';
    end;
    if LabeledEdit2.Text <> '' then
    begin
      strsql := strsql + ' and Text like ''%' + LabeledEdit2.Text + '%''';
    end;
    strsql := strsql + ' order by id desc';
    SelectClientDataSet(ClientDataSet4, strsql);
    ClientDataSet4.tag := 1;
  end;
end;

procedure TF_SysSet.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_SysSet.LoadCheckBox3;
var
  strsql: string;
begin
  strsql := 'select id from SysSomeSet where iName=''NewVerUpdate'' and iValue=''Y''';
  if SelectClientDataSetResultCount(ClientDataSet10, strsql) = 0 then
  begin
    CheckBox3.Checked := False;
  end
  else
  begin
    CheckBox3.Checked := True;
  end;

  strsql := 'select id from SysSomeSet where iName=''NewVerUpdatePDA'' and iValue=''Y''';
  if SelectClientDataSetResultCount(ClientDataSet10, strsql) = 0 then
  begin
    CheckBox5.Checked := False;
  end
  else
  begin
    CheckBox5.Checked := True;
  end;
end;

procedure TF_SysSet.LoadCheckBox4;
var
  strsql: string;
begin
  strsql := 'select id from SysSomeSet where iName=''FormatLastBarCode'' and iValue=''Y''';
  if SelectClientDataSetResultCount(ClientDataSet10, strsql) = 0 then
  begin
    CheckBox4.Checked := False;
  end
  else
  begin
    CheckBox4.Checked := True;
  end;
end;

procedure TF_SysSet.LoadEdit1;
var
  strsql: string;
begin
  strsql := 'select iValue from SysSomeSet where iName=''OtherDataBaseName''';
  Edit1.Text := SelectClientDataSetResultFieldCaption(ClientDataSet10, strsql, 'iValue');
end;

procedure TF_SysSet.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_SysSet.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05
  Action := caFree;
end;

procedure TF_SysSet.FormCreate(Sender: TObject);
begin
  Self.Top := 0;
  Self.Top := 0;
end;

procedure TF_SysSet.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
  booInit1 := False;
  booInit2 := False;
  booInit0 := False;
end;

procedure TF_SysSet.Timer1Timer(Sender: TObject);
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

procedure TF_SysSet.Timer2Timer(Sender: TObject);
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
    DateTimePicker1.Date := StrToDate(FormatDateTime('yyyy-mm-dd', Now() - 1));
    DateTimePicker2.Date := StrToDate(FormatDateTime('yyyy-mm-dd', Now));
    SpeedButton999.Click;
    //ShowMessage(GetModuleFileName);
  finally

  end;
end;

procedure TF_SysSet.SpeedButton2Click(Sender: TObject);
var
  exsql: string;
begin
  if isSuprAdmin = False then
  begin
    zsbSimpleMSNPopUpShow('操作受限.');
    Exit;
  end;
  if Memo2.Text = '' then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据.');
    Exit;
  end;
  if ShowConfidentialAuthorization(Application) = False then
  begin
    zsbSimpleMSNPopUpShow_2('YOU CAN NOT DO IT');
    Exit;
  end;
  exsql := Memo2.Lines.Text;
  if exsql <> '' then
  begin
    if EXSQLClientDataSet(ClientDataSet10, exsql) then
    begin
      zsbSimpleMSNPopUpShow('操作成功！');
    end
    else
    begin
      ZsbMsgErrorInfoNoApp(Self, '对不起，操作失败！');
    end;
  end;
end;

procedure TF_SysSet.SpeedButton3Click(Sender: TObject);
begin
  SelectLogInfo(RzPageControl2.ActivePageIndex + 1);
end;

procedure TF_SysSet.DBGridEh1DblClick(Sender: TObject);
var
  SHOW: string;
begin
  SHOW := '【' + ClientDataSet1.FieldByName('username').AsString + '】【';
  SHOW := SHOW + ClientDataSet1.FieldByName('opeedt').AsString + '】' + #13 + #10 + #13 + #10;
  SHOW := SHOW + ClientDataSet1.FieldByName('SqlText').AsString;
  ZsbShowMessageNoApp(Self, SHOW);
end;

procedure TF_SysSet.DBGridEh2DblClick(Sender: TObject);
var
  SHOW: string;
begin
  SHOW := '【' + ClientDataSet2.FieldByName('un').AsString + '】【';
  SHOW := SHOW + ClientDataSet2.FieldByName('edt').AsString + '】【';
  SHOW := SHOW + ClientDataSet2.FieldByName('esender').AsString + '】' + #13 + #10 + #13 + #10;
  SHOW := SHOW + ClientDataSet2.FieldByName('emessage').AsString;
  ZsbShowMessageNoApp(Self, SHOW);
end;

procedure TF_SysSet.DBGridEh3DblClick(Sender: TObject);
var
  SHOW: string;
begin
  SHOW := '【' + ClientDataSet3.FieldByName('un').AsString + '】【';
  SHOW := SHOW + ClientDataSet3.FieldByName('dt').AsString + '】' + #13 + #10 + #13 + #10;
  SHOW := SHOW + ClientDataSet3.FieldByName('Text').AsString;
  ZsbShowMessageNoApp(Self, SHOW);
end;

procedure TF_SysSet.DBGridEh4DblClick(Sender: TObject);
var
  SHOW: string;
begin
  SHOW := '【' + ClientDataSet4.FieldByName('un').AsString + '】【';
  SHOW := SHOW + ClientDataSet4.FieldByName('dt').AsString + '】' + #13 + #10 + #13 + #10;
  SHOW := SHOW + ClientDataSet4.FieldByName('Text').AsString;
  ZsbShowMessageNoApp(Self, SHOW);
end;

procedure TF_SysSet.RzPageControl1Change(Sender: TObject);
begin
  if RzPageControl1.ActivePageIndex = 0 then
  begin
    if booInit0 = False then
    begin

      booInit0 := True;
    end;
  end
  else if RzPageControl1.ActivePageIndex = 1 then
  begin
    if booInit1 = False then
    begin
      if SelectClientDataSetResultCount(ClientDataSet10, 'select Tips from InitInfo where id=1') = 0 then
      begin
        if EXSQLClientDataSet(ClientDataSet10, 'insert into InitInfo(id)values(''1'')') = False then
        begin
          ZsbMsgErrorInfoNoApp(Self, '初始化失败,请联系管理员.');
        end;
      end
      else
      begin
        Memo1.Text := SelectClientDataSetResultFieldCaption(ClientDataSet10, 'select Tips from InitInfo where id=1', 'Tips');
      end;
      booInit1 := True;
    end;
  end
  else if RzPageControl1.ActivePageIndex = 2 then
  begin
    if booInit2 = False then
    begin
      booInit2 := True;
    end;
  end;
end;

procedure TF_SysSet.LabeledEdit1Change(Sender: TObject);
begin
  ClientDataSet1.Tag := 0;
  ClientDataSet2.Tag := 0;
  ClientDataSet3.Tag := 0;
  ClientDataSet4.Tag := 0;
  SpeedButton3.Click;
end;

procedure TF_SysSet.SpeedButton999Click(Sender: TObject);
begin
  LoadCheckBox3;
  LoadCheckBox4;
  LoadEdit1;
end;

procedure TF_SysSet.SpeedButton4Click(Sender: TObject);
begin
  if isSuprAdmin = False then
  begin
    zsbSimpleMSNPopUpShow_2('没有操作权限', clRed);
    SpeedButton4.Enabled := False;
    Exit;
  end;
  if Application.FindComponent('frmTbM') = nil then
  begin
    Application.CreateForm(TfrmTbM, frmTbM);
  end;
  frmTbM.Show;
end;

procedure TF_SysSet.Button1Click(Sender: TObject);
begin
  ShowConfidentialAuthorization_Set(Application);
end;

procedure TF_SysSet.Button2Click(Sender: TObject);
begin
  if ShowConfidentialAuthorization(Application) = False then
  begin
    zsbSimpleMSNPopUpShow_2('YOU CAN NOT DO IT');
    Exit;
  end;
  if EXSQLClientDataSet(ClientDataSet10, 'update US set Vv=0 where id=1') = False then
  begin
    zsbSimpleMSNPopUpShow_2('false', clRed);
  end
  else
  begin
    zsbSimpleMSNPopUpShow('OK');
  end;
end;

procedure TF_SysSet.Label1Click(Sender: TObject);
var
  exsql, temp: string;
begin
  if SelectClientDataSetResultCount(ClientDataSet10, 'select id from SysSomeSet where iName=''NewVerUpdate''') = 0 then
  begin
    exsql := 'insert into SysSomeSet(iName,iValue,dt) values (''NewVerUpdate'',''' + temp +
      ''',''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) + ''')';
  end
  else
  begin
    temp := 'N';
    if CheckBox3.Checked then
    begin
      temp := 'Y';
    end;
    exsql := 'update SysSomeSet set iValue=''' + temp + ''',dt=''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) + ''' where iName=''NewVerUpdate'';';
  end;

  if SelectClientDataSetResultCount(ClientDataSet10, 'select id from SysSomeSet where iName=''NewVerUpdatePDA''') = 0 then
  begin
    exsql := 'insert into SysSomeSet(iName,iValue,dt) values (''NewVerUpdatePDA'',''' + temp +
      ''',''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) + ''')';
  end
  else
  begin  
    temp := 'N';
    if CheckBox5.Checked then
    begin
      temp := 'Y';
    end;
    exsql := exsql+'update SysSomeSet set iValue=''' + temp + ''',dt=''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) + ''' where iName=''NewVerUpdatePDA'';';
  end;

  if EXSQLClientDataSet(ClientDataSet10, exsql) then
  begin
    zsbSimpleMSNPopUpShow('设置已保存.');
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '对不起，操作失败！');
  end;
end;

procedure TF_SysSet.Label2Click(Sender: TObject);
var
  exsql: string;
begin
  if SelectClientDataSetResultCount(ClientDataSet10, 'select id from SysSomeSet where iName=''OtherDataBaseName''') = 0 then
  begin
    exsql := 'insert into SysSomeSet(iName,iValue,dt) values (''OtherDataBaseName'',''' + Edit1.Text +
      ''',''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) + ''')';
  end
  else
  begin
    exsql := 'update SysSomeSet set iValue=''' + Edit1.Text + ''',dt=''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) +
      ''' where iName=''OtherDataBaseName''';
  end;
  if EXSQLClientDataSet(ClientDataSet10, exsql) then
  begin
    zsbSimpleMSNPopUpShow('设置已保存.');
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '对不起，操作失败！');
  end;
end;

procedure TF_SysSet.SpeedButton1Click(Sender: TObject);
var
  exsql: string;
begin
  if Memo2.Text = '' then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据.');
    Exit;
  end;
  if ShowConfidentialAuthorization(Application) = False then
  begin
    zsbSimpleMSNPopUpShow_2('YOU CAN NOT DO IT');
    Exit;
  end;
  exsql := 'update InitInfo set Tips=''' + Memo1.Text + ''' where id=1';
  if exsql <> '' then
  begin
    if EXSQLClientDataSet(ClientDataSet10, exsql) then
    begin
      zsbSimpleMSNPopUpShow('操作成功！');
    end
    else
    begin
      ZsbMsgErrorInfoNoApp(Self, '对不起，操作失败！');
    end;
  end;
end;

procedure TF_SysSet.SpeedButton6Click(Sender: TObject);
var
  exsql:string;
begin
  if isSuprAdmin=False then Exit;
  if ZsbMsgBoxOkNoApp(Self,'Are you sure ?')=False then Exit;
  exsql:='delete from MatlInDepotMx where MatlCode='''+Edit2.Text+'''';
  if EXSQLClientDataSet(ClientDataSet10,exsql)=False then
  begin
    ZsbMsgErrorInfoNoApp(Self,'删除失败');
  end
  else
  begin
    zsbSimpleMSNPopUpShow_2('is ok');
    AddLog_Operation('删除原料入库信息，料号:'+Edit2.Text);
  end;
end;

procedure TF_SysSet.Button3Click(Sender: TObject);
begin
  if isSuprAdmin = False then
  begin
    zsbSimpleMSNPopUpShow_2('没有操作权限', clRed);
    Button3.Enabled := False;
    Exit;
  end;
  if Application.FindComponent('frmFuncMenu') = nil then
  begin
    Application.CreateForm(TfrmFuncMenu, frmFuncMenu);
  end;
  frmFuncMenu.Show;
end;

procedure TF_SysSet.SpeedButton5Click(Sender: TObject);
begin
  if isSuprAdmin = False then
  begin
    zsbSimpleMSNPopUpShow_2('没有操作权限', clRed);
    SpeedButton5.Enabled := False;
    Exit;
  end;
  if Application.FindComponent('frmDLLVer') = nil then
  begin
    Application.CreateForm(TfrmDLLVer, frmDLLVer);
  end;
  frmDLLVer.Show;
end;

procedure TF_SysSet.SpeedButton7Click(Sender: TObject);
begin
  if isSuprAdmin = False then
  begin
    zsbSimpleMSNPopUpShow_2('没有操作权限', clRed);
    SpeedButton7.Enabled := False;
    Exit;
  end;
  if Application.FindComponent('frmScaner') = nil then
  begin
    Application.CreateForm(TfrmScaner, frmScaner);
  end;
  frmScaner.Show;
end;

end.

