unit UOF_chengpinrukudanchakan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, U_ObjectForm, ExtCtrls, Buttons, Grids, DBGridEh, RzTabs,
  ComCtrls, StdCtrls, DB, DBClient, ComObj;

type
  TFOF_chengpinrukudanchakan = class(TF_ObjectForm)
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
    ClientDataSet10: TClientDataSet;
    CheckBox1: TCheckBox;
    ClientDataSet11: TClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FOF_chengpinrukudanchakan: TFOF_chengpinrukudanchakan;

implementation    //EPIDDONO   InNo

uses ZsbDLL, ZsbFunPro, ZsbVariable;

{$R *.dfm}

procedure TFOF_chengpinrukudanchakan.FormShow(Sender: TObject);
begin
  inherited;
  DateTimePicker1.Date := StrToDate(FormatDateTime('yyyy-MM-', Now) + '01');
  DateTimePicker2.Date := Now;
  SpeedButton1.Click;
  RzPageControl1.ActivePageIndex:=0;
end;

procedure TFOF_chengpinrukudanchakan.SpeedButton1Click(Sender: TObject);
var
  strsql, temp1, temp2: string;
begin
  inherited;
  temp1 := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date) + ' 00:00:00';
  temp2 := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date) + ' 23:59:59';
  strsql := 'select * from EndProtInDepotZ where OpeeDT>=''' + temp1 + ''' and OpeeDT<=''' + temp2 + '''';
  if LabeledEdit1.Text <> '' then
  begin
    strsql := strsql + ' and InNo in (select InNo from EndProtBarCode where EndProtCode like ''%' + LabeledEdit1.Text + '%'')';
  end;
  if LabeledEdit2.Text <> '' then
  begin
    strsql := strsql + ' and InNo like ''%' + LabeledEdit2.Text + '%''';
  end;
  SelectClientDataSet(ClientDataSet1, strsql);
  ClientDataSet2.Close;
end;

procedure TFOF_chengpinrukudanchakan.SpeedButton2Click(Sender: TObject);
var
  vexcel, workbook, sheet: OleVariant; //导出excel
  temp,temp1,temp2,temp3,NewFileName: string;
  i: SmallInt;
begin
  inherited;
  if (ClientDataSet1.Data = null) or (ClientDataSet2.Data = null) then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据');
    Exit;
  end;
  if ClientDataSet1.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据');
    Exit;
  end;
  if ClientDataSet1.FieldByName('InNo').AsString = '' then
  begin
    zsbSimpleMSNPopUpShow('没有选择导出的数据');
    Exit;
  end;
  temp := ExtractFilePath(Application.Exename) + '力真成品入库明细表.xls';
  if FileExists(temp) = False then
  begin
    zsbSimpleMSNPopUpShow('模版文件不存在.');
    Exit;
  end;
  NewFileName:=ExtractFilePath(Application.Exename) +FormatDateTime('yyyyMMdd',Now)+'-'+ClientDataSet1.FieldByName('InNo').AsString;
  CopyFile(PChar(temp),PChar(NewFileName),False);
  vExcel := CreateOleObject('Excel.application');
  vExcel.Visible := True; //显示
  vExcel.workbooks.Add(NewFileName);
  workbook := vExcel.workbooks[1];
  sheet := workbook.worksheets[1];
  temp1:=ClientDataSet1.FieldByName('InNo').AsString;
  temp2:=ClientDataSet1.FieldByName('DepotCode').AsString;
  temp3:=ClientDataSet1.FieldByName('UserCode').AsString;
  with ClientDataSet2 do
  begin
    First;
    i := 2;
    while not Eof do
    begin
      sheet.cells[i, 1] := FieldByName('ERPPDNO').AsString;
      sheet.cells[i, 2] := FieldByName('EndProtCode').AsString;
      sheet.cells[i, 3] := FieldByName('EndProtQuat').AsString;
      sheet.cells[i, 4] := FieldByName('EndProtLot').AsString;
      sheet.cells[i, 5] := FieldByName('DEP').AsString;
      sheet.cells[i, 6] := FieldByName('ShefCode').AsString;
      sheet.cells[i, 7] := temp1;
      sheet.cells[i, 8] := temp2;
      sheet.cells[i, 9] := temp3;
      i := i + 1;
      Next;
    end;
  end;
end;

procedure TFOF_chengpinrukudanchakan.DBGridEh1CellClick(Column: TColumnEh);
var
  strsql: string;
begin
  inherited;
  if ClientDataSet1.RecordCount = 0 then Exit;
  strsql:='select ERPPDNO,EndProtCode,EndProtLot,EndProtQuat,DEP,ShefCode,State from EndProtBarCode where InNo='''+
  ClientDataSet1.FieldByName('InNo').AsString+'''';
  if CheckBox1.Checked=False then
  begin
    strsql:=strsql+' and State=''Y''';
  end;
  SelectClientDataSet(ClientDataSet2,strsql);
end;

end.

