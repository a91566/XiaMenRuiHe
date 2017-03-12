unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGridEh, StdCtrls, ExtCtrls, RzPanel, DB, DBClient;

type
  TForm1 = class(TForm)
    RzPanel1: TRzPanel;
    Label1: TLabel;
    RzPanel2: TRzPanel;
    Label2: TLabel;
    RzPanel3: TRzPanel;
    Label4: TLabel;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    RzPanel6: TRzPanel;
    Label6: TLabel;
    RzPanel7: TRzPanel;
    Label7: TLabel;
    RzPanel8: TRzPanel;
    Label8: TLabel;
    RzPanel9: TRzPanel;
    Label9: TLabel;
    RzPanel10: TRzPanel;
    Label10: TLabel;
    RzPanel11: TRzPanel;
    Label11: TLabel;
    RzPanel12: TRzPanel;
    Label12: TLabel;
    RzPanel13: TRzPanel;
    Label13: TLabel;
    RzPanel14: TRzPanel;
    Label14: TLabel;
    RzPanel15: TRzPanel;
    Label15: TLabel;
    RzPanel16: TRzPanel;
    Label16: TLabel;
    RzPanel17: TRzPanel;
    Label17: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    DBGridEh1: TDBGridEh;
    RzPanel18: TRzPanel;
    RzPanel20: TRzPanel;
    RzPanel22: TRzPanel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Timer1: TTimer;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    ClientDataSet2: TClientDataSet;
    ClientDataSet10: TClientDataSet;
    Label23: TLabel;
    Label25: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Timer2: TTimer;
    Label3: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private 
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses U_Main, UDM, ZsbDLL2, ZsbFunPro2, ZsbVariable2;

{$R *.dfm}

procedure TForm1.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  strsql:string;
begin
  Timer1.Enabled:=False;
  strsql:='select Text,type from reason_LLTL order by type,Text';
  SelectClientDataSetNoTips(ClientDataSet10,strsql);
  with ClientDataSet10 do
  begin   
    First;
    while not Eof do
    begin
      if FieldByName('type').AsString='L' then
      begin
        ListBox1.Items.Add(FieldByName('Text').AsString);
        //DBGridEh1.Columns[4].PickList.Add(FieldByName('Text').AsString);
      end
      else if FieldByName('type').AsString='T' then
      begin  
        ListBox2.Items.Add(FieldByName('Text').AsString);
      end;
      Next;
    end;
  end;
end;

function GetSuprCode(MatlCode,AutoLot: string): string;
var
  strsql, strRt: string;
begin
  if MatlCode = '' then
  begin
    strRt := '';
  end
  else
  begin
    strSQL := 'select SuprCode from MatlInDepotZ where MIDDONO in (Select MIDDONO from MatlInDepotMX where MatlCode='''+MatlCode+
    ''' and AutoLot='''+AutoLot+''')';
    strRt := SelectClientDataSetResultFieldCaption(FDM.ClientDataSet1, strSQL, 'SuprCode');
  end;
  Result := strRt;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var
  strsql:string;
begin
  Timer2.Enabled:=False;
  strsql:='select top 1 * from TLm where 1=2';
  SelectClientDataSetNoTips(ClientDataSet1,strsql);
  with frmMain.CDSFF do
  begin
    First;
    while not Eof do
    begin
      ClientDataSet1.Edit;
      ClientDataSet1.FieldByName('MatlCode').Value:=FieldByName('MatlCode').AsString;
      ClientDataSet1.FieldByName('Autolot').Value:=FieldByName('Autolot').AsString;
      ClientDataSet1.FieldByName('UNIT').Value:='PCS';
      ClientDataSet1.FieldByName('QTY').Value:=FieldByName('MatlQuat').AsString;
      ClientDataSet1.FieldByName('SUP').Value:=GetSuprCode(FieldByName('MatlCode').AsString,FieldByName('Autolot').AsString);
      ClientDataSet1.Append;
      Next;
    end;
  end; 
end;

procedure TForm1.Label3Click(Sender: TObject);
var
  exsql,TLNO:string;
begin
  if label3.Tag=1 then
  begin
    zsbSimpleMSNPopUpShow_2('已保存.');
    Exit;
  end;
  if RadioButton1.Checked then
  begin
    TLNO:=Edit1.Text+'T';
  end
  else if RadioButton2.Checked then
  begin
    TLNO:=Edit1.Text+'TL';
  end
  else
  begin
    zsbSimpleMSNPopUpShow_2('请选择领退单类型.');
    Exit;
  end;
  exsql:='insert into TLz(TLNO,ML_NO,MO_NO,PW,DEP1,DEP2,DT,un,state)values('''+TLNO+''','''+Edit1.Text+
  ''','''+Edit2.Text+''','''+Edit3.Text+''','''+Edit4.Text+''','''+Edit5.Text+''','''+Edit6.Text+''','''+ZStrUser+
  ''',''1.待打印'');';
  with ClientDataSet1 do
  begin
    first;
    while not Eof do
    begin
      exsql:=exsql+'insert into TLm(TLNO,MatlCode,UNIT,QTY,SUP,reason1,reason2,memo,AutoLot)values('''+TLNO+''','''+FieldByName('MatlCode').AsString+
        ''','''+FieldByName('UNIT').AsString+''','''+FieldByName('QTY').AsString+
        ''','''+FieldByName('SUP').AsString+''','''+FieldByName('reason1').AsString+
        ''','''+FieldByName('reason2').AsString+''','''+FieldByName('memo').AsString+
        ''','''+FieldByName('AutoLot').AsString+''');';
      Next;
    end;
  end;
  if EXSQLClientDataSet(ClientDataSet10,exsql)=False then
  begin
    ZsbMsgErrorInfoNoApp(Self,'操作失败,请联系管理员.');
  end
  else
  begin
    zsbSimpleMSNPopUpShow_2('is ok');
    label3.Tag:=1;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if label3.Tag=0 then
  begin
    if ZsbMsgBoxOkNoApp(Self,'当前还未保存,是否退出?')=False then
    Action:=caNone;
  end;
end;

end.
