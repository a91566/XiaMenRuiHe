unit U_xiugaimima;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls;

type
  TF_xiugaimima = class(TForm)
    Panel3: TPanel;
    SpeedButton4: TSpeedButton;
    SpeedButton3: TSpeedButton;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    Timer1: TTimer;
    CheckBox1: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_xiugaimima: TF_xiugaimima;

implementation

uses ZsbVariable, ZsbDLL, ZsbFunPro, U_main, UDM;

{$R *.dfm}

procedure TF_xiugaimima.FormShow(Sender: TObject);
begin
  AnimateWindow(Self.Handle, 250, AW_VER_POSITIVE); //向下
  LabeledEdit1.Text:=ZStrUserCode;
end;

procedure TF_xiugaimima.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 250, AW_VER_NEGATIVE + AW_HIDE); //向上
end;

procedure TF_xiugaimima.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:=False;
  Panel3.Visible:=True; 
end;

procedure TF_xiugaimima.SpeedButton4Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_xiugaimima.SpeedButton3Click(Sender: TObject);
var
  exsql,tempmm_md5:string;
begin
  if LabeledEdit2.Text='' then
  begin
    ShowInfoTips(LabeledEdit2.Handle, '请在这里输入原密码噢.', 3);
    LabeledEdit2.SetFocus;
    Exit;
  end;  
  if LabeledEdit3.Text='' then
  begin
    ShowInfoTips(LabeledEdit3.Handle, '请在这里输入新密码噢.', 3);
    LabeledEdit3.SetFocus;
    Exit;
  end;
  if LabeledEdit4.Text='' then
  begin
    ShowInfoTips(LabeledEdit4.Handle, '请在这里输入确认新密码噢.', 3);
    LabeledEdit4.SetFocus;
    Exit;
  end;
  if LabeledEdit3.Text<>LabeledEdit4.Text then
  begin
    ShowInfoTips(LabeledEdit4.Handle, '两次密码输入不一致噢.', 3);
    LabeledEdit4.SetFocus;
    Exit;
  end;
  tempmm_md5:=Get16MD5ForString(LabeledEdit3.Text);
  if ZsbMsgBoxOkNoApp(F_main,'确认修改密码么?') then
  begin
    exsql:='update staff set UserPWD=''' + tempmm_md5+ ''' where usercode=''' + ZStrUserCode + ''' and stafcode=''' + ZStrStafCode + '''';
    if EXSQLClientDataSet(FDM.ClientDataSet1, exsql) then
    begin
      zsbSimpleMSNPopUpShow('密码修改成功！');
      LabeledEdit2.Text:='';    
      LabeledEdit3.Text:='';
      LabeledEdit4.Text:='';
    end
    else
    begin
      ZsbMsgErrorInfoNoApp(F_main, '对不起，操作失败！');
    end;
  end;
end;

procedure TF_xiugaimima.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin   
    LabeledEdit2.PasswordChar:=#0;
    LabeledEdit3.PasswordChar:=#0;
    LabeledEdit4.PasswordChar:=#0;
  end
  else
  begin 
    LabeledEdit2.PasswordChar:='*';
    LabeledEdit3.PasswordChar:='*';
    LabeledEdit4.PasswordChar:='*';
  end;
end;

end.
