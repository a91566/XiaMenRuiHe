unit UOF_shengchangtuikudanchakan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, U_ObjectForm, ExtCtrls, Buttons, Grids, DBGridEh, RzTabs,
  ComCtrls, StdCtrls, DB, DBClient, frxClass, frxChBox, frxDBSet, frxDesgn, StrUtils,
  RzPanel, psBarcode;

type
  TFOF_shengchangtuikudanchakan = class(TF_ObjectForm)
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
    ClientDataSet11: TClientDataSet;
    ClientDataSet10: TClientDataSet;
    frxReport1: TfrxReport;
    CheckBox1: TCheckBox;
    frxDBDataset1: TfrxDBDataset;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    LabeledEdit3: TLabeledEdit;
    RzPanel1: TRzPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    psBarcode1: TpsBarcode;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
  private
    procedure ButtonUpdate(b: Boolean);
    procedure AddDepot;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FOF_shengchangtuikudanchakan: TFOF_shengchangtuikudanchakan;

implementation

uses UDM, ZsbFunPro, ZsbDLL, U_main, ZsbVariable;

{$R *.dfm}

procedure TFOF_shengchangtuikudanchakan.AddDepot;
var
  strsql: string;
begin
  if ComboBox1.Tag = 1 then Exit;
  ComboBox1.Items.Clear;
  ComboBox2.Items.Clear;
  strsql := 'select depotcode,depotname from Depot where state=''Y'' order by depotcode';
  SelectClientDataSet(ClientDataSet10, strsql);
  with ClientDataSet10 do
  begin
    First;
    while not eof do
    begin
      ComboBox1.Items.Add(FieldByName('depotname').AsString);
      ComboBox2.Items.Add(FieldByName('depotcode').AsString);
      Next;
    end;
  end;
  ComboBox1.Tag := 1;
end;

procedure TFOF_shengchangtuikudanchakan.ButtonUpdate(b: Boolean);
var
  temp: string;
begin
  if b then
  begin
    if ClientDataSet1.FieldByName('TLNo').AsString = '' then Exit; //没有单号 不修改
    temp := '只能更改领退料原因，如有疑问请联系管理员。' + #13 + #10 + #13 + #10 + #13 + #10 + #13 + #10;
    temp := temp + '[定义于2015年3月18日 11:24:51]';
    MSNPopUpShow(temp, '生产退料单修改说明', 30, 150, 300);
  end
  else
  begin
    LabeledEdit1.Text := '';
    LabeledEdit2.Text := '';
  end;
  DBGridEh1.Enabled := not b;
  DBGridEh2.ReadOnly := not b;
  DBGridEh2.Columns[0].ReadOnly := True;
  DBGridEh2.Columns[1].ReadOnly := True;
  DBGridEh2.Columns[2].ReadOnly := True;
  DBGridEh2.Columns[3].ReadOnly := True;
  DBGridEh2.Columns[4].ReadOnly := not b; //便于修改
  DBGridEh2.Columns[5].ReadOnly := not b;
  DBGridEh2.Columns[6].ReadOnly := True;
  DBGridEh2.Columns[7].ReadOnly := True;
  SpeedButton1.Enabled := not b;
  SpeedButton2.Enabled := not b;
  SpeedButton3.Enabled := not b;
  SpeedButton4.Enabled := not b;
  SpeedButton5.Enabled := not b;
  SpeedButton6.Enabled := not b;
  SpeedButton7.Enabled := b;
  SpeedButton8.Enabled := b;
  DBGridEh1.Repaint;
end;

procedure TFOF_shengchangtuikudanchakan.SpeedButton1Click(Sender: TObject);
var
  strsql, temp1, temp2: string;
begin
  inherited;
  temp1 := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
  temp2 := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);
  strsql := 'select * from TLz where dt>=''' + temp1 + ''' and dt<=''' + temp2 + '''';
  if LabeledEdit1.Text <> '' then
  begin
    strsql := strsql + ' and MO_NO like ''%' + LabeledEdit1.Text + '%''';
  end;
  if LabeledEdit2.Text <> '' then
  begin
    strsql := strsql + ' and PW like ''%' + LabeledEdit2.Text + '%''';
  end;
  if LabeledEdit3.Text <> '' then
  begin
    strsql := strsql + ' and ML_NO like ''%' + LabeledEdit3.Text + '%''';
  end;
  SelectClientDataSet(ClientDataSet1, strsql);
  ClientDataSet2.Close;
end;

procedure TFOF_shengchangtuikudanchakan.FormShow(Sender: TObject);
begin
  inherited;
  DateTimePicker1.Date := Now;
  DateTimePicker2.Date := Now;
  SpeedButton1.Click;
end;

procedure TFOF_shengchangtuikudanchakan.DBGridEh1CellClick(
  Column: TColumnEh);
var
  strsql: string;
begin
  inherited;
  if ClientDataSet1.RecordCount = 0 then Exit;
  strsql := 'select TLm.*,Material.MatlName from TLm inner join Material on' +
    ' TLm.MatlCode=Material.MatlCode and TLm.TLNO=''' + ClientDataSet1.FieldByName('TLNO').AsString + '''';
  SelectClientDataSet(ClientDataSet2, strsql);
end;

procedure TFOF_shengchangtuikudanchakan.SpeedButton2Click(Sender: TObject);
var
  exsql, temp, TLNO,strBZSM: string;
  TempB: Boolean; //ClientDataSet10
  i:SmallInt;
  bmp: TBitmap;
begin
  inherited;

  if not FileExists(ExtractFilePath(ParamStr(0)) + '\frxReport8.fr3') then
  begin
    zsbSimpleMSNPopUpShow('对不起,标签模版不存在,请联系管理员！');
    exit;
  end;
  if ClientDataSet2.RecordCount = 0 then
  begin
    DBGridEh1CellClick(DBGridEh1.Columns[0]);
  end;
  TLNO := ClientDataSet1.FieldByName('TLNo').AsString;
  exsql := 'update TLz set state=''2.已打印'' where TLNo=''' + TLNO + ''' and state=''1.待打印''';
  TempB := EXSQLClientDataSet(ClientDataSet10, exsql);
  if TempB = False then
  begin
    temp := '【' + TLNO + '打印失败】';
    AddLog_ErrorText(TLNO + '打印失败');
    zsbSimpleMSNPopUpShow('打印记录失败，请联系管理员.');
    Exit;
  end;

  try
    i:=1;
    with ClientDataSet2 do
    begin
      First;
      while not Eof do
      begin
        strBZSM:=strBZSM+IntToStr(i)+':'+ClientDataSet2.FieldByName('MEMO').AsString+#13+#10;
        i:=i+1;
        Next;
      end;
    end;
    frxReport1.Clear;
    frxReport1.LoadFromFile(ExtractFilePath(ParamStr(0)) + '\frxReport8.fr3');
    temp := RightStr(TLNO, 1);
    if temp = 'L' then
    begin
      TfrxCheckBoxView(frxReport1.FindObject('CheckBox1')).CheckStyle := csCheck;
      TfrxCheckBoxView(frxReport1.FindObject('CheckBox2')).CheckStyle := csCross;
    end
    else
    begin
      TfrxCheckBoxView(frxReport1.FindObject('CheckBox2')).CheckStyle := csCheck;
      TfrxCheckBoxView(frxReport1.FindObject('CheckBox1')).CheckStyle := csCross;
    end;

    TfrxMemoView(frxReport1.FindObject('Memo3')).Memo.Text := TLNO;
    TfrxMemoView(frxReport1.FindObject('Memo1')).Memo.Text := ClientDataSet1.FieldByName('DEP1').AsString;
    TfrxMemoView(frxReport1.FindObject('Memo29')).Memo.Text := ClientDataSet1.FieldByName('DEP2').AsString;
    TfrxMemoView(frxReport1.FindObject('Memo4')).Memo.Text := FormatDateTime('yyyy-MM-dd', Now);     
    TfrxMemoView(frxReport1.FindObject('M_Bzsm')).Memo.Text := strBZSM;
    TfrxMemoView(frxReport1.FindObject('Memo60')).Memo.Text := '打印时间：' + FormatDateTime('yyyy-MM-dd HH:mm:ss ddd', Now);

    psBarcode1.BarCode := TLNO;
    bmp := TBitmap.Create;
    bmp.Width := psBarcode1.Width;
    bmp.Height := psBarcode1.Height;
    psBarcode1.PaintBarCode(bmp.Canvas, Rect(0, 0, bmp.Width, bmp.Height));
    TfrxPictureView(frxReport1.FindObject('picture1')).Picture.Assign(bmp);
    bmp.Free;

    if CheckBox1.Checked = True then
    begin
      frxReport1.ShowReport;
    end
    else
    begin
      frxReport1.PrepareReport;
      frxReport1.PrintOptions.ShowDialog := False; //不显示打印机选择框
      frxReport1.Print; //打印
    end;
    AddLog_Operation(TLNO + '被打印(后工程领退单)');
  except
    on ex: Exception do
    begin
      zsbSimpleMSNPopUpShow(ex.Message);
    end;
  end;
end;

procedure TFOF_shengchangtuikudanchakan.SpeedButton3Click(Sender: TObject);
begin
  inherited;
  frxReport1.LoadFromFile(ExtractFilePath(ParamStr(0)) + '\frxReport8.fr3'); //uses  frxDesgn
  frxReport1.DesignReport();
end;

procedure TFOF_shengchangtuikudanchakan.SpeedButton6Click(Sender: TObject);
begin
  inherited;
  if ClientDataSet1.FieldByName('TLNO').AsString = '' then Exit;
  if (ClientDataSet1.FieldByName('state').AsString <> '1.待打印') or ((ClientDataSet1.FieldByName('state').AsString <> '2.待审核')) then
  begin
    zsbSimpleMSNPopUpShow('单据状态不符合修改状态.');
    Exit;
  end;
  DBGridEh1CellClick(DBGridEh1.Columns[1]);
  ButtonUpdate(True);
end;

procedure TFOF_shengchangtuikudanchakan.SpeedButton7Click(Sender: TObject);
begin
  inherited;
  ButtonUpdate(false);
end;

procedure TFOF_shengchangtuikudanchakan.SpeedButton8Click(Sender: TObject);
var
  exsql: string;
begin
  inherited;
  if ZsbMsgBoxOkNoApp(F_main, '只能修改退领料原因，确认继续操作么？') = False then Exit;
  with ClientDataSet2 do
  begin
    First;
    while not Eof do
    begin
      exsql := exsql + 'update TLm set reason1=''' + FieldByName('reason1').AsString + ''',reason2=''' + FieldByName('reason2').AsString +
        ''' where TLNO=''' + ClientDataSet1.FieldByName('TLNO').AsString + ''' and MatlCode=''' + FieldByName('MatlCode').AsString +
        ''' and AutoLot=''' + FieldByName('AutoLot').AsString + ''';';
      Next;
    end;
  end;
  if EXSQLClientDataSet(ClientDataSet11, exsql) then
  begin
    zsbSimpleMSNPopUpShow('is ok');
    SpeedButton7.Click;
    DBGridEh1CellClick(DBGridEh1.Columns[0]);
    AddLog_Operation('修改了退料原因：' + ClientDataSet1.FieldByName('TLNO').AsString);
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(F_main, '操作失败,请联系管理员,在 procedure TFOF_rkdxg.SpeedButton2Click(Sender: TObject)');
  end;
end;

procedure TFOF_shengchangtuikudanchakan.SpeedButton5Click(Sender: TObject);
var
  exsql, MIDDONOS: string;
begin
  inherited;
  if isSuprAdmin = False then
  begin
    zsbSimpleMSNPopUpShow('Sorry You Can not do it');
    Exit;
  end;
  if ClientDataSet1.FieldByName('TLNO').AsString = '' then Exit;
  if ZsbMsgBoxOkNoApp(F_main, '确认作废所选的单据么？') = False then Exit;

  ClientDataSet11.Data := ClientDataSet1.Data;
  ClientDataSet11.Filter := 'isselect=''1''';
  ClientDataSet11.Filtered := True;
  if ClientDataSet11.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可选择操作的记录.');
    Exit;
  end;

  with ClientDataSet11 do
  begin
    First;
    while not Eof do
    begin
      if MIDDONOS = '' then
      begin
        MIDDONOS := '''' + ClientDataSet11.FieldByName('TLNO').AsString + '''';
      end
      else
      begin
        MIDDONOS := MIDDONOS + ',''' + ClientDataSet11.FieldByName('TLNO').AsString + '''';
      end;
      Next;
    end;
  end;
  MIDDONOS := '(' + MIDDONOS + ')';

  exsql := 'update TLz set state=''E.已作废'' where TLNO in ' + MIDDONOS;
  if EXSQLClientDataSet(ClientDataSet11, exsql) then
  begin
    zsbSimpleMSNPopUpShow('is ok');
    SpeedButton4.Click;
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(F_main, '操作失败,请联系管理员,在 procedure TFOF_shengchangtuikudanchakan.SpeedButton5Click(Sender: TObject)');
  end;
end;

procedure TFOF_shengchangtuikudanchakan.SpeedButton4Click(Sender: TObject);
begin
  inherited;
  if isSuprAdmin = False then
  begin
    zsbSimpleMSNPopUpShow('Sorry You Can not do it');
    Exit;
  end;
  if ClientDataSet1.FieldByName('TLNO').AsString = '' then Exit;

  ClientDataSet11.Data := ClientDataSet1.Data;
  ClientDataSet11.Filter := 'isselect=''1''';
  ClientDataSet11.Filtered := True;
  if ClientDataSet11.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可选择操作的记录.');
    Exit;
  end;
  label6.Caption := '';
  with ClientDataSet11 do
  begin
    First;
    while not Eof do
    begin
      if label6.Caption = '' then
      begin
        label6.Caption := '''' + ClientDataSet11.FieldByName('TLNO').AsString + '''';
      end
      else
      begin
        label6.Caption := label6.Caption + ',''' + ClientDataSet11.FieldByName('TLNO').AsString + '''';
      end;
      Next;
    end;
  end;
  label6.Caption := '(' + label6.Caption + ')';
  AddDepot;
  RzPanel1.Visible := True;
end;

procedure TFOF_shengchangtuikudanchakan.Label5Click(Sender: TObject);
begin
  inherited;
  RzPanel1.Visible := False;
end;

procedure TFOF_shengchangtuikudanchakan.Label4Click(Sender: TObject);
var
  exsql: string;
begin
  if ComboBox1.Text = '' then Exit;
  exsql := 'update TLz set state=''3.已审核'',SH_DT=''' + Formatdatetime('yyyy-MM-dd HH:mm:ss', Now) + ''',SH_UN=''' + ZStrUser +
    ''',SH_Depot=''' + combobox2.Text + ''' where TLNO in ' + label6.Caption + ';';
  with ClientDataSet2 do
  begin
    First;
    while not eof do
    begin
      if combobox2.Text = 'M01' then
      begin
         exsql := exsql + 'update MatlInDepotMX set StockQuat=StockQuat+'+FieldByName('qty').AsString +' where MatlCode='''+FieldByName('MatlCode').AsString+
         ''' and autolot='''+FieldByName('autolot').AsString+'''';
      end
      else
      begin
        exsql := exsql + 'Insert into MatlInDepotMX_Other (DepotCode,MatlCode,autolot,un,qty,stockquat) values (''' + combobox2.Text +
          ''',''' + FieldByName('MatlCode').AsString + ''',''' + FieldByName('autolot').AsString +
          ''',''' + ZStrUser + ''',''' + FieldByName('qty').AsString + ''',''' + FieldByName('qty').AsString + ''');';
      end;
      Next;
    end;
  end;
  if EXSQLClientDataSet(ClientDataSet11, exsql) then
  begin
    zsbSimpleMSNPopUpShow('is ok');
    SpeedButton4.Click;
    RzPanel1.Visible := False;
    AddLog_Operation('审核单据');
  end
  else
  begin
    SaveMessage(exsql);
    ZsbMsgErrorInfoNoApp(F_main, '操作失败,请联系管理员,在 procedure TFOF_shengchangtuikudanchakan.Label4Click(Sender: TObject)');
  end;
end;

procedure TFOF_shengchangtuikudanchakan.ComboBox1Change(Sender: TObject);
begin
  inherited;
  ComboBox2.ItemIndex := ComboBox1.ItemIndex;
end;

procedure TFOF_shengchangtuikudanchakan.ComboBox2Change(Sender: TObject);
begin
  inherited;
  ComboBox1.ItemIndex := ComboBox2.ItemIndex;
end;

end.

