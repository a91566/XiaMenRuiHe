unit UOF_chengpinchukudanxiugai;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, U_ObjectForm, ExtCtrls, Buttons, Grids, DBGridEh, RzTabs,
  ComCtrls, StdCtrls, DB, DBClient;

type
  TFOF_chengpinchukudanxiugai = class(TF_ObjectForm)
    Label2: TLabel;
    Label1: TLabel;
    DateTimePicker2: TDateTimePicker;
    DateTimePicker1: TDateTimePicker;
    RzPageControl1: TRzPageControl;
    RzTabSheet1: TRzTabSheet;
    RzPageControl2: TRzPageControl;
    RzTabSheet2: TRzTabSheet;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    ClientDataSet10: TClientDataSet;
    DataSource2: TDataSource;
    ClientDataSet2: TClientDataSet;
    DBGridEh1: TDBGridEh;
    DBGridEh2: TDBGridEh;
    CheckBox1: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FOF_chengpinchukudanxiugai: TFOF_chengpinchukudanxiugai;

implementation

uses ZsbDLL, ZsbFunPro, ZsbVariable, U_main;

{$R *.dfm}

procedure TFOF_chengpinchukudanxiugai.FormShow(Sender: TObject);
begin
  inherited;
  DateTimePicker1.Date := StrToDate(FormatDateTime('yyyy-MM-', Now) + '01');
  DateTimePicker2.Date := Now;
  SpeedButton4.Click;
end;

procedure TFOF_chengpinchukudanxiugai.SpeedButton4Click(Sender: TObject);
var
  strsql, temp1, temp2: string;
begin
  inherited;
  temp1 := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date) + ' 00:00:00';
  temp2 := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date) + ' 23:59:59';
  strsql := 'select * from EndProtOutDepotZ where OpeeDT>=''' + temp1 + ''' and OpeeDT<=''' + temp2 + '''';
  if LabeledEdit1.Text <> '' then
  begin
    strsql := strsql + ' and ERPSellDocZ.CustCode like ''%' + LabeledEdit1.Text + '%''';
  end;
  if LabeledEdit2.Text <> '' then
  begin
    strsql := strsql + ' and EndProtInCustZ.ERPSDNO like ''%' + LabeledEdit2.Text + '%''';
  end;
  SelectClientDataSet(ClientDataSet1, strsql);
  ClientDataSet2.Close;
end;

procedure TFOF_chengpinchukudanxiugai.DBGridEh1CellClick(
  Column: TColumnEh);
var
  strsql: string;
begin
  inherited;
  if ClientDataSet1.RecordCount = 0 then Exit;
  if ClientDataSet1.FieldByName('state').AsString = 'N' then
  begin
    strsql := 'select * from invalid_EndProtBarCode_OutDepot where OutNo=''' + ClientDataSet1.FieldByName('OutNo').AsString + '''';
  end
  else
  begin
    strsql := 'select ERPPDNO,EndProtCode,EndProtLot,EndProtQuat,DEP,ShefCode,State from EndProtBarCode where OutNo=''' +
      ClientDataSet1.FieldByName('OutNo').AsString + '''';
  end;
  if CheckBox1.Checked = False then
  begin
    strsql := strsql + ' and State=''Y''';
  end;
  SelectClientDataSet(ClientDataSet2, strsql);
end;

procedure TFOF_chengpinchukudanxiugai.SpeedButton1Click(Sender: TObject);
var
  exsql: string;
begin
  inherited;

  if ClientDataSet1.RecordCount = 0 then Exit;
  if ClientDataSet1.FieldByName('state').AsString = 'N' then
  begin
    zsbSimpleMSNPopUpShow('已经是作废状态,无需在操作.');
    Exit;
  end;
  if ZsbMsgBoxOkNoApp(F_main, '此操作不可撤销,确认作废么?单号：' + ClientDataSet1.FieldByName('OutNo').AsString) = False then Exit;
  exsql := 'insert into invalid_EndProtBarCode_OutDepot select OutNo,ERPPDNO,EndProtCode,EndProtLot,EndProtQuat,DEP,'+
  'ShefCode,State from EndProtBarCode where OutNo=''' + ClientDataSet1.FieldByName('OutNo').AsString + ''';';
  exsql := exsql + 'update EndProtOutDepotZ set state=''N'' where OutNo=''' + ClientDataSet1.FieldByName('OutNo').AsString + ''';';
  with ClientDataSet2 do
  begin
    First;
    while not Eof do
    begin
      exsql := exsql + 'update EndProtBarCode set OutNo='''' where EndProtLot=''' + FieldByName('EndProtLot').AsString + ''';';
      Next;
    end;
  end;
  exsql := 'begin tran ' + exsql + ' commit tran';
  if EXSQLClientDataSet(ClientDataSet10, exsql) then
  begin
    zsbSimpleMSNPopUpShow('已作废.');
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(F_main, '操作失败,请联系管理员.');
  end;
end;

end.

