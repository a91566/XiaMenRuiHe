unit U_frmScaner;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, DBClient, StdCtrls, Grids, DBGridEh, RzPanel,
  RzTabs, StrUtils, ComCtrls, Menus;

type
  TfrmScaner = class(TForm)
    Image1: TImage;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPanel99: TRzPanel;
    DBGridEh1: TDBGridEh;
    RzPanel3: TRzPanel;
    Button1: TButton;
    ClientDataSet11: TClientDataSet;
    ClientDataSet12: TClientDataSet;
    Button3: TButton;
    Button2: TButton;
    Button4: TButton;
    OpenDialog1: TOpenDialog;
    RzPanel1: TRzPanel;
    Button5: TButton;
    Button6: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1DblClick(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ButtonMode(b:Boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

const
  cReadMe = 'DLL �汾����,����˵��:' +
    #13 + #10 + '�洢�����и���DLL�İ汾��.' +   
    #13 + #10 + '�����PDA��ͬ�İ汾�����ڿͻ��˸������ѣ�˫���С������汾���á�����ת��ֵ��ֻ�����PDA��.' +
    #13 + #10 + #13 + #10 + '2014��11��21�� 11:46:33 ֣�ٱ�';

var
  frmScaner: TfrmScaner;

implementation

uses ZsbFunPro2, ZsbDLL2, ZsbVariable2;

{$R *.dfm}

procedure TfrmScaner.ButtonMode(b:Boolean);
begin
  Button2.Enabled:=b;  
  Button3.Enabled:=b;
  Button4.Enabled:=b;  
  Button5.Enabled:=not b;
  Button6.Enabled:=not b;
  RzPanel1.Visible:=not b;
end;

procedure TfrmScaner.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //���� ��ʾ��������
end;

procedure TfrmScaner.Timer1Timer(Sender: TObject);
var
  h: THandle;
  bit: TBitmap;
begin
  Timer1.Enabled := False;
  if FileExists(ExtractFilePath(Application.Exename) + 'BitBtnImageFormZsbDll2.dll') then
  begin
    h := LoadLibrary('BitBtnImageFormZsbDll2.dll'); //���� DLL
    bit := TBitmap.Create;
    bit.LoadFromResourceName(h, 'imgLZtopForZhuiSuSYS2'); //��ȡ��Դ
    Image1.Picture.Assign(bit);
    FreeLibrary(h); //��ж DLL
    bit.Free;
  end;
  RzPanel99.Visible := True;
  Button1.Click;
end;

procedure TfrmScaner.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //������С���
end;

procedure TfrmScaner.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmScaner.Image1DblClick(Sender: TObject);
begin
  ZsbShowMessageNoApp(Self, cReadMe);
end;    

procedure TfrmScaner.DBGridEh1DblClick(Sender: TObject);
var
  temp, exsql: string;
begin
  if DBGridEh1.Col <> 6 then Exit;
  if ClientDataSet1.FieldByName('iType').AsString = 'PC' then Exit;
  temp := ClientDataSet1.FieldByName('OtherCanUses').AsString;
  if temp = '��' then
  begin
    temp := '��';
  end
  else
  begin
    temp := '��';
  end;
  exsql := 'update appver_dll set OtherCanUses=''' + temp + ''' where iType=''PDA'' and DLLName=''' + ClientDataSet1.FieldByName('DLLName').AsString + '''';
  if EXSQLClientDataSet(ClientDataSet11, exsql) then
  begin
    Button1.Click;
    DBGridEh1.Repaint;
  end
  else
  begin
    zsbSimpleMSNPopUpShow('����ʧ��.');
  end;
end;

procedure TfrmScaner.Button2Click(Sender: TObject);
begin
  ButtonMode(False);
end;

procedure TfrmScaner.Button1Click(Sender: TObject);
var
  strsql: string;
begin
  strsql := 'select * from QGCYLSM_Scaner order by id desc';
  SelectClientDataSet(ClientDataSet1, strsql);
end;

procedure TfrmScaner.Button5Click(Sender: TObject);
var
  exsql:string;
begin
  if (LabeledEdit1.Text='') or (LabeledEdit2.Text='') then
  begin
    zsbSimpleMSNPopUpShow('��������Ϣ.');
    Exit;
  end;
  if Button5.Tag=0 then
  begin
    exsql:='insert into QGCYLSM_Scaner(ScanNo,DEP)values('''+LabeledEdit1.Text+''','''+LabeledEdit2.Text+''')';
  end
  else
  begin  
    exsql:='update QGCYLSM_Scaner set ScanNo='''+LabeledEdit1.Text+''',DEP='''+LabeledEdit2.Text+
    ''' where id='''+IntToStr(Button5.Tag)+'''';
  end;
  if EXSQLClientDataSet(ClientDataSet11,exsql) then
  begin
    zsbSimpleMSNPopUpShow('�����ɹ�.');
    Button1.Click; 
    Button6.Click;
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self,'����ʧ��,����ϵ����Ա.');
  end;
end;

procedure TfrmScaner.Button6Click(Sender: TObject);
begin
  ButtonMode(True);
  Button5.Tag:=0;
end;

procedure TfrmScaner.Button3Click(Sender: TObject);
begin
  if ClientDataSet1.RecordCount=0 then Exit;
  LabeledEdit1.Text:=ClientDataSet1.FieldByName('ScanNo').AsString;
  LabeledEdit2.Text:=ClientDataSet1.FieldByName('DEP').AsString;  
  Button5.Tag:=ClientDataSet1.FieldByName('ID').AsInteger;
  ButtonMode(false);
end;

procedure TfrmScaner.Button4Click(Sender: TObject);
begin
  zsbSimpleMSNPopUpShow('�ݲ�֧��');
end;

end.

