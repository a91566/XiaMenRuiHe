unit U_frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect, ComObj, StrUtils;

type
  TfrmMain = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    ScrollBox1: TScrollBox;
    RzPanel99: TRzPanel;
    DBGridEh1: TDBGridEh;
    RzPanel1: TRzPanel;
    SpeedButton999: TSpeedButton;
    Timer2: TTimer;
    Image1: TImage;
    ClientDataSet10: TClientDataSet;
    SpeedButton2: TSpeedButton;
    SpeedButton4: TSpeedButton;
    LabeledEdit1: TLabeledEdit;
    Panel1: TPanel;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    LabeledEdit3: TLabeledEdit;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation //ZsbMsgBoxOkNoBlack

uses UDM, ZsbFunPro2, ZsbDLL2, ZsbVariable2;

{$R *.dfm}

procedure TfrmMain.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmMain.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05
  Action := caFree;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Self.Top := 50;
  Self.Top := 50;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 250, AW_CENTER); //窗口由小变大
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
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
end;

procedure TfrmMain.Timer2Timer(Sender: TObject);
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

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
var
  temp, exsql: string;
  Temp_logs: string;
begin
  if LabeledEdit2.Text = '' then
  begin
    ShowInfoTips(LabeledEdit2.Handle, '请在这里输入品番噢.', 3);
    LabeledEdit2.SetFocus;
    Exit;
  end;
  if Leftstr(LabeledEdit2.Text, 2) <> 'PW' then
  begin
    ShowInfoTips(LabeledEdit2.Handle, '请在这里输入输入正确格式品番噢.  PW*****', 3);
    LabeledEdit2.SetFocus;
    Exit;
  end;

  if LabeledEdit2.ReadOnly = True then //修改
  begin
    exsql := 'update EndProtQuat set ver=''' + LabeledEdit3.Text + ''',sname=''' + LabeledEdit4.Text +
      ''',quat=''' + LabeledEdit5.Text + ''',ed_dt=''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) +
      ''' where id=''' + ClientDataSet1.FieldByName('id').AsString + ''';';

    Temp_logs := '【版次' + ClientDataSet1.FieldByName('ver').AsString + '→' + LabeledEdit3.Text +
      '】【报关品番' + ClientDataSet1.FieldByName('sname').AsString + '→' + LabeledEdit4.Text +
      '】【数量' + ClientDataSet1.FieldByName('sname').AsString + '→' + LabeledEdit4.Text + '】';

    exsql := exsql + 'insert into EndProtQuat_UpdateLog(EndProtCode,Tips,dt,un)values (''' + LabeledEdit2.Text +
      ''',''' + Temp_logs + ''' ,''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) + ''',''' + ZStrUser + ''');';
  end
  else
  begin //增加
    temp := 'select id from EndProtQuat where endprotcode=''' + LabeledEdit2.Text + '''';
    if SelectClientDataSetResultCount(ClientDataSet10, temp) <> 0 then
    begin
      ZsbMsgErrorInfoNoApp(Self, '品番已存在,请重新输入');
      LabeledEdit4.SetFocus;
      Exit;
    end
    else
    begin
      exsql := 'insert into EndProtQuat(endprotcode,ver,sname,quat,add_dt)values(''' + LabeledEdit2.Text +
        ''',''' + LabeledEdit3.Text + ''',''' + LabeledEdit4.Text + ''',''' + LabeledEdit5.Text +
        ''',''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) + ''')';
    end;

  end;
  if exsql <> '' then
  begin
    if EXSQLClientDataSet(ClientDataSet10, exsql) then
    begin
      zsbSimpleMSNPopUpShow('操作成功！');
      SpeedButton999.Click;
    end
    else
    begin
      SaveMessage(exsql, '.sql');
      ZsbMsgErrorInfoNoApp(Self, '对不起，操作失败！');
    end;
  end;

end;

procedure TfrmMain.SpeedButton999Click(Sender: TObject);
var
  temp: string;
begin
  temp := 'select * from EndProtQuat where 1=1 ';
  if LabeledEdit1.Text <> '' then
  begin
    temp := temp + ' and EndProtCode like ''%' + LabeledEdit1.Text + '%''';
  end;
  temp := temp + ' order by EndProtCode';
  SelectClientDataSet(ClientDataSet1, temp);
  SpeedButton3.Click;
end;

procedure TfrmMain.SpeedButton4Click(Sender: TObject);
var
  temp, exsql: string;
begin
  if isSuprAdmin = False then
  begin
    zsbSimpleMSNPopUpShow('操作受限.');
    exit;
  end;
  temp := ClientDataSet1.FieldByName('endprotcode').AsString;
  if ZsbMsgBoxOkNoApp(Self, '确认删除品番[' + temp + ']的记录么？') then
  begin
    exsql := 'delete EndProtQuat where id=''' + ClientDataSet1.FieldByName('id').AsString + '''';
    if EXSQLClientDataSet(ClientDataSet10, exsql) then
    begin
      zsbSimpleMSNPopUpShow('已成功删除.');
      SpeedButton999.Click;
    end
    else
    begin
      ZsbMsgErrorInfoNoApp(Self, '对不起，操作失败,请联系管理员！');
    end;
  end;
end;

procedure TfrmMain.LabeledEdit1Change(Sender: TObject);
begin
  SpeedButton999.Click;
end;

procedure TfrmMain.SpeedButton2Click(Sender: TObject);
begin
  if ClientDataSet1.RecordCount = 0 then Exit;
  DBGridEh1.Enabled := False;
  LabeledEdit2.Text := ClientDataSet1.FieldByName('endprotcode').AsString;
  LabeledEdit2.ReadOnly := True;
  LabeledEdit2.Color := clSkyBlue;
  LabeledEdit3.Text := ClientDataSet1.FieldByName('ver').AsString;
  LabeledEdit4.Text := ClientDataSet1.FieldByName('sname').AsString;
  LabeledEdit5.Text := ClientDataSet1.FieldByName('quat').AsString;
  Panel1.Visible := True;
end;

procedure TfrmMain.SpeedButton3Click(Sender: TObject);
begin
  LabeledEdit2.Text := '';
  LabeledEdit3.Text := '';
  LabeledEdit4.Text := '';
  LabeledEdit5.Text := '';
  Panel1.Visible := False;
  DBGridEh1.Enabled := True;
  LabeledEdit2.ReadOnly := False;
  LabeledEdit2.Color := clWhite;
  DBGridEh1.Repaint;
end;

procedure TfrmMain.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if Panel1.Visible then
  begin
    if ClientDataSet1.FieldByName('endprotcode').AsString = LabeledEdit2.Text then
    begin
      DBGridEh1.Canvas.Brush.Color := clYellow;
      DBGridEh1.Canvas.Font.Color := clRed;
      DBGridEh1.Canvas.Font.Style := [fsBold];
      DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
  end;
end;

procedure TfrmMain.SpeedButton5Click(Sender: TObject);
begin
  SpeedButton3.Click;
  Panel1.Visible := True;
  LabeledEdit2.SetFocus;
end;

procedure TfrmMain.SpeedButton6Click(Sender: TObject);
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
  filename := ExtractFilePath(Application.Exename) + '报关信息客户版次信息表.xls';
  if FileExists(filename) = False then
  begin
    ZsbMsgErrorInfoNoApp(Self, '模版文件【 报关信息客户版次信息表.xls 】不存在,无法完成导出,请联系管理员.');
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
      sheet.cells[i, 1] := FieldByName('EndProtCode').AsString;
      sheet.cells[i, 2] := FieldByName('ver').AsString;
      sheet.cells[i, 3] := FieldByName('sname').AsString;
      sheet.cells[i, 4] := FieldByName('quat').AsString;
      i := i + 1;
      sheet.cells[i, 5].select; //跟随滚动
      Next;
    end;
  end;
  zsbSimpleMSNPopUpShow('导出完成.');
end;

procedure TfrmMain.DBGridEh1DblClick(Sender: TObject);
var
  strsql, temp: string;
begin
  strsql := 'select * from EndProtQuat_UpdateLog where endprotcode=''' + ClientDataSet1.FieldByName('endprotcode').AsString + '''';
  SelectClientDataSetNoTips(ClientDataSet10, strsql);
  if ClientDataSet10.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有相关日志');
    Exit;
  end;
  temp:=ClientDataSet1.FieldByName('endprotcode').AsString;
  with ClientDataSet10 do
  begin
    First;
    while not Eof do
    begin
      temp:=temp+#13+#10+#13+#10+FieldByName('tips').AsString+'【'+FieldByName('un').AsString+'】'+
      '【'+FieldByName('dt').AsString+'】';
      Next;
    end;
  end;  
  ZsbShowMessageNoApp(Self,temp);
end;

end.

