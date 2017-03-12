unit U_YuancailiaokucunSerach;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  ComCtrls, DBGridEhImpExp, Menus;

type
  TF_YuancailiaokucunSerach = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    Timer2: TTimer;
    Image1: TImage;
    TabSheet2: TRzTabSheet;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    TabSheet3: TRzTabSheet;
    RzPanel2: TRzPanel;
    SpeedButton1: TSpeedButton;
    LabeledEdit4: TLabeledEdit;
    RzPanel1: TRzPanel;
    SpeedButton999: TSpeedButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    CheckBox1: TCheckBox;
    DBGridEh1: TDBGridEh;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    DateTimePicker2: TDateTimePicker;
    CheckBox2: TCheckBox;
    DBGridEh2: TDBGridEh;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SaveDialog1: TSaveDialog;
    ClientDataSet3: TClientDataSet;
    DataSource3: TDataSource;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    CheckBox3: TCheckBox;
    SpeedButton4: TSpeedButton;
    ClientDataSet10: TClientDataSet;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    CheckBox4: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    procedure AddDepot;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  F_YuancailiaokucunSerach: TF_YuancailiaokucunSerach;

implementation

uses UDM, ZsbFunPro2, ZsbDLL2;

{$R *.dfm}

procedure TF_YuancailiaokucunSerach.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_YuancailiaokucunSerach.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_YuancailiaokucunSerach.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05
  Action := caFree;
end;

procedure TF_YuancailiaokucunSerach.AddDepot;
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

procedure TF_YuancailiaokucunSerach.FormCreate(Sender: TObject);
begin
  Self.Left := 50;
  Self.Top := 50;
end;

procedure TF_YuancailiaokucunSerach.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
end;

procedure TF_YuancailiaokucunSerach.Timer1Timer(Sender: TObject);
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
  //DateTimePicker1.Date := StrToDate(FormatDateTime('yyyy-MM-', Now) + '01');
  DateTimePicker1.Date := Now - 1;
  DateTimePicker2.Date := Now;

  RzPageControl1.Visible := True;
  RzPageControl1.ActivePageIndex := 0;
end;

procedure TF_YuancailiaokucunSerach.Timer2Timer(Sender: TObject);
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
    AddDepot;
    SpeedButton999.Click;
  finally

  end;
end;

procedure TF_YuancailiaokucunSerach.SpeedButton3Click(Sender: TObject);
begin
  try
    SaveDialog1.FileName := '原料库存查询' + FormatDateTime('yyyyMMddHHmmss', Now) + '.xls';
    SaveDialog1.filter := 'Execl(*.xls)|*.xls';
    if SaveDialog1.Execute then
    begin
      SaveDBGridEhToExportFile(TDBGridEhExportAsXls, DBGridEh1, SaveDialog1.FileName, true);
      zsbSimpleMSNPopUpShow('文件导出成功！' + SaveDialog1.FileName);
    end;
  except
    on e: Exception do
    begin
      zsbSimpleMSNPopUpShow_2('操作失败,请联系管理员.' + e.Message, clRed, 500);
    end;
  end;
end;

procedure TF_YuancailiaokucunSerach.SpeedButton2Click(Sender: TObject);
begin
  try
    SaveDialog1.FileName := '原料库存查询' + FormatDateTime('yyyyMMddHHmmss', Now) + '.xls';
    SaveDialog1.filter := 'Execl(*.xls)|*.xls';
    if SaveDialog1.Execute then
    begin
      SaveDBGridEhToExportFile(TDBGridEhExportAsXls, DBGridEh2, SaveDialog1.FileName, true);
      zsbSimpleMSNPopUpShow('文件导出成功！' + SaveDialog1.FileName);
    end;
  except
    on e: Exception do
    begin
      zsbSimpleMSNPopUpShow_2('操作失败,请联系管理员.' + e.Message, clRed, 500);
    end;
  end;
end;

procedure TF_YuancailiaokucunSerach.SpeedButton999Click(Sender: TObject);
var
  temp, temp1, temp2: string;
begin
  if CheckBox4.Checked then //查询其他仓库
  begin
    temp := 'select * from MatlInDepotMX_Other where DepotCode=''' + combobox2.Text + '''';
    if LabeledEdit1.Text <> '' then
    begin
      temp := temp + ' and MatlCode like ''%' + LabeledEdit1.Text + '%''';
    end;  
    if LabeledEdit6.Text <> '' then
    begin
      temp := temp + ' and AutoLot like ''%' + LabeledEdit6.Text + '%''';
    end;
    temp:=temp+' order by id';
  end
  else
  begin
    temp := 'select MatlInDepotMX.MatlCode,MatlInDepotMX.MatlLot,MatlInDepotMX.MatlVer,MatlInDepotMX.AutoLot,MatlInDepotMX.ShefCode,Sum(MatlInDepotMX.StockQuat) StockQuat' +
      ',Material.MatlName,Material.SuprCode from MatlInDepotMX,Material where MatlInDepotMX.MatlCode=Material.MatlCode';

    if LabeledEdit1.Text <> '' then
    begin
      temp := temp + ' and MatlInDepotMX.MatlCode like ''%' + LabeledEdit1.Text + '%''';
    end;
    if LabeledEdit2.Text <> '' then
    begin
      temp := temp + ' and MatlInDepotMX.MatlLot like ''%' + LabeledEdit2.Text + '%''';
    end;
    if LabeledEdit3.Text <> '' then
    begin
      temp := temp + ' and MatlInDepotMX.MatlCode in(select MatlCode from Material where SuprCode like ''%' + LabeledEdit3.Text + '%'')';
    end;
    if LabeledEdit5.Text <> '' then
    begin
      temp := temp + ' and MatlInDepotMX.ShefCode like ''%' + LabeledEdit5.Text + '%''';
    end;
    if LabeledEdit6.Text <> '' then
    begin
      temp := temp + ' and MatlInDepotMX.AutoLot like ''%' + LabeledEdit6.Text + '%''';
    end;
    if CheckBox1.Checked = False then
    begin
      temp := temp + ' and MatlInDepotMX.StockQuat>0';
    end;
    if CheckBox2.Checked then
    begin
      temp1 := FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date) + ' 00:00:00';
      temp2 := FormatDateTime('yyyy-MM-dd', DateTimePicker2.Date) + ' 23:59:59';
      temp := temp + ' and MIDDONO in(Select MIDDONO from MatlInDepotZ where OpeeDT>=''' + temp1 + ''' and OpeeDT<=''' + temp2 + ''')';
    end;
    temp := temp + ' group by MatlInDepotMX.MatlCode,MatlInDepotMX.MatlLot,MatlInDepotMX.MatlVer,MatlInDepotMX.AutoLot,MatlInDepotMX.ShefCode,Material.SuprCode,Material.MatlName';
  end;
  SelectClientDataSet(ClientDataSet1, temp);
  if ClientDataSet1.RecordCount > 0 then
  begin
    DBGridEh1.FooterRowCount := 1;
    DBGridEh1.FooterDisplayStyle := True;
  end
  else
  begin
    DBGridEh1.FooterRowCount := 0;
  end;
end;

procedure TF_YuancailiaokucunSerach.CheckBox3Click(Sender: TObject);
begin
  DBGridEh2.Columns[2].Visible := CheckBox3.Checked;
end;

procedure TF_YuancailiaokucunSerach.SpeedButton1Click(Sender: TObject);
var
  temp: string;
begin
  if CheckBox3.Checked then
  begin
    temp := 'select MatlInDepotMX.matlcode,sum(MatlInDepotMX.stockquat) StockQuat,MatlInDepotMX.ShefCode,Material.MatlName from MatlInDepotMX,Material where MatlInDepotMX.MatlCode=Material.MatlCode';
    if LabeledEdit4.Text <> '' then
    begin
      temp := temp + ' and MatlInDepotMX.MatlCode like ''%' + LabeledEdit4.Text + '%''';
    end;
    if LabeledEdit7.Text <> '' then
    begin
      temp := temp + ' and MatlInDepotMX.ShefCode like ''%' + LabeledEdit7.Text + '%''';
    end;
    temp := temp + ' group by MatlInDepotMX.MatlCode,Material.MatlName,MatlInDepotMX.ShefCode';
  end
  else
  begin
    temp := 'select MatlInDepotMX.matlcode,sum(MatlInDepotMX.stockquat) StockQuat,Material.MatlName from MatlInDepotMX,Material where MatlInDepotMX.MatlCode=Material.MatlCode';
    if LabeledEdit4.Text <> '' then
    begin
      temp := temp + ' and MatlInDepotMX.MatlCode like ''%' + LabeledEdit4.Text + '%''';
    end;
    if LabeledEdit7.Text <> '' then
    begin
      temp := temp + ' and MatlInDepotMX.ShefCode like ''%' + LabeledEdit7.Text + '%''';
    end;
    temp := temp + ' group by MatlInDepotMX.MatlCode,Material.MatlName';
  end;
  SelectClientDataSet(ClientDataSet2, temp);
  if ClientDataSet2.RecordCount > 0 then
  begin
    DBGridEh2.FooterRowCount := 1;
    DBGridEh2.FooterDisplayStyle := True;
  end
  else
  begin
    DBGridEh2.FooterRowCount := 0;
  end;
end;

procedure TF_YuancailiaokucunSerach.SpeedButton4Click(Sender: TObject);
var
  strsql, temp: string;
begin
  if Trim(LabeledEdit4.Text) = '' then
  begin
    zsbSimpleMSNPopUpShow('请输入料号');
    LabeledEdit4.SetFocus;
    Exit;
  end;
  strsql := 'Select  sum(matlquat) summatlquat from MatlInDepotMX where matlcode=''' + LabeledEdit4.Text +
    ''' and middono in (select middono from MatlInDepotZ  where state=''Y'')';
  temp := SelectClientDataSetResultFieldCaption(ClientDataSet10, strsql, 'summatlquat');
  if temp = '' then
  begin
    zsbSimpleMSNPopUpShow('没有记录.');
    Exit;
  end
  else
  begin
    temp := LabeledEdit4.Text + '入库总数：' + temp;
    ZsbMsgBoxInfoNoApp(Self, temp);
  end;
end;

procedure TF_YuancailiaokucunSerach.N2Click(Sender: TObject);
var
  SHOW, strsql: string;
begin
  if ClientDataSet1.FieldByName('AutoLot').AsString = '' then Exit;
  N2.Caption := '查询该流水号[ ' + ClientDataSet1.FieldByName('AutoLot').AsString + ' ]的详细入库信息&';
  strsql := 'select MIDDONO,sysdt,MatlQuat from MatlInDepotMX where autolot=''' + ClientDataSet1.FieldByName('AutoLot').AsString + '''';
  SelectClientDataSetNoTips(ClientDataSet10, strsql);
  SHOW := '流水号:' + ClientDataSet1.FieldByName('AutoLot').AsString + #13 + #10 + #13 + #10;
  SHOW := SHOW + '入库单号:' + ClientDataSet10.FieldByName('MIDDONO').AsString + #13 + #10;
  SHOW := SHOW + '入库时间:' + ClientDataSet10.FieldByName('sysdt').AsString + #13 + #10;
  SHOW := SHOW + '入库数量:' + ClientDataSet10.FieldByName('MatlQuat').AsString + #13 + #10;
  ZsbShowMessageNoApp(Self, SHOW);
end;

procedure TF_YuancailiaokucunSerach.ComboBox1Change(Sender: TObject);
begin
  ComboBox2.ItemIndex := ComboBox1.ItemIndex;
end;

procedure TF_YuancailiaokucunSerach.ComboBox2Change(Sender: TObject);
begin
  ComboBox1.ItemIndex := ComboBox2.ItemIndex;
end;

procedure TF_YuancailiaokucunSerach.CheckBox4Click(Sender: TObject);
begin
  ComboBox1.Enabled := CheckBox4.Checked;
  ComboBox2.Enabled := CheckBox4.Checked;
end;

end.

