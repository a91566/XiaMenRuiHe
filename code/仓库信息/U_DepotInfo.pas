unit U_DepotInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect;

type
  TF_DepotInfo = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    ScrollBox1: TScrollBox;
    TabSheet2: TRzTabSheet;
    RzPanel99: TRzPanel;
    DBGridEh1: TDBGridEh;
    RzPanel1: TRzPanel;
    SpeedButton999: TSpeedButton;
    Timer2: TTimer;
    SpeedButton3: TSpeedButton;
    Image1: TImage;
    Panel3: TPanel;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    Panel2: TPanel;
    Image2: TImage;
    Button1: TButton;
    Button2: TButton;
    SpeedButton1: TSpeedButton;
    CheckBox1: TCheckBox;
    ClientDataSet10: TClientDataSet;
    TabSheet3: TRzTabSheet;
    RzPanel2: TRzPanel;
    SpeedButton4: TSpeedButton;
    DBGridEh2: TDBGridEh;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    ClientDataSet11: TClientDataSet;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
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
  F_DepotInfo: TF_DepotInfo;

implementation

uses UDM, ZsbDLL2, ZsbFunPro2;

{$R *.dfm}

procedure TF_DepotInfo.CreateParams(var Params: TCreateParams);
begin  
  inherited;  
  Params.WndParent := 0; //重载 显示在任务栏 
end;

procedure TF_DepotInfo.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_DepotInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05
  Action := caFree;
end;

procedure TF_DepotInfo.FormCreate(Sender: TObject);
begin
  Self.Top := 0;
  Self.Top := 0;
end;

procedure TF_DepotInfo.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 500, AW_CENTER); //窗口由小变大   
end;

procedure TF_DepotInfo.SpeedButton999Click(Sender: TObject);
var
  temp: string;
begin
  temp := 'select * from Depot';
  SelectClientDataSet(ClientDataSet1, temp);
end;

function TF_DepotInfo.SelectClientDataSetResultCount(ClientDataSet1: TClientDataSet; strSQL: string): Integer;
begin
  with ClientDataSet1 do
  begin
    data := RemoteServer.AppServer.fun_getdatasql(strSQL);
  end;
  Result := ClientDataSet1.RecordCount;
end;

procedure TF_DepotInfo.SelectClientDataSet(ClientDataSet1: TClientDataSet; strSQL: string);
begin
  with ClientDataSet1 do
  begin
    data := RemoteServer.AppServer.fun_getdatasql(strSQL);
  end;
end;

function TF_DepotInfo.EXSQLClientDataSet(ClientDataSet1: TClientDataSet; EXSQL: string): Boolean;
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

procedure TF_DepotInfo.Timer1Timer(Sender: TObject);
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

procedure TF_DepotInfo.Timer2Timer(Sender: TObject);
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

procedure TF_DepotInfo.SpeedButton1Click(Sender: TObject);
begin
  if ClientDataSet1.RecordCount = 0 then Exit;
  if ClientDataSet1.FieldByName('DepotCode').AsString = '' then Exit;
  RzPageControl1.ActivePageIndex := 1;
  LabeledEdit1.Text := ClientDataSet1.FieldByName('DepotCode').AsString;
  LabeledEdit1.ReadOnly := True;
  LabeledEdit2.Text := ClientDataSet1.FieldByName('Depotname').AsString;
  LabeledEdit3.Text := ClientDataSet1.FieldByName('Tips').AsString;
  CheckBox1.Checked := False;
  if ClientDataSet1.FieldByName('state').AsString = 'Y' then
  begin
    CheckBox1.Checked := True;
  end;
end;

procedure TF_DepotInfo.Button1Click(Sender: TObject);
var
  temp, temp1, exsql: string;
begin
  if LabeledEdit1.Text = '' then
  begin
    ShowInfoTips(LabeledEdit1.Handle, '请在这里输入仓库编码噢.', 3);
    LabeledEdit1.SetFocus;
    Exit;
  end;
  if LabeledEdit2.Text = '' then
  begin
    ShowInfoTips(LabeledEdit2.Handle, '请在这里输入仓库名称噢.', 3);
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
    temp := 'select id from Depot where depotname=''' + LabeledEdit2.Text + ''' and depotcode<>''' + LabeledEdit1.Text + '''';
    if SelectClientDataSetResultCount(ClientDataSet10, temp) <> 0 then
    begin
      ZsbMsgErrorInfoNoBlack(Application, Self, '仓库名称已存在,请重新输入');
      LabeledEdit1.SetFocus;
      Exit;
    end
    else
    begin
      exsql := 'update Depot set depotname=''' + LabeledEdit2.Text + ''',tips=''' + LabeledEdit3.Text +
        ''',state=''' + temp1 + ''' where depotcode=''' + LabeledEdit1.Text + '''';
    end;
  end
  else
  begin //增加 
    temp := 'select id from Depot where depotname=''' + LabeledEdit2.Text + ''' or depotcode=''' + LabeledEdit1.Text + '''';
    if SelectClientDataSetResultCount(ClientDataSet10, temp) <> 0 then
    begin
      ZsbMsgErrorInfoNoBlack(Application, Self, '仓库名称或编码已存在,请重新输入');
      LabeledEdit1.SetFocus;
      Exit;
    end
    else
    begin
      exsql := 'insert into Depot(depotcode,depotname,tips,state)values(''' + LabeledEdit1.Text +
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
      ZsbMsgErrorInfoNoBlack(Application, Self, '对不起，操作失败！');
    end;
  end;
end;

procedure TF_DepotInfo.Button2Click(Sender: TObject);
begin
  CheckBox1.Checked := False;
  LabeledEdit3.Text := '';
  LabeledEdit2.Text := '';
  LabeledEdit1.Text := '';
  LabeledEdit1.SetFocus;
  LabeledEdit1.ReadOnly := False;
end;

procedure TF_DepotInfo.SpeedButton4Click(Sender: TObject);
var
  strSQL1: string;
begin
  with ClientDataSet10 do //连接其他数据库
  begin
    RemoteServer.AppServer.LinkHISData('1');
  end;
  strSQL1 := 'select WH,NAME,REM from MY_WH';
  with ClientDataSet2 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strSQL1);
  end;
end;

procedure TF_DepotInfo.SpeedButton3Click(Sender: TObject);
var
  exsql, strSuprType: string;
  iCount, iTime: SmallInt; //每10条执行一次。执行次数
begin
  if ClientDataSet2.Data = null then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据,可能没有初始化.');
    Exit;
  end;
  if ClientDataSet2.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据,可能没有初始化.');
    Exit;
  end;
  exsql := '';
  iTime := 0;
  iCount := 0;
  ClientDataSet2.First;
  with ClientDataSet2 do
  begin
    while not eof do
    begin
      if not ClientDataSet1.Locate('depotcode', FieldByName('WH').AsString, []) then
      begin
        iCount := iCount + 1;
      end;
      Next;
    end;
  end;
  if iCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据.');
    Exit;
  end;
  if ZsbMsgBoxOkNoBlack(Application, Self, '共有' + inttostr(iCount) + '条记录需要同步.确认操作么？') = False then Exit;
  iCount := 0;
  with ClientDataSet2 do
  begin
    First;
    while not Eof do
    begin
      if not ClientDataSet1.Locate('depotcode', FieldByName('WH').AsString, []) then
      begin
        exsql := exsql +'insert into Depot(depotcode,depotname,tips,state)values(''' + FieldByName('WH').AsString +
        ''',''' + FieldByName('NAME').AsString + ''',''' + FieldByName('REM').AsString + ''',''Y'')';                                                                                                          // ,ShefCode  ERP没有货架
        iCount := iCount + 1;
        if iCount = 11 then //50条执行一次
        begin
          if exsql <> '' then
          begin
            if EXSQLClientDataSet(ClientDataSet11, exsql) then
            begin
              iTime := iTime + 1;
              iCount := 0;
              exsql := '';
            end
            else
            begin
              ZsbMsgErrorInfoNoBlack(Application, Self, '对不起，此次操作失败,将进行下一个循环！');
              SaveMessage(exsql, 'sql');
              iCount := 0;
              exsql := '';
              Break;
            end;
          end;
        end;
      end;
      ClientDataSet2.Next;
    end;
  end;
  PleaseWait(1);
  if exsql <> '' then
  begin
    if EXSQLClientDataSet(ClientDataSet11, exsql) then //最后一次
    begin
      iTime := iTime + 1;
      exsql := '';
    end
    else
    begin
      ZsbMsgErrorInfoNoBlack(Application, Self, '对不起，操作失败！');
      SaveMessage(exsql, 'sql');
    end;
  end;
  if iTime > 0 then
  begin
    iCount := (iTime - 1) * 10 + iCount;
    MSNPopUpShow('操作成功,共处理数据' + inttostr(iCount) + '条！');
    SpeedButton999.Click;
  end;
end;

end.

