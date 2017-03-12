unit U_frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect;

type
  TfrmMain = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    Timer2: TTimer;
    Image1: TImage;
    ClientDataSet10: TClientDataSet;
    Label22: TLabel;
    Timer3: TTimer;
    RzPanel99: TRzPanel;
    DBGridEh1: TDBGridEh;
    Panel4: TPanel;
    Panel3: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Button1: TButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SelectShow;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation //ZsbMsgBoxOkNoBlack

uses UDM, ZsbFunPro2, ZsbDLL2, ZsbVariable2, U_frmTbM;

{$R *.dfm}

procedure TfrmMain.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TfrmMain.SelectShow;
var
  temp,strsql: string;
begin
  temp := 'select * from staff order by online desc,usertype,stafname asc';
  SelectClientDataSet(ClientDataSet1, temp);

  strsql := 'select top 1 * from AppVer where notice=''1'' and iType=''PC'' order by id desc';
  SelectClientDataSetNoTips(FDM.GetNewAppVer, strsql);
  if FDM.GetNewAppVer.RecordCount > 0 then
  begin
    Label6.Caption := FDM.GetNewAppVer.FieldByName('ver').AsString;
  end;

  if ZStrAppVer = '' then
  begin
    ZStrAppVer := GetVersionString(Application.ExeName);
  end;
  Label1.Caption := zstrappver;

  
  temp := 'select id from staff where online=''1''';
  label10.Caption:=IntToStr(SelectClientDataSetResultCount(ClientDataSet10, temp));
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
  RzPanel99.Visible := True;
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
    Timer3.Enabled:=True;
  finally

  end;
end;

procedure TfrmMain.Timer3Timer(Sender: TObject);
begin
  if Timer3.Tag=0 then
  begin  
    SelectShow; 
    Timer3.Interval:=5000;
    Timer3.Tag:=1;
  end
  else
  begin
    SelectShow;
  end;
end;

procedure TfrmMain.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if Label6.Caption<>'' then
  begin
    if (ClientDataSet1.FieldByName('AppVer').AsString <> Label6.Caption) and
    (ClientDataSet1.FieldByName('AppVer').AsString <>'') then
    begin
      DBGridEh1.Canvas.Brush.Color := clYellow;
      DBGridEh1.Canvas.Font.Color := clRed;
      DBGridEh1.Canvas.Font.Style := [fsBold];
      DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
  end;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  if Application.FindComponent('frmTbM')=nil then
  begin
    Application.CreateForm(TfrmTbM,frmTbM);
  end;
  frmTbM.Show;
end;

end.

