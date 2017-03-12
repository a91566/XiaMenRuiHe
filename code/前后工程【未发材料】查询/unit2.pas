unit unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  ComCtrls, DBGridEhImpExp, Menus, frxClass, psBarcode, frxCross, frxDBSet;

type
  TForm2 = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    Timer2: TTimer;
    Image1: TImage;
    TabSheet2: TRzTabSheet;
    RzPanel1: TRzPanel;
    ClientDataSet10: TClientDataSet;
    Button1: TButton;
    ClientDataSet11: TClientDataSet;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    DBGridEh1: TDBGridEh;
    CheckBox1: TCheckBox;
    DateTimePicker1: TDateTimePicker;
    Label3: TLabel;
    DateTimePicker2: TDateTimePicker;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses UDM, ZsbFunPro2, ZsbDLL2, DateUtils, ZsbVariable2;

{$R *.dfm}

procedure TForm2.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TForm2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Self.Left := 50;
  Self.Top := 50;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
end;



procedure TForm2.Timer1Timer(Sender: TObject);
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
  RzPageControl1.Visible := True;
  RzPageControl1.ActivePageIndex := 0;    
  DateTimePicker1.Date := Now - 7;
  DateTimePicker2.Date := Now;
end;

procedure TForm2.Timer2Timer(Sender: TObject);
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
  finally

  end;

end;

procedure TForm2.Button1Click(Sender: TObject);
var
  strsql: string;
begin  
  strsql := 'select matlcode,Qcno,scll,MatlQuatAlreadyOut,scll - MatlQuatAlreadyOut sysl'+
  ' from QGCFLHZMx where MatlQuatAlreadyOut<SCLL and QCNo in (select QCNo from QGCFLHZ where state=''3.发料中'')';

  if CheckBox1.Checked then
  begin
    strSQL := strSQL + ' and QCNo in (select QCNo from QGCFLHZ where StartDT>='''+FormatDateTime('yyyy-MM-dd', DateTimePicker1.Date)+
    ''' and StartDT<='''+FormatDateTime('yyyy-MM-dd', DateTimePicker2.Date)+''')';
  end;

  if LabeledEdit2.Text <> '' then
  begin
    strSQL := strSQL + ' and MatlCode like  ''' + LabeledEdit2.Text + '%''';
  end;

  strsql := strsql + ' order by Qcno desc';
  SelectClientDataSet(ClientDataSet1, strsql);
  if ClientDataSet1.RecordCount>0 then
  begin
    DBGridEh1.SumList.Active:=True;
    DBGridEh1.FooterDisplayStyle:=True;
    DBGridEh1.FooterRowCount:=1;
  end
  else
  begin   
    DBGridEh1.SumList.Active:=False;
    DBGridEh1.FooterRowCount:=0;
  end;
end;

end.

