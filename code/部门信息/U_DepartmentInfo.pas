unit U_DepartmentInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  dxExEdtr, dxTL, dxDBCtrl, dxCntner, dxDBTL;

type
  TF_DepartmentInfo = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    Timer2: TTimer;
    Image1: TImage;
    RzPanel99: TRzPanel;
    RzPanel1: TRzPanel;
    RzLabel_1: TRzLabel;
    Label990: TLabel;
    SpeedButton999: TSpeedButton;
    SpeedButton3: TSpeedButton;
    DBComboBoxEh1: TDBComboBoxEh;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    dxDBTreeList1: TdxDBTreeList;
    dxDBTreeList1Column7: TdxDBTreeListColumn;
    dxDBTreeList1Column4: TdxDBTreeListColumn;
    dxDBTreeList1Column3: TdxDBTreeListColumn;
    ClientDataSet10: TClientDataSet;
    Panel1: TPanel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    RadioButton2: TRadioButton;
    RadioButton1: TRadioButton;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Image2: TImage;
    dxDBTreeList1Column5: TdxDBTreeListColumn;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    TabSheet3: TRzTabSheet;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    RzPanel2: TRzPanel;
    SpeedButton4: TSpeedButton;
    dxDBTreeList2: TdxDBTreeList;
    dxDBTreeListColumn1: TdxDBTreeListColumn;
    dxDBTreeListColumn2: TdxDBTreeListColumn;
    dxDBTreeListColumn3: TdxDBTreeListColumn;
    ClientDataSet11: TClientDataSet;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure LabeledEdit3SubLabelClick(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  F_DepartmentInfo: TF_DepartmentInfo;

implementation

uses UDM, ZsbDLL2, ZsbFunPro2, ZsbVariable2, U_ChenkDept;

{$R *.dfm}

procedure TF_DepartmentInfo.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_DepartmentInfo.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_DepartmentInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05
  Action := caFree;
end;

procedure TF_DepartmentInfo.FormCreate(Sender: TObject);
begin
  Self.Top := 0;
  Self.Top := 0;
end;

procedure TF_DepartmentInfo.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
end;

procedure TF_DepartmentInfo.Timer1Timer(Sender: TObject);
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

procedure TF_DepartmentInfo.Timer2Timer(Sender: TObject);
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

procedure TF_DepartmentInfo.Button2Click(Sender: TObject);
begin
  RadioButton1.Checked := True;
  LabeledEdit3.Text := '';
  LabeledEdit2.Text := '';
  LabeledEdit1.Text := '';
  LabeledEdit1.SetFocus;
  LabeledEdit1.ReadOnly := False;
end;

procedure TF_DepartmentInfo.Button1Click(Sender: TObject);
var
  temp, temp1, exsql: string;
begin
  if LabeledEdit1.Text = '' then
  begin
    ShowInfoTips(LabeledEdit1.Handle, '请在这里输入部门编码噢.', 3);
    LabeledEdit1.SetFocus;
    Exit;
  end;
  if LabeledEdit2.Text = '' then
  begin
    ShowInfoTips(LabeledEdit2.Handle, '请在这里输入部门名称噢.', 3);
    LabeledEdit2.SetFocus;
    Exit;
  end;
  if LabeledEdit3.Text = '' then
  begin
    ShowInfoTips(LabeledEdit3.Handle, '请在这里选择上级部门编码噢.', 3);
    LabeledEdit3.SetFocus;
    Exit;
  end;
  temp1 := 'N';
  if RadioButton1.Checked then
  begin
    temp1 := 'Y';
  end;
  if LabeledEdit1.ReadOnly = True then //修改
  begin
    temp := 'select id from department where deptname=''' + LabeledEdit2.Text + ''' and deptcode<>''' + LabeledEdit1.Text + '''';
    if SelectClientDataSetResultCount(ClientDataSet10, temp) <> 0 then
    begin
      ZsbMsgErrorInfoNoApp(Self, '部门名称已存在,请重新输入');
      LabeledEdit1.SetFocus;
      Exit;
    end
    else
    begin
      exsql := 'update department set deptname=''' + LabeledEdit2.Text + ''',parentdeptcode=''' + LabeledEdit3.Text +
        ''',state=''' + temp1 + ''' where deptcode=''' + LabeledEdit1.Text + '''';
    end;
  end
  else
  begin //增加 
    temp := 'select id from department where deptname=''' + LabeledEdit2.Text + ''' or deptcode=''' + LabeledEdit1.Text + '''';
    if SelectClientDataSetResultCount(ClientDataSet10, temp) <> 0 then
    begin
      ZsbMsgErrorInfoNoApp(Self, '部门名称或编码已存在,请重新输入');
      LabeledEdit1.SetFocus;
      Exit;
    end
    else
    begin
      exsql := 'insert into department(deptcode,deptname,parentdeptcode,state)values(''' + LabeledEdit1.Text +
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

procedure TF_DepartmentInfo.LabeledEdit3SubLabelClick(Sender: TObject);
begin
  if Application.FindComponent('F_ChenkDept') = nil then
  begin
    F_ChenkDept := TF_ChenkDept.Create(nil);
  end;
  F_ChenkDept.ShowModal;
  LabeledEdit3.Text := F_ChenkDept.strPuResult;
end;

procedure TF_DepartmentInfo.SpeedButton999Click(Sender: TObject);
var
  temp: string;
begin
  temp := 'select * from department where 1=1 ';
  if DBComboBoxEh1.ItemIndex >= 0 then
  begin
    temp := temp + 'and ' + DBComboBoxEh1.KeyItems.Strings[DBComboBoxEh1.itemindex] + ' like ''%' + trim(Edit1.Text) + '%''';
  end;
  if ComboBox1.ItemIndex > 0 then
  begin
    if ComboBox1.ItemIndex = 1 then
    begin
      temp := temp + ' and state=''Y''';
    end
    else
    begin
      temp := temp + ' and state=''N''';
    end;
  end;
  SelectClientDataSet(ClientDataSet1, temp);
  dxDBTreeList1.FullExpand;
end;

procedure TF_DepartmentInfo.SpeedButton1Click(Sender: TObject);
begin
  if ClientDataSet1.RecordCount = 0 then Exit;
  if ClientDataSet1.FieldByName('deptcode').AsString = '' then Exit;
  RzPageControl1.ActivePageIndex := 1;
  LabeledEdit1.Text := ClientDataSet1.FieldByName('deptcode').AsString;
  LabeledEdit1.ReadOnly := True;
  LabeledEdit2.Text := ClientDataSet1.FieldByName('deptname').AsString;
  LabeledEdit3.Text := ClientDataSet1.FieldByName('parentdeptcode').AsString;
  RadioButton1.Checked := True;
  if ClientDataSet1.FieldByName('state').AsString = 'N' then
  begin
    RadioButton2.Checked := True;
  end;
end;

procedure TF_DepartmentInfo.SpeedButton4Click(Sender: TObject);
var
  strSQL1: string;
begin
  with ClientDataSet10 do //连接其他数据库
  begin
    RemoteServer.AppServer.LinkHISData('1');
  end;
  strSQL1 := 'select DEP,NAME,UP from DEPT';
  with ClientDataSet2 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strSQL1);
  end;
  dxDBTreeList2.FullExpand;
end;

procedure TF_DepartmentInfo.SpeedButton3Click(Sender: TObject);
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
      if not ClientDataSet1.Locate('deptcode', FieldByName('DEP').AsString, []) then
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
      if not ClientDataSet1.Locate('deptcode', FieldByName('DEP').AsString, []) then
      begin
        exsql := exsql + 'insert into department(deptcode,deptname,parentdeptcode,state)values(''' + FieldByName('DEP').AsString +
        ''',''' + FieldByName('NAME').AsString + ''',''' + FieldByName('UP').AsString + ''',''Y'')';
                                                                                                              // ,ShefCode  ERP没有货架
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

end.

