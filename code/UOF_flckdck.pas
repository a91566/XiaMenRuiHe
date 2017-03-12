unit UOF_flckdck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, U_ObjectForm, StdCtrls, Buttons, ExtCtrls, Grids, DBGridEh,
  RzTabs, ComCtrls, DB, DBClient;

type
  TFOF_flckdck = class(TF_ObjectForm)
    LabeledEdit2: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    Label2: TLabel;
    Label1: TLabel;
    DateTimePicker2: TDateTimePicker;
    DateTimePicker1: TDateTimePicker;
    RzPageControl1: TRzPageControl;
    RzTabSheet1: TRzTabSheet;
    DBGridEh1: TDBGridEh;
    RzPageControl2: TRzPageControl;
    RzTabSheet2: TRzTabSheet;
    DBGridEh2: TDBGridEh;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    DBGridEh3: TDBGridEh;
    ClientDataSet3: TClientDataSet;
    DataSource3: TDataSource;
    Label5: TLabel;
    ComboBox1: TComboBox;
    LabeledEdit3: TLabeledEdit;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure DBGridEh2CellClick(Column: TColumnEh);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure LabeledEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure LabeledEdit3KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FOF_flckdck: TFOF_flckdck;

implementation

uses ZsbDLL, ZsbFunPro, ZsbVariable;

{$R *.dfm}

procedure TFOF_flckdck.SpeedButton1Click(Sender: TObject);
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

procedure TFOF_flckdck.FormShow(Sender: TObject);
begin
  inherited;
  DateTimePicker1.Date := StrToDate(FormatDateTime('yyyy-MM-', Now) + '01');
  DateTimePicker2.Date := Now;
  SpeedButton1.Click;
end;

procedure TFOF_flckdck.DBGridEh1CellClick(Column: TColumnEh);
var
  strsql: string;
begin
  inherited;
  strsql := 'select * from LZm_ML_MO_FromERP where ML_NO=''' + ClientDataSet1.FieldByName('ML_NO').AsString + '''';
  SelectClientDataSet(ClientDataSet2, strsql);
end;

procedure TFOF_flckdck.RadioButton1Click(Sender: TObject);
begin
  inherited;
  SpeedButton1.Click;
end;

procedure TFOF_flckdck.RadioButton2Click(Sender: TObject);
begin
  inherited;
  SpeedButton1.Click;
end;

procedure TFOF_flckdck.DBGridEh2CellClick(Column: TColumnEh);
var
  strsql: string;
begin
  inherited;
  if ClientDataSet2.Data=null then Exit;
  strsql := 'select * from LZm_ML_MO_OutLog where ML_NO=''' + ClientDataSet1.FieldByName('ML_NO').AsString +
  ''' and matlcode='''+ClientDataSet2.FieldByName('matlcode').AsString+'''';
  SelectClientDataSet(ClientDataSet3, strsql);
end;

procedure TFOF_flckdck.LabeledEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
  begin
    SpeedButton1.Click;
  end;
end;

procedure TFOF_flckdck.LabeledEdit2KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
  begin
    SpeedButton1.Click;
  end;
end;

procedure TFOF_flckdck.LabeledEdit3KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
  begin
    SpeedButton1.Click;
  end;
end;

end.

