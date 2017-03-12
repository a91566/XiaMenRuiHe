unit UOF_chengpinchukudanchakan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, U_ObjectForm, ExtCtrls, Buttons, Grids, DBGridEh, RzTabs,
  ComCtrls, StdCtrls, DB, DBClient, ComObj;

type
  TFOF_chengpinchukudanchakan = class(TF_ObjectForm)
    LabeledEdit2: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
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
    ClientDataSet10: TClientDataSet;
    DBGridEh2: TDBGridEh;
    DBGridEh1: TDBGridEh;
    CheckBox1: TCheckBox;
    ClientDataSet11: TClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
   procedure SelectMX_Export(OutNo:string);     
   procedure SelectMX_Export_2(OutNo:string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FOF_chengpinchukudanchakan: TFOF_chengpinchukudanchakan;

implementation

uses ZsbDLL, ZsbFunPro, ZsbVariable;

{$R *.dfm}

procedure TFOF_chengpinchukudanchakan.FormShow(Sender: TObject);
begin
  inherited;
  DateTimePicker1.Date := StrToDate(FormatDateTime('yyyy-MM-', Now) + '01');
  DateTimePicker2.Date := Now;
  SpeedButton1.Click;
end;

procedure TFOF_chengpinchukudanchakan.SpeedButton1Click(Sender: TObject);
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

procedure TFOF_chengpinchukudanchakan.DBGridEh1CellClick(
  Column: TColumnEh);
var
  strsql: string;
begin    
  inherited;
  if ClientDataSet1.RecordCount = 0 then Exit;
  strsql := 'select ERPPDNO,EndProtCode,EndProtLot,EndProtQuat,DEP,ShefCode,State from EndProtBarCode where OutNo=''' +
    ClientDataSet1.FieldByName('OutNo').AsString + '''';
  if CheckBox1.Checked = False then
  begin
    strsql := strsql + ' and State=''Y''';
  end;
  SelectClientDataSet(ClientDataSet2, strsql);
end;

procedure TFOF_chengpinchukudanchakan.SelectMX_Export(OutNo:string);
var
  strsql: string;
begin
  if ClientDataSet1.RecordCount = 0 then Exit;
  strsql := 'select ERPPDNO,EndProtCode,EndProtLot,EndProtQuat,DEP,ShefCode,State from EndProtBarCode where OutNo=''' +
    OutNo + '''';
  if CheckBox1.Checked = False then
  begin
    strsql := strsql + ' and State=''Y''';
  end;
  SelectClientDataSet(ClientDataSet10, strsql);
end;

procedure TFOF_chengpinchukudanchakan.SelectMX_Export_2(OutNo:string);
var
  strsql: string;
begin
  if ClientDataSet1.RecordCount = 0 then Exit;
  strsql := 'select EndProtCode,sum(EndProtQuat) sl,ShefCode from EndProtBarCode where OutNo=''' +
    OutNo + '''';
  if CheckBox1.Checked = False then
  begin
    strsql := strsql + ' and State=''Y''';
  end;   
  strsql := strsql + ' group by EndProtCode,ShefCode';
  SelectClientDataSet(ClientDataSet10, strsql);
end;

procedure TFOF_chengpinchukudanchakan.SpeedButton2Click(Sender: TObject);
var
  vexcel, workbook, sheet: OleVariant; //导出excel
  temp, temp1, temp2, temp3, temp4, temp5, NewFileName: string;
  i: SmallInt;
begin
  inherited;
  if (ClientDataSet1.Data = null) or (ClientDataSet1.RecordCount = 0) then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据');
    Exit;
  end;

  ClientDataSet11.Data := ClientDataSet1.Data;
  ClientDataSet11.Filter := 'isselect=''1''';
  ClientDataSet11.Filtered := True;
  if ClientDataSet11.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可选择操作的记录.');
    Exit;
  end;

  temp := ExtractFilePath(Application.Exename) + '力真成品出库明细表.xls';
  if FileExists(temp) = False then
  begin
    zsbSimpleMSNPopUpShow('模版文件不存在.');
    Exit;
  end;
  zsbSimpleMSNPopUpShow('导出处理中.');

  NewFileName := ExtractFilePath(Application.Exename) + FormatDateTime('yyyyMMdd', Now) + '-' + ClientDataSet1.FieldByName('outno').AsString;
  CopyFile(PChar(temp), PChar(NewFileName), False);
  vExcel := CreateOleObject('Excel.application');
  vExcel.Visible := True; //显示
  vExcel.workbooks.Add(NewFileName);
  workbook := vExcel.workbooks[1];
  sheet := workbook.worksheets[1];
  
  i := 2;
  with ClientDataSet11 do
  begin
    First;
    while not Eof do
    begin
      temp1 := ClientDataSet11.FieldByName('outno').AsString;
      temp2 := ClientDataSet11.FieldByName('DepotCode').AsString;
      temp3 := ClientDataSet11.FieldByName('BB_NO').AsString;
      temp4 := ClientDataSet11.FieldByName('dt').AsString;
      temp5 := ClientDataSet11.FieldByName('UserCode').AsString;
      SelectMX_Export(temp1);
      with ClientDataSet10 do
      begin
        First;
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
          sheet.cells[i, 10] := temp4;
          sheet.cells[i, 11] := temp5;
          i := i + 1;
          Next;
        end;
      end;
      Next;
    end;
  end;

  zsbSimpleMSNPopUpShow('导出完成.');
end;

procedure TFOF_chengpinchukudanchakan.SpeedButton3Click(Sender: TObject);
var
  vexcel, workbook, sheet: OleVariant; //导出excel
  temp, temp1, NewFileName: string;
  i: SmallInt;
begin
  inherited;
  if (ClientDataSet1.Data = null) or (ClientDataSet1.RecordCount = 0) then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据');
    Exit;
  end;

  ClientDataSet11.Data := ClientDataSet1.Data;
  ClientDataSet11.Filter := 'isselect=''1''';
  ClientDataSet11.Filtered := True;
  if ClientDataSet11.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可选择操作的记录.');
    Exit;
  end;

  temp := ExtractFilePath(Application.Exename) + '力真成品出库明细表.xls';
  if FileExists(temp) = False then
  begin
    zsbSimpleMSNPopUpShow('模版文件不存在.');
    Exit;
  end;
  zsbSimpleMSNPopUpShow('导出处理中.');

  NewFileName := ExtractFilePath(Application.Exename) + FormatDateTime('yyyyMMdd', Now) + '-' + ClientDataSet1.FieldByName('outno').AsString;
  CopyFile(PChar(temp), PChar(NewFileName), False);
  vExcel := CreateOleObject('Excel.application');
  vExcel.Visible := True; //显示
  vExcel.workbooks.Add(NewFileName);
  workbook := vExcel.workbooks[1];
  sheet := workbook.worksheets[1];
  
  i := 2;
  with ClientDataSet11 do
  begin
    First;
    while not Eof do
    begin  
      temp1 := ClientDataSet11.FieldByName('outno').AsString;
      SelectMX_Export_2(temp1);
      with ClientDataSet10 do
      begin
        First;
        while not Eof do
        begin
          sheet.cells[i, 1] := FieldByName('EndProtCode').AsString;
          sheet.cells[i, 2] := FieldByName('sl').AsString;
          sheet.cells[i, 3] := FieldByName('ShefCode').AsString;
          i := i + 1;
          Next;
        end;
      end;
      Next;
    end;
  end;

  zsbSimpleMSNPopUpShow('导出完成.');  
end;

end.

