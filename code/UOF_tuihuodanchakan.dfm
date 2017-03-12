inherited FOF_tuihuodanchakan: TFOF_tuihuodanchakan
  Caption = #36864#36135#21333#26597#30475
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 16
  inherited Panel1: TPanel
    inherited SpeedButton1: TSpeedButton
      Visible = False
    end
    inherited SpeedButton2: TSpeedButton
      Visible = False
    end
    inherited SpeedButton3: TSpeedButton
      Visible = False
    end
    inherited SpeedButton4: TSpeedButton
      Visible = False
    end
  end
  inherited Panel2: TPanel
    object Label1: TLabel
      Left = 10
      Top = 14
      Width = 48
      Height = 16
      Caption = #26085#26399#20174
    end
    object Label2: TLabel
      Left = 172
      Top = 14
      Width = 16
      Height = 16
      Caption = #21040
    end
    object DateTimePicker1: TDateTimePicker
      Left = 60
      Top = 10
      Width = 111
      Height = 24
      Date = 41354.568846388890000000
      Time = 41354.568846388890000000
      TabOrder = 0
    end
    object DateTimePicker2: TDateTimePicker
      Left = 195
      Top = 11
      Width = 111
      Height = 24
      Date = 41354.568846388890000000
      Time = 41354.568846388890000000
      TabOrder = 1
    end
    object LabeledEdit1: TLabeledEdit
      Left = 367
      Top = 10
      Width = 243
      Height = 24
      EditLabel.Width = 48
      EditLabel.Height = 16
      EditLabel.Caption = #20379#24212#21830
      LabelPosition = lpLeft
      TabOrder = 2
    end
    object LabeledEdit2: TLabeledEdit
      Left = 688
      Top = 11
      Width = 148
      Height = 24
      EditLabel.Width = 64
      EditLabel.Height = 16
      EditLabel.Caption = #26448#26009#20195#30721
      LabelPosition = lpLeft
      TabOrder = 3
    end
  end
  inherited Panel3: TPanel
    object RzPageControl1: TRzPageControl
      Left = 2
      Top = 2
      Width = 916
      Height = 193
      ActivePage = RzTabSheet1
      Align = alTop
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = #23435#20307
      Font.Style = []
      FlatColor = clTeal
      HotTrackColor = clRed
      HotTrackStyle = htsText
      ParentFont = False
      TabColors.HighlightBar = clWhite
      TabColors.Shadow = clSkyBlue
      TabColors.Unselected = clPurple
      TabIndex = 0
      TabOrder = 0
      TabStyle = tsRoundCorners
      TextColors.Unselected = clBlack
      FixedDimension = 21
      object RzTabSheet1: TRzTabSheet
        Color = clWhite
        Caption = #20027#21333#20449#24687
        object DBGridEh1: TDBGridEh
          Left = 0
          Top = 0
          Width = 912
          Height = 165
          FixGridlinecolor = clWhite
          Gridlinecolor = clWhite
          FooterDisplayStyle = False
          CurrencyStyle.CurrencyFont.Charset = DEFAULT_CHARSET
          CurrencyStyle.CurrencyFont.Color = clWindowText
          CurrencyStyle.CurrencyFont.Height = -11
          CurrencyStyle.CurrencyFont.Name = 'MS Sans Serif'
          CurrencyStyle.CurrencyFont.Style = []
          CurrencyStyle.CurrencySymbol = #65509
          CurrencyStyle.CompartColor = clSilver
          CurrencyStyle.KilobitColor = clGreen
          CurrencyStyle.RadixColor = clRed
          CurrencyStyle.ShowMinus = True
          CurrencyStyle.ShowZero = False
          CurrencyStyle.MinusColor = clRed
          CurrencyStyle.Layout = tlCenter
          CurrencyStyle.HeadFont.Charset = DEFAULT_CHARSET
          CurrencyStyle.HeadFont.Color = clWindowText
          CurrencyStyle.HeadFont.Height = -11
          CurrencyStyle.HeadFont.Name = #26999#20307'_GB2312'
          CurrencyStyle.HeadFont.Style = []
          Align = alClient
          RowColor1 = 16774625
          RowColor2 = clWhite
          ShowBmp = False
          UseMenu = True
          Ctl3D = False
          FixedColor = clSkyBlue
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #23435#20307
          Font.Style = []
          FooterColor = clWhite
          FooterFont.Charset = DEFAULT_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -11
          FooterFont.Name = 'MS Sans Serif'
          FooterFont.Style = []
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          SumList.Active = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitleLines = 1
          UseMultiTitle = True
          Columns = <
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'ymlb'
              Footers = <>
              Title.Caption = #36864#36135#21333#21495
              Width = 112
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'ckdh'
              Footers = <>
              Title.Caption = #20379#24212#21830
              Width = 114
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'fhf'
              Footers = <>
              Title.Caption = #26085#26399
              Width = 151
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'username'
              Footers = <>
              Title.Caption = #36864#36135#20154
              Width = 164
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              Footers = <>
              Title.Caption = #22791#27880
              Width = 253
            end>
        end
      end
    end
    object RzPageControl2: TRzPageControl
      Left = 2
      Top = 195
      Width = 916
      Height = 158
      ActivePage = RzTabSheet2
      Align = alClient
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = #23435#20307
      Font.Style = []
      FlatColor = clTeal
      HotTrackColor = clRed
      HotTrackStyle = htsText
      ParentFont = False
      TabColors.HighlightBar = clWhite
      TabColors.Shadow = clSkyBlue
      TabColors.Unselected = clPurple
      TabIndex = 0
      TabOrder = 1
      TabStyle = tsRoundCorners
      TextColors.Unselected = clBlack
      FixedDimension = 21
      object RzTabSheet2: TRzTabSheet
        Color = clWhite
        Caption = #26126#32454#21333#20449#24687
        object DBGridEh2: TDBGridEh
          Left = 0
          Top = 0
          Width = 912
          Height = 130
          FixGridlinecolor = clWhite
          Gridlinecolor = clWhite
          FooterDisplayStyle = False
          CurrencyStyle.CurrencyFont.Charset = DEFAULT_CHARSET
          CurrencyStyle.CurrencyFont.Color = clWindowText
          CurrencyStyle.CurrencyFont.Height = -11
          CurrencyStyle.CurrencyFont.Name = 'MS Sans Serif'
          CurrencyStyle.CurrencyFont.Style = []
          CurrencyStyle.CurrencySymbol = #65509
          CurrencyStyle.CompartColor = clSilver
          CurrencyStyle.KilobitColor = clGreen
          CurrencyStyle.RadixColor = clRed
          CurrencyStyle.ShowMinus = True
          CurrencyStyle.ShowZero = False
          CurrencyStyle.MinusColor = clRed
          CurrencyStyle.Layout = tlCenter
          CurrencyStyle.HeadFont.Charset = DEFAULT_CHARSET
          CurrencyStyle.HeadFont.Color = clWindowText
          CurrencyStyle.HeadFont.Height = -11
          CurrencyStyle.HeadFont.Name = #26999#20307'_GB2312'
          CurrencyStyle.HeadFont.Style = []
          Align = alClient
          RowColor1 = 16774625
          RowColor2 = clWhite
          ShowBmp = False
          UseMenu = True
          Ctl3D = False
          FixedColor = clSkyBlue
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #23435#20307
          Font.Style = []
          FooterColor = clWhite
          FooterFont.Charset = DEFAULT_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -11
          FooterFont.Name = 'MS Sans Serif'
          FooterFont.Style = []
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          SumList.Active = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitleLines = 1
          UseMultiTitle = True
          Columns = <
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'fhf'
              Footers = <>
              Title.Caption = #36864#36135#21333#21495
              Width = 151
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'ymlb'
              Footers = <>
              Title.Caption = #26448#26009#20195#30721
              Width = 112
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'ckdh'
              Footers = <>
              Title.Caption = #26448#26009#25209#21495
              Width = 114
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'username'
              Footers = <>
              Title.Caption = #25968#37327
              Width = 145
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              Footers = <>
              Title.Caption = #29256#27425
              Width = 68
            end>
        end
      end
    end
  end
end
