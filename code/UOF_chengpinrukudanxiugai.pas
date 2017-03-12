unit UOF_chengpinrukudanxiugai;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, U_ObjectForm, ExtCtrls, Buttons, StdCtrls, ComCtrls, Grids,
  DBGridEh, RzTabs, DB, DBClient;

type
  TFOF_chengpinrukudanxiugai = class(TF_ObjectForm)
    RzPageControl2: TRzPageControl;
    RzTabSheet2: TRzTabSheet;
    RzPageControl1: TRzPageControl;
    RzTabSheet1: TRzTabSheet;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label2: TLabel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    ClientDataSet10: TClientDataSet;
    DBGridEh1: TDBGridEh;
    DBGridEh2: TDBGridEh;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FOF_chengpinrukudanxiugai: TFOF_chengpinrukudanxiugai;

implementation

uses ZsbDLL, ZsbFunPro, ZsbVariable;

{$R *.dfm}

procedure TFOF_chengpinrukudanxiugai.FormShow(Sender: TObject);
begin
  inherited;
  DateTimePicker1.Date:=StrToDate(FormatDateTime('yyyy-MM-',Now)+'01');
  DateTimePicker2.Date:=Now;
  SpeedButton4.Click;
end;

procedure TFOF_chengpinrukudanxiugai.SpeedButton4Click(Sender: TObject);
var
  strsql,temp1,temp2:string;
begin
  inherited;
  temp1:=FormatDateTime('yyyy-mm-dd',DateTimePicker1.Date)+' 00:00:00';
  temp2:=FormatDateTime('yyyy-mm-dd',DateTimePicker2.Date)+' 23:59:59';
  strsql:='select * from EndProtInDepotZ where OpeeDT>='''+ temp1+''' and OpeeDT<='''+temp2+'''';
  if LabeledEdit1.Text<>'' then
  begin
     strsql:=strsql+' and ProeNo like ''%'+LabeledEdit1.Text+'%''';
  end;
  if LabeledEdit2.Text<>'' then
  begin
     strsql:=strsql+' and EPIDDONO like ''%'+LabeledEdit2.Text+'%''';
  end;
  SelectClientDataSet(ClientDataSet1,strsql);
  ClientDataSet2.Close;
end;

procedure TFOF_chengpinrukudanxiugai.DBGridEh1CellClick(Column: TColumnEh);
var
  strsql,temp:string;
begin
  inherited;
  if ClientDataSet1.RecordCount = 0 then Exit;
  strsql:='select ERPPDNO,EndProtCode,EndProtLot,EndProtQuat,DEP,ShefCode,State from EndProtBarCode where InNo='''+
  ClientDataSet1.FieldByName('EPIDDONO').AsString+'''';
  SelectClientDataSet(ClientDataSet2,strsql); 
end;

end.
