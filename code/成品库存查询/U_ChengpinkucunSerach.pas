unit U_ChengpinkucunSerach;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  ComCtrls, Menus, ComObj, StrUtils;

type
  TF_ChengpinkucunSerach = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    Timer2: TTimer;
    Image1: TImage;
    ClientDataSet10: TClientDataSet;
    ClientDataSet11: TClientDataSet;
    RzPanel99: TRzPanel;
    RzPanel1: TRzPanel;
    SpeedButton999: TSpeedButton;
    Label1: TLabel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    RzPanel2: TRzPanel;
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    DBGridEh1: TDBGridEh;
    RzPanel3: TRzPanel;
    RzPanel4: TRzPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Label2: TLabel;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    LabeledEdit5: TLabeledEdit;
    Label3: TLabel;
    Label4: TLabel;
    ComboBox2: TComboBox;
    Label9: TLabel;
    Label7: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    LabeledEdit6: TLabeledEdit;
    CheckBox2: TCheckBox;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    T_SelectAll: TTimer;
    Button3: TButton;
    RadioButton6: TRadioButton;
    Button4: TButton;
    CheckBox3: TCheckBox;
    RadioButton7: TRadioButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure LabeledEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure T_SelectAllTimer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    procedure AddCombobox2;
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public
    PuScrapReason: string;
    { Public declarations }
  end;

var
  F_ChengpinkucunSerach: TF_ChengpinkucunSerach;

implementation

uses UDM, ZsbFunPro2, ZsbDLL2, ZsbVariable2, U_ScrapReason, U_BaoFeiFenXi;

{$R *.dfm}

procedure TF_ChengpinkucunSerach.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_ChengpinkucunSerach.AddCombobox2;
var
  strsql: string;
  TSList1: TStringList;
  i, j: SmallInt;
begin
  strsql := 'select distinct pName from EndProtBarCode where pName<>''''';
  SelectClientDataSet(ClientDataSet11, strsql);
  with ClientDataSet11 do
  begin
    First;
    Combobox2.Items.Clear;
    Combobox2.Items.Add('');
    while not eof do
    begin
      Combobox2.Items.Add(FieldByName('pName').AsString);
      Next;
    end;
  end;
  for i := 0 to ComboBox2.Items.Count - 1 do
  begin
    for j := i + 1 to ComboBox2.Items.Count - 1 do
    begin
      if LeftStr(ComboBox2.Items.Strings[i], 8) = LeftStr(ComboBox2.Items.Strings[j], 8) then
      begin
        TSList1 := SplitString(ComboBox2.Items.Strings[i], '/');
        ComboBox2.Items.Strings[i] := ComboBox2.Items.Strings[i] + '/' + TSList1[1];
        ComboBox2.Items.Delete(j);
      end;
    end;
  end;

  ComboBox2.ItemIndex := ComboBox2.Items.IndexOf(ZStrUser);
end;

procedure TF_ChengpinkucunSerach.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_ChengpinkucunSerach.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05

  DBGridEhWidth(DBGridEh1, 'save', 'F_ChengpinkucunSerach_DBGridEh1.zsb');
  Action := caFree;
end;

procedure TF_ChengpinkucunSerach.FormCreate(Sender: TObject);
begin
  Self.Top := 0;
  Self.Top := 0;
end;

procedure TF_ChengpinkucunSerach.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
end;

procedure TF_ChengpinkucunSerach.SpeedButton999Click(Sender: TObject);
var
  strsql, temp1, temp2, temp3: string;
begin
  strsql := 'select * from EndProtBarCode where ';
  if RadioButton1.Checked then //未入库
  begin
    strsql := strsql + ' alreadyprint=''1'' and (InNo='''' or InNo is null)';
  end
  else if RadioButton2.Checked then //已入库
  begin
    strsql := strsql + ' alreadyprint=''1'' and InNo<>'''' and (OutNo='''' or OutNo is null)';
  end
  else if RadioButton3.Checked then //已出库
  begin
    strsql := strsql + ' alreadyprint=''1'' and OutNo<>''''';
  end
  else if RadioButton6.Checked then //未打印
  begin
    strsql := strsql + ' alreadyprint=''0''';
  end;

  if CheckBox3.Checked then
  begin
    temp1 := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date) + ' 00:00:00';
    temp2 := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date) + ' 23:59:59';
    strsql := strsql + ' and OpeeDT>= ''' + temp1 + ''' and OpeeDT<=''' + temp2 + '''';
  end;

  if LabeledEdit1.Text <> '' then
  begin
    strsql := strsql + ' and ERPPDNO like ''%' + LabeledEdit1.Text + '%''';
  end;
  if LabeledEdit2.Text <> '' then
  begin
    strsql := strsql + ' and EndProtCode like ''%' + LabeledEdit2.Text + '%''';
  end;
  if LabeledEdit3.Text <> '' then
  begin
    strsql := strsql + ' and ShippingD like ''%' + LabeledEdit3.Text + '%''';
  end;
  if LabeledEdit5.Text <> '' then
  begin
    strsql := strsql + ' and ML_NO like ''%' + LabeledEdit5.Text + '%''';
  end;
  if LabeledEdit6.Text <> '' then
  begin
    strsql := strsql + ' and EndProtLot like ''%' + LabeledEdit6.Text + '%''';
  end;
  if RadioButton4.Checked then
  begin
    strsql := strsql + ' and state=''Y''';
  end
  else if RadioButton5.Checked then
  begin
    strsql := strsql + ' and state=''N''';
  end;
  if ComboBox2.ItemIndex > 0 then
  begin
    temp3 := ComboBox2.Text;
    temp3 := LeftStr(temp3, 8);
    strsql := strsql + ' and pName like ''%' + temp3 + '%''';
  end;
  strsql := strsql + ' order by id desc';
  SelectClientDataSet(ClientDataSet1, strsql);
  SetDBGridEhFooterRowCount(DBGridEh1, ClientDataSet1);
  Button1.Enabled := not RadioButton5.Checked;
end;

procedure TF_ChengpinkucunSerach.Timer1Timer(Sender: TObject);
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

procedure TF_ChengpinkucunSerach.Timer2Timer(Sender: TObject);
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
    DBGridEhWidth(DBGridEh1, 'get', 'F_ChengpinkucunSerach_DBGridEh1.zsb');
    DateTimePicker1.Date := StrToDate(FormatDateTime('yyyy-mm-dd', Now() - 7));
    DateTimePicker2.Date := StrToDate(FormatDateTime('yyyy-mm-dd', Now));
    AddCombobox2;
    SpeedButton999.Click;
  finally

  end;
end;

procedure TF_ChengpinkucunSerach.LabeledEdit4KeyPress(Sender: TObject;
  var Key: Char);
var
  TSList: TStringList;
  strsql: string;
begin
  if Key = #13 then
  begin
    TSList := Split2DCode(LabeledEdit4.Text);
    if TSList.Count <> 6 then
    begin
      zsbSimpleMSNPopUpShow('条码解析错误.');
      LabeledEdit4.Text := '';
      Exit;
    end;
    strsql := 'select * from EndProtBarCode where EndProtLot=''' + TSList[3] + '''';
    SelectClientDataSet(ClientDataSet1, strsql);
  end;
end;

procedure TF_ChengpinkucunSerach.RadioButton1Click(Sender: TObject);
begin
  SpeedButton999.click;
end;

procedure TF_ChengpinkucunSerach.RadioButton2Click(Sender: TObject);
begin
  SpeedButton999.click;
end;

procedure TF_ChengpinkucunSerach.RadioButton3Click(Sender: TObject);
begin
  SpeedButton999.click;
end;

procedure TF_ChengpinkucunSerach.Button1Click(Sender: TObject);
var
  exsql, lots: string;
begin
  if ClientDataSet1.RecordCount = 0 then Exit;
  if RadioButton3.Checked = True then
  begin
    if isSuprAdmin = False then
    begin
      zsbSimpleMSNPopUpShow('操作受限.');
      exit;
    end;
  end;
  ClientDataSet11.Data := ClientDataSet1.Data;
  ClientDataSet11.Filter := 'isselect=''1''';
  ClientDataSet11.Filtered := True;
  if ClientDataSet11.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可选择操作的记录.');
    Exit;
  end;

  {temp := '确认作废所选择的成品标签么，注意：此操作不可撤销，是否继续？';
  if ZsbMsgBoxOkNoApp(Self, temp) = False then Exit;     }


  PuScrapReason := '';
  if Application.FindComponent('F_ScrapReason') = nil then
  begin
    Application.CreateForm(TF_ScrapReason, F_ScrapReason);
  end;
  F_ScrapReason.ShowModal;
  if PuScrapReason = '' then
  begin
    zsbSimpleMSNPopUpShow_2('没有输入报废原因.', clRed, 500);
    Exit;
  end;
  with ClientDataSet11 do
  begin
    First;
    exsql := '';
    if RecordCount > 0 then
    begin
      while not Eof do
      begin
        if FieldByName('isselect').AsBoolean = True then //选择状态
        begin
          exsql := exsql + 'update EndProtBarCode set state=''N'',ScrapReason=''' + PuScrapReason + ''' where id=''' + FieldByName('id').AsString + ''';';
          lots := lots + FieldByName('EndProtLot').AsString + ',';
        end;
        Next;
      end;
    end;
  end;

  if exsql <> '' then
  begin
    if EXSQLClientDataSet(ClientDataSet10, exsql) then
    begin
      zsbSimpleMSNPopUpShow('操作成功.');
      SpeedButton999.Click;
      AddLog_Operation('作废批次' + lots);
    end
    else
    begin
      ZsbMsgErrorInfoNoApp(Self, '操作失败，请联系管理员.');
      //SaveMessage(exsql, '.sql');
    end;
  end;
end;

procedure TF_ChengpinkucunSerach.Label1Click(Sender: TObject);
var
  strsql: string;
  booTemp: Boolean;
begin
  booTemp := RzPanel2.Visible;
  RzPanel2.Visible := not booTemp;
  DBGridEh1.Columns[0].Visible := not booTemp;
  if RzPanel2.Visible = True then
  begin
    if isAdmin then Exit; //非管理员查询权限
    if label1.Tag = 1 then Exit; //已经加载权限的不继续 避免重复查询
    strsql := 'select funccode from userpower where usercode=''' + ZStrUserCode + ''' and powertype=''PC'' and funccode like ''05010%''';
    SelectClientDataSetNoTips(ClientDataSet10, strsql);
    if ClientDataSet10.RecordCount = 0 then
    begin
      Button1.Enabled := false;
      Button2.Enabled := false;
    end
    else
    begin
      if ClientDataSet10.Locate('funccode', '050101', []) then
      begin
        Button1.Enabled := True;
      end
      else
      begin
        Button1.Enabled := false;
      end;
      if ClientDataSet10.Locate('funccode', '050102', []) then
      begin
        Button2.Enabled := True;
      end
      else
      begin
        Button2.Enabled := false;
      end;
    end;
    label1.Tag := 1;
  end;
end;

procedure TF_ChengpinkucunSerach.N2Click(Sender: TObject);
var
  SHOW, temp, id: string;
begin
  id := ClientDataSet1.FieldByName('id').AsString;
  SHOW := 'ID：' + id + #13 + #10 + #13 + #10;
  SHOW := SHOW + '品番：' + ClientDataSet1.FieldByName('EndProtCode').AsString + #13 + #10;
  SHOW := SHOW + '制令单：' + ClientDataSet1.FieldByName('ERPPDNO').AsString + #13 + #10;
  SHOW := SHOW + '生产领料单：' + ClientDataSet1.FieldByName('ML_NO').AsString + #13 + #10;
  SHOW := SHOW + '批次：' + ClientDataSet1.FieldByName('EndProtLot').AsString + #13 + #10;
  SHOW := SHOW + '标签生成：' + ClientDataSet1.FieldByName('uName').AsString + '/' + ClientDataSet1.FieldByName('opeedt').AsString + #13 + #10;
  SHOW := SHOW + '标签打印：' + ClientDataSet1.FieldByName('pName').AsString + '/' + ClientDataSet1.FieldByName('pdt').AsString + #13 + #10;
  if ClientDataSet1.FieldByName('state').AsString = 'Y' then
  begin
    SHOW := SHOW + '报废：否' + #13 + #10;
  end
  else
  begin
    SHOW := SHOW + '报废：是，报废原因：' + ClientDataSet1.FieldByName('ScrapReason').AsString;
    temp := '%update EndProtBarCode set state%' + id + '%';
    //ShowMessage(temp);
    temp := 'select opeedt,username from Log_ExSQLText where SQLText like ''' + temp + '''';
    //ShowMessage(temp);
    SelectClientDataSetNoTips(ClientDataSet11, temp);
    SHOW := SHOW + '。报废时间：' + ClientDataSet11.FieldByName('opeedt').AsString;
    SHOW := SHOW + '。报废人员：' + ClientDataSet11.FieldByName('username').AsString + #13 + #10 + #13 + #10;
  end;
  if ClientDataSet1.FieldByName('HandWork').AsBoolean = False then
  begin
    SHOW := SHOW + '手工生成：否' + #13 + #10;
  end
  else
  begin
    SHOW := SHOW + '手工生成：是' + #13 + #10;
  end;

  SHOW := SHOW + '打印次数：' + ClientDataSet1.FieldByName('iTime').AsString + #13 + #10;

  if ClientDataSet1.FieldByName('iSecond').AsString = '1' then
  begin
    SHOW := SHOW + '重新打印：是，重新打印日志：';

    SelectClientDataSetNoTips(ClientDataSet11, 'select top 1 * from Log_Operation where Text like ''%' +
      ClientDataSet1.FieldByName('EndProtLot').AsString + '%''');

    SHOW := SHOW + ClientDataSet11.FieldByName('un').AsString + '/' +
      ClientDataSet11.FieldByName('dt').AsString + '/' + ClientDataSet11.FieldByName('Text').AsString + #13 + #10 + #13 + #10;
  end
  else
  begin
    SHOW := SHOW + '重新打印：否' + #13 + #10;
  end;
  if ClientDataSet1.FieldByName('InNo').AsString = '' then
  begin
    SHOW := SHOW + '入库：否' + #13 + #10;
  end
  else
  begin
    SHOW := SHOW + '入库：是。入库单号：' + ClientDataSet1.FieldByName('InNo').AsString + #13 + #10;
  end;
  if ClientDataSet1.FieldByName('OutNo').AsString = '' then
  begin
    SHOW := SHOW + '出库：否' + #13 + #10;
  end
  else
  begin
    SHOW := SHOW + '出库：是。出库单号：' + ClientDataSet1.FieldByName('OutNo').AsString + #13 + #10;
  end;
  ZsbShowMessageNoApp(Self, SHOW);
end;

procedure TF_ChengpinkucunSerach.CheckBox1Click(Sender: TObject);
begin
  T_SelectAll.Enabled := True;
end;

procedure TF_ChengpinkucunSerach.CheckBox2Click(Sender: TObject);
var
  b: Boolean;
begin
  b := CheckBox2.Checked;
  DBGridEh1.Columns[12].Visible := b;
  DBGridEh1.Columns[13].Visible := b;
  DBGridEh1.Columns[14].Visible := b;
  DBGridEh1.Columns[15].Visible := b;
  DBGridEh1.Columns[16].Visible := b;
  DBGridEh1.Columns[17].Visible := b;
  DBGridEh1.Columns[18].Visible := b;
  DBGridEh1.Columns[19].Visible := b;
  DBGridEh1.Columns[20].Visible := b;
  DBGridEh1.Columns[21].Visible := b;
  DBGridEh1.Columns[22].Visible := b;
end;

procedure TF_ChengpinkucunSerach.T_SelectAllTimer(Sender: TObject);
var
  temp, LocalID: string;
begin
  T_SelectAll.Enabled := False;
  if ClientDataSet1.Data = null then Exit;
  if ClientDataSet1.RecordCount = 0 then Exit;
  if CheckBox1.Checked then
  begin
    temp := '1';
  end
  else
  begin
    temp := '0';
  end;
  ClientDataSet10.Data := ClientDataSet1.Data;
  with ClientDataSet10 do
  begin
    LocalID := FieldByName('isselect').AsString;
    First;
    while not Eof do
    begin
      Edit;
      FieldByName('isselect').Value := temp;
      Next;
    end;
  end;
  ClientDataSet10.Locate('ID', LocalID, []);
  ClientDataSet1.Data := ClientDataSet10.Data;
end;

procedure TF_ChengpinkucunSerach.Button2Click(Sender: TObject);
var
  temp, exsql: string;
begin
  if ClientDataSet1.RecordCount = 0 then Exit;
  if RadioButton1.Checked = False then
  begin
    zsbSimpleMSNPopUpShow('只能删除未入库的标签.');
    exit;
  end;
  ClientDataSet11.Data := ClientDataSet1.Data;
  ClientDataSet11.Filter := 'isselect=''1''';
  ClientDataSet11.Filtered := True;
  if ClientDataSet11.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可选择操作的记录.');
    Exit;
  end;

  temp := '确认删除所选择的成品标签么？';
  if ZsbMsgBoxOkNoApp(Self, temp) = False then Exit;

  with ClientDataSet11 do
  begin
    First;
    exsql := '';
    if RecordCount > 0 then
    begin
      while not Eof do
      begin
        if FieldByName('isselect').AsBoolean = True then //选择状态
        begin
          exsql := exsql + 'delete from EndProtBarCode  where id=''' + FieldByName('id').AsString + ''';';
        end;
        Next;
      end;
    end;
  end;

  if exsql <> '' then
  begin
    if EXSQLClientDataSet(ClientDataSet10, exsql) then
    begin
      zsbSimpleMSNPopUpShow('操作成功.');
      SpeedButton999.Click;
    end
    else
    begin
      ZsbMsgErrorInfoNoApp(Self, '操作失败，请联系管理员.');
      //SaveMessage(exsql, '.sql');
    end;
  end;
end;

procedure TF_ChengpinkucunSerach.Button3Click(Sender: TObject);
var
  vexcel, workbook, sheet: OleVariant; //导出excel
  filename: string;
  i: SmallInt;
begin
  if (ClientDataSet1.Data = null) or (ClientDataSet1.RecordCount = 0) then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据');
    Exit;
  end;
  filename := ExtractFilePath(Application.Exename) + '库存明细.xls';
  if FileExists(filename) = False then
  begin
    ZsbMsgErrorInfoNoApp(Self, '模版文件【 库存明细.xls 】不存在,无法完成导出,请联系管理员.');
    Exit;
  end;
  vExcel := CreateOleObject('Excel.application');
  vExcel.Visible := True; //显示
  vExcel.workbooks.Add(filename);
  workbook := vExcel.workbooks[1];
  sheet := workbook.worksheets[1];
  with ClientDataSet1 do
  begin
    First;
    i := 2;
    while not Eof do
    begin
      sheet.cells[i, 1] := FieldByName('ERPPDNO').AsString;
      sheet.cells[i, 2] := FieldByName('ML_NO').AsString;
      sheet.cells[i, 3] := FieldByName('EndProtCode').AsString;
      sheet.cells[i, 4] := FieldByName('EndProtQuat').AsString;
      sheet.cells[i, 5] := FieldByName('EndProtLot').AsString;
      sheet.cells[i, 6] := FieldByName('EndProtVer').AsString;
      sheet.cells[i, 7] := FieldByName('DEP').AsString;
      sheet.cells[i, 8] := FieldByName('ShefCode').AsString;
      sheet.cells[i, 9] := FieldByName('ShippingD').AsString;

      i := i + 1;
      sheet.cells[i, 10].select; //跟随滚动
      Next;
    end;
  end;
  zsbSimpleMSNPopUpShow('导出完成.');
end;

procedure TF_ChengpinkucunSerach.Button4Click(Sender: TObject);
begin
  if isSuprAdmin = False then Exit;

  if Application.FindComponent('F_BaoFeiFenXi') = nil then
  begin
    Application.CreateForm(TF_BaoFeiFenXi, F_BaoFeiFenXi);
  end;
  F_BaoFeiFenXi.DateTimePicker1.Date := DateTimePicker1.Date;
  F_BaoFeiFenXi.DateTimePicker2.Date := DateTimePicker2.Date;
  F_BaoFeiFenXi.ComboBox2.Items := ComboBox2.Items;
  F_BaoFeiFenXi.Left := Self.Left;
  F_BaoFeiFenXi.Top := Self.Top;
  F_BaoFeiFenXi.Show;
end;

end.

