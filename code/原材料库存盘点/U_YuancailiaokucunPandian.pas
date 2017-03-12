unit U_YuancailiaokucunPandian;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  ComCtrls, Menus;

type
  TF_YuancailiaokucunPandian = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    ScrollBox1: TScrollBox;
    RzPanel99: TRzPanel;
    RzPanel1: TRzPanel;
    SpeedButton999: TSpeedButton;
    Timer2: TTimer;
    LabeledEdit1: TLabeledEdit;
    OpenDialog1: TOpenDialog;
    Image1: TImage;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    DateTimePicker2: TDateTimePicker;
    Label3: TLabel;
    ComboBox1: TComboBox;
    TabSheet2: TRzTabSheet;
    RzPageControl2: TRzPageControl;
    RzTabSheet1: TRzTabSheet;
    DBGridEh1: TDBGridEh;
    RzPageControl3: TRzPageControl;
    RzTabSheet2: TRzTabSheet;
    DBGridEh2: TDBGridEh;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    RzPageControl4: TRzPageControl;
    RzTabSheet3: TRzTabSheet;
    ScrollBox2: TScrollBox;
    RzPanel3: TRzPanel;
    DBGridEh3: TDBGridEh;
    RzPanel4: TRzPanel;
    ClientDataSet3: TClientDataSet;
    DataSource3: TDataSource;
    CheckBox1: TCheckBox;
    ClientDataSet10: TClientDataSet;
    TabSheet3: TRzTabSheet;
    RzPanel5: TRzPanel;
    ClientDataSet4: TClientDataSet;
    DataSource4: TDataSource;
    Label4: TLabel;
    DBGridEh4: TDBGridEh;
    ClientDataSet11: TClientDataSet;
    Panel4: TPanel;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    Label5: TLabel;
    Timer3: TTimer;
    LabeledEdit21: TLabeledEdit;
    LabeledEdit22: TLabeledEdit;
    LabeledEdit23: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    Panel1: TPanel;
    Label6: TLabel;
    LabeledEdit2: TLabeledEdit;
    Timer4: TTimer;
    Image2: TImage;
    SpeedButton3: TButton;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure SpeedButton999Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure RzPageControl1Change(Sender: TObject);
    procedure DBGridEh4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label4Click(Sender: TObject);
    procedure DBGridEh4ColWidthsChanged(Sender: TObject);
    procedure DBGridEh4CellClick(Column: TColumnEh);
    procedure LabeledEdit5Change(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure DBGridEh1ColWidthsChanged(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure LabeledEdit2Change(Sender: TObject);
    procedure DBGridEh3CellClick(Column: TColumnEh);
    procedure Button1Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    function GetMPDDONO: string;
    procedure ChongZhiPanDianJiHua;
    procedure SetPanelLeft(iNO: SmallInt);
    procedure SavePadDianPlan(DDONO: string);
    { Private declarations }
  public

    { Public declarations }
  end;

var
  F_YuancailiaokucunPandian: TF_YuancailiaokucunPandian;

implementation

uses UDM, ZsbFunPro2, ZsbVariable2, ZsbDLL2;

{$R *.dfm}

procedure TF_YuancailiaokucunPandian.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_YuancailiaokucunPandian.SavePadDianPlan(DDONO: string);
var
  exsql: string;
begin
  ClientDataSet10.Data := ClientDataSet4.Data;
  with ClientDataSet10 do
  begin
    First;
    while not Eof do
    begin
      exsql := exsql + 'insert into MatlPanDianMX(MPDDONO,MatlCode,MatlLot,MatlVer,MatlQuat,ScanStockQuat,State) values(''' + DDONO +
        ''',''' + FieldByName('MatlCode').AsString + ''',''' + FieldByName('MatlLot').AsString + ''',''' + FieldByName('MatlVer').AsString +
        ''',''' + FieldByName('MatlQuat').AsString + ''',''0'',''未盘点'')';
      Next;
    end;
  end;
  if exsql <> '' then
  begin
    exsql := exsql + 'insert into MatlPanDianZ(MPDDONO,OpeeDT,DepotCode,OPUserCode,State) values(''' + DDONO +
      ''',''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) + ''',''' + ZStrUserDept + ''',''' + ZStrUser +
      ''',''ING'')';
  end;
  if exsql <> '' then
  begin
    exsql := ' begin ' + exsql + ' commit; end;';
    if EXSQLClientDataSet(ClientDataSet10, exsql) then
    begin
      zsbSimpleMSNPopUpShow('盘点计划单生产成功，单号：' + DDONO);
      SpeedButton1.Click;
    end
    else
    begin
      ZsbMsgErrorInfo(Application, Self, '对不起，操作失败！');
      Exit;
    end;
  end;
end;

procedure TF_YuancailiaokucunPandian.SetPanelLeft(iNO: SmallInt);
var
  i, iLeft: SmallInt;
begin
  if (iNO = 1) then
  begin
    iLeft := 0;
    for i := 0 to DBGridEh1.Columns.Count - 1 do
    begin
      iLeft := iLeft + DBGridEh1.Columns[i].Width;
    end;
    Panel1.Left := iLeft + 40;
  end;
  if (iNO = 4) then
  begin
    iLeft := 0;
    for i := 0 to DBGridEh4.Columns.Count - 1 do
    begin
      iLeft := iLeft + DBGridEh4.Columns[i].Width;
    end;
    Panel4.Left := iLeft + 40;
  end;
end;

procedure TF_YuancailiaokucunPandian.ChongZhiPanDianJiHua;
var
  strsql: string;
begin
  if ClientDataSet3.Data = null then
  begin
    SpeedButton1.Click;
  end;
  if ClientDataSet4.Data = null then
  begin
    strsql := 'select * from MatlPanDianMX where 1=2';
    SelectClientDataSetNoTips(ClientDataSet4, strsql);
    Panel4.Visible := False;
    RzPageControl4.ActivePageIndex:=0;
  end;
end;


function TF_YuancailiaokucunPandian.GetMPDDONO: string;
var
  strsql, temp: string;
  iCount: Integer;
begin
  strsql := 'select count(id) icount from MatlPanDianZ';
  temp := SelectClientDataSetResultFieldCaption(ClientDataSet10, strsql, 'icount');
  iCount := StrToInt(temp) + 1;
  if iCount < 1000 then
  begin
    temp := Format('%.3d', [iCount]);
  end
  else if iCount < 10000 then
  begin
    temp := Format('%.4d', [iCount]);
  end
  else if iCount < 100000 then //肯定够用吧
  begin
    temp := Format('%.5d', [iCount]);
  end;
  Result := '8' + temp; //以8开头吧
end;

procedure TF_YuancailiaokucunPandian.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_YuancailiaokucunPandian.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05
  Action := caFree;
end;

procedure TF_YuancailiaokucunPandian.FormCreate(Sender: TObject);
begin
  Self.Top := 0;
  Self.Top := 0;
end;

procedure TF_YuancailiaokucunPandian.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 250, AW_CENTER); //窗口由小变大
end;

procedure TF_YuancailiaokucunPandian.Timer1Timer(Sender: TObject);
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
  DateTimePicker1.Date := StrToDate(FormatDateTime('yyyy-MM-', Now) + '01');
  DateTimePicker2.Date := Now;
end;

procedure TF_YuancailiaokucunPandian.Timer2Timer(Sender: TObject);
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

procedure TF_YuancailiaokucunPandian.DBGridEh1CellClick(Column: TColumnEh);
var
  strsql: string;
begin
  LabeledEdit2.Text := ClientDataSet1.FieldByName('MPDDONO').AsString;
  if LabeledEdit2.Text = '' then
  begin
    ClientDataSet2.Close;
    Panel1.Visible := False;
  end
  else
  begin
    strsql := 'select * from MatlPanDianMX where MPDDONO=''' + LabeledEdit2.Text + '''';
    SelectClientDataSet(ClientDataSet2, strsql);
    Panel1.Visible := True;
    Timer4.Enabled := True;
    if ClientDataSet1.FieldByName('State').AsString = 'ING' then
    begin
      label6.Enabled := True;
    end
    else
    begin
      label6.Enabled := False;
    end;
  end;
end;

procedure TF_YuancailiaokucunPandian.SpeedButton999Click(Sender: TObject);
var
  strsql, temp1, temp2: string;
begin
  temp1 := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date) + ' 00:00:00';
  temp2 := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date) + ' 23:59:59';
  strsql := 'select * from MatlPanDianZ where OpeeDT>=''' + temp1 + ''' and OpeeDT<=''' + temp2 + '''';
  if LabeledEdit1.Text <> '' then
  begin
    strsql := strsql + ' and MPDDONO like ''%' + LabeledEdit1.Text + '%''';
  end;
  if ComboBox1.ItemIndex = 1 then
  begin
    strsql := strsql + ' and State=''ING''';
  end
  else if ComboBox1.ItemIndex = 2 then
  begin
    strsql := strsql + ' and State=''DONE''';
  end
  else if ComboBox1.ItemIndex = 3 then
  begin
    strsql := strsql + ' and State=''CANCEL''';
  end;
  SelectClientDataSet(ClientDataSet1, strsql);
  ClientDataSet2.Close;
  Panel1.Visible := False;
end;

procedure TF_YuancailiaokucunPandian.SpeedButton1Click(Sender: TObject);
var
  temp: string;
begin
  temp := 'select MatlInDepotMX.IsSelect,MatlInDepotMX.MatlCode,MatlInDepotMX.MatlLot,MatlInDepotMX.MatlVer,MatlInDepotMX.StockQuat' +
    ',Supplier.SuprName, Material.MatlName from MatlInDepotMX,Supplier,Material where MatlInDepotMX.MatlCode=Material.MatlCode ' +
    'and Material.SuprCode=Supplier.SuprCode';
  if LabeledEdit21.Text <> '' then
  begin
    temp := temp + ' and MatlInDepotMX.MatlCode like ''%' + LabeledEdit21.Text + '%''';
  end;
  if LabeledEdit22.Text <> '' then
  begin
    temp := temp + ' and MatlInDepotMX.MatlLot like ''%' + LabeledEdit22.Text + '%''';
  end;
  if LabeledEdit23.Text <> '' then
  begin
    temp := temp + ' and MatlInDepotMX.MatlCode in(select MatlCode from Material where SuprCode like ''%' + LabeledEdit23.Text + '%'')';
  end;
  temp := temp + ' and MatlInDepotMX.StockQuat>0';
  SelectClientDataSet(ClientDataSet3, temp);
//  ShowMessage(PChar('ZStrUser:'+ZStrUser));
//  ShowMessage(PChar('ZStrUserDept:'+ZStrUserDept));
end;

procedure TF_YuancailiaokucunPandian.CheckBox1Click(Sender: TObject);
var
  temp: string;
  bAdd: Boolean;
begin
  if ClientDataSet3.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据.');
    Exit;
  end;
  temp := '0'; //未选择
  if CheckBox1.Checked then temp := '1'; //已选择
  ClientDataSet10.Data := ClientDataSet3.Data;
  with ClientDataSet10 do
  begin
    First;
    while not Eof do
    begin
      Edit;
      FieldByName('IsSelect').Value := temp;
      if temp = '1' then
      begin
        bAdd := True;
        if ClientDataSet4.Locate('MatlLot', FieldByName('MatlLot').AsString, []) then
        begin
          if ClientDataSet4.FieldByName('MatlCode').AsString = FieldByName('MatlCode').AsString then
          begin
            bAdd := False;
          end;
        end;
        if bAdd then
        begin
          ClientDataSet4.Edit;
          ClientDataSet4.Insert;
          ClientDataSet4.FieldByName('MatlCode').Value := FieldByName('MatlCode').AsString;
          ClientDataSet4.FieldByName('MatlQuat').Value := FieldByName('StockQuat').AsString;
          ClientDataSet4.FieldByName('MatlLot').Value := FieldByName('MatlLot').AsString;
          ClientDataSet4.FieldByName('MatlVer').Value := FieldByName('MatlVer').AsString;
          ClientDataSet4.Post;
        end;
      end;
      Next;
    end;
  end;
  ClientDataSet3.Data := ClientDataSet10.Data;
end;

procedure TF_YuancailiaokucunPandian.RzPageControl1Change(Sender: TObject);
begin
  if RzPageControl1.ActivePageIndex = 1 then
  begin
    ChongZhiPanDianJiHua;
  end;
end;

procedure TF_YuancailiaokucunPandian.DBGridEh4MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ClientDataSet4.RecordCount > 0 then
  begin
    Panel4.Visible := True;
  end
  else
  begin
    Panel4.Visible := False;
    LabeledEdit4.Text := '';
    LabeledEdit5.Text := '';
  end;
end;

procedure TF_YuancailiaokucunPandian.Label4Click(Sender: TObject);
var
  strsql: string;
begin
  if ClientDataSet4.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据.');
    Exit;
  end;
  strsql := 'select * from MatlPanDianMX where 1=2';
  SelectClientDataSetNoTips(ClientDataSet4, strsql);
  Panel4.Visible := False;
end;

procedure TF_YuancailiaokucunPandian.DBGridEh4ColWidthsChanged(
  Sender: TObject);
begin
  SetPanelLeft(4);
end;

procedure TF_YuancailiaokucunPandian.DBGridEh4CellClick(Column: TColumnEh);
begin
  LabeledEdit4.Text := ClientDataSet4.FieldByName('MatlCode').AsString;
  LabeledEdit5.Text := ClientDataSet4.FieldByName('MatlLot').AsString;
  if LabeledEdit4.Text = '' then
  begin
    Panel4.Visible := False;
  end
  else
  begin
    Timer3.Enabled := False;
    Timer3.Enabled := True;
  end;
end;

procedure TF_YuancailiaokucunPandian.LabeledEdit5Change(Sender: TObject);
begin
  if LabeledEdit5.Text = '' then Panel4.Visible := False;
end;

procedure TF_YuancailiaokucunPandian.Label5Click(Sender: TObject);
begin
  if (ClientDataSet4.RecordCount = 0) or (ClientDataSet4.FieldByName('MatlCode').AsString = '') then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据.');
    Exit;
  end;
  ClientDataSet4.Delete;
  LabeledEdit4.Text := ClientDataSet4.FieldByName('MatlCode').AsString;
  LabeledEdit5.Text := ClientDataSet4.FieldByName('MatlLot').AsString;
end;

procedure TF_YuancailiaokucunPandian.DBGridEh1ColWidthsChanged(
  Sender: TObject);
begin
  SetPanelLeft(1);
end;

procedure TF_YuancailiaokucunPandian.Timer3Timer(Sender: TObject);
begin
  Panel4.Visible := False;
end;

procedure TF_YuancailiaokucunPandian.Timer4Timer(Sender: TObject);
begin
  Panel1.Visible := False;
end;

procedure TF_YuancailiaokucunPandian.LabeledEdit2Change(Sender: TObject);
begin
  if LabeledEdit2.Text = '' then Panel1.Visible := False;
end;

procedure TF_YuancailiaokucunPandian.DBGridEh3CellClick(Column: TColumnEh);
var
  badd:Boolean;
begin
  if DBGridEh3.Col = 1 then
  begin
    if ClientDataSet3.FieldByName('IsSelect').AsBoolean=False then
    begin   
      bAdd := True;
      if ClientDataSet4.Locate('MatlLot', ClientDataSet3.FieldByName('MatlLot').AsString, []) then
      begin
        if ClientDataSet4.FieldByName('MatlCode').AsString = ClientDataSet3.FieldByName('MatlCode').AsString then
        begin
          bAdd := False;
        end;
      end;
      if bAdd then
      begin
        ClientDataSet4.Edit;
        ClientDataSet4.Insert;
        ClientDataSet4.FieldByName('MatlCode').Value := ClientDataSet3.FieldByName('MatlCode').AsString;
        ClientDataSet4.FieldByName('MatlQuat').Value := ClientDataSet3.FieldByName('StockQuat').AsString;
        ClientDataSet4.FieldByName('MatlLot').Value := ClientDataSet3.FieldByName('MatlLot').AsString;
        ClientDataSet4.FieldByName('MatlVer').Value := ClientDataSet3.FieldByName('MatlVer').AsString;
        ClientDataSet4.Post;
      end;
    end;
  end;
end;

procedure TF_YuancailiaokucunPandian.Button1Click(Sender: TObject);
var
  DDONO: string;
begin
  if ClientDataSet4.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据.');
    Exit;
  end;
  DDONO := GetMPDDONO;
  if DDONO = '' then
  begin
    zsbSimpleMSNPopUpShow('单号获取失败.');
    Exit;
  end;
  SavePadDianPlan(DDONO);
end;

procedure TF_YuancailiaokucunPandian.Label6Click(Sender: TObject);
var
  exsql: string;
begin
  if LabeledEdit2.Text = '' then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据.');
    Exit;
  end;
  if ZsbMsgBoxOk(Application, Self, '确认撤销单号为[' + LabeledEdit2.Text + ']的盘点单么?') then
  begin
    exsql := 'update MatlPanDianZ set state=''CANCEL'' where MPDDONO=''' + LabeledEdit2.Text + '''';
    if EXSQLClientDataSet(ClientDataSet10, exsql) then
    begin
      zsbSimpleMSNPopUpShow('操作成功.');
      SpeedButton999.Click;
    end
    else
    begin
      ZsbMsgErrorInfo(Application, Self, '对不起，操作失败！');
      Exit;
    end;
  end;
end;

procedure TF_YuancailiaokucunPandian.Label8Click(Sender: TObject);
begin
  if ClientDataSet2.RecordCount=0 then
  begin  
    zsbSimpleMSNPopUpShow('没有可操作的数据.');
    Exit;
  end;
  if Label8.Caption='盈亏变色' then
  begin
    Label8.Caption:='撤销变色';
  end
  else
  begin
    Label8.Caption:='盈亏变色';
  end;
  DBGridEh2.Repaint;
end;

procedure TF_YuancailiaokucunPandian.DBGridEh2DrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if Label8.Caption='盈亏变色' then
  begin //原样

  end
  else
  begin
    if ClientDataSet2.FieldByName('State').AsString = '盘盈' then
    begin
      DBGridEh2.Canvas.Brush.Color := clGreen;
      DBGridEh2.Canvas.Font.Color := clWhite;
      DBGridEh2.Canvas.Font.Style := [fsBold];
      DBGridEh2.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end
    else if ClientDataSet2.FieldByName('State').AsString = '盘亏' then
    begin
      DBGridEh2.Canvas.Brush.Color := clRed;
      DBGridEh2.Canvas.Font.Color := clWhite;
      DBGridEh2.Canvas.Font.Style := [fsBold];
      DBGridEh2.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;

  end;
end;

end.

