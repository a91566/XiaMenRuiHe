inherited FOF_YuanLiaoPiCiShiXiaoQi: TFOF_YuanLiaoPiCiShiXiaoQi
  Left = 256
  Top = 91
  Width = 1099
  Height = 585
  Caption = #21407#26009#25209#27425#22833#25928#26399#26597#35810#20462#25913
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 16
  inherited Panel1: TPanel
    Width = 1091
    inherited SpeedButton999: TSpeedButton
      Left = 999
    end
    inherited SpeedButton4: TSpeedButton
      Left = 306
      Width = 39
      Caption = '?'
      OnClick = SpeedButton4Click
    end
    inherited SpeedButton3: TSpeedButton
      Left = 210
      Caption = '7'#22825#21518#36807#26399
      OnClick = SpeedButton3Click
    end
    inherited SpeedButton2: TSpeedButton
      Left = 113
      Caption = '2'#22825#21518#36807#26399
      OnClick = SpeedButton2Click
    end
    inherited SpeedButton1: TSpeedButton
      Width = 101
      Caption = #26174#31034#24050#36807#26399
      OnClick = SpeedButton1Click
    end
  end
  inherited Panel2: TPanel
    Width = 1091
    object LabeledEdit1: TLabeledEdit
      Left = 47
      Top = 13
      Width = 144
      Height = 24
      EditLabel.Width = 32
      EditLabel.Height = 16
      EditLabel.Caption = #26009#21495
      LabelPosition = lpLeft
      TabOrder = 0
      OnKeyPress = LabeledEdit1KeyPress
    end
    object Button1: TButton
      Left = 754
      Top = 7
      Width = 77
      Height = 37
      Caption = #31579#36873
      TabOrder = 1
      OnClick = Button1Click
    end
    object LabeledEdit2: TLabeledEdit
      Left = 247
      Top = 13
      Width = 144
      Height = 24
      EditLabel.Width = 32
      EditLabel.Height = 16
      EditLabel.Caption = #25209#27425
      LabelPosition = lpLeft
      TabOrder = 2
      OnKeyPress = LabeledEdit1KeyPress
    end
    object CheckBox1: TCheckBox
      Left = 416
      Top = 17
      Width = 97
      Height = 17
      Caption = #36807#26399#26085#26399
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object DateTimePicker2: TDateTimePicker
      Left = 506
      Top = 13
      Width = 125
      Height = 24
      Date = 41354.568846388890000000
      Time = 41354.568846388890000000
      TabOrder = 4
      OnChange = Button1Click
    end
    object CheckBox4: TCheckBox
      Left = 648
      Top = 16
      Width = 97
      Height = 17
      Caption = #24211#23384#22823#20110'0'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 5
    end
  end
  inherited Panel3: TPanel
    Width = 1091
    Height = 460
    object RzPageControl2: TRzPageControl
      Left = 2
      Top = 2
      Width = 1087
      Height = 456
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
      TabOrder = 0
      TabStyle = tsRoundCorners
      TextColors.Unselected = clBlack
      FixedDimension = 21
      object RzTabSheet2: TRzTabSheet
        Color = clWhite
        Caption = #26126#32454#21333#20449#24687
        object DBGridEh2: TDBGridEh
          Left = 0
          Top = 0
          Width = 1083
          Height = 428
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
          DataSource = DataSource1
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
          OnDblClick = DBGridEh2DblClick
          Columns = <
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'MIDDONO'
              Footers = <>
              Title.Caption = #20837#24211#21333#21495
              Width = 101
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'MatlCode'
              Footers = <>
              Title.Caption = #26448#26009#20195#30721
              Width = 112
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'MatlLot'
              Footers = <>
              Title.Caption = #26448#26009#25209#21495
              Width = 146
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'LostUsesDate'
              Footers = <>
              Title.Caption = #22833#25928#26085#26399
              Width = 93
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'StockQuat'
              Footers = <>
              Title.Caption = #25968#37327
              Width = 52
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'MatlVer'
              Footers = <>
              Title.Caption = #29256#27425
              Width = 68
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'ShefCode'
              Footers = <>
              Title.Caption = #36135#26550
              Width = 130
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'AutoLot'
              Footers = <>
              Title.Caption = #27969#27700#21495
              Width = 115
            end>
        end
        object Panel4: TPanel
          Left = 894
          Top = 16
          Width = 185
          Height = 60
          BevelInner = bvLowered
          Color = clWhite
          TabOrder = 1
          object Label3: TLabel
            Left = 9
            Top = 174
            Width = 45
            Height = 15
            Caption = #24310#38271#33267
          end
          object LabeledEdit4: TLabeledEdit
            Left = 7
            Top = 82
            Width = 164
            Height = 23
            Color = 16776176
            EditLabel.Width = 30
            EditLabel.Height = 15
            EditLabel.Caption = #26009#21495
            ReadOnly = True
            TabOrder = 0
          end
          object LabeledEdit5: TLabeledEdit
            Left = 7
            Top = 136
            Width = 164
            Height = 23
            Color = 16776176
            EditLabel.Width = 30
            EditLabel.Height = 15
            EditLabel.Caption = #25209#27425
            ReadOnly = True
            TabOrder = 1
          end
          object DateTimePicker1: TDateTimePicker
            Left = 8
            Top = 196
            Width = 125
            Height = 24
            Date = 41354.568846388890000000
            Time = 41354.568846388890000000
            TabOrder = 2
          end
          object Button2: TButton
            Left = 23
            Top = 238
            Width = 140
            Height = 45
            Caption = #30830#23450
            TabOrder = 3
            OnClick = Button2Click
          end
          object Button3: TButton
            Left = 22
            Top = 7
            Width = 140
            Height = 45
            Caption = #24310#38271#26399#25928
            TabOrder = 4
            OnClick = Button3Click
          end
          object CheckBox2: TCheckBox
            Left = 40
            Top = 64
            Width = 121
            Height = 17
            Caption = #21152#20837#26356#26032#26465#20214
            Checked = True
            State = cbChecked
            TabOrder = 5
          end
          object CheckBox3: TCheckBox
            Left = 40
            Top = 118
            Width = 113
            Height = 17
            Caption = #21152#20837#26356#26032#26465#20214
            Checked = True
            State = cbChecked
            TabOrder = 6
          end
        end
      end
    end
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = FDM.SC
    Left = 107
    Top = 222
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 155
    Top = 223
  end
  object ClientDataSet10: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = FDM.SC
    Left = 107
    Top = 259
  end
end
