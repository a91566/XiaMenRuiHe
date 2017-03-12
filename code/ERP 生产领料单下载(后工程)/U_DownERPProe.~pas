{

这边下载ERP生产单的后，最好能生成一个出库单 。
（客户要求的，直接提示出库哪个批号是最早的，而不是一个一个去找然后扫描验证是不是最早的批次）
好像这样也不行，要是货不见了呢。

显示最早的批次，供打印出单据。

                }

unit U_DownERPProe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  ComCtrls, frxClass, frxCross, frxBarcode, psBarcode, Clipbrd,
  IdBaseComponent, IdComponent, IdIPWatch, Animate, GIFCtrl, Menus;

type
  TF_DownERPProe = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    ScrollBox1: TScrollBox;
    RzPanel99: TRzPanel;
    RzPanel1: TRzPanel;
    SpeedButton999: TSpeedButton;
    Timer2: TTimer;
    Image1: TImage;
    RzPageControl2: TRzPageControl;
    RzTabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    DateTimePicker2: TDateTimePicker;
    LabeledEdit1: TLabeledEdit;
    RzPageControl6: TRzPageControl;
    RzTabSheet5: TRzTabSheet;
    ScrollBox6: TScrollBox;
    RzPanel5: TRzPanel;
    RzPageControl4: TRzPageControl;
    RzTabSheet3: TRzTabSheet;
    ScrollBox2: TScrollBox;
    RzPanel2: TRzPanel;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    ClientDataSet3: TClientDataSet;
    DataSource3: TDataSource;
    ClientDataSet4: TClientDataSet;
    DataSource4: TDataSource;
    RzPageControl3: TRzPageControl;
    RzTabSheet2: TRzTabSheet;
    ScrollBox3: TScrollBox;
    RzPanel3: TRzPanel;
    DBGridEh2: TDBGridEh;
    RzPageControl5: TRzPageControl;
    RzTabSheet4: TRzTabSheet;
    ScrollBox4: TScrollBox;
    RzPanel4: TRzPanel;
    DBGridEh3: TDBGridEh;
    DBGridEh4: TDBGridEh;
    DBGridEh1: TDBGridEh;
    RzPanel6: TRzPanel;
    Button1: TButton;
    ClientDataSet11: TClientDataSet;
    ClientDataSet10: TClientDataSet;
    ClientDataSet5: TClientDataSet;
    DataSource5: TDataSource;
    RzPanel7: TRzPanel;
    Image3: TImage;
    Button2: TButton;
    frxReport1: TfrxReport;
    ClientDataSet101: TClientDataSet;
    TabSheet3: TRzTabSheet;
    DBGridEh5: TDBGridEh;
    ClientDataSet6: TClientDataSet;
    DataSource6: TDataSource;
    DBGridEh6: TDBGridEh;
    ClientDataSet7: TClientDataSet;
    DataSource7: TDataSource;
    TabSheet4: TRzTabSheet;
    DBGridEh7: TDBGridEh;
    DBGridEh8: TDBGridEh;
    ClientDataSet8: TClientDataSet;
    DataSource8: TDataSource;
    ClientDataSet9: TClientDataSet;
    DataSource9: TDataSource;
    Button4: TButton;
    psBarcode1: TpsBarcode;
    Button3: TButton;
    ClientDataSet12: TClientDataSet;
    Label5: TLabel;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    ClientDataSet13_Filter: TClientDataSet;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    IdIPWatch1: TIdIPWatch;
    Label6: TLabel;
    ComboBox2: TComboBox;
    RzPanel8: TRzPanel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure SpeedButton999Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure DBGridEh2CellClick(Column: TColumnEh);
    procedure Button3Click(Sender: TObject);
    procedure DBGridEh6CellClick(Column: TColumnEh);
    procedure DBGridEh7CellClick(Column: TColumnEh);
    procedure Button4Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox1Change(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public
    procedure SelectProeDocFromLZDB;
    procedure SelectProeDocFromERPDB;
    procedure AddCombobox2;
    { Public declarations }
  end;
  const  cReadMe = 'ERP生产领料单下载,功能说明:' +
    #13 + #10 + '.' +
    #13 + #10 + #13 + #10 + '2014年11月26日 10:06:42 郑少宝';

var
  F_DownERPProe: TF_DownERPProe;

implementation

uses UDM, ZsbDLL2, ZsbFunPro2, ZsbVariable2;

//ERPProduceDocZ -> LZz_ML_MO_FromERP
//ERPProduceDocMx -> LZm_ML_MO_FromERP
//ERPPDNO -> ML_NO
//ERPZLDH-> MO_NO
//OccupyERPPDNO ->  OccupyML_NO

{$R *.dfm}

procedure TF_DownERPProe.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_DownERPProe.AddCombobox2;
var
  strsql: string;
begin
  strsql := 'select distinct usr from ZT_ML_NO_FromERP where usr<>''''';
  SelectClientDataSet(ClientDataSet11, strsql);
  with ClientDataSet11 do
  begin
    First;
    Combobox2.Items.Clear;
    Combobox2.Items.Add('');
    while not eof do
    begin
      Combobox2.Items.Add(FieldByName('usr').AsString);
      Next;
    end;
  end;
end;

procedure TF_DownERPProe.SelectProeDocFromERPDB;
var
  strSQL1: string;
begin
  strSQL1 := 'select * from ZT_ML_NO_FromERP where 1=1';
  if LabeledEdit1.Text <> '' then
  begin
    strSQL1 := strSQL1 + ' and ML_NO like ''%' + LabeledEdit1.Text + '%''';
  end;
  if LabeledEdit5.Text <> '' then
  begin
    strSQL1 := strSQL1 + ' and MO_NO like ''%' + LabeledEdit5.Text + '%''';
  end;
  if LabeledEdit6.Text <> '' then
  begin
    strSQL1 := strSQL1 + ' and MRP_NO like ''%' + LabeledEdit6.Text + '%''';
  end;
  if LabeledEdit7.Text <> '' then
  begin
    strSQL1 := strSQL1 + ' and DEP=''' + LabeledEdit7.Text + '''';
  end;
  if ComboBox2.ItemIndex > 0 then
  begin
    strSQL1 := strSQL1 + ' and usr=''' + ComboBox2.Text + '''';
  end;
  strSQL1 := strSQL1 + ' order by dt desc';
  SelectClientDataSet(ClientDataSet1, strSQL1);
  ClientDataSet2.Close;
end;

procedure TF_DownERPProe.SelectProeDocFromLZDB;
var
  strSQL2: string;
begin
  strSQL2 := 'select * from LZz_ML_MO_FromERP where OpeeDT>=''' + FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date) + ''' and OpeeDT<=''' +
    FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date) + '''';
  if LabeledEdit1.Text <> '' then
  begin
    strSQL2 := strSQL2 + ' and ML_NO like ''%' + LabeledEdit1.Text + '%''';
  end;

  if ComboBox1.ItemIndex > 0 then
  begin
    strSQL2 := strSQL2 + ' and state=''' + ComboBox1.Text + '''';
  end;

  if ComboBox2.ItemIndex > 0 then
  begin
    strSQL2 := strSQL2 + ' and usr=''' + ComboBox2.Text + '''';
  end;

  if LabeledEdit5.Text <> '' then
  begin
    strSQL2 := strSQL2 + ' and ML_NO in (select distinct ML_NO from LZm_ML_MO_FromERP where MO_NO like ''%' + LabeledEdit5.Text + '%'')';
  end;
  if LabeledEdit6.Text <> '' then
  begin
    strSQL2 := strSQL2 + ' and EndProtCode like ''%' + LabeledEdit6.Text + '%''';
  end;
  if LabeledEdit7.Text <> '' then
  begin
    strSQL2 := strSQL2 + ' and ProeDept like ''%' + LabeledEdit7.Text + '%''';
  end;

  strSQL2 := strSQL2 + ' order by DOWNTIME desc';
  SelectClientDataSet(ClientDataSet3, strSQL2);
  ClientDataSet4.Close;
end;

procedure TF_DownERPProe.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_DownERPProe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05
  Action := caFree;
end;

procedure TF_DownERPProe.FormCreate(Sender: TObject);
begin
  Self.Left := 50;
  Self.Top := 50;
end;

procedure TF_DownERPProe.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
end;

procedure TF_DownERPProe.Timer1Timer(Sender: TObject);
var
  h: THandle;
  bit, bit2: TBitmap;
begin
  Timer1.Enabled := False;
  if FileExists(ExtractFilePath(Application.Exename) + 'BitBtnImageFormZsbDll2.dll') then
  begin
    h := LoadLibrary('BitBtnImageFormZsbDll2.dll'); //载入 DLL
    bit := TBitmap.Create;
    bit2 := TBitmap.Create;
    bit.LoadFromResourceName(h, 'imgLZtopForZhuiSuSYS2'); //提取资源
    bit2.LoadFromResourceName(h, 'imgSkyBlue'); //提取资源
    Image1.Picture.Assign(bit);
    Image3.Picture.Assign(bit2);
    FreeLibrary(h); //载卸 DLL
    bit.Free;
    bit2.Free;
  end;
  RzPageControl1.Visible := True;
  RzPageControl1.ActivePageIndex := 0;
  RzPageControl2.ActivePageIndex := 1;
end;

procedure TF_DownERPProe.Timer2Timer(Sender: TObject);
var
  TSList: TStringList;
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
    RzTabSheet2.Caption := '主单据【单据状态说明：1.待打印->2.待发料->3.发料中->4.已完成->E.已作废】【右键可以进行全选操作】';
    AddCombobox2;
      //加载查询条件
    if FileExists(ExtractFilePath(Application.Exename) + 'DownERPProe_Select.zsb') then
    begin
      TSList := TStringList.Create;
      TSList.LoadFromFile(ExtractFilePath(Application.Exename) + 'DownERPProe_Select.zsb');
      //DateTimePicker1.Date := StrToDate(TSList[0]);
      //DateTimePicker2.Date := StrToDate(TSList[1]);
      //LabeledEdit1.Text := TSList[2];
      //LabeledEdit5.Text := TSList[3];
      //LabeledEdit6.Text := TSList[4];
      //LabeledEdit7.Text := TSList[5];
      if TSList[6] = '' then
      begin
        TSList[6] := '0';
      end;
      ComboBox2.ItemIndex := StrToInt(TSList[6]);
      TSList.Free;
      DateTimePicker1.Date := Now - 1;
      DateTimePicker2.Date := Now;
    end
    else
    begin
      DateTimePicker1.Date := Now;
      DateTimePicker2.Date := Now;
    end;

    if isSuprAdmin = False then
    begin
      TabSheet3.TabVisible := False;
      TabSheet4.TabVisible := False;
    end;
    SpeedButton999.Click;
  finally

  end;
end;

procedure TF_DownERPProe.DBGridEh1CellClick(Column: TColumnEh);
var
  temp, strSQL1: string;
begin
  temp := ClientDataSet1.FieldByName('ML_NO').AsString;
  if temp = '' then Exit;

  with ClientDataSet2 do //连接其他数据库
  begin
    RemoteServer.AppServer.LinkHISData('1');
  end;

  strSQL1 := 'select PRD_NO,PRD_NAME,WH,QTY,ML_NO,MO_NO from TF_ML where ML_NO=''' + temp + '''';
  with ClientDataSet2 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strSQL1);
  end;
end;

procedure TF_DownERPProe.SpeedButton999Click(Sender: TObject);
var
  TSList: TStringList;
begin
  Self.Cursor := crSQLWait;
  if FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date) < '2014-11-01' then
  begin
    zsbSimpleMSNPopUpShow_2('请注意,2014年11月1日以前的单据系统没有下载,无法查询.', clLime, 500);
    DateTimePicker1.Date := StrToDate('2014-11-01');
  end;
  SelectProeDocFromERPDB;
  SelectProeDocFromLZDB;
  TSList := TStringList.Create;
  TSList.Add(FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date));
  TSList.Add(FormatDateTime('yyyy-MM-dd', DateTimePicker2.Date));
  TSList.Add(LabeledEdit1.Text);
  TSList.Add(LabeledEdit5.Text);
  TSList.Add(LabeledEdit6.Text);
  TSList.Add(LabeledEdit7.Text);
  TSList.Add(IntToStr(ComboBox2.ItemIndex));
  TSList.SaveToFile(ExtractFilePath(Application.Exename) + 'DownERPProe_Select.zsb');
  TSList.Free;

  Self.Cursor := crDefault;
  N6.Caption:='重新下载 [  ]';
end;

procedure TF_DownERPProe.Button1Click(Sender: TObject);
var
  strshow, strsql, exsql, strNeedOutLot, strNeedOutLotShefCode, exsqlOccupyQuat: string;
  strML_NO, strMO_NO, strPW, strQty, strErrorShow: string;
  //TSList: TStringList;
  iCount, iCountError, iTemp: SmallInt;
begin
  Exit;
  ClientDataSet13_Filter.Data := ClientDataSet1.Data;
  ClientDataSet13_Filter.Filter := 'isselect=''1''';
  ClientDataSet13_Filter.Filtered := True;
  if ClientDataSet13_Filter.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可选择操作的记录.');
    Exit;
  end;

  strshow := '确认下载所选的领退单（ML）么？';
  if ZsbMsgBoxOkNoApp(Self, strshow) = False then Exit;
  WaitTime(100);
  iCount := 0;
  iCountError := 0;
  exsql := '';
  strErrorShow := '';

  with ClientDataSet13_Filter do
  begin
    First;
    while not Eof do
    begin
      strML_NO := FieldByName('ML_NO').AsString;
      Application.ProcessMessages;

      strpw := fieldbyname('MRP_NO').AsString;
      strqty := fieldbyname('QTY').AsString;

      //查询记录是否已经存在
      strsql := 'select id from LZz_ML_MO_FromERP where  ML_NO=''' + strML_NO +
        ''' and state in(''1.待打印'',''2.待发料'',''3.发料中'',''4.已完成'') '; //查询是否已经存在
      iTemp := SelectClientDataSetResultCount(ClientDataSet12, strsql);
      if iTemp > 0 then //已存在的不操作
      begin
        zsbSimpleMSNPopUpShow_2(strML_NO + '已存在.');
        WaitTime(100);
      end
      else
      begin

         //插入主单
        exsql := exsql + 'insert into LZz_ML_MO_FromERP(ML_NO,OpeeDT,ProeDept,EndProtCode,EndProtQuat,DownTime,State,un) values (''' + strML_NO + ''',''' +
          ClientDataSet1.FieldByName('ML_DD').AsString + ''',''' + ClientDataSet1.FieldByName('DEP').AsString + ''',''' +
          strpw + ''',''' + strqty + ''',''' + FormatDateTime('yyyy-mm-dd hh:mm:ss', Now) + ''',''1.待打印'',''' + ZstrUser + ''');';



        //exsql := exsql + 'update matlindepotmx set OccupyML_NO='''',OccupyQuat=0  where OccupyML_NO=''' + strML_NO + ''';'; //先删除

        //插入明细
        strSQL := 'select PRD_NO,PRD_NAME,QTY_RSV,WH,MO_NO from TF_ML where ML_NO=''' + strML_NO + '''';
        with ClientDataSet2 do
        begin
          data := RemoteServer.AppServer.HISFUN_GetDataSql(strSQL);
        end;
        with ClientDataSet2 do //查询明细表与指令单号
        begin
          First;
          while not Eof do
          begin
            strMO_NO := FieldByName('MO_NO').AsString;

            //预出库  暂时停用
            strNeedOutLot := '';
            exsqlOccupyQuat := ''; //占用数量
           {
           temp := GetOldestMatlCode(FieldByName('PRD_NO').AsString, FieldByName('QTY_RSV').AsFloat, strML_NO); // 获取出库批次
            TSList := TStringList.Create;
            iCount := ExtractStrings(['/'], [], PChar(temp), TSList); //分割
            if iCount = 2 then
            begin
              strNeedOutLot := TSList[0];
              exsqlOccupyQuat := TSList[1]; //占用数量
            end;
            TSList.Free;
            strNeedOutLotShefCode := GetOldestMatlShefCode(FieldByName('PRD_NO').AsString, strNeedOutLot); //获取批次的货架
            }

            exsql := exsql + 'insert into LZm_ML_MO_FromERP(ML_NO,MatlCode,MatlName,MatlQuat,DepotCode,OldestMatlLot,MO_NO,ShefCode) values (''' + strML_NO + ''',''' +
              FieldByName('PRD_NO').AsString + ''',''' + FieldByName('PRD_NAME').AsString + ''',''' + FieldByName('QTY_RSV').AsString +
              ''',''' + FieldByName('WH').AsString + ''',''' + strNeedOutLot +
              ''',''' + StrMO_NO + ''',''' + strNeedOutLotShefCode + ''');';
            Application.ProcessMessages;
            Next;
          end;
        end;
      end;

      if exsql <> '' then
      begin
        exsql := ' begin ' + exsql + ' commit; end;';
        if EXSQLClientDataSet(ClientDataSet10, exsql) then
        begin
          iCount := iCount + 1;
        end
        else
        begin
          iCountError := iCountError + 1;
          strErrorShow := strErrorShow + '【' + strML_NO + '】';
        end;
      end;
      exsql := '';
      Application.ProcessMessages;
      Next;
    end;
  end;

  SelectProeDocFromLZDB;
  if iCountError > 0 then
  begin
    strErrorShow := strErrorShow + '下载失败';
    ZsbMsgErrorInfoNoApp(Self, strErrorShow);
  end;
end;

procedure TF_DownERPProe.Button2Click(Sender: TObject);
var
  strML_NO, strMO_NO, strSQL1, strqrcode, strError, exsql: string;
  i, iCount, iCountError: SmallInt;
  bmp: TBitmap;
  TempB: Boolean; //ClientDataSet10
begin
  if ClientDataSet3.RecordCount = 0 then Exit;

  ClientDataSet13_Filter.Data := ClientDataSet3.Data;
  ClientDataSet13_Filter.Filter := 'isselect=''1''';
  ClientDataSet13_Filter.Filtered := True;
  if ClientDataSet13_Filter.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('没有可选择操作的记录.');
    Exit;
  end;

  RzPanel8.Visible := True;
  Application.ProcessMessages;

  iCount := 0;
  iCountError := 0;
  strError := '';
  try
    with ClientDataSet13_Filter do
    begin
      First;
      while not eof do
      begin
        strML_NO := FieldByName('ML_NO').AsString;
        zsbSimpleMSNPopUpShow('打印领料单:' + strML_NO);
        RzPanel8.Caption := strML_NO;
        Application.ProcessMessages;
        exsql := 'update LZz_ML_MO_FromERP set state=''2.待发料'' where ML_NO=''' + strML_NO + ''' and state=''1.待打印''';
        TempB := EXSQLClientDataSet(ClientDataSet12, exsql);
        if TempB = False then
        begin
          strError := strError + '【' + strML_NO + '打印失败】';
          AddLog_ErrorText(strML_NO + '打印失败');
          iCountError := iCountError + 1;
        end
        else
        begin
          //strSQL1 := 'select MatlQuatAlreadyOut,MatlCode,MatlName,MatlQuat,DepotCode,MO_NO,OldestMatlLot,ShefCode ' +
            //'from LZm_ML_MO_FromERP where ML_NO=''' + strML_NO + '''';
          strSQL1 := 'select MatlQuatAlreadyOut,MatlCode,MatlName,MatlQuat,DepotCode,MO_NO ' +
            'from LZm_ML_MO_FromERP where ML_NO=''' + strML_NO + '''';
          SelectClientDataSet(ClientDataSet11, strSQL1);
          ClientDataSet4.Data := ClientDataSet11.Data;
          with ClientDataSet11 do
          begin
            First;
            i := 1;
            strMO_NO := FieldByName('MO_NO').AsString;
            while not eof do
            begin
              Edit;
              FieldByName('MatlQuatAlreadyOut').Value := IntToStr(i);
              i := i + 1;
              Next;
            end;
          end;
          frxReport1.Clear;
          frxReport1.LoadFromFile(ExtractFilePath(ParamStr(0)) + '\frERPProeDoc.fr3');

          TfrxMemoView(frxReport1.FindObject('Memo1')).Memo.Text := fieldbyname('CUS_OS_NO').AsString;

          TfrxMemoView(frxReport1.FindObject('Memo2')).Memo.Text := strMO_NO;
          TfrxMemoView(frxReport1.FindObject('Memo12')).Memo.Text := fieldbyname('ML_NO').AsString;
          TfrxMemoView(frxReport1.FindObject('Memo3')).Memo.Text := fieldbyname('EndProtCode').AsString;
          TfrxMemoView(frxReport1.FindObject('Memo4')).Memo.Text := fieldbyname('ProeDept').AsString;
          TfrxMemoView(frxReport1.FindObject('Memo5')).Memo.Text := fieldbyname('BQ').AsString;

          strqrcode := strML_NO + ',' + strMO_NO;
          psBarcode1.BarCode := strqrcode;
          bmp := TBitmap.Create;
          bmp.Width := psBarcode1.Width;
          bmp.Height := psBarcode1.Height;
          psBarcode1.PaintBarCode(bmp.Canvas, Rect(0, 0, bmp.Width, bmp.Height));
          TfrxPictureView(frxReport1.FindObject('picture1')).Picture.Assign(bmp);
          //TfrxPictureView(frxReport1.FindObject('picture2')).Picture.Assign(bmp);
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
          AddLog_Operation(strML_NO + '被打印(领料单)');
          iCount := iCount + 1;
        end;
        Application.ProcessMessages;
        Next;
      end;
    end;

    RzPanel8.Visible := False;
    if iCountError > 0 then
    begin
      strError := strError + '【' + IntToStr(iCountError) + '张打印失败】';
      ZsbMsgErrorInfoNoApp(Self, strError);
    end
    else
    begin
      ZsbShowMessageNoApp(Self, '操作完成,共打印领料单' + IntToStr(iCount) + '张');
    end;
    SelectProeDocFromLZDB;
  except
    on e: Exception do
    begin
      RzPanel8.Visible := False;
      ZsbMsgErrorInfoNoApp(Self, e.Message);
    end;
  end;

end;

procedure TF_DownERPProe.frxReport1BeforePrint(
  Sender: TfrxReportComponent);
var
  Cross: TfrxCrossView;
  i, j, k, iLen: Integer;
  temp, tempNull, TempField: string;
begin
  tempNull := '    ';
  ClientDataSet11.Fields[0].DisplayLabel := 'No.';
  ClientDataSet11.Fields[1].DisplayLabel := ' 睿  和  料  号 ';
  ClientDataSet11.Fields[2].DisplayLabel := ' 品    名 ';
  ClientDataSet11.Fields[3].DisplayLabel := ' 领  料  数  量';
  ClientDataSet11.Fields[4].DisplayLabel := ' 库    别 ';
  ClientDataSet11.Fields[5].DisplayLabel := ' 发  料  单  号 ';
  //ClientDataSet11.Fields[6].DisplayLabel := ' 生  产  批  号 ';
  //ClientDataSet11.Fields[7].DisplayLabel := ' 货    架 ';

  if Sender is TfrxCrossView then
  begin
    Cross := TfrxCrossView(Sender);
    ClientDataSet11.First;
    i := 0;
    while not ClientDataSet11.Eof do
    begin
      for j := 0 to ClientDataSet11.FieldCount - 1 do
      begin
        TempField := ClientDataSet11.Fields[j].AsString;
        if i = 0 then
        begin 
          if j = 1 then
          begin
            iLen := Length(TempField);
            if iLen <= 12 then
            begin
              for k := iLen to 12 do
              begin
                TempField := TempField + ' ';
              end;
            end;
          end;
          if j = 2 then
          begin
            iLen := Length(TempField);
            if iLen <= 32 then
            begin
              for k := iLen to 32 do
              begin
                TempField := TempField + ' ';
              end;
            end;
          end;
        end;
        Cross.AddValue([i], [ClientDataSet11.Fields[j].DisplayLabel], [TempField]);
      end;
      ClientDataSet11.Next;
      Inc(i);
    end;
  end;

  Exit;

  if Sender is TfrxCrossView then
  begin
    Cross := TfrxCrossView(Sender);
    ClientDataSet11.First;
    i := 0;
    //Cross.AutoSize := False;
    while not ClientDataSet11.Eof do
    begin
      if i = 0 then
      begin
        for j := 0 to ClientDataSet11.FieldCount - 1 do
        begin
          case j of
            0: temp := ClientDataSet11.Fields[j].AsString;
            1: temp := tempNull + ClientDataSet11.Fields[j].AsString + tempNull;
            2: temp := tempNull + ClientDataSet11.Fields[j].AsString + tempNull;
            3: temp := ClientDataSet11.Fields[j].AsString;
            4: temp := ClientDataSet11.Fields[j].AsString;
            5: temp := tempNull + ClientDataSet11.Fields[j].AsString + tempNull;
            6: temp := tempNull + ClientDataSet11.Fields[j].AsString + tempNull;
            7: temp := ClientDataSet11.Fields[j].AsString;
          end;
          Cross.AddValue([i], [ClientDataSet11.Fields[j].DisplayLabel], [temp]);
        end;
      end
      else
      begin
        for j := 0 to ClientDataSet11.FieldCount - 1 do
        begin
          Cross.AddValue([i], [ClientDataSet11.Fields[j].DisplayLabel], [ClientDataSet11.Fields[j].AsString]);
        end;
      end;

      ClientDataSet11.Next;
      Inc(i);
    end;
  end;
end;

procedure TF_DownERPProe.DBGridEh2CellClick(Column: TColumnEh);
var
  temp, strSQL1: string;
begin
  if ClientDataSet3.Data = null then Exit;
  temp := ClientDataSet3.FieldByName('ML_NO').AsString;
  if temp = '' then Exit;
  if ClientDataSet3.FieldByName('state').AsString='E.已作废' then
  begin
    ClientDataSet4.Close;
    Exit;
  end;
  psBarcode1.BarCode := temp;
  strSQL1 := 'select *,MatlQuat-MatlQuatAlreadyOut Temp from LZm_ML_MO_FromERP where ML_NO=''' + temp + '''';
  SelectClientDataSet(ClientDataSet4, strSQL1);
end;

procedure TF_DownERPProe.Button3Click(Sender: TObject);
var
  strSQL1: string;
begin
  with ClientDataSet6 do //连接其他数据库
  begin
    RemoteServer.AppServer.LinkHISData('1');
  end;
  strSQL1 := 'select * from MF_ML where ML_DD>=''2013-07-01''';
  with ClientDataSet6 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strSQL1);
  end;

  with ClientDataSet8 do //连接其他数据库
  begin
    RemoteServer.AppServer.LinkHISData('1');
  end;
  strSQL1 := 'select * from MF_MO where MO_DD>=''2012-07-01''';
  with ClientDataSet8 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strSQL1);
  end;
end;

procedure TF_DownERPProe.DBGridEh6CellClick(Column: TColumnEh);
var
  strSQL1: string;
begin
  if ClientDataSet7.Data = null then Exit;
  with ClientDataSet7 do //连接其他数据库
  begin
    RemoteServer.AppServer.LinkHISData('1');
  end;
  strSQL1 := 'select * from TF_ML where ML_NO=''' + ClientDataSet6.fieldbyname('ML_NO').AsString + '''';
  with ClientDataSet7 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strSQL1);
  end;
end;

procedure TF_DownERPProe.DBGridEh7CellClick(Column: TColumnEh);
var
  strSQL1: string;
begin
  if ClientDataSet9.Data = null then Exit;
  with ClientDataSet9 do //连接其他数据库
  begin
    RemoteServer.AppServer.LinkHISData('1');
  end;
  strSQL1 := 'select * from TF_MO_FCP where MO_NO=''' + ClientDataSet6.fieldbyname('MO_NO').AsString + '''';
  with ClientDataSet9 do
  begin
    data := RemoteServer.AppServer.HISFUN_GetDataSql(strSQL1);
  end;
end;

procedure TF_DownERPProe.Button4Click(Sender: TObject);
var
  strML_NO, exsql,temp: string;
begin
  if ClientDataSet3.Data = null then Exit;
  strML_NO := ClientDataSet3.FieldByName('ML_NO').AsString;
  if strML_NO = '' then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据.');
    Exit;
  end;
  temp:=ClientDataSet3.FieldByName('state').AsString;
  if (temp<>'1.待打印') and (temp<>'2.待发料') then
  begin
    zsbSimpleMSNPopUpShow('单据状态不能完成.');
    Exit;
  end;
  if ZsbMsgBoxOkNoApp(Self, '确定作废【' + strML_NO + '】么？') = false then exit;
  exsql := 'update LZz_ML_MO_FromERP set State=''E.已作废'' where ML_NO=''' + strML_NO + ''';'; //1.作废
  exsql := exsql + 'delete from LZm_ML_MO_FromERP where ML_NO=''' + strML_NO + ''';'; //2.删除   
  exsql := exsql + 'delete from ZT_ML_NO_FromERP where ML_NO=''' + strML_NO + ''';'; //3.删除
  //exsql := exsql + 'update matlindepotmx set OccupyML_NO='''',OccupyQuat=0  where OccupyML_NO=''' + strML_NO + ''';'; //先删除
  exsql := ' begin ' + exsql + ' commit; end;';
  if EXSQLClientDataSet(ClientDataSet10, exsql) then
  begin
    zsbSimpleMSNPopUpShow(strML_NO + '作废成功！');
    SelectProeDocFromLZDB;
    strML_NO := strML_NO + '被作废';
    AddLog_Operation(strML_NO);
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '对不起，操作失败！');
  end;
end;

procedure TF_DownERPProe.CheckBox1Click(Sender: TObject);
begin
  SelectProeDocFromLZDB;
end;

procedure TF_DownERPProe.LabeledEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    SpeedButton999.Click;
  end;
end;

procedure TF_DownERPProe.ComboBox1Change(Sender: TObject);
begin
  SelectProeDocFromLZDB;
end;

procedure TF_DownERPProe.N2Click(Sender: TObject);
begin
  if ClientDataSet3.RecordCount = 0 then Exit;
  with ClientDataSet3 do
  begin
    First;
    while not eof do
    begin
      Edit;
      FieldByName('isselect').Value := 1;
      Next;
    end;
  end;
end;

procedure TF_DownERPProe.N4Click(Sender: TObject);
begin
  if ClientDataSet3.RecordCount = 0 then Exit;
  with ClientDataSet3 do
  begin
    First;
    while not eof do
    begin
      Edit;
      FieldByName('isselect').Value := 0;
      Next;
    end;
  end;
end;

procedure TF_DownERPProe.N6Click(Sender: TObject);
var
  strML_NO,temp,strsql:string;
begin
  if ClientDataSet3.Data = null then Exit;
  strML_NO := ClientDataSet3.FieldByName('ML_NO').AsString;
  if strML_NO = '' then
  begin
    zsbSimpleMSNPopUpShow('没有可操作的数据.');
    Exit;
  end;
  
  temp:=ClientDataSet3.FieldByName('state').AsString;
  if temp='E.已作废' then
  begin
    zsbSimpleMSNPopUpShow('单据状态不能完成.');
    Exit;
  end;

  temp:='确定重新下载【' + strML_NO + '】么？'+#13+#10;
  temp:=temp+'发料表头只能根据领退单号，更新[制单日期][制造部门][生产品番][生产数量][制单人][期别][领料时间][下载时间][操作员][]'+#13+#10;
  temp:=temp+'发料表身只能根据领退单号，料号 更新[数量][库位][制令单号]原先不存在的则会新增.';

  if ZsbMsgBoxOkNoApp(Self, temp) = false then exit;

  strsql := 'Exec ZP_Select_ZT_ML_NO_FromERP_Down_ByML_NO ';   
  strsql := strsql + '''' + strML_NO + '''';
  if EXSQLClientDataSet(ClientDataSet10, strsql) then
  begin             
    zsbSimpleMSNPopUpShow('is ok');
    SpeedButton999.Click;
  end
  else
  begin
    zsbSimpleMSNPopUpShow('is false');
  end;
end;

procedure TF_DownERPProe.PopupMenu1Popup(Sender: TObject);
begin
  if ClientDataSet3.FieldByName('ML_NO').AsString='' then Exit;
  N6.Caption:='重新下载 [ '+ClientDataSet3.FieldByName('ML_NO').AsString+' ]';
end;

procedure TF_DownERPProe.Image1DblClick(Sender: TObject);
begin
  ZsbShowMessageNoApp(Self, cReadMe);
end;

end.

