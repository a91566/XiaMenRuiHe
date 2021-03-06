unit U_ChangeCARTON;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzPanel, StdCtrls, psBarcode, Grids, DBGridEh, DB,
  DBClient, frxClass, frxBarcode;

type
  TF_ChangeCARTON = class(TForm)
    RzPanel4: TRzPanel;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    ClientDataSet10: TClientDataSet;
    RzPanel1: TRzPanel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    Button3: TButton;
    Label1: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    procedure Label3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RzPanel4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LabeledEdit7KeyPress(Sender: TObject; var Key: Char);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    function SaveHistory: Boolean;
    { Private declarations }
  public
    Pu_OutNo, Pu_DT: string;
    { Public declarations }
  end;

var
  F_ChangeCARTON: TF_ChangeCARTON;

implementation

uses UDM, ZsbDLL2, ZsbFunPro2, ZsbVariable2, U_frmMain, U_frmAlreadyPrint;

{$R *.dfm}

procedure TF_ChangeCARTON.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;



function TF_ChangeCARTON.SaveHistory: Boolean;
var
  exsql, temp: string;
  iCount: SmallInt;
begin
  exsql := 'insert into Log_BigBarCode(BB_NO,dt,iNo,PART_NO,QTY,CARTON,NEW_CARTON,Text,opdt,un)values(''' +LabeledEdit1.Text+
  ''',''' + LabeledEdit2.Text + ''',''' + LabeledEdit3.Text + ''',''' + LabeledEdit4.Text + ''',''' + LabeledEdit5.Text +
    ''',''' + LabeledEdit6.Text + ''',''' + LabeledEdit7.Text + ''',''' + Memo1.Lines.Text +
    ''',''' + FormatDateTime('yyyy-mm-dd HH:mm:ss', Now) + ''',''' + ZStrUser + ''');';

  if StrToInt(LabeledEdit6.Text)>StrToInt(LabeledEdit7.Text) then //原箱数  大于 新的箱数
  begin
    temp:='-';
    iCount:=StrToInt(LabeledEdit6.Text)-StrToInt(LabeledEdit7.Text);
  end
  else
  begin 
    temp:='+';  
    iCount:=StrToInt(LabeledEdit7.Text)-StrToInt(LabeledEdit6.Text);
  end;
  exsql := exsql + 'update BigBarCodeMX set CARTON='''+LabeledEdit7.Text+''' where  bb_no=''' + LabeledEdit2.Text +
  ''' and dt=''' + LabeledEdit1.Text + ''' and iNo=''' + LabeledEdit3.Text + ''';';

  exsql := exsql + 'update BigBarCodeZ set TotalCARTON=TotalCARTON'+temp+Inttostr(iCount)+' where  bb_no=''' +
  LabeledEdit2.Text + ''' and dt=''' + LabeledEdit1.Text + ''';';

  Result := EXSQLClientDataSet(ClientDataSet10, exsql);
end;

procedure TF_ChangeCARTON.Label3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (ssleft in Shift) then
  begin
    ReleaseCapture;
    Perform(WM_syscommand, $F012, 0);
  end;
end;

procedure TF_ChangeCARTON.RzPanel4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (ssleft in Shift) then
  begin
    ReleaseCapture;
    Perform(WM_syscommand, $F012, 0);
  end;
end;

procedure TF_ChangeCARTON.Button1Click(Sender: TObject);
begin
  if LabeledEdit6.Text=LabeledEdit7.Text then
  begin
    zsbSimpleMSNPopUpShow_2('数量没有更改',clRed);
    LabeledEdit7.SetFocus;
    Exit;
  end; 
  if Memo1.Lines.Text='' then
  begin
    zsbSimpleMSNPopUpShow_2('没有输入内容',clRed);
    Memo1.SetFocus;
    Exit;
  end;
  if SaveHistory = False then
  begin
    ZsbMsgErrorInfoNoApp(frmMain, '操作失败，请联系管理员。');
    Exit;
  end
  else
  begin
    zsbSimpleMSNPopUpShow('保存成功.');
    Self.Close;
    frmAlreadyPrint.Button1.Click;
  end;
end;

procedure TF_ChangeCARTON.Button3Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_ChangeCARTON.FormShow(Sender: TObject);
begin
  LabeledEdit7.SetFocus;
end;

procedure TF_ChangeCARTON.LabeledEdit7KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (key in ['0'..'9', #8, '.'])) then Key := #0;
end;

end.

