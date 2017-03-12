unit U_CangKuJinHuoDanYanZhen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  ComCtrls, Menus, RzGroupBar;

type
  TF_CangKuJinHuoDanYanZhen = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    Timer2: TTimer;
    OpenDialog1: TOpenDialog;
    Image1: TImage;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    ClientDataSet3: TClientDataSet;
    DataSource3: TDataSource;
    ClientDataSet10: TClientDataSet;
    ClientDataSet4: TClientDataSet;
    DataSource4: TDataSource;
    ClientDataSet11: TClientDataSet;
    Timer3: TTimer;
    Timer4: TTimer;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    Label4: TLabel;
    Panel3: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    DateTimePicker3: TDateTimePicker;
    DateTimePicker4: TDateTimePicker;
    LabeledEdit2: TLabeledEdit;
    RzPageControl4: TRzPageControl;
    RzTabSheet3: TRzTabSheet;
    DBGridEh3: TDBGridEh;
    RzPageControl5: TRzPageControl;
    RzTabSheet4: TRzTabSheet;
    DBGridEh4: TDBGridEh;
    Button1: TButton;
    RzPanel4: TRzPanel;
    Label3: TLabel;
    Panel1: TPanel;
    RzPageControl2: TRzPageControl;
    RzTabSheet1: TRzTabSheet;
    RzPageControl3: TRzPageControl;
    RzTabSheet2: TRzTabSheet;
    SpeedButton999: TSpeedButton;
    LabeledEdit1: TLabeledEdit;
    Label2: TLabel;
    Label1: TLabel;
    DateTimePicker2: TDateTimePicker;
    DateTimePicker1: TDateTimePicker;
    DBGridEh1: TDBGridEh;
    DBGridEh2: TDBGridEh;
    Timer5: TTimer;
    Button2: TButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure DBGridEh1ColWidthsChanged(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure DBGridEh3CellClick(Column: TColumnEh);
    procedure Timer5Timer(Sender: TObject);
    procedure LabeledEdit2Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
  F_CangKuJinHuoDanYanZhen: TF_CangKuJinHuoDanYanZhen;

implementation

uses UDM, ZsbFunPro2, ZsbVariable2, ZsbDLL2, U_YanZhenResult;

{$R *.dfm}

procedure TF_CangKuJinHuoDanYanZhen.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_CangKuJinHuoDanYanZhen.SavePadDianPlan(DDONO: string);
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
    end
    else
    begin
      ZsbMsgErrorInfoNoApp(Self, '对不起，操作失败！');
      Exit;
    end;
  end;
end;

procedure TF_CangKuJinHuoDanYanZhen.SetPanelLeft(iNO: SmallInt);

begin

end;

procedure TF_CangKuJinHuoDanYanZhen.ChongZhiPanDianJiHua;

begin

end;


function TF_CangKuJinHuoDanYanZhen.GetMPDDONO: string;
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

procedure TF_CangKuJinHuoDanYanZhen.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_CangKuJinHuoDanYanZhen.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05
  Action := caFree;
end;

procedure TF_CangKuJinHuoDanYanZhen.FormCreate(Sender: TObject);
begin
  Self.Top := 0;
  Self.Top := 0;
end;

procedure TF_CangKuJinHuoDanYanZhen.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 250, AW_CENTER); //窗口由小变大
end;

procedure TF_CangKuJinHuoDanYanZhen.Timer1Timer(Sender: TObject);
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
  RzPanel2.Visible := True;
  DateTimePicker1.Date := StrToDate(FormatDateTime('yyyy-MM-', Now) + '01');
  DateTimePicker2.Date := Now;
  DateTimePicker3.Date := DateTimePicker1.Date;
  DateTimePicker4.Date := Now;
end;

procedure TF_CangKuJinHuoDanYanZhen.Timer2Timer(Sender: TObject);
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

procedure TF_CangKuJinHuoDanYanZhen.SpeedButton999Click(Sender: TObject);
var
  strSQL1: string;
begin
  with ClientDataSet1 do //连接其他数据库
  begin
    RemoteServer.AppServer.LinkHISData('1');
  end;
  strSQL1 := 'select PS_DD,PS_NO,CUS_NO from MF_PSS where PS_DD>=''' + FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date) +
    ''' and PS_DD<=''' + FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date) + '''';
  if LabeledEdit1.Text <> '' then
  begin
    strSQL1 := strSQL1 + ' and CUS_NO like ''%' + LabeledEdit1.Text + '%''';
  end;
  with ClientDataSet1 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strSQL1);
  end;
  ClientDataSet2.Close;
  Label3.Caption:='ERP进货单';
end;

procedure TF_CangKuJinHuoDanYanZhen.DBGridEh1ColWidthsChanged(
  Sender: TObject);
begin
  SetPanelLeft(1);
end;

procedure TF_CangKuJinHuoDanYanZhen.Button1Click(Sender: TObject);
var
  strsql, temp1, temp2: string;
begin
  if LabeledEdit2.Text = '' then
  begin
    zsbSimpleMSNPopUpShow('请选选择供应商');
    Exit;
  end;
  temp1 := FormatDateTime('yyyy-mm-dd', DateTimePicker3.Date) + ' 00:00:00';
  temp2 := FormatDateTime('yyyy-mm-dd', DateTimePicker4.Date) + ' 23:59:59';
  strsql := 'select * from matlInDepotZ where OpeeDT>=''' + temp1 + ''' and OpeeDT<=''' + temp2 + '''';
  if LabeledEdit2.Text <> '' then
  begin
    strsql := strsql + ' and SuprCode=''' + LabeledEdit2.Text + '''';
  end;
  strsql := strsql + ' order by id desc';
  {
  strsql := 'select matlInDepotZ.*,Supplier.SuprCode+''/''+Supplier.SuprName SuprCodeName from matlInDepotZ,Supplier where matlInDepotZ.OpeeDT>=''' +
    temp1 + ''' and matlInDepotZ.OpeeDT<=''' + temp2 + ''' and matlInDepotZ.SuprCode=Supplier.SuprCode+''/''+Supplier.SuprName';
  if LabeledEdit2.Text <> '' then
  begin
    strsql := strsql + ' and matlInDepotZ.SuprCode like ''%' + LabeledEdit2.Text + '%''';
  end;
  strsql := strsql + ' order by matlInDepotZ.id desc';
  }
  SelectClientDataSet(ClientDataSet3, strsql);
  ClientDataSet4.Close; 
  label4.Caption:='力真进货单';
end;

procedure TF_CangKuJinHuoDanYanZhen.DBGridEh1CellClick(Column: TColumnEh);
var
  temp, strSQL1: string;
begin
  temp := ClientDataSet1.FieldByName('PS_NO').AsString;
  if temp = '' then Exit;  
  Label3.Caption:='ERP进货单'+temp;
  strSQL1 := 'select PRD_NO,QTY from TF_PSS where PS_NO=''' + temp + '''';
  with ClientDataSet2 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strSQL1);
  end;
  LabeledEdit2.Text:=ClientDataSet1.FieldByName('CUS_NO').AsString;
end;

procedure TF_CangKuJinHuoDanYanZhen.DBGridEh3CellClick(Column: TColumnEh);
begin
  Timer5.Enabled := True;
end;

procedure TF_CangKuJinHuoDanYanZhen.Timer5Timer(Sender: TObject);
var
  strsql, temp: string;
  i: SmallInt;
begin
  Timer5.Enabled := False;
 { if DBGridEh3.Col <> 1 then
  begin
    strsql := 'select * from MatlInDepotMx where MIDDONO=''' + ClientDataSet3.FieldByName('MIDDONO').AsString + '''';
  end
  else  }
  begin
    label4.Caption:='力真进货单';
    ClientDataSet10.Data := ClientDataSet3.Data;
    ClientDataSet10.Filter := 'isselect=''1''';
    ClientDataSet10.Filtered := True;
    if ClientDataSet10.RecordCount = 0 then
    begin
      strsql := 'select * from MatlInDepotMx where MIDDONO=''' + ClientDataSet3.FieldByName('MIDDONO').AsString + '''';
    end
    else
    begin
      i := 0;
      with ClientDataSet10 do
      begin
        First;
        while not eof do
        begin
          if i = 0 then
          begin
            temp := ' where MIDDONO in(''' + FieldByName('MIDDONO').AsString + '''';
            label4.Caption:=label4.Caption+FieldByName('MIDDONO').AsString;
            i := i + 1;
          end
          else
          begin
            temp := temp + ',''' + FieldByName('MIDDONO').AsString + ''''; 
            label4.Caption:=label4.Caption+','+FieldByName('MIDDONO').AsString;
          end;
          Next;
        end;
      end;
      temp := temp + ')';
      strsql := 'select * from MatlInDepotMx' + temp;
    end;
  end;
  //ZsbMsgErrorInfoNoApp(Self,strsql);
  SelectClientDataSet(ClientDataSet4, strsql);
end;

procedure TF_CangKuJinHuoDanYanZhen.LabeledEdit2Change(Sender: TObject);
begin
  Button1.Click;
end;

procedure TF_CangKuJinHuoDanYanZhen.Button2Click(Sender: TObject);   
begin
  if label4.Caption='力真进货单' then
  begin
    ZsbMsgErrorInfoNoApp(Self,'没有选择力真进货单.');
    Exit;
  end;
  if label3.Caption='ERP进货单' then
  begin
    ZsbMsgErrorInfoNoApp(Self,'没有选择ERP进货单.');
    Exit;
  end;
  if Application.FindComponent('F_YanZhenResult')=nil then
  begin
    Application.CreateForm(TF_YanZhenResult,F_YanZhenResult);
  end;
  F_YanZhenResult.Label1.Caption:=label3.Caption+'与'+label4.Caption+',验证结果如下';
  F_YanZhenResult.Timer1.Enabled:=True;
  F_YanZhenResult.ShowModal;
end;

end.

