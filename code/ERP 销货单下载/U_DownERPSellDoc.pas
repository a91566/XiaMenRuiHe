unit U_DownERPSellDoc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  ComCtrls;

type
  TF_DownERPSellDoc = class(TForm)
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
    RzPageControl5: TRzPageControl;
    RzTabSheet4: TRzTabSheet;
    ScrollBox4: TScrollBox;
    RzPanel4: TRzPanel;
    DBGridEh4: TDBGridEh;
    DBGridEh1: TDBGridEh;
    RzPanel6: TRzPanel;
    Button1: TButton;
    Image2: TImage;
    ClientDataSet11: TClientDataSet;
    ClientDataSet10: TClientDataSet;
    ClientDataSet5: TClientDataSet;
    DataSource5: TDataSource;
    DBGridEh2: TDBGridEh;
    DBGridEh3: TDBGridEh;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBGridEh2CellClick(Column: TColumnEh);
    procedure DBGridEh1CellClick(Column: TColumnEh);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public
    procedure SelectSellDocFromLZDB;
    procedure SelectSellDocFromERPDB;

    { Public declarations }
  end;

var
  F_DownERPSellDoc: TF_DownERPSellDoc;

implementation

uses UDM, ZsbDLL2, ZsbFunPro2;

{$R *.dfm}   

procedure TF_DownERPSellDoc.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_DownERPSellDoc.SelectSellDocFromERPDB;
var
  strSQL1: string;
begin
  with ClientDataSet1 do //连接其他数据库
  begin
    RemoteServer.AppServer.LinkHISData('1');
  end;
  strSQL1 := 'select * from MF_PSS where PS_DD>=''' + FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date) + ''' and PS_DD<=''' +
    FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date) + '''';
  if LabeledEdit1.Text <> '' then
  begin
    strSQL1 := strSQL1 + ' and PS_NO like ''%' + LabeledEdit1.Text + '%''';
  end;
  with ClientDataSet1 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strSQL1);
  end;
  ClientDataSet2.Close;
end;

procedure TF_DownERPSellDoc.SelectSellDocFromLZDB;
var
  strSQL2: string;
begin
  strSQL2 := 'select * from ERPSellDocZ where OpeeDT>=''' + FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date) + ''' and OpeeDT<=''' +
    FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date) + '''';
  if LabeledEdit1.Text <> '' then
  begin
    strSQL2 := strSQL2 + ' and ERPSDNO like ''%' + LabeledEdit1.Text + '%''';
  end;
  SelectClientDataSet(ClientDataSet3, strSQL2);
  ClientDataSet4.Close;
end;

procedure TF_DownERPSellDoc.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_DownERPSellDoc.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05
  Action := caFree;
end;

procedure TF_DownERPSellDoc.FormCreate(Sender: TObject);
begin
  Self.Left := 50;
  Self.Top := 50;
end;

procedure TF_DownERPSellDoc.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
  DateTimePicker1.Date := StrToDate(FormatDateTime('yyyy-mm-', Now) + '01');
  DateTimePicker2.Date := StrToDate(FormatDateTime('yyyy-mm-dd', Now));
end;

procedure TF_DownERPSellDoc.Timer1Timer(Sender: TObject);
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
  RzPageControl2.ActivePageIndex := 0;
end;

procedure TF_DownERPSellDoc.Timer2Timer(Sender: TObject);
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

procedure TF_DownERPSellDoc.SpeedButton999Click(Sender: TObject);
begin
  SelectSellDocFromERPDB;
  SelectSellDocFromLZDB;
end;

procedure TF_DownERPSellDoc.Button1Click(Sender: TObject);
var
  temp, strshow, strsql, exsql: string;
begin
  temp := ClientDataSet1.FieldByName('PS_NO').AsString;
  if temp = '' then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据');
    Exit;
  end;
  strshow := '确认下载单号[' + temp + ']的销货单么？';
  if ZsbMsgBoxOkNoBlackNoApp(Self, strshow) = False then Exit;
  strsql := 'select id from ERPSellDocZ where ERPSDNO=''' + temp + ''''; //查询是否已经存在
  exsql := '';
  if SelectClientDataSetResultCount(ClientDataSet11, strsql) > 0 then
  begin
    if ZsbMsgBoxOkNoBlackNoApp(Self, '该单已经下载，是否更新？') = False then Exit;
    exsql := 'delete from ERPSellDocZ where ERPSDNO=''' + temp + ''';'; //先删除
    exsql := exsql + 'delete from ERPSellDocMX where ERPSDNO=''' + temp + ''';'; //先删除
  end;
  if ClientDataSet2.Data=null then DBGridEh1CellClick(DBGridEh1.Columns[0]);
  with ClientDataSet2 do
  begin
    First;
    while not Eof do
    begin
      exsql :=exsql+'insert into ERPSellDocMX(ERPSDNO,EndProtCode,EndProtName,EndProtQuat,UNIT,DepotCode) values (''' + temp + ''',''' +
        FieldByName('PRD_NO').AsString + ''',''' + FieldByName('PRD_NAME').AsString + ''',''' +
        FieldByName('QTY').AsString + ''',''' + FieldByName('UNIT').AsString + ''',''' + FieldByName('WH').AsString + ''');';
      Next;
    end;
  end;
  exsql := exsql+'insert into ERPSellDocZ(ERPSDNO,OpeeDT,CustCode,DeptCode,DownTime) values (''' + temp + ''',''' +
    ClientDataSet1.FieldByName('PS_DD').AsString + ''',''' + ClientDataSet1.FieldByName('CUS_NO').AsString + ''',''' +
    ClientDataSet1.FieldByName('DEP').AsString + ''',''' + FormatDateTime('yyyy-mm-dd hh:mm:ss', Now) + ''');';

  if exsql <> '' then
  begin
    exsql := ' begin ' + exsql + ' commit; end;';
    if EXSQLClientDataSet(ClientDataSet10, exsql) then
    begin
      zsbSimpleMSNPopUpShow('下载成功！');
      SelectSellDocFromLZDB;
    end
    else
    begin
      ZsbMsgErrorInfoNoBlack(Application, Self, '对不起，操作失败！');
      Exit;
    end;
  end;
end;

procedure TF_DownERPSellDoc.DBGridEh2CellClick(Column: TColumnEh);
var
  temp, strSQL1: string;
begin
  temp := ClientDataSet3.FieldByName('ERPSDNO').AsString;
  if temp = '' then Exit;
  strSQL1 := 'select * from ERPSellDocMX where ERPSDNO=''' + temp + '''';
  SelectClientDataSet(ClientDataSet4, strSQL1);
end;

procedure TF_DownERPSellDoc.DBGridEh1CellClick(Column: TColumnEh);
var
  temp, strSQL1: string;
begin
  temp := ClientDataSet1.FieldByName('PS_NO').AsString;
  if temp = '' then Exit;
  strSQL1 := 'select * from TF_PSS where PS_NO=''' + temp + '''';
  with ClientDataSet2 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strSQL1);
  end;
end;

end.

