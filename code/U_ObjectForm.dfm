object F_ObjectForm: TF_ObjectForm
  Left = 250
  Top = 147
  Width = 928
  Height = 480
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'F_ObjectForm'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 920
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    Color = clWhite
    TabOrder = 0
    Visible = False
    DesignSize = (
      920
      41)
    object SpeedButton999: TSpeedButton
      Left = 828
      Top = 2
      Width = 90
      Height = 37
      Anchors = [akTop, akRight]
      Caption = #20851#38381
      OnClick = SpeedButton999Click
    end
    object SpeedButton4: TSpeedButton
      Left = 278
      Top = 2
      Width = 90
      Height = 37
    end
    object SpeedButton3: TSpeedButton
      Left = 186
      Top = 2
      Width = 90
      Height = 37
    end
    object SpeedButton2: TSpeedButton
      Left = 94
      Top = 2
      Width = 90
      Height = 37
    end
    object SpeedButton1: TSpeedButton
      Left = 2
      Top = 2
      Width = 90
      Height = 37
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 920
    Height = 50
    Align = alTop
    BevelInner = bvLowered
    Color = clWhite
    TabOrder = 1
    Visible = False
  end
  object Panel3: TPanel
    Left = 0
    Top = 91
    Width = 920
    Height = 355
    Align = alClient
    BevelInner = bvLowered
    Color = clWhite
    TabOrder = 2
    Visible = False
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 687
    Top = 117
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 500
    Left = 733
    Top = 121
  end
end
