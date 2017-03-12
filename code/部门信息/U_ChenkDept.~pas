unit U_ChenkDept;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, dxTL, dxDBCtrl, dxCntner, dxDBTL, ExtCtrls, DB,
  DBClient, StdCtrls, RzTabs, Grids, DBGridEh;

type
  TF_ChenkDept = class(TForm)
    Panel2: TPanel;
    Image1: TImage;
    Panel1: TPanel;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    Timer1: TTimer;
    Panel3: TPanel;
    Image2: TImage;
    Button1: TButton;
    Button2: TButton;
    RzPageControl1: TRzPageControl;
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    dxDBTreeList1: TdxDBTreeList;
    dxDBTreeList1Column7: TdxDBTreeListColumn;
    dxDBTreeList1Column4: TdxDBTreeListColumn;
    DBGridEh1: TDBGridEh;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    dxDBTreeList1Column3: TdxDBTreeListColumn;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure dxDBTreeList1DblClick(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
  private  
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public
    strPuResult:string;
    { Public declarations }
  end;

var
  F_ChenkDept: TF_ChenkDept;

implementation

uses ZsbFunPro2;

{$R *.dfm}

procedure TF_ChenkDept.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_ChenkDept.Timer1Timer(Sender: TObject);
var
  h: THandle;
  bit,bit2: TBitmap;
begin
  Timer1.Enabled := False;
  if FileExists(ExtractFilePath(Application.Exename) + 'BitBtnImageFormZsbDll2.dll') then
  begin
    h := LoadLibrary('BitBtnImageFormZsbDll2.dll'); //载入 DLL
    bit := TBitmap.Create;  
    bit2 := TBitmap.Create;
    bit.LoadFromResourceName(h, 'imgLZLeft'); //提取资源
    bit2.LoadFromResourceName(h, 'imgSkyBlue'); //提取资源
    Image1.Picture.Assign(bit); 
    Image2.Picture.Assign(bit2);
    FreeLibrary(h); //载卸 DLL
    bit.Free;  
    bit2.Free;
  end;
  Panel2.Visible:=True;
  SelectClientDataSet(ClientDataSet1,'select * from department where state=''Y''');  
  SelectClientDataSet(ClientDataSet2,'select * from Depot where state=''Y''');
  dxDBTreeList1.FullExpand;
  RzPageControl1.ActivePageIndex:=0;
end;

procedure TF_ChenkDept.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //窗口由小变大
end;

procedure TF_ChenkDept.Button2Click(Sender: TObject);
begin
  strPuResult:='';
  Self.Close;
end;

procedure TF_ChenkDept.Button1Click(Sender: TObject);
begin
  if RzPageControl1.ActivePageIndex=0 then
  begin
    strPuResult:=ClientDataSet1.fieldbyname('DeptCode').AsString;
    strPuResult:=strPuResult+'/'+ClientDataSet1.fieldbyname('DeptName').AsString;
  end
  else
  begin  
    strPuResult:=ClientDataSet2.fieldbyname('DepotCode').AsString; 
    strPuResult:=strPuResult+'/'+ClientDataSet2.fieldbyname('DepotName').AsString;
  end;
  if strPuResult='/' then
  begin
    zsbSimpleMSNPopUpShow('没有选择科室.');
    Exit;
  end;
  Self.Close;
end;

procedure TF_ChenkDept.dxDBTreeList1DblClick(Sender: TObject);
begin
  Button1.Click;
end;

procedure TF_ChenkDept.DBGridEh1DblClick(Sender: TObject);
begin
  Button1.Click;
end;

end.
