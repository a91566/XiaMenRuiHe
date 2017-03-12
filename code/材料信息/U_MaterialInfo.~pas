unit U_MaterialInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect, DateUtils;

type
  TF_MaterialInfo = class(TForm)
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
    RzLabel_1: TRzLabel;
    DBComboBoxEh1: TDBComboBoxEh;
    SpeedButton999: TSpeedButton;
    Edit1: TEdit;
    Timer2: TTimer;
    Image1: TImage;
    Panel3: TPanel;
    Image2: TImage;
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    Label2: TLabel;
    Label1: TLabel;
    ComboBox3: TComboBox;
    ComboBox2: TComboBox;
    CheckBox1: TCheckBox;
    ClientDataSet10: TClientDataSet;
    SpeedButton2: TSpeedButton;
    TabSheet3: TRzTabSheet;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    DBGridEh2: TDBGridEh;
    RzPanel2: TRzPanel;
    SpeedButton4: TSpeedButton;
    ClientDataSet3: TClientDataSet;
    ClientDataSet11: TClientDataSet;
    LabeledEdit6: TLabeledEdit;
    Button3: TButton;
    ClientDataSet4: TClientDataSet;
    LabeledEdit9: TLabeledEdit;
    Label3: TLabel;
    LabeledEdit10: TLabeledEdit;
    SpeedButton3: TSpeedButton;
    RzPanel3: TRzPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    Edit2: TEdit;
    Label4: TLabel;
    SpeedButton8: TSpeedButton;
    Label5: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure LabeledEdit7SubLabelClick(Sender: TObject);
    procedure LabeledEdit8SubLabelClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure LabeledEdit5SubLabelClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure RzPageControl1Change(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    strLocalCode: string;
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public
    procedure InitForms;
    { Public declarations }
  end;

var
  F_MaterialInfo: TF_MaterialInfo;

implementation

uses UDM, ZsbDLL2, ZsbFunPro2, U_SuprCheck, U_ChenkDept, U_CheckShelf;

{$R *.dfm}

procedure TF_MaterialInfo.InitForms;    //ZsbShowMessageNoApp
var
  temp: string;
begin
  temp := ExtractFilePath(Application.Exename) + 'MatlUnit.zsb';
  if FileExists(temp) then
  begin
    ComboxLoadFromFile(ComboBox2, temp);
    ComboxLoadFromFile(ComboBox3, temp);
  end;
end;

procedure TF_MaterialInfo.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_MaterialInfo.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_MaterialInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05
  Action := caFree;
end;

procedure TF_MaterialInfo.FormCreate(Sender: TObject);
begin
  Self.Top := 0;
  Self.Top := 0;


  //2014年9月3日 16:01:26 不可修改
  LabeledEdit1.ReadOnly := True;
  LabeledEdit2.ReadOnly := True;
  ComboBox2.Enabled := False;
  ComboBox3.Enabled := False;
  LabeledEdit3.Enabled := False;
  LabeledEdit4.Enabled := False;
  LabeledEdit5.Enabled := False;
  LabeledEdit7.Enabled := False;
end;

procedure TF_MaterialInfo.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 250, AW_CENTER); //窗口由小变大
end;

procedure TF_MaterialInfo.SpeedButton999Click(Sender: TObject);
var
  temp: string;
begin
  temp := 'select * from material where 1=1 ';
  if DBComboBoxEh1.ItemIndex >= 0 then
  begin
    temp := temp + 'and ' + DBComboBoxEh1.KeyItems.Strings[DBComboBoxEh1.itemindex] + ' like ''%' + trim(Edit1.Text) + '%''';
  end;
  temp := temp + ' order by matlcode';
  SelectClientDataSet(ClientDataSet1, temp);
  if strLocalCode <> '' then
  begin
    ClientDataSet1.Locate('MatlCode', strLocalCode, []);
    strLocalCode := '';
  end;
end;

procedure TF_MaterialInfo.Timer1Timer(Sender: TObject);
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
  DBComboBoxEh1.ItemIndex:=0;
  RzPageControl1.Visible := True;
  RzPageControl1.ActivePageIndex := 0;
end;

procedure TF_MaterialInfo.Timer2Timer(Sender: TObject);
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
    InitForms;
  finally

  end;
end;

procedure TF_MaterialInfo.Button1Click(Sender: TObject);
var
  strstate, temp, exsql: string;
  SLFieldName: TStringList;
  i: SmallInt;
begin
  if LabeledEdit1.Text = '' then
  begin
    ShowInfoTips(LabeledEdit1.Handle, '请在这里输入材料代号噢.', 3);
    LabeledEdit1.SetFocus;
    Exit;
  end;

  strstate := 'N';
  if CheckBox1.Checked then
  begin
    strstate := 'Y';
  end;

  if LabeledEdit9.Text <> '' then
  begin
    SLFieldName := TStringList.Create;
    SLFieldName := SplitString(LabeledEdit9.Text, ','); //分割条码
    //ShowMessage(IntToStr(SLFieldName.Count));
    temp := 'select id from material';
    if SLFieldName.Count > 0 then
    begin
      for i := 0 to SLFieldName.Count - 1 do
      begin
        if i = 0 then
        begin
          temp := temp + ' where MatlBarCode like ''%' + SLFieldName[i] + '%''';
        end
        else
        begin
          temp := temp + ' or MatlBarCode like ''%' + SLFieldName[i] + '%''';
        end;
      end;
    end;
    SLFieldName.Free;
    if LabeledEdit1.ReadOnly = True then // 查询条码是否重复了
    begin
      temp := temp + ' and MatlCode<>''' + LabeledEdit1.Text + '''';
    end;
    if SelectClientDataSetResultCount(ClientDataSet10, temp) <> 0 then
    begin
      ShowInfoTips(LabeledEdit9.Handle, '材料条码已存在,请重新输入噢.', 3);
      LabeledEdit9.SetFocus;
      Exit;
    end;
  end;

  //Exit;

  if LabeledEdit1.ReadOnly = True then //修改
  begin
    exsql := 'update material set MatlName=''' + LabeledEdit2.Text + ''',MatlUnit=''' + ComboBox2.Text +
      ''',MatlUnit2=''' + ComboBox3.Text + ''',TypeCode=''' + LabeledEdit3.Text + ''',TypeName=''' + LabeledEdit4.Text +
      ''',SuprCode=''' + LabeledEdit5.Text + ''',DepotCode=''' + LabeledEdit7.Text + ''',ShefCode=''' + LabeledEdit8.Text +
      ''',state=''' + strstate + ''',ValidDate=''' + LabeledEdit6.Text + ''',MatlBarCode=''' + LabeledEdit9.Text +
      ''',SupQty=''' + LabeledEdit10.Text + ''' where matlcode=''' + LabeledEdit1.Text + '''';
  end
  else
  begin //增加
    zsbSimpleMSNPopUpShow('暂不支持新增.');
    exit;
    temp := 'select id from material where MatlCode=''' + LabeledEdit1.Text + '''';
    if SelectClientDataSetResultCount(ClientDataSet10, temp) <> 0 then
    begin
      ZsbMsgErrorInfoNoApp(Self, '材料编号已存在,请重新输入');
      LabeledEdit1.SetFocus;
      Exit;
    end
    else
    begin
      exsql := 'insert into material(MatlCode,MatlName,MatlUnit,MatlUnit2,TypeCode,TypeName,SuprCode,DepotCode,ShefCode,state,ValidDate,MatlBarCode,SupQty)values(''' + LabeledEdit1.Text +
        ''',''' + LabeledEdit2.Text + ''',''' + ComboBox2.Text + ''',''' + ComboBox3.Text + ''',''' + LabeledEdit3.Text +
        ''',''' + LabeledEdit4.Text + ''',''' + LabeledEdit5.Text + ''',''' + LabeledEdit7.Text +
        ''',''' + LabeledEdit8.Text + ''',''' + strstate + ''',''' + LabeledEdit6.Text +
        ''',''' + LabeledEdit9.Text + ''',''' + LabeledEdit10.Text + ''')';
    end;
  end;
  if exsql <> '' then
  begin
    if EXSQLClientDataSet(ClientDataSet10, exsql) then
    begin
      zsbSimpleMSNPopUpShow('操作成功！');
      strLocalCode := labelededit1.Text;
      SpeedButton999.Click;
      Button2.Click;
    end
    else
    begin
      ZsbMsgErrorInfoNoApp(Self, '对不起，操作失败！');
    end;
  end;
end;

procedure TF_MaterialInfo.Button2Click(Sender: TObject);
begin
  WaitTime(100);
  RzPageControl1.ActivePageIndex := 0;
  WaitTime(100);
  ComboBox2.ItemIndex := -1;
  ComboBox3.ItemIndex := -1;
  LabeledEdit10.Text := '';
  LabeledEdit9.Text := '';
  LabeledEdit8.Text := '';
  LabeledEdit7.Text := '';
  LabeledEdit5.Text := '';
  LabeledEdit4.Text := '';
  LabeledEdit3.Text := '';
  LabeledEdit2.Text := '';
  LabeledEdit1.Text := '';
  LabeledEdit1.ReadOnly := False;
  Button1.Enabled := False;
  Button2.Enabled := False;
end;

procedure TF_MaterialInfo.SpeedButton2Click(Sender: TObject);
begin
  if ClientDataSet1.RecordCount = 0 then Exit;
  if ClientDataSet1.FieldByName('MatlCode').AsString = '' then Exit;
  RzPageControl1.ActivePageIndex := 1;
  LabeledEdit1.Text := ClientDataSet1.FieldByName('MatlCode').AsString;
  LabeledEdit1.ReadOnly := True;
  LabeledEdit2.Text := ClientDataSet1.FieldByName('MatlName').AsString;
  LabeledEdit3.Text := ClientDataSet1.FieldByName('TypeCode').AsString;
  LabeledEdit4.Text := ClientDataSet1.FieldByName('TypeName').AsString;
  ComboBox2.ItemIndex := ComboBox2.Items.IndexOf(ClientDataSet1.FieldByName('MatlUnit').AsString);
  ComboBox3.ItemIndex := ComboBox3.Items.IndexOf(ClientDataSet1.FieldByName('MatlUnit2').AsString);
  LabeledEdit5.Text := ClientDataSet1.FieldByName('SuprCode').AsString;
  LabeledEdit7.Text := ClientDataSet1.FieldByName('DepotCode').AsString;
  LabeledEdit8.Text := ClientDataSet1.FieldByName('ShefCode').AsString;
  LabeledEdit9.Text := ClientDataSet1.FieldByName('MatlBarCode').AsString;
  LabeledEdit10.Text := ClientDataSet1.FieldByName('SupQty').AsString;

  CheckBox1.Checked := True;
  if ClientDataSet1.FieldByName('state').AsString = 'N' then
  begin
    CheckBox1.Checked := False;
  end;
  Button1.Enabled := True;
  Button2.Enabled := True;
end;

procedure TF_MaterialInfo.LabeledEdit7SubLabelClick(Sender: TObject);
begin
  if Application.FindComponent('F_ChenkDept') = nil then
  begin
    F_ChenkDept := TF_ChenkDept.Create(nil);
  end;
  F_ChenkDept.ShowModal;
  LabeledEdit7.Text := F_ChenkDept.strPuResult;
end;

procedure TF_MaterialInfo.LabeledEdit8SubLabelClick(Sender: TObject);
begin
  if Application.FindComponent('F_CheckShelf') = nil then
  begin
    F_CheckShelf := TF_CheckShelf.Create(nil);
  end;
  F_CheckShelf.ShowModal;
  LabeledEdit8.Text := F_CheckShelf.strPuResult;
end;

procedure TF_MaterialInfo.SpeedButton3Click(Sender: TObject);
var
  exsql: string;
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
      if not ClientDataSet1.Locate('MatlCode', FieldByName('PRD_NO').AsString, []) then
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
  iCount := 0;
  with ClientDataSet2 do
  begin
    First;
    while not Eof do
    begin
      if not ClientDataSet1.Locate('MatlCode', FieldByName('PRD_NO').AsString, []) then
      begin // ,ShefCode  ERP没有货架
        exsql := exsql + 'insert into material(MatlCode,MatlName,MatlUnit,MatlUnit2,TypeCode,TypeName,SuprCode,DepotCode,state)values(''' + FieldByName('PRD_NO').AsString +
          ''',''' + FieldByName('NAME').AsString + ''',''' + FieldByName('ut').AsString + ''',''' + FieldByName('UT1').AsString + ''',''' + FieldByName('IDX1').AsString +
          ''',''' + FieldByName('IDX2').AsString + ''',''' + FieldByName('SUP1').AsString + ''',''' + FieldByName('WH').AsString + ''',''Y'');';
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
              ZsbMsgErrorInfoNoApp(Self, '对不起，此次操作失败,将进行下一个循环！');
              SaveMessage(exsql, 'sql');
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

procedure TF_MaterialInfo.Button3Click(Sender: TObject);
var
  strsql, exsql, strhj, stryxq: string;
  i, j: Integer;
begin
  i := 0;
  strsql := 'select * from Material where typecode=''aaaa''';
  SelectClientDataSet(ClientDataSet4, strsql);
  with ClientDataSet4 do
  begin
    First;
    while not eof do
    begin
      strhj := fieldbyname('MatlUnit').AsString;
      stryxq := fieldbyname('MatlUnit2').AsString;
      if stryxq = '1年' then stryxq := '12';
      if stryxq = '2年' then stryxq := '24';
      if stryxq = '3年' then stryxq := '36';
      exsql := exsql + 'update Material set ShefCode=''' + strhj + ''',ValidDate=''' + stryxq +
        ''' where MatlCode=''' + fieldbyname('matlcode').AsString + ''' and TypeCode<>''aaaa'';';
      i := i + 1;
      j := i mod 500;
      if j = 0 then
      begin
        if exsql <> '' then
        begin
          if EXSQLClientDataSet(ClientDataSet3, exsql) then
          begin
            Application.ProcessMessages;
            zsbSimpleMSNPopUpShow('操作成功.');
          end
          else
          begin
            ZsbMsgErrorInfoNoApp(Self, '操作失败啦.');
            SaveMessage(exsql, 'sql');
          end;
          exsql := '';
        end;
      end;
      next;
    end;
  end;

  if exsql <> '' then
  begin
    if EXSQLClientDataSet(ClientDataSet3, exsql) then
    begin
      Application.ProcessMessages;
      zsbSimpleMSNPopUpShow('操作成功.');
    end
    else
    begin
      ZsbMsgErrorInfoNoApp(Self, '操作失败啦.');
      SaveMessage(exsql, 'sql');
    end;
    exsql := '';
  end;
end;

procedure TF_MaterialInfo.LabeledEdit5SubLabelClick(Sender: TObject);
begin
  if Application.FindComponent('F_SuprCheck') = nil then
  begin
    F_SuprCheck := TF_SuprCheck.Create(nil);
  end;
  F_SuprCheck.ShowModal;
  LabeledEdit5.Text := F_SuprCheck.strPuResult;
end;

procedure TF_MaterialInfo.SpeedButton4Click(Sender: TObject);
var
  strSQL1: string;
begin
  with ClientDataSet3 do //连接其他数据库
  begin
    RemoteServer.AppServer.LinkHISData('1');
  end;
  strSQL1 := 'select PRD_NO,NAME,UT,UT1,IDX1,SUP1,WH from PRDT';
  with ClientDataSet2 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strSQL1);
  end;
end;

procedure TF_MaterialInfo.SpeedButton7Click(Sender: TObject);
begin
  Edit2.Clear;
  RzPanel3.Visible := False; ;
end;

procedure TF_MaterialInfo.SpeedButton5Click(Sender: TObject);
begin
  RzPanel3.Visible := True;
end;

procedure TF_MaterialInfo.SpeedButton8Click(Sender: TObject);
var
  exsql, dt, TempShow: string;
  iCount, iTime: SmallInt; //每100条执行一次。执行次数
  sd, ed: TDateTime; //计算时间间隔
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
  if ZsbMsgBoxOkNoApp(Self, '共有' + inttostr(ClientDataSet2.RecordCount) + '条记录需要同步,可能需要几分钟时间.确认操作么？') = False then Exit;

  exsql := '';
  iTime := 0;
  iCount := 0;
  dt := FormatDateTime('yyyy-MM-dd HH:mm:ss', Now);
  sd := Now;
  with ClientDataSet2 do
  begin
    First;
    while not Eof do
    begin
      exsql := exsql + 'update material set MatlName=''' + FieldByName('NAME').AsString +
        ''',MatlUnit=''' + FieldByName('ut').AsString + ''',MatlUnit2=''' + FieldByName('UT1').AsString +
        ''',TypeCode=''' + FieldByName('IDX1').AsString + ''',SuprCode=''' + FieldByName('SUP1').AsString +
        ''',DepotCode=''' + FieldByName('WH').AsString + ''',dt=''' + dt +
        ''' where MatlCode=''' + FieldByName('PRD_NO').AsString + ''';';
      iCount := iCount + 1;
      if iCount = 100 then
      begin
        if EXSQLClientDataSet(ClientDataSet11, exsql) then
        begin
          iTime := iTime + 1;
          iCount := 0;
          exsql := '';
        end
        else
        begin
          ZsbMsgErrorInfoNoApp(Self, '对不起，此次操作失败,请联系管理员查看日志' +
            Formatdatetime('yyyy-MM-dd HH:mm:ss', Now) + '，系统将忽略此错误继续下一个更新.');
          SaveMessage(exsql, 'sql');
          iCount := 0;
          exsql := '';
        end;
      end;
      Next;
    end;
  end;
  if EXSQLClientDataSet(ClientDataSet11, exsql) then
  begin
    iCount := iTime * 100 + iCount;
    ed := Now;
    TempShow := '共处理数据' + inttostr(iCount) + '条,总共耗时' + inttostr(SecondsBetween(ed, sd) + 2) + '秒.';
    //  WaitTime +1秒
    WaitTime(1000);
    ZsbShowMessageNoApp(Self, TempShow);
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '对不起，此次操作失败,请联系管理员查看日志' + Formatdatetime('yyyy-MM-dd HH:mm:ss', Now) + '.');
    SaveMessage(exsql, 'sql');
  end;
end;

procedure TF_MaterialInfo.SpeedButton1Click(Sender: TObject);
var
  i, iExTotal: SmallInt;
  TSList: TStringList;
  exsql, dt, ExTempShow, TempShow: string;
begin
  if ZsbMsgBoxOkNoApp(Self, '确认操作么？') = False then Exit;

  TSList := Split2DCode(Edit2.Text);
  iExTotal := 0;
  exsql := '';
  TempShow := '';
  ExTempShow := '';
  dt := FormatDateTime('yyyy-MM-dd HH:mm:ss', Now);
  for i := 0 to TSList.Count - 1 do
  begin
    //ShowMessage(TSList[i]);
    if ClientDataSet2.Locate('PRD_NO', TSList[i], []) then
    begin
      exsql := exsql + 'update material set MatlName=''' + ClientDataSet2.FieldByName('NAME').AsString +
        ''',MatlUnit=''' + ClientDataSet2.FieldByName('ut').AsString + ''',MatlUnit2=''' + ClientDataSet2.FieldByName('UT1').AsString +
        ''',TypeCode=''' + ClientDataSet2.FieldByName('IDX1').AsString + ''',SuprCode=''' + ClientDataSet2.FieldByName('SUP1').AsString +
        ''',DepotCode=''' + ClientDataSet2.FieldByName('WH').AsString + ''',dt=''' + dt +
        ''' where MatlCode=''' + ClientDataSet2.FieldByName('PRD_NO').AsString + ''';';

      iExTotal := iExTotal + 1;
      if ExTempShow = '' then
      begin
        ExTempShow := '分别为，料号：' + TSList[i];
      end
      else
      begin
        ExTempShow := ExTempShow + ',' + TSList[i];
      end;
    end
    else
    begin
      if TempShow = '' then
      begin
        TempShow := '请注意，料号：' + TSList[i];
      end
      else
      begin
        TempShow := TempShow + ',' + TSList[i];
      end;
    end;
  end;
  if EXSQLClientDataSet(ClientDataSet11, exsql) then
  begin
    if TempShow = '' then
    begin
      TempShow := '共处理数据' + inttostr(iExTotal) + '条,' + ExTempShow;
    end
    else
    begin
      TempShow := TempShow + ' 没有相关信息，也就没有处理。共处理数据' + inttostr(iExTotal) + '条,' + ExTempShow;
    end;
    WaitTime(1000);
    ZsbShowMessageNoApp(Self, TempShow);
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '对不起，此次操作失败,请联系管理员查看日志' + Formatdatetime('yyyy-MM-dd HH:mm:ss', Now) + '.');
    SaveMessage(exsql, 'sql');
  end;

  TSList.Free;
end;

procedure TF_MaterialInfo.SpeedButton6Click(Sender: TObject);
var
  exsql, strOtherDB, strsql, dt, TempShow: string;
  iCount, iTime: SmallInt; //每100条执行一次。执行次数
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
  strOtherDB := GetStringFromIni(ExtractFilePath(Application.Exename) + 'config.ini', 'config', 'OtherDBName');
  if strOtherDB = '' then
  begin
    ZsbMsgErrorInfoNoApp(Self, '请先设置其他数据库名称,在config.ini 下。');
    exit;
  end;

  if ZsbMsgBoxOkNoApp(Self, '确认操作么？') = False then Exit;
  iTime := 0;
  iCount := 0;
  TempShow := '';
  dt := FormatDateTime('yyyy-MM-dd HH:mm:ss', Now);
  strsql := 'select PRD_NO,NAME,UT,UT1,IDX1,SUP1,WH from ';
  strsql := strsql + strOtherDB;
  strsql := strsql + '.dbo.PRDT where ';
  strsql := strsql + strOtherDB;
  strsql := strsql + '.dbo.PRDT.PRD_NO COLLATE SQL_Latin1_General_CP1_CI_AS not in (select MatlCode from RuiHe.dbo.Material)';
  //SQL_Latin1_General_CP1_CI_AS 关于这个见文档说明
  SelectClientDataSet(ClientDataSet10, strsql);
  if ClientDataSet10.RecordCount = 0 then
  begin
    ZsbMsgErrorInfoNoApp(Self, '没有监测到新增的数据.');
    Exit;
  end;
  with ClientDataSet10 do
  begin
    First;
    while not Eof do
    begin
      exsql := exsql + 'insert into material (MatlCode,MatlName,MatlUnit,MatlUnit2,TypeCode,SuprCode,DepotCode,dt,state) values (''' + FieldByName('PRD_NO').AsString +
        ''',''' + FieldByName('NAME').AsString + ''',''' + FieldByName('ut').AsString + ''',''' + FieldByName('UT1').AsString +
        ''',''' + FieldByName('IDX1').AsString + ''',''' + FieldByName('SUP1').AsString +
        ''',''' + FieldByName('WH').AsString + ''',''' + dt + ''',''N'')';


      if TempShow = '' then
      begin
        TempShow := '新增料号：' + FieldByName('PRD_NO').AsString;
      end
      else
      begin
        TempShow := TempShow + ',' + FieldByName('PRD_NO').AsString;
      end;

      iCount := iCount + 1;
      if iCount = 100 then
      begin
        if EXSQLClientDataSet(ClientDataSet11, exsql) then
        begin
          iTime := iTime + 1;
          iCount := 0;
          exsql := '';
        end
        else
        begin
          ZsbMsgErrorInfoNoApp(Self, '对不起，此次操作失败,请联系管理员查看日志' + Formatdatetime('yyyy-MM-dd HH:mm:ss', Now) + '.');
          SaveMessage(exsql, 'sql');
          iCount := 0;
          exsql := '';
          Break;
        end;
      end;
      Next;
    end;
  end;

  if EXSQLClientDataSet(ClientDataSet11, exsql) then
  begin
    iCount := iTime * 100 + iCount;
    TempShow := TempShow + ' 。共处理数据' + inttostr(iCount) + '条！';
    WaitTime(1000);
    ZsbShowMessageNoApp(Self, TempShow);
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '对不起，此次操作失败,请联系管理员查看日志' + Formatdatetime('yyyy-MM-dd HH:mm:ss', Now) + '.');
    SaveMessage(exsql, 'sql');
  end;
end;

procedure TF_MaterialInfo.RzPageControl1Change(Sender: TObject);
begin
  if RzPageControl1.ActivePageIndex = 2 then
  begin
    if SpeedButton4.Tag = 0 then
    begin
      SpeedButton4.Click;
      SpeedButton4.Tag := 1;
    end;
  end;
end;

procedure TF_MaterialInfo.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    SpeedButton999.Click;
  end;
end;

end.

