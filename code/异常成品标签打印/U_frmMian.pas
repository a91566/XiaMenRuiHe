unit U_frmMian;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, RzPanel, DB, DBClient;

type
  TfrmMian = class(TForm)
    RzPanel4: TRzPanel;
    RzPanel1: TRzPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    Timer2: TTimer;
    Label5: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label4Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Label2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label2MouseLeave(Sender: TObject);
    procedure Label3MouseLeave(Sender: TObject);
    procedure Label3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label4MouseLeave(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    procedure LoadQX;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMian: TfrmMian;

implementation

uses ZsbDLL2, U_PrintAgain_Before, U_PrintAgain_After, UDM, ZsbVariable2,
  ZsbFunPro2;

{$R *.dfm}

procedure TfrmMian.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TfrmMian.LoadQX;
var
  strsql: string;
begin
  label2.Enabled:=False;
  label3.Enabled:=False;
  strsql := 'select funccode from userpower where usercode=''' + ZStrUserCode + ''' and powertype=''PC'' and funccode like ''06030%''';
  SelectClientDataSetNoTips(ClientDataSet1, strsql);
  if ClientDataSet1.RecordCount > 0 then    
  begin
    if ClientDataSet1.Locate('funccode', '060301', []) then
    begin
      Label2.Enabled := True;
    end;
    if ClientDataSet1.Locate('funccode', '060302', []) then
    begin
      Label3.Enabled := True;
    end;
  end;
end;

procedure TfrmMian.Button2Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmMian.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmMian.Label4Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmMian.Label2Click(Sender: TObject);
begin
  if Application.FindComponent('F_PrintAgain_Before') = nil then
  begin
    Application.CreateForm(TF_PrintAgain_Before, F_PrintAgain_Before);
  end;
  F_PrintAgain_Before.show;
  Self.Close;
end;

procedure TfrmMian.Label3Click(Sender: TObject);
begin
  if Application.FindComponent('F_PrintAgain_After') = nil then
  begin
    Application.CreateForm(TF_PrintAgain_After, F_PrintAgain_After);
  end;
  F_PrintAgain_After.show;
  Self.Close;  
end;

procedure TfrmMian.Timer1Timer(Sender: TObject);
begin
  try
    timer1.Enabled:=False;
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
    if isSuprAdmin=False then
    begin   
      LoadQX;
    end;
  finally

  end;
end;

procedure TfrmMian.Label2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Label2.Font.Style:=[fsBold];
end;

procedure TfrmMian.Label2MouseLeave(Sender: TObject);
begin
  Label2.Font.Style:=[];
end;

procedure TfrmMian.Label3MouseLeave(Sender: TObject);
begin
  Label3.Font.Style:=[];
end;

procedure TfrmMian.Label3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Label3.Font.Style:=[fsBold];
end;

procedure TfrmMian.Label4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Label4.Font.Style:=[fsBold];
end;

procedure TfrmMian.Label4MouseLeave(Sender: TObject);
begin
  Label4.Font.Style:=[];
end;

procedure TfrmMian.Timer2Timer(Sender: TObject);
begin
  Label2.Font.Style:=[];
  Label3.Font.Style:=[];
  Label4.Font.Style:=[];
end;

end.

