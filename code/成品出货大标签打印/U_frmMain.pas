unit U_frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  RzLine, Clipbrd, StrUtils, mmsystem,
  ComCtrls, frxClass,frxDesgn;

type
  TfrmMain = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    Timer2: TTimer;
    Image1: TImage;
    ClientDataSet10: TClientDataSet;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    Panel1: TPanel;
    DateTimePicker2: TDateTimePicker;
    Label2: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    RzPageControl1: TRzPageControl;
    RzTabSheet1: TRzTabSheet;
    DBGridEh1: TDBGridEh;
    RzPageControl2: TRzPageControl;
    RzTabSheet2: TRzTabSheet;
    DBGridEh2: TDBGridEh;
    Button1: TButton;
    CheckBox1: TCheckBox;
    ClientDataSet3: TClientDataSet;
    DataSource3: TDataSource;
    Panel2: TPanel;
    Label4: TLabel;
    DateTimePicker4: TDateTimePicker;
    Button2: TButton;
    Label3: TLabel;
    Button3: TButton;
    Button4: TButton;
    frxReport1: TfrxReport;
    Button5: TButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure Button2Click(Sender: TObject);
    procedure DateTimePicker4Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses UDM, ZsbDLL2, ZsbFunPro2, ZsbVariable2, U_Print, U_frmAlreadyPrint;

{$R *.dfm} //EndPot  TabSheet3    F_SelectPrintInfo

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
  Action := caFree;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Self.Top := 0;
  Self.Top := 0;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
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
  RzPanel1.Visible := True;
  Panel2.Visible := True;
  DateTimePicker1.Date := StrToDate(FormatDateTime('yyyy-MM-', Now) + '01');
  DateTimePicker2.Date := Now;
  DateTimePicker4.Date := Now()-1;
  //LabeledEdit2.Text := ZStrUserDept;
  //LabeledEdit3.Text := ZStrUser;
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
    Button1.Click;
  finally

  end;
end;



procedure TfrmMain.DBGridEh1CellClick(Column: TColumnEh);
var
  strsql: string;
begin
  if ClientDataSet1.RecordCount = 0 then Exit;
  strsql := 'select ERPPDNO,EndProtCode,EndProtLot,EndProtQuat,DEP,ShefCode,State,CUSTOMNO from EndProtBarCode where OutNo=''' +
    ClientDataSet1.FieldByName('OutNo').AsString + '''';
  if CheckBox1.Checked = False then
  begin
    strsql := strsql + ' and State=''Y''';
  end;
  SelectClientDataSet(ClientDataSet2, strsql);
end;

procedure TfrmMain.Button2Click(Sender: TObject);
var
  i, iTotalQTY: Integer;
  temp:string;
begin
  if ClientDataSet1.Data = null then Exit;
  if ClientDataSet1.RecordCount = 0 then Exit;   
  if ClientDataSet2.Data = null then Exit;
  if ClientDataSet2.RecordCount = 0 then Exit;
  if ClientDataSet1.FieldByName('BB_NO').AsString<>'' then
  begin
    zsbSimpleMSNPopUpShow_2('已经打印过了.',clRed);
    Exit;
  end;
  if DateTimePicker4.Tag=0 then
  begin
    zsbSimpleMSNPopUpShow_2('请选择出货日期.',clRed);
    DateTimePicker4.SetFocus;
    Exit;
  end;
  temp:='出货日期：'+FormatDateTime('yyyy-mm-dd', DateTimePicker4.Date);
  if ZsbMsgBoxOkNoApp(Self,temp)=False then Exit;
  ClientDataSet10.Data := ClientDataSet2.Data;
  SelectClientDataSetNoTips(ClientDataSet3, 'select * from BigBarCodeMX where 1=2');
  with ClientDataSet10 do
  begin
    First;
    iTotalQTY := 0;
    while not eof do
    begin
      iTotalQTY := iTotalQTY + FieldByName('EndProtQuat').AsInteger;
      if ClientDataSet3.Locate('PART_NO', FieldByName('CUSTOMNO').AsString, []) then
      begin
        ClientDataSet3.Edit;
        ClientDataSet3.FieldByName('QTY').Value := ClientDataSet3.FieldByName('QTY').Value + FieldByName('EndProtQuat').AsInteger;
        ClientDataSet3.FieldByName('CARTON').Value := ClientDataSet3.FieldByName('CARTON').Value + 1;
      end
      else
      begin
        ClientDataSet3.Last;
        ClientDataSet3.Edit;
        ClientDataSet3.Append;
        ClientDataSet3.FieldByName('PART_NO').Value := FieldByName('CUSTOMNO').AsString;
        ClientDataSet3.FieldByName('QTY').Value := FieldByName('EndProtQuat').AsInteger;
        ClientDataSet3.FieldByName('CARTON').Value := 1;
      end;
      ClientDataSet3.Post;
      Next;
    end;
  end;
  for i := ClientDataSet3.RecordCount to 15 do
  begin
    ClientDataSet3.Edit;
    ClientDataSet3.Append;
    ClientDataSet3.FieldByName('PART_NO').Value := '';
    ClientDataSet3.Post;
  end;
  if Application.FindComponent('F_Print') = nil then
  begin
    Application.CreateForm(TF_Print, F_Print);
  end;
  F_Print.lTotalQTY.Caption := IntToStr(iTotalQTY);
  F_Print.lTotalCarton.Caption := IntToStr(ClientDataSet10.RecordCount);
  F_Print.Pu_OutNo:=ClientDataSet1.FieldByName('OutNo').AsString;
  F_Print.ClientDataSet1.Data := ClientDataSet3.Data;
  F_Print.Pu_DT:=FormatDateTime('yyyy-mm-dd', DateTimePicker4.Date);
  F_Print.get_BB_NO;
  F_Print.ShowModal;
  Button1.Click;
end;

procedure TfrmMain.DateTimePicker4Change(Sender: TObject);
begin
  DateTimePicker4.Tag:=1;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  strsql, temp1, temp2: string;
begin
  temp1 := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date) + ' 00:00:00';
  temp2 := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date) + ' 23:59:59';
  strsql := 'select * from EndProtOutDepotZ where OpeeDT>=''' + temp1 + ''' and OpeeDT<=''' + temp2 + '''';
  SelectClientDataSet(ClientDataSet1, strsql);
  ClientDataSet2.Close;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
  if Application.FindComponent('frmAlreadyPrint') = nil then
  begin
    Application.CreateForm(TfrmAlreadyPrint, frmAlreadyPrint);
  end;
  frmAlreadyPrint.Show;
end;

procedure TfrmMain.Button4Click(Sender: TObject);
begin
  frxReport1.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'frxReport6.fr3'); //uses  frxDesgn
  frxReport1.DesignReport();
end;

procedure TfrmMain.Button5Click(Sender: TObject);
begin
  if Application.FindComponent('F_Print') = nil then
  begin
    Application.CreateForm(TF_Print, F_Print);
  end;
  F_Print.Pu_DT:=FormatDateTime('yyyy-mm-dd', DateTimePicker4.Date);
  F_Print.get_BB_NO;
  ShowMessage(F_Print.lBB_NO.Caption);
  F_Print.Free;
end;

end.

