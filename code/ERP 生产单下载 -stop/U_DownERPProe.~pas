{

这边下载ERP生产单的后，最好能生成一个出库单 。
（客户要求的，直接提示出库哪个批号是最早的，而不是一个一个去找然后扫描验证是不是最早的批次）
好像这样也不行，要是货不见了呢。

显示最早的批次，供打印出单据。

                }

unit U_DownERPProe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  ComCtrls, frxClass,frxCross,frxBarcode;

type
  TF_DownERPProe = class(TForm)
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
    Image1: TImage;
    RzPageControl2: TRzPageControl;
    RzTabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    DateTimePicker2: TDateTimePicker;
    LabeledEdit1: TLabeledEdit;
    RzPageControl6: TRzPageControl;
    RzTabSheet5: TRzTabSheet;
    ScrollBox6: TScrollBox;
    RzPanel5: TRzPanel;
    RzPageControl4: TRzPageControl;
    RzTabSheet3: TRzTabSheet;
    ScrollBox2: TScrollBox;
    RzPanel2: TRzPanel;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    ClientDataSet3: TClientDataSet;
    DataSource3: TDataSource;
    ClientDataSet4: TClientDataSet;
    DataSource4: TDataSource;
    RzPageControl3: TRzPageControl;
    RzTabSheet2: TRzTabSheet;
    ScrollBox3: TScrollBox;
    RzPanel3: TRzPanel;
    DBGridEh2: TDBGridEh;
    RzPageControl5: TRzPageControl;
    RzTabSheet4: TRzTabSheet;
    ScrollBox4: TScrollBox;
    RzPanel4: TRzPanel;
    DBGridEh3: TDBGridEh;
    DBGridEh4: TDBGridEh;
    DBGridEh1: TDBGridEh;
    RzPanel6: TRzPanel;
    Button1: TButton;
    Image2: TImage;
    ClientDataSet11: TClientDataSet;
    ClientDataSet10: TClientDataSet;
    ClientDataSet5: TClientDataSet;
    DataSource5: TDataSource;
    RzPanel7: TRzPanel;
    Image3: TImage;
    Button2: TButton;
    frxReport1: TfrxReport;
    ClientDataSet101: TClientDataSet;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure SpeedButton999Click(Sender: TObject);
    procedure DBGridEh2CellClick(Column: TColumnEh);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    function SelectQiBie(strProeNo: String):string;
    function SelectLingLiaoShiJian(strProeNo: String):string;
    { Private declarations }
  public
    procedure SelectProeDocFromLZDB;
    procedure SelectProeDocFromERPDB;

    { Public declarations }
  end;

var
  F_DownERPProe: TF_DownERPProe;

implementation

uses UDM, ZsbDLL2, ZsbFunPro2;

{$R *.dfm}    

procedure TF_DownERPProe.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

function TF_DownERPProe.SelectQiBie(strProeNo: String):string;
var          //期别=客户订单CUS_OS_NO
  strSQL1: string;
begin
  with ClientDataSet101 do //连接其他数据库
  begin
    RemoteServer.AppServer.LinkHISData('1');
  end;
  strSQL1 := 'select CUS_OS_NO from MF_MO where MO_NO>=''' + ClientDataSet3.fieldbyname('ERPPDNO').AsString + '''';
  with ClientDataSet101 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strSQL1);
  end;
  Result:=ClientDataSet101.fieldbyname('CUS_OS_NO').AsString;
end;

function TF_DownERPProe.SelectLingLiaoShiJian(strProeNo: String):string;
var          //领料时间=附件张数   FJ_NUM
  strSQL1: string;
begin
  with ClientDataSet101 do //连接其他数据库
  begin
    RemoteServer.AppServer.LinkHISData('1');
  end;
  strSQL1 := 'select FJ_NUM from MF_ML where ML_NO>=''' + ClientDataSet3.fieldbyname('ERPPDNO').AsString + '''';
  with ClientDataSet101 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strSQL1);
  end;
  Result:=ClientDataSet101.fieldbyname('FJ_NUM').AsString;
end;

procedure TF_DownERPProe.SelectProeDocFromERPDB;
var
  strSQL1: string;
begin
  with ClientDataSet1 do //连接其他数据库
  begin
    RemoteServer.AppServer.LinkHISData('1');
  end;
  strSQL1 := 'select * from MF_MO where MO_DD>=''' + FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date) + ''' and MO_DD<=''' +
    FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date) + '''';
  if LabeledEdit1.Text <> '' then
  begin
    strSQL1 := strSQL1 + ' and MO_NO like ''%' + LabeledEdit1.Text + '%''';
  end;
  with ClientDataSet1 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strSQL1);
  end;
  ClientDataSet2.Close;
end;

procedure TF_DownERPProe.SelectProeDocFromLZDB;
var
  strSQL2: string;
begin
  strSQL2 := 'select * from ERPProduceDocZ where OpeeDT>=''' + FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date) + ''' and OpeeDT<=''' +
    FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date) + '''';
  if LabeledEdit1.Text <> '' then
  begin
    strSQL2 := strSQL2 + ' and ERPPDNO like ''%' + LabeledEdit1.Text + '%''';
  end;
  SelectClientDataSet(ClientDataSet3, strSQL2);
  ClientDataSet4.Close;
end;

procedure TF_DownERPProe.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_DownERPProe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05
  Action := caFree;
end;

procedure TF_DownERPProe.FormCreate(Sender: TObject);
begin
  Self.Left := 50;
  Self.Top := 50;
end;

procedure TF_DownERPProe.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
  DateTimePicker1.Date := StrToDate(FormatDateTime('yyyy-mm-', Now) + '01');
  DateTimePicker2.Date := StrToDate(FormatDateTime('yyyy-mm-dd', Now));
end;

procedure TF_DownERPProe.Timer1Timer(Sender: TObject);
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
    Image3.Picture.Assign(bit2);
    FreeLibrary(h); //载卸 DLL
    bit.Free;
    bit2.Free;
  end;
  RzPageControl1.Visible := True;
  RzPageControl1.ActivePageIndex := 0;
  RzPageControl2.ActivePageIndex := 0;
end;

procedure TF_DownERPProe.Timer2Timer(Sender: TObject);
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

procedure TF_DownERPProe.DBGridEh1CellClick(Column: TColumnEh);
var
  temp, strSQL1: string;
begin
  temp := ClientDataSet1.FieldByName('MO_NO').AsString;
  if temp = '' then Exit;
  strSQL1 := 'select * from TF_MO where MO_NO=''' + temp + '''';
  with ClientDataSet2 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strSQL1);
  end;
end;

procedure TF_DownERPProe.SpeedButton999Click(Sender: TObject);
begin
  SelectProeDocFromERPDB;
  SelectProeDocFromLZDB;
end;

procedure TF_DownERPProe.DBGridEh2CellClick(Column: TColumnEh);
var
  temp, strSQL1: string;
begin
  temp := ClientDataSet3.FieldByName('ERPPDNO').AsString;
  if temp = '' then Exit;
  strSQL1 := 'select * from ERPProduceDocMX where ERPPDNO=''' + temp + '''';
  SelectClientDataSet(ClientDataSet4, strSQL1);
end;

procedure TF_DownERPProe.Button1Click(Sender: TObject);
var
  temp, strshow, strsql, exsql: string;
begin
  temp := ClientDataSet1.FieldByName('MO_NO').AsString;
  if temp = '' then Exit;
  strshow := '确认下载单号[' + temp + ']的生产单么？';
  if ZsbMsgBoxOkNoBlackNoApp(Self, strshow) = False then Exit;
  strsql := 'select id from ERPProduceDocZ where ERPPDNO=''' + temp + ''''; //查询是否已经存在
  exsql := '';
  if SelectClientDataSetResultCount(ClientDataSet11, strsql) > 0 then
  begin
    if ZsbMsgBoxOkNoBlackNoApp(Self, '该单已经下载，是否更新？') = False then Exit;
    exsql := 'delete from ERPProduceDocZ where ERPPDNO=''' + temp + ''';'; //先删除
    exsql := exsql + 'delete from ERPProduceDocMX where ERPPDNO=''' + temp + ''';'; //先删除
  end;
  if ClientDataSet2.Data=null then DBGridEh1CellClick(DBGridEh1.Columns[0]);
  with ClientDataSet2 do
  begin
    First;
    while not Eof do
    begin
      exsql :=exsql+'insert into ERPProduceDocMX(ERPPDNO,MatlCode,MatlName,MatlQuat,DepotCode,OldestMatlLot) values (''' + temp + ''',''' +
        FieldByName('PRD_NO').AsString + ''',''' + FieldByName('PRD_NAME').AsString + ''',''' + FieldByName('QTY_RSV').AsString +
        ''',''' + FieldByName('WH').AsString + ''',''' + GetOldestMatlCode(FieldByName('PRD_NO').AsString,FieldByName('QTY_RSV').AsFloat ) + ''');';
      Next;
    end;
  end;
  exsql := exsql+'insert into ERPProduceDocZ(ERPPDNO,OpeeDT,ProeDept,EndProtCode,EndProtQuat,DownTime) values (''' + temp + ''',''' +
    ClientDataSet1.FieldByName('MO_DD').AsString + ''',''' + ClientDataSet1.FieldByName('DEP').AsString + ''',''' +
    ClientDataSet1.FieldByName('MRP_NO').AsString + ''',''' + ClientDataSet1.FieldByName('QTY').AsString + ''',''' +
    FormatDateTime('yyyy-mm-dd hh:mm:ss', Now) + ''');';
    
  if exsql <> '' then
  begin
    exsql := ' begin ' + exsql + ' commit; end;';
    if EXSQLClientDataSet(ClientDataSet10, exsql) then
    begin
      zsbSimpleMSNPopUpShow('下载成功！');
      SelectProeDocFromLZDB;
    end
    else
    begin
      ZsbMsgErrorInfoNoBlack(Application, Self, '对不起，操作失败！');
      Exit;
    end;
  end;
end;

procedure TF_DownERPProe.Button2Click(Sender: TObject);
var
  temp, strSQL1: string;
  i:SmallInt;
begin
  temp := ClientDataSet3.FieldByName('ERPPDNO').AsString;
  if temp = '' then Exit;
  strSQL1 := 'select MatlQuatAlreadyOut,MatlCode,MatlName,MatlQuat,DepotCode,ERPPDNO,OldestMatlLot,ZSBTemp from ERPProduceDocMX where ERPPDNO=''' + temp + '''';
  SelectClientDataSet(ClientDataSet11, strSQL1);
  with ClientDataSet11 do
  begin
    First;
    i:=1;
    while not eof do
    begin
      Edit;
      FieldByName('MatlQuatAlreadyOut').Value:=IntToStr(i);
      i:=i+1;
      Next;
    end;
  end;
  frxReport1.Clear;
  frxReport1.LoadFromFile(ExtractFilePath(ParamStr(0)) + '\frERPProeDoc.fr3');
  TfrxBarCodeView(frxReport1.FindObject('BarCode1')).Text := ClientDataSet3.fieldbyname('ERPPDNO').AsString;
  TfrxMemoView(frxReport1.FindObject('Memo1')).Memo.Text :=SelectQiBie(ClientDataSet3.fieldbyname('ERPPDNO').AsString);
 // TfrxMemoView(frxReport1.FindObject('Memo2')).Memo.Text := ClientDataSet3.fieldbyname('ERPPDNO').AsString;    
  TfrxMemoView(frxReport1.FindObject('Memo2')).Memo.Text := '';
  TfrxMemoView(frxReport1.FindObject('Memo3')).Memo.Text := ClientDataSet3.fieldbyname('EndProtCode').AsString;
  TfrxMemoView(frxReport1.FindObject('Memo4')).Memo.Text := ClientDataSet3.fieldbyname('ProeDept').AsString;
  TfrxMemoView(frxReport1.FindObject('Memo5')).Memo.Text := SelectLingLiaoShiJian(ClientDataSet3.fieldbyname('ERPPDNO').AsString);
  frxReport1.ShowReport;

 { if N12.Checked = True then
  begin
    frxReport1.ShowReport;
  end
  else
  begin
    frxReport1.PrepareReport;
    frxReport1.PrintOptions.ShowDialog := False; //不显示打印机选择框
    frxReport1.Print; //打印
  end;   }
end;

procedure TF_DownERPProe.frxReport1BeforePrint(
  Sender: TfrxReportComponent);
var
  Cross, Cross1: TfrxCrossView;
  i, j: Integer;
begin

  ClientDataSet11.Fields[0].DisplayLabel := 'No.';
  ClientDataSet11.Fields[1].DisplayLabel := '睿和料号';
  ClientDataSet11.Fields[2].DisplayLabel := '品名';
  ClientDataSet11.Fields[3].DisplayLabel := '领料数量';
  ClientDataSet11.Fields[4].DisplayLabel := '库别';
  ClientDataSet11.Fields[5].DisplayLabel := '发料单号';
  ClientDataSet11.Fields[6].DisplayLabel := '最早的批次';
  ClientDataSet11.Fields[7].DisplayLabel := '生产批号';

  if Sender is TfrxCrossView then
  begin
    Cross := TfrxCrossView(Sender);
    ClientDataSet11.First;
    i := 0;
    while not ClientDataSet11.Eof do
    begin
      for j := 0 to ClientDataSet11.FieldCount - 1 do
      begin
        Cross.AddValue([i], [ClientDataSet11.Fields[j].DisplayLabel], [ClientDataSet11.Fields[j].AsString]);
      end;
      ClientDataSet11.Next;
      Inc(i);
    end;
  end;
end;

end.

