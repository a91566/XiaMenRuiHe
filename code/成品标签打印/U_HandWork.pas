unit U_HandWork;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, DBClient, StdCtrls, Grids, DBGridEh, RzPanel,
  RzTabs, frxClass, StrUtils, frxBarcode, psBarcode, ComCtrls, Spin,
  RzLabel;

type
  TF_HandWork = class(TForm)
    Image1: TImage;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPanel99: TRzPanel;
    ClientDataSet2: TClientDataSet;
    frxReport1: TfrxReport;
    ClientDataSet12: TClientDataSet;
    RzPanel8: TRzPanel;
    RzPanel9: TRzPanel;
    Label45: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label60: TLabel;
    psBarcode16: TpsBarcode;
    psBarcode17: TpsBarcode;
    psBarcode18: TpsBarcode;
    psBarcode19: TpsBarcode;
    LabeledEdit13_1: TLabeledEdit;
    LabeledEdit14_1: TLabeledEdit;
    LabeledEdit15_1: TLabeledEdit;
    psBarcode20: TpsBarcode;
    RzPanel10: TRzPanel;
    Label62: TLabel;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    LabeledEdit12: TLabeledEdit;
    LabeledEdit13: TLabeledEdit;
    LabeledEdit14: TLabeledEdit;
    LabeledEdit15: TLabeledEdit;
    LabeledEdit16: TLabeledEdit;
    LabeledEdit17: TLabeledEdit;
    LabeledEdit18: TLabeledEdit;
    LabeledEdit19: TLabeledEdit;
    LabeledEdit20: TLabeledEdit;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    LabeledEdit1: TLabeledEdit;
    ClientDataSet3_1: TClientDataSet;
    ClientDataSet3_2: TClientDataSet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpinEdit1: TSpinEdit;
    Timer2: TTimer;
    ClientDataSet4_OtherDB: TClientDataSet;
    LabeledEdit21: TLabeledEdit;
    LabeledEdit22: TLabeledEdit;
    Timer3: TTimer;
    Label5: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1DblClick(Sender: TObject);
    procedure LabeledEdit17Enter(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure LabeledEdit16Enter(Sender: TObject);
    procedure LabeledEdit11Change(Sender: TObject);
    procedure LabeledEdit20Change(Sender: TObject);
    procedure LabeledEdit10Change(Sender: TObject);
    procedure LabeledEdit13Change(Sender: TObject);
    procedure LabeledEdit14Change(Sender: TObject);
    procedure LabeledEdit15Change(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Label62Click(Sender: TObject);
    procedure Label62MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label1MouseLeave(Sender: TObject);
    procedure Label1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label62MouseLeave(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure LabeledEdit12Change(Sender: TObject);
    procedure LabeledEdit12KeyPress(Sender: TObject; var Key: Char);
  private
    PrEndProtLot: string;
    iTotalQuat, iAlreadyQuat: Integer;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SavePrintHistory;
    procedure GetEndProtQuat(strCode: string);
    procedure Made2DCode_2;
    procedure GetOtherInfo(MO_NO: string);
    { Private declarations }
  public
    { Public declarations }
  end;

const
  cReadMe = '�ֹ����ɱ�ǩ,����˵��:' +
    #13 + #10 + 'Ϊ�˷�ֹ����� bug ���´�ӡ������ǩ���ؿ��˹���.' +
    #13 + #10 + #13 + #10 + 'CONPANY-�ͻ�����' +
    #13 + #10 + 'PART NO-�Ʒ��' +
    #13 + #10 + 'QUANTITY-����' +
    #13 + #10 + 'LOT NO-�����' +
    #13 + #10 + 'SHIPPING DATE-װ������' +
    #13 + #10 + 'CUSTOM NO-�ͻ��Լ��ĺ�' +
    #13 + #10 + 'C/N' +
    #13 + #10 + 'Serial NO-��ˮ��' +
    #13 + #10 + 'REVISION-���' +
    #13 + #10 + '2014��5��7�� 16:52:26 ֣�ٱ�' +
    #13 + #10 + #13 + #10 + '���ӻ�ȡ���ݹ���,' +
    #13 + #10 + '�����������ɶ��ű�ǩ����,' +
    #13 + #10 + #13 + #10 + '2014��5��8�� 11:11:11 ֣�ٱ�';

var
  F_HandWork: TF_HandWork;

implementation

uses ZsbFunPro2, ZsbDLL2, ZsbVariable2, U_PrintCodeNew;

{$R *.dfm}

procedure TF_HandWork.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //���� ��ʾ��������
end;



procedure TF_HandWork.Made2DCode_2;
var
  BarCode2D: string;
begin
  BarCode2D := LabeledEdit12.Text + ',' + LabeledEdit11.Text + ',' + LabeledEdit10.Text +
    ',' + LabeledEdit17.Text + ',' + LabeledEdit18.Text + ',' + LabeledEdit19.Text;
  psBarcode19.BarCode := BarCode2D;
end;

procedure TF_HandWork.GetEndProtQuat(strCode: string);
var
  strsql, temp: string;
begin
  strsql := 'select quat,sname,ver from endprotquat where endprotcode=''' + strCode + '''';
  SelectClientDataSetNoTips(ClientDataSet2, strsql);
  if ClientDataSet2.RecordCount = 0 then Exit;
  temp := ClientDataSet2.FieldByName('quat').AsString;
  LabeledEdit10.Text := ClientDataSet2.FieldByName('quat').AsString;
  LabeledEdit14.Text := ClientDataSet2.FieldByName('sname').AsString;
  LabeledEdit20.Text := ClientDataSet2.FieldByName('ver').AsString;
  if LabeledEdit10.Text = '' then LabeledEdit10.Text := '0';
end;

procedure TF_HandWork.GetOtherInfo(MO_NO: string);
var
  strsql, temp: string;
begin
  with ClientDataSet3_1 do //�����������ݿ�
  begin
    RemoteServer.AppServer.LinkHISData('1');
  end;
  strsql := 'select DEP,WH,MRP_NO,QTY from MF_MO where MO_NO=''' + MO_NO + ''' ';

  with ClientDataSet3_1 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strsql);
  end;
  LabeledEdit11.Text := ClientDataSet3_1.fieldbyname('MRP_NO').AsString;
  LabeledEdit19.Text := ClientDataSet3_1.fieldbyname('WH').AsString;
  LabeledEdit18.Text := ClientDataSet3_1.fieldbyname('DEP').AsString;
  iTotalQuat := ClientDataSet3_1.fieldbyname('QTY').AsInteger;


  strsql := 'select sum(endprotquat) endprotquat from EndProtBarCode where ERPPDNO=''' + LabeledEdit12.Text +
    ''' and state=''Y''';
  temp := SelectClientDataSetResultFieldCaption(ClientDataSet3_1, strsql, 'endprotquat');
  if temp = '' then temp := '0';
  iAlreadyQuat := StrToInt(temp);

 { strsql:='select DEP,ML_NO from MF_ML where MO_NO='''+MO_NO+''' ';
  with ClientDataSet3_1 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strsql);
  end;
  LabeledEdit1.Text := ClientDataSet3_1.fieldbyname('ML_NO').AsString;   }
end;

procedure TF_HandWork.SavePrintHistory;
var
  custname, temp8, exsql, temp, tnull: string;
  i: SmallInt;
  bRt: Boolean;
begin
  temp8 := FormatDateTime('yyyy-MM-dd HH:mm:ss', Now);
  tnull := '';
  custname := StringReplace(LabeledEdit16.Text, '''', '''''', [rfReplaceAll]); //һ�������滻�������Ϳ�����
  exsql := '';
  for i := 1 to SpinEdit1.Value do
  begin
    if iTotalQuat > 0 then //û��ѡ��
    begin
      iAlreadyQuat := iAlreadyQuat + StrToInt(LabeledEdit10.Text);
      if iAlreadyQuat > iTotalQuat then
      begin
        iAlreadyQuat := iAlreadyQuat - StrToInt(LabeledEdit10.Text);
        Break;
      end;
    end;
    exsql := exsql + 'insert into EndProtBarCode(EndProtCode,EndProtQuat,CustCode,EndProtVer,EndProtLot,' +
      'OrderNo,Tips,OpeeDT,ShippingD,DEP,ShefCode,CustName,ERPPDNO,ML_NO,CUSTOMNO,uName,cn,HandWork)values(''' + LabeledEdit11.Text + ''',''' + LabeledEdit10.Text +
      ''',''' + tnull + ''',''' + LabeledEdit20.Text + ''',''' + LabeledEdit17.Text + ''',''' + tnull + ''',''' + tnull + ''',''' + temp8 +
      ''',''' + LabeledEdit13.Text + ''',''' + LabeledEdit18.Text + ''',''' + LabeledEdit19.Text +
      ''',''' + custname + ''',''' + LabeledEdit12.Text + ''',''' + LabeledEdit1.Text + ''',''' + LabeledEdit14.Text +
      ''',''' + ZStrUser + ''',''' + LabeledEdit15.Text + ''',''1'');';
    LabeledEdit17.Text := GetSetSerialNo('��Ʒ');
  end;
  if exsql <> '' then
  begin
    if EXSQLClientDataSet(ClientDataSet12, exsql) = False then
    begin
      temp := '����ʧ��.��TF_HandWork.SavePrintHistory';
      AddLog_ErrorText(temp);
      ZsbMsgErrorInfoNoApp(Self, temp);
    end
    else
    begin
      temp := '��ӳɹ�.���ɱ�ǩ�� ' + Inttostr(i - 1) + ' ����';
      zsbSimpleMSNPopUpShow(temp);
      AddLog_Operation('�ֹ��������ɱ�ǩ,�����' + LabeledEdit12.Text + ';Ʒ����' + LabeledEdit11.Text);
    end;
  end
  else
  begin
    zsbSimpleMSNPopUpShow('��ǩ�ѹ������������ɱ�ǩ.');
  end;
end;

procedure TF_HandWork.Timer1Timer(Sender: TObject);
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
end;

procedure TF_HandWork.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //������С���
  iTotalQuat := 0;
  iAlreadyQuat := 0;
end;

procedure TF_HandWork.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TF_HandWork.Image1DblClick(Sender: TObject);
begin
  ZsbShowMessageNoApp(Self, cReadMe);
end;

procedure TF_HandWork.LabeledEdit17Enter(Sender: TObject);
begin
  if LabeledEdit17.Text = '' then
  begin
    LabeledEdit17.Text := GetSetSerialNo('��Ʒ');
  end;
end;

procedure TF_HandWork.Button9Click(Sender: TObject);
var
  temp: string;
begin
  if LabeledEdit16.Text = '' then
  begin
    ShowInfoTips(LabeledEdit16.Handle, '������������ CONPANY ��.', 3);
    LabeledEdit16.SetFocus;
    Exit;
  end;
  if LabeledEdit17.Text = '' then
  begin
    ShowInfoTips(LabeledEdit17.Handle, 'û�����Σ������ı����ȡ.�����ֹ�����.', 3);
    LabeledEdit17.SetFocus;
    Exit;
  end;
  if (LabeledEdit10.Text = '') or (LabeledEdit10.Text = '0') then
  begin
    ShowInfoTips(LabeledEdit10.Handle, '������������ QTY ��.', 3);
    LabeledEdit10.SetFocus;
    Exit;
  end;

  temp := 'ȷ�����ɡ� ' + IntToStr(SpinEdit1.Value) + ' ���ű�ǩô?' + #13 + #10 + #13 + #10;
  temp := temp + '����� ' + LabeledEdit12.Text + ' ��.' + #13 + #10 + #13 + #10;
  temp := temp + 'Ʒ���� ' + LabeledEdit11.Text + ' ��.' + #13 + #10;
  if ZsbMsgBoxOkNoApp(Self, temp) = False then Exit;

  SavePrintHistory;
end;

procedure TF_HandWork.LabeledEdit16Enter(Sender: TObject);
begin
  if LabeledEdit16.Tag = 0 then //��ȡ��ʼ����
  begin
    LabeledEdit16.Text := SelectClientDataSetResultFieldCaption(ClientDataSet2, 'select tips from initinfo where id=2', 'Tips');
    LabeledEdit16.Tag := 1;
  end;
end;

procedure TF_HandWork.LabeledEdit11Change(Sender: TObject);
begin
  if LabeledEdit11.Text = '' then Exit;
  GetEndProtQuat(LabeledEdit11.Text);
  psBarcode16.BarCode := LabeledEdit11.Text;
end;

procedure TF_HandWork.LabeledEdit20Change(Sender: TObject);
begin
  psBarcode20.BarCode := LabeledEdit20.Text;
end;

procedure TF_HandWork.LabeledEdit10Change(Sender: TObject);
begin
  psBarcode17.BarCode := LabeledEdit10.Text;
  Made2DCode_2;
end;

procedure TF_HandWork.LabeledEdit13Change(Sender: TObject);
begin
  LabeledEdit13_1.Text := LabeledEdit13.Text;
end;

procedure TF_HandWork.LabeledEdit14Change(Sender: TObject);
begin
  LabeledEdit14_1.Text := LabeledEdit14.Text;
end;

procedure TF_HandWork.LabeledEdit15Change(Sender: TObject);
begin
  LabeledEdit15_1.Text := LabeledEdit15.Text;
end;

procedure TF_HandWork.Button11Click(Sender: TObject);
begin
  LabeledEdit10.Text := '0';
  LabeledEdit1.Text := '';
  LabeledEdit11.Text := '';
  LabeledEdit12.Text := ' ';
  LabeledEdit13.Text := '';
  LabeledEdit14.Text := '';
  LabeledEdit15.Text := '';
  LabeledEdit17.Text := '';
  LabeledEdit18.Text := '';
  LabeledEdit19.Text := '';
  LabeledEdit19.Text := ' ';
  LabeledEdit20.Text := ' ';
  psBarcode16.BarCode := ' ';
end;

procedure TF_HandWork.Button10Click(Sender: TObject);
begin
  if Application.FindComponent('F_PrintCodeNew') = nil then
  begin
    Application.CreateForm(TF_PrintCodeNew, F_PrintCodeNew);
  end;
  F_PrintCodeNew.CheckBox3.Checked := True;
  F_PrintCodeNew.show;
end;

procedure TF_HandWork.Label62Click(Sender: TObject);
begin
  if LabeledEdit11.Text = '' then Exit;
  GetEndProtQuat(LabeledEdit11.Text);
end;

procedure TF_HandWork.Label62MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  Label62.Font.Style := [fsBold];
end;

procedure TF_HandWork.Label62MouseLeave(Sender: TObject);
begin
  Label62.Font.Style := [];
end;

procedure TF_HandWork.Label1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  Label1.Font.Style := [fsBold];
end;

procedure TF_HandWork.Label1MouseLeave(Sender: TObject);
begin
  Label1.Font.Style := [];
end;

procedure TF_HandWork.Label1Click(Sender: TObject);
var
  temp: string;
  TSList: TStringList;
begin
  if LeftStr(LabeledEdit12.Text, 2) = 'ML' then
  begin
    TSList := SplitString(LabeledEdit12.Text, ',');
    if LeftStr(TSList[1], 2) = 'MO' then
    begin
      LabeledEdit12.Text := TSList[1];
    end;  
    Application.ProcessMessages;
  end;
  if LeftStr(LabeledEdit12.Text, 2) <> 'MO' then
  begin
    zsbSimpleMSNPopUpShow_2('����ʶ��������.', clRed);
    Exit;
  end;
  GetOtherInfo(LabeledEdit12.Text);
  psBarcode18.BarCode := LabeledEdit12.Text;
  Made2DCode_2;
end;

procedure TF_HandWork.Timer2Timer(Sender: TObject);
begin
  //Label1MouseLeave(Sender: TObject);  ����¼���ִ�У�����

  Label1.Font.Style := [];
  Label62.Font.Style := [];
end;

procedure TF_HandWork.Timer3Timer(Sender: TObject);
begin
  //������
  LabeledEdit21.Text := IntToStr(iTotalQuat);
  LabeledEdit22.Text := IntToStr(iAlreadyQuat);
end;

procedure TF_HandWork.LabeledEdit12Change(Sender: TObject);
begin
  psBarcode18.BarCode := LabeledEdit12.Text;
  Made2DCode_2;
end;

procedure TF_HandWork.LabeledEdit12KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Label1Click(Sender);
  end;
end;

end.

