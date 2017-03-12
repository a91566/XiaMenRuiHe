unit U_frmAlreadyPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  RzLine, Clipbrd, StrUtils, mmsystem,
  ComCtrls, psBarcode, frxClass, ComObj, Menus;

type
  TfrmAlreadyPrint = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    Timer2: TTimer;
    Image1: TImage;
    ClientDataSet10: TClientDataSet;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    Panel1: TPanel;
    DateTimePicker2: TDateTimePicker;
    Label2: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    RzPageControl1: TRzPageControl;
    RzTabSheet1: TRzTabSheet;
    DBGridEh1: TDBGridEh;
    RzPageControl2: TRzPageControl;
    RzTabSheet2: TRzTabSheet;
    Button1: TButton;
    ClientDataSet3: TClientDataSet;
    DataSource3: TDataSource;
    DBGridEh2: TDBGridEh;
    Button2: TButton;
    frxReport1: TfrxReport;
    psBarcode1: TpsBarcode;
    Button3: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Made2DCode;
    function SaveHistory: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAlreadyPrint: TfrmAlreadyPrint;

implementation

uses UDM, ZsbDLL2, ZsbFunPro2, ZsbVariable2, U_Print, U_ChangeCARTON;

{$R *.dfm} //EndPot  TabSheet3    F_SelectPrintInfo

procedure TfrmAlreadyPrint.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TfrmAlreadyPrint.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmAlreadyPrint.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmAlreadyPrint.FormCreate(Sender: TObject);
begin
  Self.Top := 0;
  Self.Top := 0;
end;

procedure TfrmAlreadyPrint.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
end;

procedure TfrmAlreadyPrint.Timer1Timer(Sender: TObject);
var
  h: THandle;
  bit: TBitmap;
begin
  Timer1.Enabled := False;
  if FileExists(ExtractFilePath(Application.Exename) + 'BitBtnImageFormZsbDll2.dll') then
  begin
    h := LoadLibrary('BitBtnImageFormZsbDll2.dll'); //载入 DLL
    bit := TBitmap.Create;
    bit.LoadFromResourceName(h, 'imgLZtopForZhuiSuSYS2'); //提取资源
    Image1.Picture.Assign(bit);
    FreeLibrary(h); //载卸 DLL
    bit.Free;
  end;
  RzPanel1.Visible := True;
  DateTimePicker1.Date := StrToDate(FormatDateTime('yyyy-MM-', Now) + '01');
  DateTimePicker2.Date := Now;
end;

procedure TfrmAlreadyPrint.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled := False;
  try
    FDM := TFDM.Create(nil);
    FDM.RestartLink; //创建数据库连接
    if FDM.booPuLinkDBSta = False then
    begin
      if Application.MessageBox(PChar(FDM.strPuLinkError), '错误信息', MB_ICONERROR + MB_RETRYCANCEL) = idRETRY then
      begin
        FDM.RestartLink;
      end
      else
      begin
        Self.Close;
      end;
    end;
    Button1.Click;
  finally

  end;
end;


procedure TfrmAlreadyPrint.DBGridEh1CellClick(Column: TColumnEh);
var
  strsql: string;
begin
  if ClientDataSet1.RecordCount = 0 then Exit;
  strsql := 'select *  from BigBarcodeMX where BB_NO=''' + ClientDataSet1.FieldByName('BB_NO').AsString +
    ''' and dt=''' + ClientDataSet1.FieldByName('dt').AsString + '''';

  SelectClientDataSet(ClientDataSet2, strsql);
end;

procedure TfrmAlreadyPrint.Button1Click(Sender: TObject);
var
  strsql, temp1, temp2: string;
begin
  temp1 := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
  temp2 := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);
  strsql := 'select * from BigBarcodeZ where dt>=''' + temp1 + ''' and dt<=''' + temp2 + '''';
  SelectClientDataSet(ClientDataSet1, strsql);
  ClientDataSet2.Close;
end;

procedure TfrmAlreadyPrint.Made2DCode;
begin
  psBarcode1.BarCode := ClientDataSet1.FieldByName('OutNo').AsString + ',' + ClientDataSet1.FieldByName('dt').AsString;
end;

function TfrmAlreadyPrint.SaveHistory: Boolean;
var
  exsql: string;
begin
  exsql := 'update BigBarCodeZ set iTime=iTime+1  where OutNo=''' + ClientDataSet1.FieldByName('OutNo').AsString + ''';';
  Result := EXSQLClientDataSet(ClientDataSet10, exsql);
end;

procedure TfrmAlreadyPrint.Button2Click(Sender: TObject);
var
  reportFilePath, n1, n2, n3: string;
  bmp: TBitmap;
  i, iPage, itemp: SmallInt;
begin
  if ClientDataSet1.Data = null then Exit;
  if ClientDataSet1.RecordCount = 0 then Exit;
  if ClientDataSet2.Data = null then Exit;
  if ClientDataSet2.RecordCount = 0 then Exit;
  if SaveHistory = False then
  begin
    ZsbMsgErrorInfoNoApp(Self, 'TfrmAlreadyPrint.Made2DCode 操作失败，请联系管理员。');
    Exit;
  end;
  Made2DCode;
  if (ClientDataSet2.RecordCount > 16) and (ClientDataSet2.RecordCount < 32) then
  begin
    iPage := 2;
    zsbSimpleMSNPopUpShow('标签将会生成两张.');
    itemp := 16;
  end
  else
  begin
    iPage := 1;
    itemp := ClientDataSet2.RecordCount;
  end;

  reportFilePath := ExtractFilePath(ParamStr(0)) + 'frxReport6.fr3';
  frxReport1.Clear;
  frxReport1.LoadFromFile(reportFilePath);

  TfrxMemoView(frxReport1.FindObject('M_No')).Text := ClientDataSet1.FieldByName('BB_NO').AsString;
  if iPage = 2 then
  begin
    TfrxMemoView(frxReport1.FindObject('M_PageNo')).Text := '1/2';
  end
  else
  begin //如果有两张，第一张不显示二维码，不显示总数
    TfrxMemoView(frxReport1.FindObject('M_TotalQTY')).Text := ClientDataSet1.FieldByName('TotalQty').AsString;
    TfrxMemoView(frxReport1.FindObject('M_TotalCarton')).Text := ClientDataSet1.FieldByName('TotalCarton').AsString;

    bmp := TBitmap.Create;
    bmp.Width := psBarcode1.Width;
    bmp.Height := psBarcode1.Height;
    psBarcode1.PaintBarCode(bmp.Canvas, Rect(0, 0, bmp.Width, bmp.Height));
    TfrxPictureView(frxReport1.FindObject('picture1')).Picture.Assign(bmp);
    bmp.Free;
  end;

  ClientDataSet2.First;
  for i := 1 to itemp do
  begin
    with ClientDataSet2 do
    begin
      if FieldByName('PART_NO').AsString = '' then
      begin
        Break;
      end;
      n1 := 'M' + IntToStr(i) + '1';
      n2 := 'M' + IntToStr(i) + '2';
      n3 := 'M' + IntToStr(i) + '3';
      TfrxMemoView(frxReport1.FindObject(n1)).Text := FieldByName('PART_NO').AsString;
      TfrxMemoView(frxReport1.FindObject(n2)).Text := FieldByName('QTY').AsString;
      TfrxMemoView(frxReport1.FindObject(n3)).Text := FieldByName('CARTON').AsString;
      Next;
    end;
  end;


  frxReport1.ShowReport();
  //frxReport1.PrepareReport;
  //frxReport1.PrintOptions.ShowDialog := False; //不显示打印机选择框
  //frxReport1.Print; //打印


  if iPage = 2 then
  begin
    frxReport1.Clear;
    frxReport1.LoadFromFile(reportFilePath);

    TfrxMemoView(frxReport1.FindObject('M_TotalQTY')).Text := ClientDataSet1.FieldByName('TotalQty').AsString;
    TfrxMemoView(frxReport1.FindObject('M_TotalCarton')).Text := ClientDataSet1.FieldByName('TotalCarton').AsString;
    TfrxMemoView(frxReport1.FindObject('M_No')).Text := ClientDataSet1.FieldByName('BB_NO').AsString;
    TfrxMemoView(frxReport1.FindObject('M_PageNo')).Text := '2/2';
    for i := 17 to ClientDataSet2.RecordCount do
    begin
      with ClientDataSet2 do
      begin
        if FieldByName('PART_NO').AsString = '' then
        begin
          Break;
        end;
        n1 := 'M' + IntToStr(i - 16) + '1';
        n2 := 'M' + IntToStr(i - 16) + '2';
        n3 := 'M' + IntToStr(i - 16) + '3';
        TfrxMemoView(frxReport1.FindObject(n1)).Text := FieldByName('PART_NO').AsString;
        TfrxMemoView(frxReport1.FindObject(n2)).Text := FieldByName('QTY').AsString;
        TfrxMemoView(frxReport1.FindObject(n3)).Text := FieldByName('CARTON').AsString;
        Next;
      end;
    end;


    bmp := TBitmap.Create;
    bmp.Width := psBarcode1.Width;
    bmp.Height := psBarcode1.Height;
    psBarcode1.PaintBarCode(bmp.Canvas, Rect(0, 0, bmp.Width, bmp.Height));
    TfrxPictureView(frxReport1.FindObject('picture1')).Picture.Assign(bmp);
    bmp.Free;


    frxReport1.ShowReport();
    //frxReport1.PrepareReport;
    //frxReport1.PrintOptions.ShowDialog := False; //不显示打印机选择框
    //frxReport1.Print; //打印
  end;

  Button1.Click;
  zsbSimpleMSNPopUpShow('重新打印出货大标签' + IntToStr(iPage) + '张.');
  AddLog_Operation('重新打印出货大标签' + IntToStr(iPage) + '张.');
end;

procedure TfrmAlreadyPrint.Button3Click(Sender: TObject);
var
  title, strsql, NewFileName, tA, tE,bb_no: string;
  vexcel, workbook, sheet: OleVariant; //导出excel
  i, itemp: SmallInt;
begin
  if ClientDataSet1.RecordCount = 0 then Exit;
  if DateTimePicker1.Date = DateTimePicker2.Date then
  begin
    title := FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date);
  end
  else
  begin
    title := FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date) + '至' + FormatDateTime('yyyy-MM-dd', DateTimePicker2.Date);
  end;
  title := title + '海运托盘明细';

  NewFileName := ExtractFilePath(Application.Exename) + '海运托盘明细.xls';
  vExcel := CreateOleObject('Excel.application');
  vExcel.Visible := True; //显示
  vExcel.workbooks.Add(NewFileName);
  workbook := vExcel.workbooks[1];
  sheet := workbook.worksheets[1];  
  sheet.cells[1, 1] := title;
  i := 3;

  with ClientDataSet1 do
  begin
    First;
    while not Eof do
    begin
      strsql := 'select *  from BigBarcodeMX where BB_NO=''' + FieldByName('BB_NO').AsString +
        ''' and dt=''' + FieldByName('dt').AsString + '''';
      SelectClientDataSet(ClientDataSet3, strsql);
      
      itemp := i + ClientDataSet3.RecordCount - 1;
      tA := 'A' + IntToStr(i) + ':A' + IntToStr(itemp);
      tE := 'E' + IntToStr(i) + ':E' + IntToStr(itemp); 
      Sheet.range[tA].Merge; //合并单元格   列   
      Sheet.range[tE].Merge; //合并单元格   列
      bb_no:=FieldByName('BB_NO').AsString;
      bb_no:=RightStr(bb_no,Length(bb_no)-3);
      sheet.cells[i, 1] :=bb_no ;
      sheet.cells[i, 5] := FieldByName('totalCARTON').AsString;
      with ClientDataSet3 do
      begin
        First;
        while not eof do
        begin
          sheet.cells[i, 2] := FieldByName('PART_NO').AsString;
          sheet.cells[i, 3] := FieldByName('QTY').AsString;
          sheet.cells[i, 4] := FieldByName('CARTON').AsString;
          i := i + 1;
          Next;
        end;
      end;
      Next;
    end;
  end;



  zsbSimpleMSNPopUpShow('导出完成.');
end;

procedure TfrmAlreadyPrint.N2Click(Sender: TObject);
begin
  if ZsbMsgBoxOkNoApp(Self,'确认调整数量么？')=False then Exit;
  if Application.FindComponent('F_ChangeCARTON') = nil then
  begin
    Application.CreateForm(TF_ChangeCARTON, F_ChangeCARTON);
  end;
  F_ChangeCARTON.LabeledEdit1.Text:=ClientDataSet1.FieldByName('dt').AsString;
  F_ChangeCARTON.LabeledEdit2.Text:=ClientDataSet1.FieldByName('BB_NO').AsString; 
  F_ChangeCARTON.LabeledEdit3.Text:=ClientDataSet2.FieldByName('iNo').AsString;
  F_ChangeCARTON.LabeledEdit4.Text:=ClientDataSet2.FieldByName('PART_NO').AsString;
  F_ChangeCARTON.LabeledEdit5.Text:=ClientDataSet2.FieldByName('QTY').AsString;
  F_ChangeCARTON.LabeledEdit6.Text:=ClientDataSet2.FieldByName('CARTON').AsString;
  F_ChangeCARTON.ShowModal;
end;

end.

