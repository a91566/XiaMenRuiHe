{
2015��6��7�� 09:10:42 ͣ�� ֣�ٱ�

������������Ρ�Ʒ����   �� EndProtInDepotZ��EndProtInDepotMX���鵽���������š��롾Ʒ�����������Ρ���
                         �� EndProtInCustZ��EndProtInCustMX��  �顾�ͻ���

���ݲ�ѯ���ġ��������š� �� MartlInProeZ   �鵽�����ⵥ�š�
���ݲ�ѯ���ġ����ⵥ�š� �� MartlInProeMX  �鵽��ԭ���ϵ��Ϻš����Ρ���Ρ�
���ݲ�ѯ���ġ��Ϻš�     �� Material       ��ѯ������Ӧ�̡�

������Ҫ������

��Ʒ   ��Ʒ����Ʒ�������Ρ���Ρ��������ͻ���
ԭ���� ���Ϻš�Ʒ�������Ρ���Ρ���������Ӧ�̣�
}
unit U_ChengPinZhuiSuChaXun;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask, ComObj,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect, StrUtils;

type
  TF_ChengPinZhuiSuChaXun = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    Timer2: TTimer;
    Image1: TImage;
    ClientDataSet10: TClientDataSet;
    ClientDataSet11: TClientDataSet;
    ClientDataSet12: TClientDataSet;
    RzPanel99: TRzPanel;
    Label4: TLabel;
    Label1: TLabel;
    RzPanel1: TRzPanel;
    SpeedButton999: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton123: TSpeedButton;
    LabeledEdit1: TLabeledEdit;
    RzPageControl2: TRzPageControl;
    RzTabSheet1: TRzTabSheet;
    Label3: TLabel;
    RzPanel2: TRzPanel;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    TabSheet2: TRzTabSheet;
    DBGridEh1: TDBGridEh;
    LabeledEdit3: TLabeledEdit;
    Label2: TLabel;
    RzPanel3: TRzPanel;
    LabeledEdit6: TLabeledEdit;
    Label5: TLabel;
    RzPanel4: TRzPanel;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    LabeledEdit13: TLabeledEdit;
    LabeledEdit15: TLabeledEdit;
    LabeledEdit14: TLabeledEdit;
    LabeledEdit12: TLabeledEdit;
    LabeledEdit16: TLabeledEdit;
    Label6: TLabel;
    RzPanel5: TRzPanel;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    LabeledEdit17: TLabeledEdit;
    LabeledEdit18: TLabeledEdit;
    LabeledEdit19: TLabeledEdit;
    LabeledEdit20: TLabeledEdit;
    LabeledEdit21: TLabeledEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton123Click(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton2Click(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ChaXun(strEndProtLot: string);
    procedure ClearText;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_ChengPinZhuiSuChaXun: TF_ChengPinZhuiSuChaXun;

implementation

uses UDM, ZsbFunPro2, ZsbDLL2, U_GetEndProtLot;

{$R *.dfm}

procedure TF_ChengPinZhuiSuChaXun.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //���� ��ʾ��������
end;

procedure TF_ChengPinZhuiSuChaXun.ClearText;
begin
  LabeledEdit2.Text := '';
  LabeledEdit3.Text := '';
  LabeledEdit4.Text := '';
  LabeledEdit5.Text := '';
  LabeledEdit6.Text := '';
  LabeledEdit7.Text := '';
  LabeledEdit8.Text := '';
end;

procedure TF_ChengPinZhuiSuChaXun.ChaXun(strEndProtLot: string);
var
  strsql, temp, temp1: string;
begin
  strsql := 'select * from EndProtBarCode where EndProtLot=''' + strEndProtLot + '''';
  SelectClientDataSet(ClientDataSet10, strsql);
  LabeledEdit2.Text := ClientDataSet10.FieldByName('EndProtCode').AsString; //Ʒ��
  //LabeledEdit3.Text := SelectEndProtNameForCode(LabeledEdit2.Text); //Ʒ��
  LabeledEdit3.Text := ClientDataSet10.FieldByName('customno').AsString; //����Ʒ��
  LabeledEdit4.Text := ClientDataSet10.FieldByName('EndProtVer').AsString; //���
  LabeledEdit5.Text := ClientDataSet10.FieldByName('EndProtQuat').AsString; //����
  LabeledEdit6.Text := ClientDataSet10.FieldByName('custname').AsString; //�ͻ�
  LabeledEdit8.Text := ClientDataSet10.FieldByName('ERPPDNO').AsString; //MO
  LabeledEdit9.Text := ClientDataSet10.FieldByName('ML_NO').AsString; //ML

  LabeledEdit10.Text := ClientDataSet10.FieldByName('uName').AsString + ' ' + ClientDataSet10.FieldByName('OpeeDT').AsString; //���ɱ�ǩ
  LabeledEdit11.Text := ClientDataSet10.FieldByName('pName').AsString + ' ' + ClientDataSet10.FieldByName('pDT').AsString; //��ӡ��ǩ
  LabeledEdit12.Text := ClientDataSet10.FieldByName('DEP').AsString; //���첿��
  LabeledEdit13.Text := ClientDataSet10.FieldByName('ShefCode').AsString; //��λ
  LabeledEdit14.Text := ClientDataSet10.FieldByName('shippingd').AsString; //װ������

  if ClientDataSet10.FieldByName('HandWork').AsString = '1' then //�ֹ�����
  begin   
    LabeledEdit15.Text := '��';
  end
  else
  begin
    LabeledEdit15.Text := '��';
  end;

  LabeledEdit16.Text := ClientDataSet10.FieldByName('iTime').AsString;

  if ClientDataSet10.FieldByName('state').AsString = 'Y' then //�ֹ�����
  begin
    LabeledEdit17.Text := '��';
    LabeledEdit18.Text := '';
    LabeledEdit18.Visible := False;
  end
  else
  begin
    LabeledEdit17.Text := '��';
    LabeledEdit18.Text := ClientDataSet10.FieldByName('ScrapReason').AsString;
    LabeledEdit18.Visible := True;
  end;

  if ClientDataSet10.FieldByName('iSecond').AsString = '1' then //�ֹ�����
  begin
    LabeledEdit21.Text := '��';
  end
  else
  begin
    LabeledEdit21.Text := '��';
  end;

  temp := ClientDataSet10.FieldByName('inNo').AsString;
  temp1 := ClientDataSet10.FieldByName('OutNo').AsString;
  if temp = '' then
  begin
    LabeledEdit7.Text := 'δ���';
    LabeledEdit19.Text := '';
    LabeledEdit20.Text := '';
  end
  else if (temp <> '') and (temp1 = '') then
  begin
    LabeledEdit7.Text := '�ڿ�';
    SelectClientDataSet(ClientDataSet11,'select opeedt,usercode from EndProtInDepotZ where InNo='''+temp+'''');
    LabeledEdit19.Text := ClientDataSet11.FieldByName('usercode').AsString + ' ' + ClientDataSet11.FieldByName('opeedt').AsString;
    LabeledEdit20.Text := '';
  end
  else if temp1 <> '' then
  begin
    LabeledEdit7.Text := '�ѳ���';
    SelectClientDataSet(ClientDataSet11,'select opeedt,usercode from EndProtInDepotZ where InNo='''+temp+'''');
    LabeledEdit19.Text := ClientDataSet11.FieldByName('usercode').AsString + ' ' + ClientDataSet11.FieldByName('opeedt').AsString;
    SelectClientDataSet(ClientDataSet11,'select dt,usercode from EndProtOutDepotZ where outno='''+temp1+'''');
    LabeledEdit20.Text := ClientDataSet11.FieldByName('usercode').AsString + ' ' + ClientDataSet11.FieldByName('dt').AsString;
  end;



  strsql := 'select * from LZm_ML_MO_OutLog where ML_NO=''' + LabeledEdit9.Text + '''';

  // 2015��6��4�� 21:14:42 ���һ����Ӧ�̴���
  strsql:='select LZm_ML_MO_OutLog.*,MatlInDepotZ.SuprCode from LZm_ML_MO_OutLog,MatlInDepotZ,MatlInDepotMx'+
  ' where LZm_ML_MO_OutLog.ML_NO=''' + LabeledEdit9.Text + '''  and'+
  ' LZm_ML_MO_OutLog.AutoLot=MatlInDepotMx.AutoLot and MatlInDepotMx.MIDDONO=MatlInDepotZ.MIDDONO';
  SelectClientDataSet(ClientDataSet1, strsql);
  SpeedButton999.Enabled:=True; 
end;

procedure TF_ChengPinZhuiSuChaXun.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_ChengPinZhuiSuChaXun.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // ûЧ������2013��3��18�� 11:38:05
  Action := caFree;
end;

procedure TF_ChengPinZhuiSuChaXun.FormCreate(Sender: TObject);
begin
  Self.Left := 50;
  Self.Top := 50;
end;

procedure TF_ChengPinZhuiSuChaXun.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //������С���
end;

procedure TF_ChengPinZhuiSuChaXun.Timer1Timer(Sender: TObject);
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
  RzPageControl2.ActivePageIndex := 0;
  LabeledEdit1.SetFocus;
end;

procedure TF_ChengPinZhuiSuChaXun.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled := False;
  try
    FDM := TFDM.Create(nil);
    FDM.RestartLink; //�������ݿ�����
    if FDM.booPuLinkDBSta = False then
    begin
      if Application.MessageBox(PChar(FDM.strPuLinkError), '������Ϣ', MB_ICONERROR + MB_RETRYCANCEL) = idRETRY then
      begin
        FDM.RestartLink;
      end
      else
      begin
        Self.Close;
      end;
    end;
  finally

  end;
end;

procedure TF_ChengPinZhuiSuChaXun.SpeedButton123Click(Sender: TObject);
var
  temp: string;
begin //��ʱ����
  temp := 'if not exists (select name  from sysobjects where [name] = ''TempChengPinZhuiSuChaXun'' and xtype=''U'')' +
    ' begin' +
    ' CREATE TABLE [dbo].[TempChengPinZhuiSuChaXun] (' +
    ' [ID] [int] IDENTITY (1, 1) NOT NULL ,' +
    ' [a] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[b] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[c] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[d] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[e] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[f] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[g] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[h] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[i] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[j] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[k] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[l] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[m] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[n] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[o] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[p] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[q] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[r] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[s] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[t] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[u] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[v] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[w] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[x] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[y] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,' +
    '	[z] [nvarchar] (300) COLLATE Chinese_PRC_CI_AS NULL' +
    ' ) ON [PRIMARY]' +
    ' end;';

  if EXSQLClientDataSet(ClientDataSet10, temp) then
  begin
    zsbSimpleMSNPopUpShow('����ʱ��  �ɹ�.');
  end
  else
  begin
    zsbSimpleMSNPopUpShow('����ʱ��  ʧ��.');
  end;
end;

procedure TF_ChengPinZhuiSuChaXun.SpeedButton999Click(Sender: TObject);
var
  strsql: string;
  i: SmallInt;
begin
  ClearText;
  SpeedButton999.Enabled:=False;
  if LabeledEdit1.Text = '' then
  begin
    ShowInfoTips(LabeledEdit1.Handle, '���������β�ѯ.', 3);
    LabeledEdit1.SetFocus;
    SpeedButton999.Enabled:=True;
    Exit;
  end;
  strsql := 'select EndProtLot from EndProtBarCode where EndProtLot like ''%' + LabeledEdit1.Text + '%''';
  i := SelectClientDataSetResultCount(ClientDataSet11, strsql);
  if i = 0 then
  begin
    zsbSimpleMSNPopUpShow('û����ؼ�¼.');
    ClientDataSet1.Close;   
    SpeedButton999.Enabled:=True;
    Exit;
  end
  else if i = 1 then
  begin
    LabeledEdit1.Text := ClientDataSet11.FieldByName('EndProtLot').AsString;
    ChaXun(LabeledEdit1.Text);
  end
  else if i > 1 then
  begin
    MSNPopUpShow('����[' + LabeledEdit1.Text + ']���ڶ������Ƽ�¼,��ȷ������.');
    if Application.FindComponent('F_GetEndProtLot') = nil then
    begin
      F_GetEndProtLot := TF_GetEndProtLot.Create(nil);
    end;
    F_GetEndProtLot.strPuEndProtLot := LabeledEdit1.Text;
    F_GetEndProtLot.ShowModal;
    if F_GetEndProtLot.strPuResult <> '' then
    begin
      LabeledEdit1.Text := F_GetEndProtLot.strPuResult;
      ChaXun(LabeledEdit1.Text);
    end;
  end;
end;

procedure TF_ChengPinZhuiSuChaXun.LabeledEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then SpeedButton999.Click;
end;

procedure TF_ChengPinZhuiSuChaXun.SpeedButton2Click(Sender: TObject);
var
  vexcel, workbook, sheet: OleVariant; //����excel
  temp: string;
  i: SmallInt;
begin
  zsbSimpleMSNPopUpShow_2('�ݲ�֧��');
  Exit;
  if ClientDataSet1.Data = null then
  begin
    zsbSimpleMSNPopUpShow('û�пɲ���������');
    Exit;
  end;
  if ClientDataSet1.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('û�пɲ���������');
    Exit;
  end;
  temp := ExtractFilePath(Application.Exename) + 'SPSPS.xls';
  if FileExists(temp) = False then
  begin
    zsbSimpleMSNPopUpShow('ģ���ļ�������.');
    Exit;
  end;
  vExcel := CreateOleObject('Excel.application');
  vExcel.Visible := True; //��ʾ
  vExcel.workbooks.Add(temp);
  workbook := vExcel.workbooks[1];
  sheet := workbook.worksheets[1];


  sheet.name := '����׷�ݹ���ϵͳ';

  sheet.cells[1, 1] := '��Ʒ�����Ϣ';
  sheet.cells[2, 1] := 'Ʒ��';
  sheet.cells[3, 1].value := LabeledEdit2.Text;

  sheet.cells[2, 2] := 'Ʒ��';
  sheet.cells[3, 2].value := LabeledEdit3.Text;

  sheet.cells[2, 3] := '����';
  sheet.cells[3, 3].value := LabeledEdit1.Text;

  sheet.cells[2, 4] := '���';
  sheet.cells[3, 4].value := LabeledEdit4.Text;

  sheet.cells[2, 5] := '����';
  sheet.cells[3, 5].value := LabeledEdit5.Text;

  sheet.cells[2, 6] := '�ͻ�';
  sheet.cells[3, 6].value := LabeledEdit6.Text;

  sheet.cells[2, 7] := '״̬';
  sheet.cells[3, 7].value := LabeledEdit7.Text;


  sheet.cells[5, 1] := 'ԭ���������Ϣ';
  sheet.cells[6, 1] := '��Ӧ��';
  sheet.cells[6, 2] := '�Ϻ�';
  sheet.cells[6, 3] := '����';
  sheet.cells[6, 4] := '���';
  sheet.cells[6, 5] := '����';


  ClientDataSet10.Data := ClientDataSet1.Data;
  with ClientDataSet10 do
  begin
    First;
    i := 7;
    while not Eof do
    begin
      sheet.cells[i, 1] := FieldByName('SuprCodeName').AsString;
      sheet.cells[i, 2] := FieldByName('MatlCode').AsString;
      sheet.cells[i, 3] := FieldByName('MatlLot').AsString;
      sheet.cells[i, 4] := FieldByName('MatlVer').AsString;
      sheet.cells[i, 5] := FieldByName('MatlQuat').AsString;
      i := i + 1;
      Next;
    end;
  end;


  //VExcel.quit;

end;

end.

