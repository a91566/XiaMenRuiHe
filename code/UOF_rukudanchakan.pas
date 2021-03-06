unit UOF_rukudanchakan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, U_ObjectForm, ExtCtrls, Buttons, Grids, DBGridEh, RzTabs, DB,
  DBClient, StdCtrls, ComCtrls, ComObj, RzPanel;

type
  TFOF_rukudanchakan = class(TF_ObjectForm)
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    DateTimePicker2: TDateTimePicker;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    RzPageControl1: TRzPageControl;
    RzTabSheet1: TRzTabSheet;
    DBGridEh1: TDBGridEh;
    RzPageControl2: TRzPageControl;
    RzTabSheet2: TRzTabSheet;
    DBGridEh2: TDBGridEh;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    ClientDataSet10: TClientDataSet;
    ClientDataSet11: TClientDataSet;
    RzPanel1: TRzPanel;
    SpeedButton5: TSpeedButton;
    Label3: TLabel;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FOF_rukudanchakan: TFOF_rukudanchakan;

implementation

uses ZsbDLL, ZsbFunPro, ZsbVariable, U_main, ShellAPI;

{$R *.dfm}

procedure TFOF_rukudanchakan.SpeedButton1Click(Sender: TObject);
var
  strsql, temp1, temp2: string;
begin
  inherited;
  temp1 := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date) + ' 00:00:00';
  temp2 := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date) + ' 23:59:59';

  strsql := 'select * from matlInDepotZ where OpeeDT>=''' + temp1 + ''' and OpeeDT<=''' + temp2 + '''';
  if LabeledEdit1.Text <> '' then
  begin
    strsql := strsql + ' and SuprCode like ''%' + LabeledEdit1.Text + '%''';
  end;
  if LabeledEdit2.Text <> '' then
  begin
    strsql := strsql + ' and MIDDONO in(select MIDDONO from matlInDepotMX where MatlCode like ''%' + LabeledEdit2.Text + '%'')';
  end;
  if ComboBox1.Text <> '' then
  begin
    strsql := strsql + ' and state=''' + ComboBox1.Text + '''';
  end;
  strsql := strsql + ' order by id desc';

  {strsql:='select matlInDepotZ.*,Supplier.SuprCode+''/''+Supplier.SuprName SuprCodeName from matlInDepotZ,Supplier where matlInDepotZ.OpeeDT>='''+
  temp1+''' and matlInDepotZ.OpeeDT<='''+temp2+''' and matlInDepotZ.SuprCode=Supplier.SuprCode+''/''+Supplier.SuprName';
  if LabeledEdit1.Text<>'' then
  begin
     strsql:=strsql+' and matlInDepotZ.SuprCode like ''%'+LabeledEdit1.Text+'%''';
  end;
  if LabeledEdit2.Text<>'' then
  begin
     strsql:=strsql+' and matlInDepotZ.MIDDONO in(select MIDDONO from matlInDepotMX where MatlCode like ''%'+LabeledEdit2.Text+'%'')';
  end;
  strsql:=strsql+' order by matlInDepotZ.id desc';   }
  SelectClientDataSet(ClientDataSet1, strsql);
  ClientDataSet2.Close;
end;

procedure TFOF_rukudanchakan.FormShow(Sender: TObject);
begin
  inherited;
  DateTimePicker1.Date := StrToDate(FormatDateTime('yyyy-MM-', Now) + '01');
  DateTimePicker2.Date := Now;
  SpeedButton1.Click;
end;

procedure TFOF_rukudanchakan.DBGridEh1CellClick(Column: TColumnEh);
var
  strsql: string;
begin
  inherited;
  strsql := 'select * from MatlInDepotMx where MIDDONO=''' + ClientDataSet1.FieldByName('MIDDONO').AsString + ''''; 
  if CheckBox1.Checked then
  begin
    if LabeledEdit2.Text <> '' then
    begin
      strsql := strsql + ' and MatlCode like ''%' + LabeledEdit2.Text + '%''';
    end;
  end;
  strsql := strsql + ' order by MatlCode';
  SelectClientDataSet(ClientDataSet2, strsql);
end;

procedure TFOF_rukudanchakan.SpeedButton2Click(Sender: TObject);
var
  vexcel, workbook, sheet: OleVariant; //导出excel
  strsql, fn, fp, MIDDONOS: string;
  i, iCount: SmallInt;
  TSList, TSList2: TStringList;
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
  if ClientDataSet1.FieldByName('MIDDONO').AsString = '' then
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

  iCount := 0;
  MIDDONOS := '';
  RzPanel1.Visible := True;
  RzPanel1.Caption := '正在处理所选入库单';
  WaitTime(100);

  with ClientDataSet11 do
  begin
    First;
    while not Eof do
    begin
      if MIDDONOS = '' then
      begin
        MIDDONOS := '''' + ClientDataSet11.FieldByName('MIDDONO').AsString + '''';
      end
      else
      begin
        MIDDONOS := MIDDONOS + ',''' + ClientDataSet11.FieldByName('MIDDONO').AsString + '''';
      end;
      Next;
    end;
  end;
  MIDDONOS := '(' + MIDDONOS + ')';

  RzPanel1.Caption := '正在处理所选入库单里的料号';
  WaitTime(100);


  strsql := 'select distinct MatlCode from MatlInDepotMx where MIDDONO in ' + MIDDONOS;
  strsql := strsql + ' order by MatlCode';
  SelectClientDataSetNoTips(ClientDataSet10, strsql);
  iCount := ClientDataSet11.RecordCount;

  TSList := TStringList.Create;
  TSList2 := TStringList.Create;

  with ClientDataSet10 do
  begin
    First;
    while not Eof do
    begin
      RzPanel1.Caption := '正在处理料号:' + FieldByName('MatlCode').AsString;
      TSList.Add(FieldByName('MatlCode').AsString);
      Application.ProcessMessages;
      Next;
    end;
  end;


  for i := 0 to TSList.Count - 1 do
  begin
    strsql := 'select sum(MatlQuat) zzz from MatlInDepotMx where matlcode=''' + TSList[i] +
      ''' and MIDDONO in' + MIDDONOS;
    TSList2.Add(SelectClientDataSetResultFieldCaption(ClientDataSet10, strsql, 'zzz'));
    RzPanel1.Caption := '正在计算料号数量,料号:' + TSList[i];
    WaitTime(100);
  end;


  RzPanel1.Caption := '数量整理完毕准备导出';
  fp := ExtractFilePath(Application.Exename) + '导出的文件';
  if DirectoryExists(fp) = False then
  begin
    CreateDir(fp);
  end;
  fn := fp + '\力真进货汇总表.' + FormatDateTime('yyyyMMddHHmmss', Now) + '.xls';
  if FileExists(fn) then
  begin
    if ZsbMsgBoxOkNoApp(F_main, '文件已存在,是否继续?') = False then Exit;
  end;
  Self.Enabled := False;
  WaitTime(1000);



  vExcel := CreateOleObject('Excel.Application');
  vExcel.Visible := false; //不显示
  Workbook := CreateOleObject('Excel.sheet');
  Workbook.worksheets[1].name := '力真进货汇总表';
  workbook.worksheetS[1].cells[1, 1] := '料号';
  workbook.worksheetS[1].cells[1, 2] := '数量';

  for i := 0 to TSList.Count - 1 do
  begin
    workbook.worksheetS[1].cells[i + 2, 1] := TSList[i];
    workbook.worksheetS[1].cells[i + 2, 2] := TSList2[i];
    RzPanel1.Caption := '正在导出:' + TSList[i];
    WaitTime(100);
  end;


  TSList.Free;
  TSList2.Free;
  //ShowMessage(fn);
  vExcel.DisplayAlerts := false;
  workbook.worksheets[1].saveas(fn);


  Self.Enabled := True;
  RzPanel1.Visible := False;
  WaitTime(1000);

  strsql := '成功导出' + Inttostr(iCount) + '条数据,文件:' + fn;
  //if ZsbMsgBoxOkNoApp(F_main,strsql ) = False then Exit;
  MSNPopUpShow(strsql, '', 10, 50, F_main.Width - 32);
  ShellExecute(Handle, 'open', 'Explorer.exe', PChar(fp), nil, 1); //打开文件夹

  //ShellExecute(Application.Handle, 'open', PChar(fn), '-s', nil, SW_SHOWNORMAL);//打开文件
end;

procedure TFOF_rukudanchakan.SpeedButton3Click(Sender: TObject);
var
  temp: string;
begin
  inherited;
  zsbSimpleMSNPopUpShow('暂不支持.');
  Exit;
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
  if ClientDataSet1.FieldByName('MIDDONO').AsString = '' then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据');
    Exit;
  end;
  temp := '确认验证【' + ClientDataSet1.FieldByName('MIDDONO').AsString + '】单据明细么？';
  if ZsbMsgBoxOkNoApp(F_main, temp) then
  begin

  end;
end;

procedure TFOF_rukudanchakan.SpeedButton5Click(Sender: TObject);
var
  vexcel, workbook, sheet: OleVariant; //导出excel
  strsql, fn, fp, MIDDONOS: string;
  iCount: SmallInt;
  TSList, TSList2: TStringList;
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
  if ClientDataSet1.FieldByName('MIDDONO').AsString = '' then
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

  iCount := 0;
  MIDDONOS := '';
  RzPanel1.Visible := True;
  RzPanel1.Caption := '正在处理所选入库单';
  WaitTime(100);

  with ClientDataSet11 do
  begin
    First;
    while not Eof do
    begin
      if MIDDONOS = '' then
      begin
        MIDDONOS := '''' + ClientDataSet11.FieldByName('MIDDONO').AsString + '''';
      end
      else
      begin
        MIDDONOS := MIDDONOS + ',''' + ClientDataSet11.FieldByName('MIDDONO').AsString + '''';
      end;
      Next;
    end;
  end;
  MIDDONOS := '(' + MIDDONOS + ')';

  WaitTime(100);

  RzPanel1.Caption := '数量整理完毕准备导出';
  fp := ExtractFilePath(Application.Exename) + '导出的文件';
  if DirectoryExists(fp) = False then
  begin
    CreateDir(fp);
  end;
  fn := fp + '\力真进货明细表.' + FormatDateTime('yyyyMMddHHmmss', Now) + '.xls';
  if FileExists(fn) then
  begin
    if ZsbMsgBoxOkNoApp(F_main, '文件已存在,是否继续?') = False then Exit;
  end;


  vExcel := CreateOleObject('Excel.Application');
  vExcel.Visible := false; //不显示
  Workbook := CreateOleObject('Excel.sheet');
  Workbook.worksheets[1].name := '力真进货汇总表';
  workbook.worksheetS[1].cells[1, 1] := '单号';
  workbook.worksheetS[1].cells[1, 2] := '料号';
  workbook.worksheetS[1].cells[1, 3] := '批号';
  workbook.worksheetS[1].cells[1, 4] := '数量';
  workbook.worksheetS[1].cells[1, 5] := '版次';
  workbook.worksheetS[1].cells[1, 6] := '货架';
  workbook.worksheetS[1].cells[1, 7] := '流水号';


  workbook.ActiveSheet.Columns[1].ColumnWidth := 15;
  workbook.ActiveSheet.Columns[2].ColumnWidth := 15;
  workbook.ActiveSheet.Columns[3].ColumnWidth := 20;
  workbook.ActiveSheet.Columns[4].ColumnWidth := 8;
  workbook.ActiveSheet.Columns[5].ColumnWidth := 8;
  workbook.ActiveSheet.Columns[6].ColumnWidth := 8;
  workbook.ActiveSheet.Columns[7].ColumnWidth := 15;

  strsql := 'select * from MatlInDepotMx where MIDDONO in ' + MIDDONOS;
  strsql := strsql + ' order by MatlCode';
  SelectClientDataSetNoTips(ClientDataSet10, strsql);


  with ClientDataSet10 do
  begin
    First;
    while not Eof do
    begin
      RzPanel1.Caption := '正在导出:' + FieldByName('MIDDONO').AsString;
      WaitTime(100);
      workbook.worksheetS[1].cells[iCount + 2, 1] := FieldByName('MIDDONO').AsString;
      workbook.worksheetS[1].cells[iCount + 2, 2] := FieldByName('MatlCode').AsString;
      workbook.worksheetS[1].cells[iCount + 2, 3] := FieldByName('MatlLot').AsString;
      workbook.worksheetS[1].cells[iCount + 2, 4] := FieldByName('MatlQuat').AsString;
      workbook.worksheetS[1].cells[iCount + 2, 5] := FieldByName('MatlVer').AsString;
      workbook.worksheetS[1].cells[iCount + 2, 6] := FieldByName('ShefCode').AsString;
      workbook.worksheetS[1].Columns[7].numberformatlocal := '@'; //设为文本
      workbook.worksheetS[1].cells[iCount + 2, 7] := FieldByName('autoLot').AsString;
      iCount := iCount + 1;
      Application.ProcessMessages;
      Next;
    end;
  end;

  vExcel.DisplayAlerts := false;
  workbook.worksheets[1].saveas(fn);


  RzPanel1.Caption := '完成导出。';

  Self.Enabled := True;
  WaitTime(1000);

  strsql := '成功导出' + Inttostr(iCount) + '条数据,文件:' + fn;
  MSNPopUpShow(strsql, '', 10, 50, F_main.Width);
  ShellExecute(Handle, 'open', 'Explorer.exe', PChar(fp), nil, 1); //打开文件夹

  RzPanel1.Visible := False;

  //ShellExecute(Application.Handle, 'open', PChar(fn), '-s', nil, SW_SHOWNORMAL);//打开文件

end;

procedure TFOF_rukudanchakan.SpeedButton4Click(Sender: TObject);
begin
  inherited;
  with ClientDataSet1 do
  begin
    First;
    while not Eof do
    begin
      Edit;
      FieldByName('isSelect').Value:=1;
      Next;
    end;
  end;
  ClientDataSet1.First;
end;

end.

