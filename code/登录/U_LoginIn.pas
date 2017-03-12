{

ShockwaveFlash1�ؼ��и����õĵط���
labelû�취������һ�㣬ֻ�����ڵײ㣬
����radiobutton֮��Ŀؼ���͸��Ч���ֲ���
 2013��3��17�� 10:05:34
}
unit U_LoginIn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, ShockwaveFlashObjects_TLB, Math, StdCtrls, Buttons,
  ExtCtrls, XPMan, RzLabel, RzPanel, jpeg, RzButton, RzRadChk, Menus,
  frxpngimage, RzLine;

type
  TF_LoginIn = class(TForm)
    Timer1: TTimer;
    XPManifest1: TXPManifest;
    RzPanel1: TRzPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Panel2: TPanel;
    Image2: TImage;
    Panel1: TPanel;
    Image3: TImage;
    Image1: TImage;
    Timer2: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
   // hr: THandle;
    FFlash: TShockwaveFlash; //��Ҫ��̬����.
    FFlashMes: TWndMethod; //����Flash�ؼ�ԭ����WindowProc�¼����
    Edit98, Edit99: TEdit;

    { Private declarations }
    procedure FlashMes(var Message: TMessage);
    procedure EUsernameEnter(Sender: TObject);
    procedure EUsernameExit(Sender: TObject);
    procedure EUsernameKeyPress(Sender: TObject; var Key: Char);
    procedure EUserpwdExit(Sender: TObject);
    procedure EUserpwdEnter(Sender: TObject);
    procedure EUserpwdKeyPress(Sender: TObject; var Key: Char);

  //  procedure PlayFlash;
  //  procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
  //  procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPAINT;
  //  procedure DrawFormLine;
  //  procedure CreateHr;

  protected
   // procedure Resize; override;

  public
    procedure SoftReg(b: Boolean);
    function CheckLoginIn: Boolean;
    procedure ExecuteOnTerminate(Sender: TObject); //�߳�ִ�������¼�
    { Public declarations }
  end;

var
  F_LoginIn: TF_LoginIn;

function CheckZCM: Boolean; stdcall; external 'RegisterForMac.dll';
function VerityMMForFile(var App: TApplication; ParentForm: TForm): Boolean; stdcall; external 'RegisterForMac.dll';

implementation

uses UDM, ZsbFunPro2, ZsbDLL2, ZsbVariable2, U_TSCLinkDBThread;

{$R *.dfm} ////showmessage
{
procedure TF_LoginIn.PlayFlash; //��Դ�ļ���ʹ�ú���ܸ��ӡ�
var
  Res: TResourceStream;
  temp: string;
begin
  temp := 'temp.swf';
  Res := TResourceStream.Create(0, 'swfLogo1', 'swf');
  Res.SaveToFile(temp);
  FFlash.Movie := temp;
  Res.Free;
end;  }


procedure TF_LoginIn.FlashMes(var Message: TMessage);
begin
  if (Message.Msg = WM_RBUTTONDOWN) then //������Ҽ�����:Flash�ؼ���������갴�µ���Ϣ�ﵯ���˵���.
  begin
    FFlash.Perform(WM_RBUTTONUP, Message.WParam, Message.LParam); //ֱ�Ӵ��ݸ�Flash�ؼ���굯�����Ϣ.
    Exit;
//���˳�������,��������ԭ�����¼����,��������Flash�ؼ�������갴�µ���Ϣ,
//�����Ͳ��ᵯ���˵���.
  end;
//�ر��Ҽ���Ϣ�������ݸ�Flash�ؼ����������Ͳ��ᵯ���Ҽ��˵���
  FFlashMes(Message);
//��ԭ����¼����������������Ϣ.
end;


procedure TF_LoginIn.FormShow(Sender: TObject);
//var
  //hr: THandle;
begin
  AnimateWindow(Self.Handle, 250, AW_VER_POSITIVE); //����
  //hr := CreateRoundRectRgn(0, 0, width, height, 10, 10);
  //SetWindowRgn(Self.Handle, hr, true);  //Բ��
end;

procedure TF_LoginIn.ExecuteOnTerminate(Sender: TObject);
begin
  if FDM.SC.Connected=True then
  begin  
    SaveMessage(Edit98.Text, 'zsb', 'LoginHistory');
    if CheckLoginIn then
    begin    
      PCharPuOpercode := Edit98.Text;
      AnimateWindow(Self.Handle, 200, AW_VER_NEGATIVE + AW_HIDE); //����
      Self.Close;
    end;
  end
  else
  begin
    SpeedButton1.Caption:='��¼';
    ZsbMsgErrorInfoNoApp(Self, '�����������ʧ��,����ϵ����Ա.');
  end;
end;

procedure TF_LoginIn.FormCreate(Sender: TObject);
var
  temp, usercode: string;
  TSList: TStringList;
  i:SmallInt;
begin
  i:=Screen.Width-Self.Width;
  Self.Left:=i div 2;  
  i:=Screen.Height-Self.Height;
  i:=i div 2;
  Self.Top:=i-50;
  temp := ExtractFilePath(Application.ExeName) + 'back.swf';
  if FileExists(temp) then
  begin
    //ShockwaveFlash1.LoadMovie(0,temp);
    FFlash := TShockwaveFlash.Create(Self); //����Flash�ؼ���ʵ��.
    FFlash.Parent := Panel1; //�ڱ����ڲ���.
    FFlashMes := FFlash.WindowProc;
    FFlash.WindowProc := FlashMes; // WindowProc;
    FFlash.Align := alClient; //����������Ϊ��������.
    FFlash.Movie := temp; //���ŵ��ļ�.
    FFlash.Menu := False; //����ʾ�˵�.
    //PlayFlash;
    Image3.Visible := False;
  end
  else
  begin
    Image3.Visible := True;
  end;

  temp := ExtractFilePath(Application.ExeName) + 'LoginHistory.zsb';
  if FileExists(temp) then
  begin
    TSList := TStringList.Create;
    TSList := LoadOwnFile(temp);
    usercode := TSList[0];
    TSList.Free;
  end
  else
  begin
    usercode:='';
  end;

  Edit98 := TEdit.Create(self);
  Edit98.Parent := Panel1;
  Edit98.Name := 'Edit1';
  Edit98.Left := 2;
  Edit98.Top := 210;
  Edit98.Width := 150;
  Edit98.Text := '�������ʺ�';
  Edit98.Font.Color := clGray;
  Edit98.OnEnter := EUsernameEnter;
  Edit98.OnExit := EUsernameExit;
  Edit98.OnKeyPress := EUsernameKeyPress;

  edit99 := TEdit.Create(self);
  edit99.Parent := Panel1;
  edit99.Name := 'Edit2';
  edit99.Left := 211;
  edit99.Top := 210;
  edit99.Width := 150;
  Edit99.Text := '����������';
  Edit99.Font.Color := clGray;
  Edit99.OnEnter := EUserpwdEnter;
  Edit99.OnExit := EUserpwdExit;
  Edit99.OnKeyPress := EUserpwdKeyPress;
  SetWindowLong(edit99.Handle, GWL_STYLE, GetWindowLong(edit99.Handle, GWL_STYLE) or Es_right);
  //ʹ֮�Ҷ���

  Edit98.Visible := False;
  Edit99.Visible := False;
  if usercode<>'' then
  begin    
    Edit98.Text := usercode;
    Edit98.Font.Color := clBlack;
  end;  

  //Edit99.Text := 'admin9901';
end;

procedure TF_LoginIn.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (ssleft in Shift) then
  begin
    ReleaseCapture;
    Perform(WM_syscommand, $F012, 0);
  end;
end;

procedure TF_LoginIn.Timer1Timer(Sender: TObject);
begin
  timer1.Enabled := False;
  Edit98.Visible := True;
  Edit99.Visible := True;
  SoftReg(False);
end;

procedure TF_LoginIn.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  AnimateWindow(Self.Handle, 250, AW_VER_NEGATIVE + AW_HIDE); //����
end;

procedure TF_LoginIn.SpeedButton2Click(Sender: TObject);
begin
  PCharPuOpercode := '';
  Self.Close;
end;


procedure TF_LoginIn.EUsernameEnter(Sender: TObject);
begin
  TEdit(Sender).Font.Color := clBlack;
  if TEdit(Sender).Text = '�������ʺ�' then
  begin
    TEdit(Sender).Text := '';
  end;
end;


procedure TF_LoginIn.EUserpwdEnter(Sender: TObject);
begin
  TEdit(Sender).Font.Color := clBlack;
  TEdit(Sender).PasswordChar := '*';
  if TEdit(Sender).Text = '����������' then
  begin
    TEdit(Sender).Text := '';
  end;
end;

procedure TF_LoginIn.EUsernameExit(Sender: TObject);
begin
  if TEdit(Sender).Text = '' then
  begin
    TEdit(Sender).Text := '�������ʺ�';
    TEdit(Sender).Font.Color := clGray;
  end;
end;

procedure TF_LoginIn.EUserpwdExit(Sender: TObject);
begin
  if TEdit(Sender).Text = '' then
  begin
    TEdit(Sender).Text := '����������';
    TEdit(Sender).Font.Color := clGray;
    TEdit(Sender).PasswordChar := #0;
  end;
end;

procedure TF_LoginIn.EUsernameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then Edit99.SetFocus;
end;

procedure TF_LoginIn.EUserpwdKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then SpeedButton1.Click;
end;

function TF_LoginIn.CheckLoginIn: Boolean;
var
  strsql, strPWD: string;
  bootemp: Boolean;
  itemp, ix, iy: SmallInt;
begin
  bootemp := True;
  itemp := Self.Width div 2;
  itemp := itemp + Self.Left;
  ix := Screen.Width - itemp - 150;
  iy := Screen.Height - Self.Top - 83;

  if Edit98.Text = 'admin' then
  begin
    if Edit99.Text <> 'admin9901' then
    begin
      SimpleMSNPopUpShow('��������Ա�������.', ix, iy);
      Edit99.Text := '';
      Edit99.SetFocus;
      bootemp := False;
      SpeedButton1.Caption := '��¼';
      Exit;
    end;
  end
  else if Edit98.Text = 'IT' then
  begin
    if Edit99.Text <> 'admin5509' then
    begin
      SimpleMSNPopUpShow('��������Ա�������.', ix, iy);
      Edit99.Text := '';
      Edit99.SetFocus;
      bootemp := False;
      SpeedButton1.Caption := '��¼';
      Exit;
    end
    else
    begin
      Edit98.Text := 'admin';
    end;
  end
  else
  begin  
    strsql := 'select UserPwd,UserState,StafState from staff where usercode=''' + Edit98.Text + '''';
    SelectClientDataSetNoTips(FDM.ClientDataSet1, strsql);
    if FDM.ClientDataSet1.RecordCount = 0 then
    begin
      SimpleMSNPopUpShow('�û�������.', ix, iy);
      Edit99.Text := '';
      Edit98.Text := '';
      Edit98.SetFocus;
      bootemp := False;
    end;
    strPWD := Get16MD5ForString(Edit99.Text);
    if strPWD <> FDM.ClientDataSet1.FieldByName('UserPwd').AsString then
    begin
      SimpleMSNPopUpShow('�������.', ix, iy);
      Edit99.Text := '';
      Edit99.SetFocus;
      bootemp := False;
    end;
    if FDM.ClientDataSet1.FieldByName('StafState').AsString <> '��ְ' then
    begin
      SimpleMSNPopUpShow('���û�����ְ.', ix, iy);
      Edit99.Text := '';
      Edit98.Text := '';
      Edit98.SetFocus;
      bootemp := False;
    end;
    if FDM.ClientDataSet1.FieldByName('UserState').AsString <> 'Y' then
    begin
      SimpleMSNPopUpShow('���ʺ�û������.', ix, iy);
      Edit99.Text := '';
      Edit98.Text := '';
      Edit98.SetFocus;
      bootemp := False;
    end;
  end;
  if bootemp = False then
  begin
    SpeedButton1.Caption := '��¼';
  end;
  Result := bootemp;
end;

procedure TF_LoginIn.SpeedButton1Click(Sender: TObject);
var
  itemp, ix, iy: SmallInt;
begin
  itemp := Self.Width + 300;
  itemp := itemp div 2;
  itemp := itemp + Self.Left;
  itemp := Screen.Width - itemp;
  ix := itemp;
  iy := Screen.Height - Self.Top - 100; //�Ϸ�
  if SpeedButton1.Caption = '��¼' then
  begin
    if (Edit98.Text = '') or (Edit98.Text = '�������ʺ�') then
    begin
      ShowInfoTips(Edit98.Handle, '�������������ʺ���.', 3);
      Edit98.SetFocus;
      Exit;
    end;
    if (Edit99.Text = '') or (Edit99.Text = '����������') then
    begin
      ShowInfoTips(Edit99.Handle, '������������������.', 3);
      Edit99.SetFocus;
      Exit;
    end;
    Speedbutton1.Caption := '������...';
    WaitTime(100);
    FDM := TFDM.Create(nil);
    TSCLinkDBThread.Create(False); //�����߳�����
  end
  else if SpeedButton1.Caption = 'ע��' then
  begin
    if VerityMMForFile(Application, Self) then
    begin
      SimpleMSNPopUpShow('ע��ɹ�!', ix, iy);
      SoftReg(True);
    end
    else
    begin
      SimpleMSNPopUpShow('ע��ʧ��!', ix, iy);
    end;
  end;
end;

procedure TF_LoginIn.SpeedButton3Click(Sender: TObject);
type
  Func = procedure; stdcall;
var
  Th: Thandle;
  Tf: Func;
  Tp: TFarProc;
begin
  Th := LoadLibrary('SetServer.dll'); {װ��DLL}
  if Th > 0 then ///����0ΪDLLװ�سɹ�
  try
    Tp := GetProcAddress(Th, PChar('ProSetServer')); ///ȡ��DLL��TestC�������ڴ��еĵ�ַ
    if Tp <> nil then
    begin
      Tf := Func(Tp);
      Tf;
    end;
  finally
   // FreeLibrary(Th); {�ͷ�DLL}
  end
  else
  begin
    Application.MessageBox('SetServer.dllû���ҵ�', '������Ϣ', MB_ICONERROR);
  end;
end;

//ע��

procedure TF_LoginIn.SoftReg(b: Boolean); //ע��
var
  boo: Boolean; //�������Ϊtrue����Ҫ���
begin
  boo := b;
  if not boo then
  begin
    boo := CheckZCM;
  end;
  if not boo then //ע����
  begin
    SpeedButton1.Caption := 'ע��';
  end
  else
  begin
    SpeedButton1.Caption := '��¼';
  end;
end;


{���Ʊ߿�}
{
procedure TF_LoginIn.CreateHr;
begin
  hr := CreateRoundRectRgn(0, 0, Width, Height, 10, 10);
  SetWindowRgn(handle, hr, true);
end;

procedure TF_LoginIn.DrawFormLine;
var
  dc: hDc;
  Pen: hPen;
  OldPen: hPen;
  OldBrush: hBrush;
begin
  dc := GetWindowDC(Handle);
  Self.Refresh;
  Pen := CreatePen(PS_SOLID, 1, RGB(0, 0, 200));
  OldPen := SelectObject(dc, Pen);
  OldBrush := SelectObject(dc, GetStockObject(NULL_BRUSH));
  RoundRect(dc, 0, 0, Width - 1, Height - 1, 10, 10);
  SelectObject(dc, OldBrush);
  SelectObject(dc, OldPen);
  DeleteObject(Pen);
  Pen := CreatePen(PS_SOLID, 1, RGB(137, 245, 255));
  OldPen := SelectObject(dc, Pen);
  OldBrush := SelectObject(dc, GetStockObject(NULL_BRUSH));
  RoundRect(dc, 1, 1, Width - 2, Height - 2, 10, 10);
  SelectObject(dc, OldBrush);
  SelectObject(dc, OldPen);
  DeleteObject(Pen);
  ReleaseDC(Handle, Canvas.Handle);
end;

procedure TF_LoginIn.WMNCHitTest(var Msg: TWMNCHitTest);
var
  tmpPoint: TPoint;
const
  C_BORDERWIDTH = 4;
begin
  tmpPoint.X := Msg.Pos.x;
  tmpPoint.Y := Msg.Pos.y;
  tmpPoint := ScreenToClient(tmpPoint);
  if (tmpPoint.x <= C_BORDERWIDTH) and (tmpPoint.y <= C_BORDERWIDTH) then
  begin
    Msg.Result := HTTOPLEFT; //����
  end else
    if (tmpPoint.x <= C_BORDERWIDTH) and (tmpPoint.y >= Height - C_BORDERWIDTH) then
    begin
      Msg.Result := HTBOTTOMLEFT; //����
    end else
      if (tmpPoint.x >= Width - C_BORDERWIDTH) and (tmpPoint.y <= C_BORDERWIDTH) then
      begin
        Msg.Result := HTTOPRIGHT; //����
      end else
        if (tmpPoint.x >= Width - C_BORDERWIDTH) and (tmpPoint.y >= Height - C_BORDERWIDTH) then
        begin
          Msg.Result := HTBOTTOMRIGHT; //����
        end else
          if (tmpPoint.x <= C_BORDERWIDTH) then
          begin
            Msg.Result := HTLEFT; //��
          end;

  if (tmpPoint.x >= Width - C_BORDERWIDTH) then
  begin
    Msg.Result := HTRIGHT; //��
  end;

  if (tmpPoint.Y <= C_BORDERWIDTH) then
  begin
    Msg.Result := HTTOP; //��
  end;

  if (tmpPoint.y >= Height - C_BORDERWIDTH) then
  begin
    Msg.Result := HTBOTTOM; //��
  end;
end;



procedure TF_LoginIn.WMNCPaint(var Msg: TWMNCPaint);
begin
  DrawFormLine;
end;


procedure TF_LoginIn.Resize;
begin
  inherited;
  CreateHr;
end;
}

procedure TF_LoginIn.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled := False;
  if Edit98.Font.Color = clblack then
    Edit99.SetFocus;
end;

end.

