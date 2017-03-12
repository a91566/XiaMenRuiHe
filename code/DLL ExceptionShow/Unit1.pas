unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, XPMan;

type
  TForm1 = class(TForm)
    SpeedButton1: TSpeedButton;
    LabeledEdit1: TLabeledEdit;
    XPManifest1: TXPManifest;
    Button1: TButton;
    CheckBox1: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public    
    procedure ErrorShow(Sender: TObject; E: Exception);
    procedure ErrorShow1(Sender: TObject; E: Exception);
    procedure ErrorShow2(Sender: TObject; E: Exception);
    { Public declarations }
  end;

var
  Form1: TForm1;
procedure ExceptionShowM(var app: TApplication; Sender: TObject; E: Exception); stdcall; external 'ExceptionShow.dll';
procedure ExceptionShowStr(var app: TApplication; ParentForm: TForm; Sender: TObject; eMessage, eClassName: string); stdcall; external 'ExceptionShow.dll';
procedure ExceptionShowStrNoApp(eMessage: string; bBlack: Boolean = False); stdcall; external 'ExceptionShow.dll';

implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.ErrorShow(Sender: TObject; E: Exception);
begin
  ExceptionShowStr(Application, Self, Sender, e.Message, e.ClassName);
end;

procedure TForm1.ErrorShow1(Sender: TObject; E: Exception);
var
  temp: string;
begin
  temp := #13 + #10 + 'Ӧ�ó���' + Application.Title + #13 + #10 + #13 + #10;
  temp := temp + '����ʱ�䣺' + FormatDateTime('yyyy��MM��dd�� HH:mm:ss', Now) + #13 + #10 + #13 + #10;
  temp := temp + '������Ϣ��' + e.Message + #13 + #10 + #13 + #10;
  temp := temp + '�������ͣ�' + e.ClassName + #13 + #10 + #13 + #10;
  temp := temp + '�������' + Sender.ClassName + #13 + #10 + #13 + #10;
  //temp:=temp'Ӧ�ó���'+Title+#13+#10;
  //Application.MessageBox(PChar(temp),'ϵͳ�쳣',MB_ICONERROR);
  if Application.FindComponent('Form2') = nil then
  begin
    Application.CreateForm(TForm2, Form2);
  end;
  Form2.Memo1.Lines.Add(temp);
  Form2.ShowModal;
end;

procedure TForm1.ErrorShow2(Sender: TObject; E: Exception);
var
  temp: string;
begin
  temp := #13 + #10 + 'Ӧ�ó���' + Application.Title + #13 + #10 + #13 + #10;
  temp := temp + '����ʱ�䣺' + FormatDateTime('yyyy��MM��dd�� HH:mm:ss', Now) + #13 + #10 + #13 + #10;
  temp := temp + '������Ϣ��' + e.Message + #13 + #10 + #13 + #10;
  temp := temp + '�������ͣ�' + e.ClassName + #13 + #10 + #13 + #10;
  temp := temp + '�������' + Sender.ClassName + #13 + #10 + #13 + #10;
  temp := temp + '����ʱ�䣺' + FormatDateTime('yyyy��MM��dd�� HH:mm:ss', Now) + #13 + #10 + #13 + #10;
  temp := temp + '����ϵ����Ա ���� ����������.' + #13 + #10 + #13 + #10;
  ExceptionShowStrNoApp(temp,CheckBox1.Checked);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Application.OnException := ErrorShow2;
  //Application.OnException:=ErrorShow1;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  i: SmallInt;
begin
  i := StrToInt(LabeledEdit1.Text);
end;

end.

