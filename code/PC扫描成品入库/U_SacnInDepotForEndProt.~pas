unit U_SacnInDepotForEndProt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, 
  DBCtrlsEh, ExtCtrls, RzPanel, Clipbrd, mmsystem;

type
  TF_SacnInDepotForEndProt = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    Timer2: TTimer;
    Image1: TImage;
    ClientDataSet10: TClientDataSet;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    Timer3: TTimer;
    RzPanel11: TRzPanel;
    Label61: TLabel;
    RzPanel12: TRzPanel;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    Label10: TLabel;
    DBGridEh1: TDBGridEh;
    Button1: TButton;
    RzPanel1: TRzPanel;
    SpeedButton999: TSpeedButton;
    Button2: TButton;
    Memo1: TMemo;
    Label1: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure Timer3Timer(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    function isCanInDepot(lot: string): string; //存储过程 查询是否已经入库
    function LotsInDepot(InNo, Lots: string): string; //存储过程入库
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_SacnInDepotForEndProt: TF_SacnInDepotForEndProt;

implementation

uses UDM, ZsbDLL2, ZsbFunPro2, ZsbVariable2;

{$R *.dfm} //EndPot  TabSheet3    F_SelectPrintInfo

procedure TF_SacnInDepotForEndProt.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_SacnInDepotForEndProt.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_SacnInDepotForEndProt.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TF_SacnInDepotForEndProt.FormCreate(Sender: TObject);
begin
  Self.Top := 0;
  Self.Top := 0;
end;

procedure TF_SacnInDepotForEndProt.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
end;

procedure TF_SacnInDepotForEndProt.Timer1Timer(Sender: TObject);
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
  RzPanel11.Visible := True;
  LabeledEdit2.Text := ZStrUserDept;
  LabeledEdit3.Text := ZStrUser;
end;

procedure TF_SacnInDepotForEndProt.Timer2Timer(Sender: TObject);
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

procedure TF_SacnInDepotForEndProt.SpeedButton999Click(Sender: TObject);
var
  temp, exsql, lots: string;
  i: SmallInt;
begin
  if isSuprAdmin then
  begin
    zsbSimpleMSNPopUpShow('超级管理员不属于任何科室,无法操作.');
    Exit;
  end;
  if ClientDataSet1.RecordCount = 0 then Exit;
  //LabeledEdit1.Text:=GetEPIDDONO;
  LabeledEdit1.Text := 'R' + GetSetSerialNo('成入');
  exsql := 'insert into EndProtInDepotZ(EPIDDONO,DepotCode,UserCode,OpeeDT,State) values (''' + LabeledEdit1.Text + ''',''' + LabeledEdit2.Text +
    ''',''' + LabeledEdit3.Text + ''',''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) + ''',''Y'');';

 { with ClientDataSet1 do
  begin
    First;
    while not Eof do
    begin
      exsql := exsql + 'insert into EndProtInDepotMX(EPIDDONO,EndProtLot,InDepot,EndProtCode,ERPPDNO,EndProtQuat,ShefCode,DEP) values (''' + LabeledEdit1.Text +
      ''',''' + FieldByName('EndProtLot').AsString + ''',''Y'',''' + FieldByName('EndProtCode').AsString +
      ''',''' + FieldByName('ERPPDNO').AsString + ''',''' + FieldByName('EndProtQuat').AsString +
      ''',''' + FieldByName('ShefCode').AsString + ''',''' + FieldByName('DEP').AsString + ''');';
      Next;
    end;
  end; }

  {with ClientDataSet1 do  //2014年5月23日 11:36:31
  begin
    First;
    while not Eof do
    begin
      exsql := exsql + 'update EndProtBarCode set InNo='''+LabeledEdit1.Text+''' where EndProtLot='''+FieldByName('EndProtLot').AsString+
      '''';
      Next;
    end;
  end; }

  i := 1;
  with ClientDataSet1 do //2014年5月24日 13:56:50
  begin
    First;
    while not Eof do
    begin
      if i = 1 then
      begin
        lots := '(''''' + FieldByName('EndProtLot').AsString + '''''';   //两个单引号
        Inc(i);
      end
      else
      begin
        lots := lots + ',''''' + FieldByName('EndProtLot').AsString + '''''';
      end;
      Next;
    end;
  end;

  lots := lots + ')';
  if EXSQLClientDataSet(ClientDataSet10, exsql) then
  begin
    temp := LotsInDepot(LabeledEdit1.Text, lots);
    if temp <> '0' then
    begin
      zsbSimpleMSNPopUpShow('操作成功,影响数据' + temp + '条.');
      RzPanel1.Visible := false;
      RzPanel11.Enabled := True;
    end
    else
    begin
      EXSQLClientDataSet(ClientDataSet10, 'delete from EndProtInDepotZ where EPIDDONO='''+LabeledEdit1.Text+'''');
      ZsbMsgErrorInfoNoApp(Self, '操作失败，请联系管理员.');
    end;
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '操作失败，请联系管理员.');
  end;



 { if EXSQLClientDataSet(ClientDataSet10,exsql) then
  begin
    zsbSimpleMSNPopUpShow('操作成功.');
    RzPanel1.Visible := false;
    RzPanel11.Enabled := True;
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self,'操作失败，请联系管理员.');
  end; }
end;

procedure TF_SacnInDepotForEndProt.Button1Click(Sender: TObject);
var
  strsql: string;
begin
  RzPanel1.Visible := True;
  RzPanel11.Enabled := false;
  LabeledEdit1.Text := 'XXX';
  Memo1.SetFocus;
  strsql := 'select ERPPDNO,EndProtCode,EndProtQuat,EndProtLot,DEP,ShefCode from EndProtBarCode where 1=2';
  SelectClientDataSetNoTips(ClientDataSet1, strsql);
end;

procedure TF_SacnInDepotForEndProt.Button2Click(Sender: TObject);
var
  strsql: string;
begin
  if ZsbMsgBoxOkNoApp(Self, '确认操作么?') = false then Exit;
  RzPanel1.Visible := false;
  RzPanel11.Enabled := True;
  strsql := 'select ERPPDNO,EndProtCode,EndProtQuat,EndProtLot,DEP,ShefCode from EndProtBarCode where 1=2';
  SelectClientDataSetNoTips(ClientDataSet1, strsql);
end;

function TF_SacnInDepotForEndProt.isCanInDepot(lot: string): string;
var
  strsql: string;
begin
  strsql := 'declare @out int  exec @out=ZP_isCanInDepot ';
  strsql := strsql + '''' + lot + '''';
  strsql := strsql + ' select @out outvalue';
  //SaveMessage(strsql,'sql');
  Result := SelectClientDataSetResultFieldCaption(ClientDataSet10, strsql, 'outvalue');
end;

function TF_SacnInDepotForEndProt.LotsInDepot(InNo, Lots: string): string;
var
  strsql: string;
begin
  strsql := 'declare @out int  exec @out=ZP_setInDepot ';
  strsql := strsql + '''' + InNo + ''',';
  strsql := strsql + '''' + Lots + '''';
  strsql := strsql + ' select @out outvalue';
  //SaveMessage(strsql, 'sql');
  Result := SelectClientDataSetResultFieldCaption(ClientDataSet10, strsql, 'outvalue');
end;

procedure TF_SacnInDepotForEndProt.Memo1KeyPress(Sender: TObject;
  var Key: Char);
var
  TSList: TStringList;
  iTemp:SmallInt;
  temp:string;
begin
  if Key = #13 then
  begin
    TSList := Split2DCode(Memo1.Lines.Text);
    if TSList.Count <> 6 then
    begin
      zsbSimpleMSNPopUpShow_2('条码解析错误.', clRed);
      Memo1.Text := '';
      Exit;
    end;
    if ClientDataSet1.Locate('EndProtLot', TSList[3], []) then
    begin
      zsbSimpleMSNPopUpShow_2('此标签已存在列表中.', clRed);
      ClientDataSet1.Last;
      Memo1.Text := '';
      Exit;
    end;
    //iTemp:=StrToInt(isCanInDepot(TSList[3]));
    Temp:=isCanInDepot(TSList[3]);
    iTemp:=StrToInt(Temp);
    if iTemp<>0 then
    begin
      Timer3.Enabled:=True;
      case iTemp of
        1:temp:='不可识别的批次码.';
        2:temp:='此标签已经入库,请勿重复操作.';
        3:temp:='此标签已经报废.';
      end;
      ZsbMsgErrorInfoNoApp(Self,temp);
      Timer3.Enabled:=False;
      ClientDataSet1.Last;
      Memo1.Text := '';
      Exit;
    end;
    ClientDataSet1.Edit;
    ClientDataSet1.Insert;
    ClientDataSet1.FieldByName('ERPPDNO').Value := TSList[0];
    ClientDataSet1.FieldByName('EndProtCode').Value := TSList[1];
    ClientDataSet1.FieldByName('EndProtQuat').Value := TSList[2];
    ClientDataSet1.FieldByName('EndProtLot').Value := TSList[3];
    ClientDataSet1.FieldByName('DEP').Value := TSList[4];
    ClientDataSet1.FieldByName('ShefCode').Value := TSList[5];
    ClientDataSet1.Post;
    Memo1.Text := '';
  end;
end;

procedure TF_SacnInDepotForEndProt.Timer3Timer(Sender: TObject);
var
  fn:PChar;
begin
  if fn='' then
  begin
    fn:=PChar(ExtractFilePath(Application.ExeName)+'Windows XP 惊叹号.wav');
  end;
  PlaySound(fn,0,snd_async);
end;

end.

