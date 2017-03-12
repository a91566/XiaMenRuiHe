unit U_SupplierInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect;

type
  TF_SupplierInfo = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    Timer2: TTimer;
    Image1: TImage;
    Panel3: TPanel;
    Image2: TImage;
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    Label1: TLabel;
    ComboBox2: TComboBox;
    CheckBox1: TCheckBox;
    ClientDataSet10: TClientDataSet;
    TabSheet3: TRzTabSheet;
    DBGridEh2: TDBGridEh;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    ClientDataSet3: TClientDataSet;
    RzPanel2: TRzPanel;
    SpeedButton1: TSpeedButton;
    RzPanel1: TRzPanel;
    RzLabel_1: TRzLabel;
    Label990: TLabel;
    SpeedButton999: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    DBComboBoxEh1: TDBComboBoxEh;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    DBGridEh1: TDBGridEh;
    ClientDataSet11: TClientDataSet;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public
    function EXSQLClientDataSet(ClientDataSet1: TClientDataSet; EXSQL: string): Boolean;
    function SelectClientDataSetResultCount(ClientDataSet1: TClientDataSet; strSQL: string): Integer;
    procedure SelectClientDataSet(ClientDataSet1: TClientDataSet; strSQL: string);

    { Public declarations }
  end;

var
  F_SupplierInfo: TF_SupplierInfo;

implementation

uses UDM, ZsbDLL2, ZsbFunPro2;

{$R *.dfm}

procedure TF_SupplierInfo.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_SupplierInfo.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_SupplierInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05
  Action := caFree;
end;

procedure TF_SupplierInfo.FormCreate(Sender: TObject);
begin
  Self.Top := 0;
  Self.Top := 0;
end;

procedure TF_SupplierInfo.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 500, AW_CENTER); //窗口由小变大
end;

function TF_SupplierInfo.SelectClientDataSetResultCount(ClientDataSet1: TClientDataSet; strSQL: string): Integer;
begin
  with ClientDataSet1 do
  begin
    data := RemoteServer.AppServer.fun_getdatasql(strSQL);
  end;
  Result := ClientDataSet1.RecordCount;
end;

procedure TF_SupplierInfo.SelectClientDataSet(ClientDataSet1: TClientDataSet; strSQL: string);
begin
  with ClientDataSet1 do
  begin
    data := RemoteServer.AppServer.fun_getdatasql(strSQL);
  end;
end;

function TF_SupplierInfo.EXSQLClientDataSet(ClientDataSet1: TClientDataSet; EXSQL: string): Boolean;
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

procedure TF_SupplierInfo.Timer1Timer(Sender: TObject);
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

procedure TF_SupplierInfo.Timer2Timer(Sender: TObject);
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
    SpeedButton999.Click;
  finally

  end;
end;

procedure TF_SupplierInfo.Button1Click(Sender: TObject);
var
  strstate, temp, exsql: string;
begin
  if LabeledEdit1.Text = '' then
  begin
    ShowInfoTips(LabeledEdit1.Handle, '请在这里输入客户编号噢.', 3);
    LabeledEdit1.SetFocus;
    Exit;
  end;
  if LabeledEdit2.Text = '' then
  begin
    ShowInfoTips(LabeledEdit2.Handle, '请在这里输入客户名称噢.', 3);
    LabeledEdit2.SetFocus;
    Exit;
  end;
  if ComboBox2.Text = '' then
  begin
    ShowInfoTips(ComboBox2.Handle, '请在这里选择客户类别噢.', 3);
    ComboBox2.SetFocus;
    Exit;
  end;
  strstate := 'N';
  if CheckBox1.Checked then
  begin
    strstate := 'Y';
  end;
  if LabeledEdit1.ReadOnly = True then //修改
  begin
    temp := 'select id from supplier where SuprCode<>''' + LabeledEdit1.Text + ''' and SuprName=''' + LabeledEdit2.Text + ''' ';
    if SelectClientDataSetResultCount(ClientDataSet10, temp) <> 0 then
    begin
      ZsbMsgErrorInfoNoApp(Self, '客户名称已存在,请重新输入');
      LabeledEdit2.SetFocus;
      Exit;
    end
    else
    begin
      exsql := 'update supplier set SuprName=''' + LabeledEdit2.Text + ''',SuprType=''' + ComboBox2.Text +
        ''',SuprFax=''' + LabeledEdit3.Text + ''',SuprTel=''' + LabeledEdit4.Text + ''',SuprAddress=''' + LabeledEdit5.Text +
        ''',state=''' + strstate + ''' where SuprCode=''' + LabeledEdit1.Text + '''';
    end;
  end
  else
  begin //增加
    temp := 'select id from supplier where SuprCode=''' + LabeledEdit1.Text + '''';
    if SelectClientDataSetResultCount(ClientDataSet10, temp) <> 0 then
    begin
      ZsbMsgErrorInfoNoApp(Self, '客户代号已存在,请重新输入');
      LabeledEdit1.SetFocus;
      Exit;
    end
    else
    begin
      exsql := 'insert into supplier(SuprCode,SuprName,SuprType,SuprFax,SuprTel,SuprAddress,state)values(''' + LabeledEdit1.Text +
        ''',''' + LabeledEdit2.Text + ''',''' + ComboBox2.Text + ''',''' + LabeledEdit3.Text + ''',''' + LabeledEdit4.Text +
        ''',''' + LabeledEdit5.Text + ''',''' + strstate + ''')';
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

procedure TF_SupplierInfo.Button2Click(Sender: TObject);
begin
  ComboBox2.ItemIndex := -1;
  LabeledEdit5.Text := '';
  LabeledEdit4.Text := '';
  LabeledEdit3.Text := '';
  LabeledEdit2.Text := '';
  LabeledEdit1.Text := '';
  LabeledEdit1.SetFocus;
  LabeledEdit1.ReadOnly := False;
end;

procedure TF_SupplierInfo.SpeedButton2Click(Sender: TObject);
begin
  if ClientDataSet1.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据.');
    Exit;
  end;
  if ClientDataSet1.FieldByName('SuprCode').AsString = '' then Exit;
  RzPageControl1.ActivePageIndex := 1;
  LabeledEdit1.Text := ClientDataSet1.FieldByName('SuprCode').AsString;
  LabeledEdit1.ReadOnly := True;
  LabeledEdit2.Text := ClientDataSet1.FieldByName('SuprName').AsString;
  LabeledEdit3.Text := ClientDataSet1.FieldByName('SuprFax').AsString;
  LabeledEdit4.Text := ClientDataSet1.FieldByName('SuprTel').AsString;
  LabeledEdit5.Text := ClientDataSet1.FieldByName('SuprAddress').AsString;
  ComboBox2.ItemIndex := ComboBox2.Items.IndexOf(ClientDataSet1.FieldByName('SUprType').AsString);

  CheckBox1.Checked := True;
  if ClientDataSet1.FieldByName('state').AsString = 'N' then
  begin
    CheckBox1.Checked := False;
  end;
end;

procedure TF_SupplierInfo.SpeedButton999Click(Sender: TObject);
var
  temp: string;
begin
  temp := 'select * from Supplier where 1=1 ';
  if DBComboBoxEh1.ItemIndex >= 0 then
  begin
    temp := temp + 'and ' + DBComboBoxEh1.KeyItems.Strings[DBComboBoxEh1.itemindex] + ' like ''%' + trim(Edit1.Text) + '%''';
  end;
  if ComboBox1.Text <> '' then
  begin
    temp := temp + 'and SuprType like ''%' + trim(ComboBox1.Text) + '%''';
  end;
  temp := temp + ' order by SuprCode';
  SelectClientDataSet(ClientDataSet1, temp);
end;

procedure TF_SupplierInfo.SpeedButton1Click(Sender: TObject);
var
  strSQL1: string;
begin
  with ClientDataSet3 do //连接其他数据库
  begin
    RemoteServer.AppServer.LinkHISData('1');
  end;
  strSQL1 := 'select CUS_NO,NAME,OBJ_ID,FAX,TEL1,ADR2 from CUST';
  with ClientDataSet2 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strSQL1);
  end;
end;

procedure TF_SupplierInfo.SpeedButton3Click(Sender: TObject);
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
  ClientDataSet2.First;
  with ClientDataSet2 do
  begin
    while not eof do
    begin
      if not ClientDataSet1.Locate('SuprCode', FieldByName('CUS_NO').AsString, []) then
      begin
        iCount := iCount + 1;
      end;
      Application.ProcessMessages;
      Next;
    end;
  end;
  if iCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据.');
    Exit;
  end;
  if ZsbMsgBoxOkNoApp(Self, '共有' + inttostr(iCount) + '条记录需要同步.确认操作么？') = False then Exit;
  PleaseWait(0);
  iCount := 0;
  with ClientDataSet2 do
  begin
    First;
    while not Eof do
    begin
      if not ClientDataSet1.Locate('SuprCode', FieldByName('CUS_NO').AsString, []) then
      begin
        strSuprType := '客户';
        if FieldByName('OBJ_ID').AsString = '2' then
        begin
          strSuprType := '厂商';
        end;
        exsql := exsql + 'insert into supplier(SuprCode,SuprName,SuprType,SuprFax,SuprTel,SuprAddress,state)values(''' + FieldByName('CUS_NO').AsString +
          ''',''' + FieldByName('NAME').AsString + ''',''' + strSuprType + ''',''' + FieldByName('FAX').AsString + ''',''' + FieldByName('TEL1').AsString +
          ''',''' + FieldByName('ADR2').AsString + ''',''Y'');';
        iCount := iCount + 1;
        if iCount = 11 then //10条执行一次
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
              PleaseWait(1);
              ZsbMsgErrorInfoNoApp(Self, '对不起，此次操作失败,将进行下一个循环！');
              iCount := 0;
              exsql := '';
              Break;
            end;
          end;
        end;
      end; 
      Application.ProcessMessages;
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
      ZsbMsgErrorInfoNoApp(Self, '对不起，操作失败！');
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

