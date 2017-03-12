unit U_ScrapReason;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, RzPanel, DB, DBClient;

type
  TF_ScrapReason = class(TForm)
    RzPanel4: TRzPanel;
    Label2: TLabel;
    RzPanel1: TRzPanel;
    ComboBox1: TComboBox;
    Label3: TLabel;
    RzPanel2: TRzPanel;
    Memo1: TMemo;
    RzPanel3: TRzPanel;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    ClientDataSet1: TClientDataSet;
    RzPanel5: TRzPanel;
    Label4: TLabel;
    procedure ComboBox1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private        
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SaveOrLoadReason(iType: SmallInt);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_ScrapReason: TF_ScrapReason;

implementation

uses U_ChengpinkucunSerach, ZsbDLL2, ZsbFunPro2, ZsbVariable2, UDM;

{$R *.dfm}

procedure TF_ScrapReason.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_ScrapReason.SaveOrLoadReason(iType: SmallInt);
var //保留查询条件
  temp: string;
begin 
  if iType = 0 then //save
  begin
    temp:='insert into ScrapReason(Text,czy,dt)values('''+Memo1.Lines.Text+''','''+ZStrUser+
    ''','''+FormatDateTime('yyyy-MM-dd HH:mm:ss',Now)+''')';

    if EXSQLClientDataSet(ClientDataSet1,temp)=False then
    begin  
      zsbSimpleMSNPopUpShow_2('报废原因保存失败.',clRed,500);
    end
    else
    begin
      zsbSimpleMSNPopUpShow('保存成功.');
      SaveOrLoadReason(1);
    end;
  end
  else if iType = 1 then
  begin          
    ComboBox1.Items.Clear;
    SelectClientDataSet(ClientDataSet1,'select Text from ScrapReason order by Text');
    with ClientDataSet1 do
    begin
      First;
      while not Eof do
      begin
        ComboBox1.Items.Add(FieldByName('Text').AsString);
        Next;
      end;
    end;
    ComboBox1.Items.Add('自定义');
    Memo1.Clear;
  end;
end;

procedure TF_ScrapReason.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.ItemIndex=ComboBox1.Items.Count-1 then
  begin
    RzPanel2.Visible:=True;
    Self.Height:=480;
  end
  else
  begin
    RzPanel2.Visible:=False;
    Self.Height:=311;
  end;
end;

procedure TF_ScrapReason.Button2Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_ScrapReason.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TF_ScrapReason.Button1Click(Sender: TObject);
begin
  if ComboBox1.ItemIndex=ComboBox1.Items.Count-1 then
  begin
    if Memo1.Lines.Text='' then Exit;
    F_ChengpinkucunSerach.PuScrapReason:=Memo1.Lines.Text;
  end
  else
  begin  
    F_ChengpinkucunSerach.PuScrapReason:=ComboBox1.Text;
  end;
  Self.Close;
end;

procedure TF_ScrapReason.FormShow(Sender: TObject);
begin
  SaveOrLoadReason(1);
end;

procedure TF_ScrapReason.FormCreate(Sender: TObject);
begin
  RzPanel2.Visible:=False;
  Self.Height:=311;
end;

procedure TF_ScrapReason.Label4Click(Sender: TObject);
begin
  if Memo1.Lines.Text='' then
  begin
    zsbSimpleMSNPopUpShow('没有数据.');
  end
  else
  begin
    SaveOrLoadReason(0);
  end;
end;

procedure TF_ScrapReason.Memo1Change(Sender: TObject);
begin
  if ComboBox1.Items.IndexOf(Memo1.Lines.Text)>=0 then
  begin
    zsbSimpleMSNPopUpShow_2(Memo1.Lines.Text+',已存在.',clRed,300);
    Memo1.Clear;
    Exit;
  end;
end;

end.

