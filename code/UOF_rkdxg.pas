unit UOF_rkdxg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, U_ObjectForm, Buttons, ExtCtrls, StdCtrls, Grids, DBGridEh,
  RzTabs, ComCtrls, DB, DBClient, Menus;

type
  TFOF_rkdxg = class(TF_ObjectForm)
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
    SpeedButton5: TSpeedButton;
    DBGridEh2: TDBGridEh;
    ClientDataSet11: TClientDataSet;
    ClientDataSet12: TClientDataSet;
    ComboBox1: TComboBox;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ButtonUpdate(b: Boolean);
    { Public declarations }
  end;

var
  FOF_rkdxg: TFOF_rkdxg;

implementation

uses ZsbDLL, ZsbFunPro, ZsbVariable, UDM, U_main;

{$R *.dfm}

procedure TFOF_rkdxg.ButtonUpdate(b: Boolean);
var
  temp: string;
begin
  if b then
  begin
    if ClientDataSet1.FieldByName('MIDDONO').AsString = '' then Exit; //没有单号 不修改
    temp := '采购入库单修改只能更改明细表的库存数量，如有疑问请联系管理员。' + #13 + #10 + #13 + #10 + #13 + #10 + #13 + #10;
    temp := temp + '[定义于2014年11月21日 16:37:47]';
    MSNPopUpShow(temp, '采购入库单修改说明', 30, 150, 300);
    LabeledEdit1.Text := ClientDataSet1.FieldByName('SuprCode').AsString;
    LabeledEdit2.Text := ClientDataSet1.FieldByName('MIDDONO').AsString;
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
  DBGridEh2.Columns[4].Visible := b; //便于修改
  DBGridEh2.Columns[5].ReadOnly := True;
  DBGridEh2.Columns[6].ReadOnly := True;
  DBGridEh2.Columns[7].ReadOnly := True;
  DBGridEh2.Columns[8].ReadOnly := True;
  SpeedButton1.Enabled := not b;
  SpeedButton4.Enabled := not b;
  SpeedButton2.Enabled := b;
  SpeedButton3.Enabled := b;
  DBGridEh1.Repaint;
end;

procedure TFOF_rkdxg.SpeedButton1Click(Sender: TObject);
var
  strsql: string;
begin
  inherited;
  strsql := 'select MatlCode,MatlLot,MatlQuat,StockQuat,StockQuat TempQuat,MatlVer,ShefCode,AutoLot,lostusesdate,ProeNo,OccupyQuat,OccupyML_NO  from MatlInDepotMx where MIDDONO=''' + ClientDataSet1.FieldByName('MIDDONO').AsString + '''';
  SelectClientDataSet(ClientDataSet2, strsql);
  ButtonUpdate(True);
end;

procedure TFOF_rkdxg.SpeedButton4Click(Sender: TObject);
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
  if ComboBox1.Text  <> '' then
  begin
    strsql := strsql + ' and state=''' + ComboBox1.Text + '''';
  end;
  strsql := strsql + ' order by id desc'; 
  SelectClientDataSet(ClientDataSet1, strsql);
  ClientDataSet2.Close;
end;

procedure TFOF_rkdxg.FormShow(Sender: TObject);
begin
  inherited;
  DateTimePicker1.Date := StrToDate(FormatDateTime('yyyy-MM-', Now) + '01');
  DateTimePicker2.Date := Now;
  SpeedButton4.Click;
  ButtonUpdate(False);
end;

procedure TFOF_rkdxg.DBGridEh1CellClick(Column: TColumnEh);
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

procedure TFOF_rkdxg.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  inherited;
  if SpeedButton1.Enabled then
  begin //原样
    {DBGridEh1.Canvas.Brush.Color := clWhite;
    DBGridEh1.Canvas.Font.Color := clBlack;
    DBGridEh1.Canvas.Font.Style := DBGridEh0_1.Canvas.Font.Style - [fsBold];
    DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State); }
  end
  else
  begin
    if ClientDataSet1.FieldByName('MIDDONO').AsString = LabeledEdit2.Text then
    begin
      DBGridEh1.Canvas.Brush.Color := clYellow;
      DBGridEh1.Canvas.Font.Color := clRed;
      DBGridEh1.Canvas.Font.Style := [fsBold];
      DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
  end;
end;

procedure TFOF_rkdxg.SpeedButton3Click(Sender: TObject);
begin
  inherited;
  ButtonUpdate(False);
end;

procedure TFOF_rkdxg.SpeedButton5Click(Sender: TObject);
var
  exsql, MIDDONOS: string;
begin
  inherited;
  if isSuprAdmin = False then
  begin
    zsbSimpleMSNPopUpShow('Sorry You Can not do it');
    Exit;
  end;
  if ClientDataSet1.FieldByName('MIDDONO').AsString = '' then Exit;
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

  exsql := 'update MatlInDepotZ set state=''N'' where MIDDONO in ' + MIDDONOS;
  if EXSQLClientDataSet(ClientDataSet12, exsql) then
  begin
    zsbSimpleMSNPopUpShow('is ok');
    SpeedButton4.Click;
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(F_main, '操作失败,请联系管理员,在 procedure TFOF_rkdxg.SpeedButton5Click(Sender: TObject)');
  end;
end;

procedure TFOF_rkdxg.SpeedButton2Click(Sender: TObject);
var
  exsql: string;
begin
  inherited;
  if ZsbMsgBoxOkNoApp(F_main, '确认调整库存数量么？') = False then Exit;
  with ClientDataSet2 do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('stockquat').AsString <> FieldByName('TempQuat').AsString then
      begin
        exsql := exsql + 'update MatlInDepotMX set stockquat=''' + FieldByName('TempQuat').AsString +
          ''' where MIDDONO=''' + labelededit2.Text + ''' and MatlCode=''' + FieldByName('MatlCode').AsString +
          ''' and AutoLot=''' + FieldByName('AutoLot').AsString + ''';';

        exsql := exsql + 'insert into MatlInDepotMX_UpdateLog(un,MIDDONO,MatlCode,BeforeQuat,AfterQuat,AutoLot)values(''' + ZStrUser +
          ''',''' + labelededit2.Text + ''',''' + FieldByName('MatlCode').AsString + ''',''' + FieldByName('stockquat').AsString +
          ''',''' + FieldByName('TempQuat').AsString + ''',''' + FieldByName('AutoLot').AsString + ''') ;';
      end;
      Next;
    end;
  end;
  if EXSQLClientDataSet(ClientDataSet12, exsql) then
  begin
    zsbSimpleMSNPopUpShow('is ok');
    SpeedButton3.Click;
    DBGridEh1CellClick(DBGridEh1.Columns[0]);
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(F_main, '操作失败,请联系管理员,在 procedure TFOF_rkdxg.SpeedButton2Click(Sender: TObject)');
  end;
end;

procedure TFOF_rkdxg.N1Click(Sender: TObject);
var
  temp,exsql,DH,NewDH,strsql,suprcode:string;
begin
  inherited;
  if isSuprAdmin=False then
  begin
    zsbSimpleMSNPopUpShow('操作受限.');
    Exit;
  end;
  DH:=ClientDataSet1.fieldByName('MIDDONO').AsString;
  suprcode:=ClientDataSet1.fieldByName('SuprCode').AsString;
  strsql:='select id from MatlInDepotZ where MIDDONO='''+DH+'''';
  if SelectClientDataSetResultCount(ClientDataSet12,strsql)<>2 then
  begin
    zsbSimpleMSNPopUpShow('不满足处理条件.');
    Exit;
  end;

  temp:='确认调整入库单号:【'+DH+'】供应商代号为：【'+suprcode+'】的单号记录么?';

  if ZsbMsgBoxOkNoApp(F_main,temp)=False then Exit;
  NewDH:=DH+'A';
  exsql:='update MatlInDepotZ set MIDDONO='''+NewDH+''' where MIDDONO='''+DH+''' and SuprCode='''+suprcode+''';';
  with ClientDataSet2 do
  begin
    First;
    while not eof do
    begin
      strsql:='select id from Material where matlcode='''+fieldByName('matlcode').AsString+
      ''' and suprcode='''+suprcode+'''';
      if SelectClientDataSetResultCount(ClientDataSet11,strsql)=1 then
      begin
        exsql:=exsql+'update MatlInDepotMX set MIDDONO='''+NewDH+''' where id='''+FieldByName('ID').AsString+''';';
      end;
      Next;
    end;
  end;
  //SaveMessage(exsql,'.sql');
  if EXSQLClientDataSet(ClientDataSet12, exsql) then
  begin
    zsbSimpleMSNPopUpShow('is ok');
    SpeedButton4.Click;
    ClientDataSet1.Locate('middono',NewDH,[]);
    DBGridEh1CellClick(DBGridEh1.Columns[0]);
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(F_main, '操作失败,请联系管理员,在 procedure TFOF_rkdxg.SpeedButton2Click(Sender: TObject)');
  end;
end;

end.

