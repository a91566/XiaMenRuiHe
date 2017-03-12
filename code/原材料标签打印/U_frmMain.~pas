unit U_frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect, ComObj, StrUtils,
  psBarcode, frxClass, frxBarcode, Clipbrd, frxDesgn, RzEdit, ComCtrls;

type
  TfrmMain = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    Timer2: TTimer;
    Image1: TImage;
    ClientDataSet10: TClientDataSet;
    frxReport1: TfrxReport;
    RzPanel99: TRzPanel;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    Label52: TLabel;
    RzPanel4: TRzPanel;
    L2: TLabel;
    RzPanel5: TRzPanel;
    Label2: TLabel;
    RzPanel6: TRzPanel;
    Label3: TLabel;
    RzEdit1: TRzEdit;
    RzEdit2: TRzEdit;
    Timer3: TTimer;
    Label9: TLabel;
    L3: TLabel;
    psBarcode5: TpsBarcode;
    RzPanel7: TRzPanel;
    TabSheet2: TRzTabSheet;
    RzPanel77: TRzPanel;
    RzPanel8: TRzPanel;
    DBGridEh1: TDBGridEh;
    LabeledEdit2_1: TLabeledEdit;
    LabeledEdit2_2: TLabeledEdit;
    ComboBox2: TComboBox;
    Label1: TLabel;
    Label6: TLabel;
    Label10: TLabel;
    DateTimePicker2: TDateTimePicker;
    DateTimePicker1: TDateTimePicker;
    SpeedButton2: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton999: TSpeedButton;
    CheckBox1: TCheckBox;
    l4: TLabel;
    Button1: TButton;
    ClientDataSet33: TClientDataSet;
    Label11: TLabel;
    RzPanel1: TRzPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Edit1: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure RzEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure Timer3Timer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure RzEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton999Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure RzPageControl1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Label17Click(Sender: TObject);
    procedure Label16Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Label11Click(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    function SavePrintHistory: string;
    function PrintLabel(sAutoLot: string): SmallInt;
    function SelectOtherInfo(matlcode: string): Boolean;
    procedure AddCombobox2;
    function PrintLabelAgain(sMatlCode,sMatlName,sQuat,sLot,s2D: string): SmallInt;
    { Private declarations }
  public
    { Public declarations }
  end;

const
  cReadMe = '内部标签打印,功能说明:' + 
    #13 + #10 + #13 + #10 + '2014年9月1日 15:57:22 郑少宝';

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
  Self.Top := 0;
  Self.Top := 0;
  self.Height := Screen.Height;
  Self.Width := Screen.Width;
  RzEdit1.Text := '';
  RzEdit2.Text := '';
  Label5.Caption := '0';
  Label7.Caption := '0'; 
  SetWindowLong(RzEdit1.Handle, GWL_STYLE, GetWindowLong(RzEdit1.Handle, GWL_STYLE) or ES_center);
  SetWindowLong(RzEdit2.Handle, GWL_STYLE, GetWindowLong(RzEdit2.Handle, GWL_STYLE) or ES_center);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  //AnimateWindow(Handle, 250, AW_CENTER); //窗口由小变大
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
  RzPageControl1.ActivePageIndex:=0;
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
    RzEdit1.SetFocus;
  finally
  end;
end;

procedure TfrmMain.AddCombobox2;
var
  strsql:string;
begin
  strsql:= 'select distinct pName from Inside_MatlLabel where un<>''''';
  SelectClientDataSet(ClientDataSet10, strsql);
  with ClientDataSet10 do
  begin
    First;
    ComboBox2.Items.Clear;
    ComboBox2.Items.Add('');
    while not eof do
    begin
      ComboBox2.Items.Add(FieldByName('pName').AsString);
      Next;
    end;
  end;
  ComboBox2.ItemIndex:=ComboBox2.Items.IndexOf(ZStrUser);
end;

function TfrmMain.SavePrintHistory: string;
var
  sAutoLot, exsql, temp: string;
begin
  sAutoLot := GetSetSerialNo('原料');
  exsql := 'insert into Inside_MatlLabel(MatlCode,MatlCode_Sup,SuprCode,Qty,Lot,dt,' +
    'un,AutoLot,Ver)values(''' + RzEdit1.Text + ''',''' + l2.Caption + ''',''' + l4.Caption + ''',''' + l3.Caption +
    ''',''' + RzEdit2.Text + ''',''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) + ''',''' + ZStrUser +
    ''',''' + sAutoLot + ''',''.'');';
  if exsql <> '' then
  begin
    if EXSQLClientDataSet(ClientDataSet10, exsql) = False then
    begin
      temp := '对不起,没有打印成功,因为标签记录失败,请联系管理员.在PrintMatlCode_Inside-TfrmMain.SavePrintHistory';
      sAutoLot := '';
      AddLog_ErrorText(temp);
      ZsbMsgErrorInfoNoApp(Self, temp);
    end
    else
    begin
      temp := '生成标签1张';
      zsbSimpleMSNPopUpShow(temp);
    end;
  end;
  Result := sAutoLot;
end;

function TfrmMain.PrintLabel(sAutoLot: string): SmallInt;
var
  reportFilePath, dc: string;
  iRt: SmallInt;
  bmp: TBitmap;
begin
  //二维码 内含厂商码、产品料号、数量、批号、版次(版次为空，这里用一个点标识)、序号
  try
    iRt := 0;
    dc:='inside,';  //为了区分
    dc :=dc+ l4.Caption  + ',' + RzEdit1.Text +
      ',' + l3.Caption + ',' + RzEdit2.Text + ',.,' + sAutoLot;
    psBarcode5.BarCode := dc;

    reportFilePath := ExtractFilePath(ParamStr(0)) + 'PrintMatlCode_Inside.fr3';
    frxReport1.Clear;
    frxReport1.LoadFromFile(reportFilePath);

    TfrxMemoView(frxReport1.FindObject('Memo1')).Text := RzEdit1.Text;
    TfrxMemoView(frxReport1.FindObject('Memo2')).Text := L2.Caption;
    TfrxMemoView(frxReport1.FindObject('Memo3')).Text := l3.Caption;
    TfrxMemoView(frxReport1.FindObject('Memo4')).Text := RzEdit2.Text;
    TfrxMemoView(frxReport1.FindObject('Memo5')).Text := FormatDateTime('yyyyMMdd', Now);

    TfrxBarCodeView(frxReport1.FindObject('BarCode1')).Text := RzEdit1.Text;
    TfrxBarCodeView(frxReport1.FindObject('BarCode2')).Text := L2.Caption;
    TfrxBarCodeView(frxReport1.FindObject('BarCode3')).Text := L3.Caption;
    TfrxBarCodeView(frxReport1.FindObject('BarCode4')).Text := RzEdit2.Text;

    bmp := TBitmap.Create;
    bmp.Width := psBarcode5.Width;
    bmp.Height := psBarcode5.Height;
    psBarcode5.PaintBarCode(bmp.Canvas, Rect(0, 0, bmp.Width, bmp.Height));
    TfrxPictureView(frxReport1.FindObject('picture1')).Picture.Assign(bmp);
    bmp.Free;
    if CheckBox1.Checked then
    begin
      frxReport1.ShowReport();
    end
    else
    begin
      frxReport1.PrepareReport;
      frxReport1.PrintOptions.ShowDialog := False; //不显示打印机选择框
      frxReport1.Print; //打印
    end;

    Timer3.Enabled := True;
    RzEdit2.Clear;
    RzEdit2.SetFocus;
  except
    on e: Exception do
    begin
      ZsbMsgErrorInfoNoApp(Self, e.Message);
      iRt := 1;
    end;
  end;
  Result := iRt;
end;

function TfrmMain.PrintLabelAgain(sMatlCode,sMatlName,sQuat,sLot,s2D: string): SmallInt;
var
  reportFilePath, dc: string;
  iRt: SmallInt;
  bmp: TBitmap;
begin
  //二维码 内含厂商码、产品料号、数量、批号、版次(版次为空，这里用一个点标识)、序号
  try
    iRt := 0;
    dc:=s2D;
    psBarcode5.BarCode := dc;

    reportFilePath := ExtractFilePath(ParamStr(0)) + 'PrintMatlCode_Inside.fr3';
    frxReport1.Clear;
    frxReport1.LoadFromFile(reportFilePath);

    TfrxMemoView(frxReport1.FindObject('Memo1')).Text := sMatlCode;
    TfrxMemoView(frxReport1.FindObject('Memo2')).Text := sMatlName;
    TfrxMemoView(frxReport1.FindObject('Memo3')).Text := sQuat;
    TfrxMemoView(frxReport1.FindObject('Memo4')).Text := sLot;
    TfrxMemoView(frxReport1.FindObject('Memo5')).Text := FormatDateTime('yyyyMMdd', Now);

    TfrxBarCodeView(frxReport1.FindObject('BarCode1')).Text := sMatlCode;
    TfrxBarCodeView(frxReport1.FindObject('BarCode2')).Text := sMatlName;
    TfrxBarCodeView(frxReport1.FindObject('BarCode3')).Text := sQuat;
    TfrxBarCodeView(frxReport1.FindObject('BarCode4')).Text := sLot;

    bmp := TBitmap.Create;
    bmp.Width := psBarcode5.Width;
    bmp.Height := psBarcode5.Height;
    psBarcode5.PaintBarCode(bmp.Canvas, Rect(0, 0, bmp.Width, bmp.Height));
    TfrxPictureView(frxReport1.FindObject('picture1')).Picture.Assign(bmp);
    bmp.Free;
    if CheckBox1.Checked then
    begin
      frxReport1.ShowReport();
    end
    else
    begin
      frxReport1.PrepareReport;
      frxReport1.PrintOptions.ShowDialog := False; //不显示打印机选择框
      frxReport1.Print; //打印
    end;  
  except
    on e: Exception do
    begin
      ZsbMsgErrorInfoNoApp(Self, e.Message);
      iRt := 1;
    end;
  end;
  Result := iRt;
end;

function TfrmMain.SelectOtherInfo(matlcode: string): Boolean;
var
  iRt: Boolean;
  strsql: string;
begin
  strsql := 'select MatlName,SupQty,suprcode from Material where matlcode=''' + matlcode + '''';
  iRt := False;
  SelectClientDataSetNoTips(ClientDataSet10, strsql);
  if ClientDataSet10.RecordCount = 1 then
  begin
    L2.Caption := ClientDataSet10.FieldByName('MatlName').AsString;
    L3.Caption := ClientDataSet10.FieldByName('SupQty').AsString;
    L4.Caption := ClientDataSet10.FieldByName('suprcode').AsString;
    Timer3.Enabled := True; //刷新打印情况
    RzEdit1.Enabled := False;
    RzEdit2.Enabled := True;   
    SpeedButton999.Enabled := True;
    iRt := True;
    RzEdit2.SetFocus;
  end;
  Result := iRt;
end;

procedure TfrmMain.RzEdit2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    SpeedButton999.Click;
  end;
end;

procedure TfrmMain.Timer3Timer(Sender: TObject);
var
  strsql: string;
begin
  //刷新打印情况
  Timer3.Enabled := False;
  strsql := 'declare @out int  exec @out=ZP_getAlready_PrintQty ';
  strsql := strsql + '''' + FormatDateTime('yyyy-MM-dd', Now) + ''',';
  strsql := strsql + '''' + RzEdit1.Text + '''';
  strsql := strsql + ' select @out outvalue';
  Label5.Caption := SelectClientDataSetResultFieldCaption(ClientDataSet10, strsql, 'outvalue');

  strsql := 'declare @out int  exec @out=ZP_getAlready_PrintCount ';
  strsql := strsql + '''' + FormatDateTime('yyyy-MM-dd', Now) + ''',';
  strsql := strsql + '''' + RzEdit1.Text + '''';
  strsql := strsql + ' select @out outvalue';
  Label7.Caption := SelectClientDataSetResultFieldCaption(ClientDataSet10, strsql, 'outvalue');
end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
begin
  if SpeedButton1.Caption = '开始' then
  begin
    if SelectOtherInfo(RzEdit1.Text) then
    begin
      SpeedButton1.Caption := '重置';
    end
    else
    begin
      zsbSimpleMSNPopUpShow_2('没有检索到该料号,请重新输入.',clRed);
    end;
  end
  else
  begin
    SpeedButton1.Caption := '开始';
    RzEdit1.Text:='';
    RzEdit2.Text:='';
    L2.Caption:='';
    L3.Caption:='';   
    L4.Caption:='';
    RzEdit1.Enabled:=True;  
    RzEdit2.Enabled:=False;
    SpeedButton999.Enabled:=False;
    RzEdit1.SetFocus;
  end;
end;

procedure TfrmMain.RzEdit1KeyPress(Sender: TObject; var Key: Char);
begin
   if Key=#13 then
   begin
     SpeedButton1.Click;
   end;
end;
procedure TfrmMain.SpeedButton999Click(Sender: TObject);
var
  autolot: string;
begin
  if (RzEdit1.Text = '') or (l2.Caption = '') or
    (L3.Caption = '') or (RzEdit2.Text = '') then
  begin
    zsbSimpleMSNPopUpShow_2('字段不能为空.', clRed);
    Exit;
  end;
  if L4.Caption = ''  then
  begin
    zsbSimpleMSNPopUpShow_2('此料号没有供应商代码,请完善后再操作.', clRed);
    Exit;
  end;
  autolot := SavePrintHistory;
  if autolot <> '' then
  begin
    PrintLabel(autolot);
  end;
end;

procedure TfrmMain.SpeedButton2Click(Sender: TObject);
var
  strsql,temp1,temp2: string;
begin
  temp1 := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date) + ' 00:00:00';
  temp2 := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date) + ' 23:59:59';
  strsql := 'select * from Inside_MatlLabel where dt>='''+temp1+''' and dt<='''+temp2+'''';

  if LabeledEdit2_1.Text <> '' then
  begin
    strsql := strsql + ' and MatlCode like ''%' + LabeledEdit2_1.Text + '%''';
  end;
  if LabeledEdit2_2.Text <> '' then
  begin
    strsql := strsql + ' and Lot like ''%' + LabeledEdit2_2.Text + '%''';
  end;
 { if ComboBox2.ItemIndex>0 then
  begin
    strsql := strsql + ' and un='''+ComboBox2.Text+'''';
  end;  }
  strsql := strsql + ' order by id desc';
  SelectClientDataSet(ClientDataSet1, strsql);
end;

procedure TfrmMain.RzPageControl1Change(Sender: TObject);
begin
  if RzPageControl1.ActivePageIndex=1 then
  begin
    if LabeledEdit2_1.Tag=0 then
    begin
      LabeledEdit2_1.Tag:=1;//进行初始化
      DateTimePicker1.Date := StrToDate(FormatDateTime('yyyy-mm-dd', Now() - 2));
      DateTimePicker2.Date := StrToDate(FormatDateTime('yyyy-mm-dd', Now));
      //AddCombobox2;
    end;
  end;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  sMatlCode,sMatlName,sQuat,sLot,s2D,sAutoLots,exsql: string;
begin
  if ClientDataSet1.RecordCount = 0 then Exit;

  ClientDataSet33.Data := ClientDataSet1.Data;
  ClientDataSet33.Filter := 'isselect=''1''';
  ClientDataSet33.Filtered := True;
  if ClientDataSet33.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可选择操作的记录.');
    Exit;
  end;
  sAutoLots:='';
  with ClientDataSet33 do
  begin
    First;
    while not eof do
    begin
      sMatlCode:=FieldByName('MatlCode').AsString;
      sMatlName:=FieldByName('MatlCode_Sup').AsString;
      sQuat:=FieldByName('Qty').AsString;
      sLot:=FieldByName('Lot').AsString;
      s2D:='inside,';
      
      s2D :=s2D+ FieldByName('SuprCode').AsString  + ',' + sMatlCode +
        ',' + sQuat + ',' + sLot + ',.,' + FieldByName('AutoLot').AsString;

      if sAutoLots='' then
      begin
        sAutoLots:=''''+FieldByName('AutoLot').AsString+'''';
      end
      else
      begin 
        sAutoLots:=sAutoLots+','''+FieldByName('AutoLot').AsString+'''';
      end;

      if PrintLabelAgain(sMatlCode,sMatlName,sQuat,sLot,s2D)=1 then
      begin
        Break;
      end;
      WaitTime(1000);
      Next;
    end;
  end;
  zsbSimpleMSNPopUpShow('打印完成。');
  exsql:='update Inside_MatlLabel set iTime=iTime+1 where AutoLot in ('+sAutoLots+')';
  if EXSQLClientDataSet(ClientDataSet10,exsql)=false then
  begin   
    zsbSimpleMSNPopUpShow('PrintMatlCode_Inside.TfrmMain.Button1Click is false');
  end;
end;

procedure TfrmMain.Label17Click(Sender: TObject);
begin
  RzPanel1.Visible:=False;  
  RzPageControl1.Enabled:=True;
end;

procedure TfrmMain.Label16Click(Sender: TObject);
begin
  L3.Caption:=Edit1.Text;
  RzPanel1.Visible:=False;
  RzPageControl1.Enabled:=True;
end;

procedure TfrmMain.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if (not (key in ['0'..'9', #8, '.'])) then Key := #0;
end;

procedure TfrmMain.Label11Click(Sender: TObject);
begin
  if L2.Caption='' then  Exit;
  RzPanel1.Visible:=True;
  RzPageControl1.Enabled:=False;
  Edit1.SetFocus;
end;

end.
