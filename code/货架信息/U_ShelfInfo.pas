unit U_ShelfInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect;

type
  TF_ShelfInfo = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    ScrollBox1: TScrollBox;
    TabSheet2: TRzTabSheet;
    RzPanel99: TRzPanel;
    DBGridEh1: TDBGridEh;
    Timer2: TTimer;
    Image1: TImage;
    Panel3: TPanel;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Panel2: TPanel;
    Image2: TImage;
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    RzPanel1: TRzPanel;
    SpeedButton999: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton1: TSpeedButton;
    ClientDataSet10: TClientDataSet;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private  
    procedure CreateParams(var Params: TCreateParams);override;
    { Private declarations }
  public
    function EXSQLClientDataSet(ClientDataSet1: TClientDataSet; EXSQL: string): Boolean;
    function SelectClientDataSetResultCount(ClientDataSet1: TClientDataSet; strSQL: string): Integer;
    procedure SelectClientDataSet(ClientDataSet1: TClientDataSet; strSQL: string);
    
    { Public declarations }
  end;

var
  F_ShelfInfo: TF_ShelfInfo;

implementation

uses UDM, ZsbDLL2, ZsbFunPro2;

{$R *.dfm}


procedure TF_ShelfInfo.CreateParams(var Params: TCreateParams);  
begin  
  inherited;  
  Params.WndParent := 0; //重载 显示在任务栏 
end;

procedure TF_ShelfInfo.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_ShelfInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05
  Action := caFree;
end;

procedure TF_ShelfInfo.FormCreate(Sender: TObject);
begin
  Self.Top := 0;
  Self.Top := 0;
end;

procedure TF_ShelfInfo.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大   
end;

function TF_ShelfInfo.SelectClientDataSetResultCount(ClientDataSet1: TClientDataSet; strSQL: string): Integer;
begin
  with ClientDataSet1 do
  begin
    data := RemoteServer.AppServer.fun_getdatasql(strSQL);
  end;
  Result := ClientDataSet1.RecordCount;
end;

procedure TF_ShelfInfo.SelectClientDataSet(ClientDataSet1: TClientDataSet; strSQL: string);
begin
  with ClientDataSet1 do
  begin
    data := RemoteServer.AppServer.fun_getdatasql(strSQL);
  end;
end;

function TF_ShelfInfo.EXSQLClientDataSet(ClientDataSet1: TClientDataSet; EXSQL: string): Boolean;
var
  temp: string;
begin
  with ClientDataSet1 do
  begin
    temp := RemoteServer.AppServer.fun_peradd(EXSQL);
  end;
  if temp = 'false' then //返回的是字符串
  begin
    result := False;
  end
  else
  begin
    result := True;
  end;
end;

procedure TF_ShelfInfo.Timer1Timer(Sender: TObject);
var
  h: THandle;
  bit, bit2: TBitmap;
begin
  Timer1.Enabled := False;
  if FileExists(ExtractFilePath(Application.Exename) + 'BitBtnImageFormZsbDll2.dll') then
  begin
    h := LoadLibrary('BitBtnImageFormZsbDll2.dll'); //载入 DLL
    bit := TBitmap.Create;
    bit2 := TBitmap.Create;
    bit.LoadFromResourceName(h, 'imgLZtopForZhuiSuSYS2'); //提取资源
    bit2.LoadFromResourceName(h, 'imgSkyBlue'); //提取资源
    Image1.Picture.Assign(bit);
    Image2.Picture.Assign(bit2);
    FreeLibrary(h); //载卸 DLL
    bit.Free;
    bit2.Free;
  end;
  RzPageControl1.Visible := True;
  RzPageControl1.ActivePageIndex := 0;
end;

procedure TF_ShelfInfo.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled := False;
  try
    FDM := TFDM.Create(nil);
    FDM.RestartLink;//创建数据库连接
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
    SpeedButton999.Click;
  finally

  end;
end;

procedure TF_ShelfInfo.SpeedButton999Click(Sender: TObject);
var
  temp: string;
begin
  temp := 'select * from Shelf order by shefcode';
  SelectClientDataSet(ClientDataSet1, temp);
end;

procedure TF_ShelfInfo.SpeedButton1Click(Sender: TObject);
begin
  if ClientDataSet1.RecordCount = 0 then Exit;
  if ClientDataSet1.FieldByName('ShefCode').AsString = '' then Exit;
  RzPageControl1.ActivePageIndex := 1;
  LabeledEdit1.Text := ClientDataSet1.FieldByName('ShefCode').AsString;
  LabeledEdit1.ReadOnly := True;
  LabeledEdit2.Text := ClientDataSet1.FieldByName('ShefName').AsString;
  LabeledEdit3.Text := ClientDataSet1.FieldByName('Tips').AsString;
  CheckBox1.Checked := False;
  if ClientDataSet1.FieldByName('state').AsString = 'Y' then
  begin
    CheckBox1.Checked := True;
  end;
end;

procedure TF_ShelfInfo.Button2Click(Sender: TObject);
begin
  CheckBox1.Checked := False;
  LabeledEdit3.Text := '';
  LabeledEdit2.Text := '';
  LabeledEdit1.Text := '';
  LabeledEdit1.SetFocus;
  LabeledEdit1.ReadOnly := False;
end;

procedure TF_ShelfInfo.Button1Click(Sender: TObject);
var
  temp, temp1, exsql: string;
begin
  if LabeledEdit1.Text = '' then
  begin
    ShowInfoTips(LabeledEdit1.Handle, '请在这里输入货架编码噢.', 3);
    LabeledEdit1.SetFocus;
    Exit;
  end;
  if LabeledEdit2.Text = '' then
  begin
    ShowInfoTips(LabeledEdit2.Handle, '请在这里输入货架名称噢.', 3);
    LabeledEdit2.SetFocus;
    Exit;
  end;
  temp1 := 'N';
  if CheckBox1.Checked then
  begin
    temp1 := 'Y';
  end;
  if LabeledEdit1.ReadOnly = True then //修改
  begin
    temp := 'select id from Shelf where Shefname=''' + LabeledEdit2.Text + ''' and Shefcode<>''' + LabeledEdit1.Text + '''';
    if SelectClientDataSetResultCount(ClientDataSet10, temp) <> 0 then
    begin
      ZsbMsgErrorInfoNoApp(Self, '货架名称已存在,请重新输入');
      LabeledEdit1.SetFocus;
      Exit;
    end
    else
    begin
      exsql := 'update Shelf set Shefname=''' + LabeledEdit2.Text + ''',tips=''' + LabeledEdit3.Text +
        ''',state=''' + temp1 + ''' where Shefcode=''' + LabeledEdit1.Text + '''';
    end;
  end
  else
  begin //增加 
    temp := 'select id from Shelf where Shefname=''' + LabeledEdit2.Text + ''' or Shefcode=''' + LabeledEdit1.Text + '''';
    if SelectClientDataSetResultCount(ClientDataSet10, temp) <> 0 then
    begin
      ZsbMsgErrorInfoNoApp(Self, '仓库名称或编码已存在,请重新输入');
      LabeledEdit1.SetFocus;
      Exit;
    end
    else
    begin
      exsql := 'insert into Shelf(Shefcode,Shefname,tips,state)values(''' + LabeledEdit1.Text +
      ''',''' + LabeledEdit2.Text + ''',''' + LabeledEdit3.Text + ''',''' + temp1 + ''')';
    end;

  end;
  if exsql <> '' then
  begin
    if EXSQLClientDataSet(ClientDataSet10, exsql) then
    begin
      zsbSimpleMSNPopUpShow('操作成功！');
      SpeedButton999.Click;
      Button2.Click;
    end
    else
    begin
      ZsbMsgErrorInfoNoApp(Self, '对不起，操作失败！');
    end;
  end;
end;

end.

