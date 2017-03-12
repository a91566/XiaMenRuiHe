unit UOF_faliaochukudanxiugai;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, U_ObjectForm, ExtCtrls, Buttons, Grids, DBGridEh, RzTabs,
  ComCtrls, StdCtrls, DB, DBClient;

type
  TFOF_faliaochukudanxiugai = class(TF_ObjectForm)
    Label2: TLabel;
    Label1: TLabel;
    DateTimePicker2: TDateTimePicker;
    DateTimePicker1: TDateTimePicker;
    RzPageControl1: TRzPageControl;
    RzTabSheet1: TRzTabSheet;
    RzPageControl2: TRzPageControl;
    RzTabSheet2: TRzTabSheet;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    DBGridEh1: TDBGridEh;
    DBGridEh2: TDBGridEh;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    ComboBox1: TComboBox;
    Label5: TLabel;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FOF_faliaochukudanxiugai: TFOF_faliaochukudanxiugai;

implementation   

uses ZsbDLL, ZsbFunPro, ZsbVariable;

{$R *.dfm}

procedure TFOF_faliaochukudanxiugai.FormShow(Sender: TObject);
begin
  inherited;
  DateTimePicker1.Date:=StrToDate(FormatDateTime('yyyy-MM-',Now)+'01');
  DateTimePicker2.Date:=Now;
  SpeedButton1.Click;
end;

procedure TFOF_faliaochukudanxiugai.SpeedButton4Click(Sender: TObject);
var
  strsql, temp1, temp2: string;
begin
  inherited;
  //temp1 := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date) + ' 00:00:00';
  //temp2 := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date) + ' 23:59:59';
  temp1 := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
  temp2 := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);
  strsql:='select * from LZz_ML_MO_FromERP where OpeeDT>='''+temp1+'''and OpeeDT<='''+temp2+'''';

  if ComboBox1.ItemIndex > 0 then
  begin
    strsql := strsql + ' and state=''' + ComboBox1.Text + '''';
  end;

  if LabeledEdit1.Text <> '' then
  begin
    strsql := strsql + ' and ML_NO like ''%' + LabeledEdit1.Text + '%''';
  end;
  if LabeledEdit2.Text <> '' then
  begin
    strsql := strsql + ' and ML_NO in(select ML_NO from LZm_ML_MO_FromERP where MO_NO like ''%' + LabeledEdit2.Text + '%'')';
  end;   
  if LabeledEdit3.Text <> '' then
  begin
    strsql := strsql + ' and ML_NO in(select ML_NO from LZm_ML_MO_FromERP where MatlCode like ''%' + LabeledEdit3.Text + '%'')';
  end;

  SelectClientDataSet(ClientDataSet1, strsql);
  ClientDataSet2.Close;
end;

procedure TFOF_faliaochukudanxiugai.DBGridEh1CellClick(Column: TColumnEh);
var
  strsql:string;
begin
  inherited;
  strsql:='select MatlInProeMx.*,ERPProduceDocMX.DepotCode from MatlInProeMx,ERPProduceDocMX where MatlInProeMx.MIPDONO='''+
  ClientDataSet1.FieldByName('MIPDONO').AsString+''' and MatlInProeMx.MatlCode=ERPProduceDocMX.MatlCode and '+
  'ERPProduceDocMX.ERPPDNO='''+ClientDataSet1.FieldByName('ERPPDNO').AsString+'''';
  SelectClientDataSet(ClientDataSet2,strsql);
end;

end.
