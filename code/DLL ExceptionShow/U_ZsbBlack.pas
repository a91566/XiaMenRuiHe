unit U_ZsbBlack;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TF_Zsbblack = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Zsbblack: TF_Zsbblack;

implementation

{$R *.dfm}

procedure TF_Zsbblack.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Action := caFree;
end;

procedure TF_Zsbblack.FormCreate(Sender: TObject);
var
  ExSty: DWORD;
begin
  SetWindowLong(Self.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW); //不在任务栏显示
  Self.AlphaBlend:=True;
  Self.AlphaBlendValue:=240;

  {ExSty := GetWindowLong(Handle, GWL_EXSTYLE);
  ExSty := ExSty or WS_EX_TRANSPARENT or WS_EX_LAYERED;
  SetWindowLong(Handle, GWL_EXSTYLE, ExSty);
  SetLayeredWindowAttributes(Handle, cardinal(clBtnFace), 125, LWA_ALPHA);
  MoveWindow(Handle, 0, 0, Screen.Width, Screen.Height, True);
  }
end;

end.

