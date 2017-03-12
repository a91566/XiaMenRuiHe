inherited FOF_flckdck: TFOF_flckdck
  Width = 1070
  Caption = #29983#20135#39046#26009#21333#26597#30475
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 16
  inherited Panel1: TPanel
    Width = 1062
    inherited SpeedButton999: TSpeedButton
      Left = 970
    end
    inherited SpeedButton4: TSpeedButton
      Visible = False
    end
    inherited SpeedButton3: TSpeedButton
      Visible = False
    end
    inherited SpeedButton2: TSpeedButton
      Visible = False
    end
    inherited SpeedButton1: TSpeedButton
      Caption = #26597#35810
      OnClick = SpeedButton1Click
    end
  end
  inherited Panel2: TPanel
    Width = 1062
    object Label2: TLabel
      Left = 172
      Top = 14
      Width = 16
      Height = 16
      Caption = #21040
    end
    object Label1: TLabel
      Left = 10
      Top = 14
      Width = 48
      Height = 16
      Caption = #26085#26399#20174
    end
    object Label5: TLabel
      Left = 792
      Top = 17
      Width = 64
      Height = 16
      Caption = #21333#25454#29366#24577
    end
    object LabeledEdit2: TLabeledEdit
      Left = 553
      Top = 12
      Width = 95
      Height = 24
      EditLabel.Width = 64
      EditLabel.Height = 16
      EditLabel.Caption = #21046#20196#21333#21495
      LabelPosition = lpLeft
      TabOrder = 0
      OnKeyPress = LabeledEdit2KeyPress
    end
    object LabeledEdit1: TLabeledEdit
      Left = 386
      Top = 11
      Width = 95
      Height = 24
      EditLabel.Width = 64
      EditLabel.Height = 16
      EditLabel.Caption = #39046#36864#21333#21495
      LabelPosition = lpLeft
      TabOrder = 1
      OnKeyPress = LabeledEdit1KeyPress
    end
    object DateTimePicker2: TDateTimePicker
      Left = 195
      Top = 11
      Width = 111
      Height = 24
      Date = 41354.568846388890000000
      Time = 41354.568846388890000000
      TabOrder = 2
    end
    object DateTimePicker1: TDateTimePicker
      Left = 60
      Top = 10
      Width = 111
      Height = 24
      Date = 41354.568846388890000000
      Time = 41354.568846388890000000
      TabOrder = 3
    end
    object RadioButton1: TRadioButton
      Left = 955
      Top = 4
      Width = 79
      Height = 16
      Caption = #21069#24037#31243
      Checked = True
      TabOrder = 4
      TabStop = True
      Visible = False
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 955
      Top = 27
      Width = 79
      Height = 16
      Caption = #21518#24037#31243
      TabOrder = 5
      Visible = False
      OnClick = RadioButton2Click
    end
    object ComboBox1: TComboBox
      Left = 862
      Top = 13
      Width = 107
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      ItemIndex = 4
      TabOrder = 6
      Text = '4.'#24050#23436#25104
      OnChange = SpeedButton1Click
      Items.Strings = (
        ''
        '1.'#24453#25171#21360
        '2.'#24453#21457#26009
        '3.'#21457#26009#20013
        '4.'#24050#23436#25104
        'E.'#24050#20316#24223)
    end
    object LabeledEdit3: TLabeledEdit
      Left = 689
      Top = 12
      Width = 95
      Height = 24
      EditLabel.Width = 32
      EditLabel.Height = 16
      EditLabel.Caption = #26009#21495
      LabelPosition = lpLeft
      TabOrder = 7
      OnKeyPress = LabeledEdit3KeyPress
    end
  end
  inherited Panel3: TPanel
    Width = 1062
    object RzPageControl1: TRzPageControl
      Left = 2
      Top = 2
      Width = 1058
      Height = 188
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
          Width = 1054
          Height = 160
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
          OnCellClick = DBGridEh1CellClick
          Columns = <
            item
              IsCurrency = False
              Alignment = taCenter
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'ML_NO'
              Footers = <>
              Title.Caption = #39046#36864#21333#21495
              Width = 136
            end
            item
              IsCurrency = False
              Alignment = taCenter
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'OpeeDT'
              Footers = <>
              Title.Caption = #21046#21333#26085#26399
              Width = 106
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'ProeDept'
              Footers = <>
              Title.Caption = #29983#20135#37096#38376
              Width = 95
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'EndProtCode'
              Footers = <>
              Title.Caption = #29983#20135#21697#30058
              Width = 180
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'EndProtQuat'
              Footers = <>
              Title.Caption = #29983#20135#25968#37327
              Width = 73
            end
            item
              IsCurrency = False
              Alignment = taCenter
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'State'
              Footers = <>
              Title.Caption = #21333#25454#29366#24577
              Width = 99
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'un'
              Footers = <>
              Title.Caption = #25805#20316#20154
              Width = 121
            end>
        end
      end
    end
    object RzPageControl2: TRzPageControl
      Left = 2
      Top = 190
      Width = 1058
      Height = 163
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
          Width = 713
          Height = 135
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
          Align = alLeft
          RowColor1 = 16774625
          RowColor2 = clWhite
          ShowBmp = False
          UseMenu = True
          Ctl3D = False
          DataSource = DataSource2
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
          OnCellClick = DBGridEh2CellClick
          Columns = <
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'MatlCode'
              Footers = <>
              Title.Caption = #26009#21495
              Width = 112
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'MatlQuat'
              Footers = <>
              Title.Caption = #38656#35201#30340#25968#37327
              Width = 108
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'MatlQuatAlreadyOut'
              Footers = <>
              Title.Caption = #24050#21457#25968#37327
              Width = 114
            end
            item
              IsCurrency = False
              Alignment = taCenter
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'MO_NO'
              Footers = <>
              Title.Caption = #21046#20196#21333#21495
              Width = 129
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'ShefCode'
              Footers = <>
              Title.Caption = #36135#26550
              Width = 91
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'DepotCode'
              Footers = <>
              Title.Caption = #21457#36135#20179#24211
              Width = 74
            end>
        end
        object DBGridEh3: TDBGridEh
          Left = 713
          Top = 0
          Width = 341
          Height = 135
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
          DataSource = DataSource3
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
          TabOrder = 1
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
              FieldName = 'MatlCode'
              Footers = <>
              Title.Caption = #26009#21495
              Width = 112
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'MatlQuat'
              Footers = <>
              Title.Caption = #25968#37327
              Width = 108
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'MatlLot'
              Footers = <>
              Title.Caption = #25209#27425
              Width = 114
            end
            item
              IsCurrency = False
              Alignment = taCenter
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'MatlVer'
              Footers = <>
              Title.Caption = #29256#27425
              Width = 129
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'AutoLot'
              Footers = <>
              Title.Caption = #27969#27700#21495
              Width = 113
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'un'
              Footers = <>
              Title.Caption = #21457#26009#20154
              Width = 88
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'dt'
              Footers = <>
              Title.Caption = #21457#26009#26102#38388
              Width = 122
            end>
        end
      end
    end
  end
  inherited Timer1: TTimer
    Left = 236
    Top = 264
  end
  inherited Timer2: TTimer
    Left = 282
    Top = 268
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
  object ClientDataSet2: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = FDM.SC
    Left = 107
    Top = 258
  end
  object DataSource2: TDataSource
    DataSet = ClientDataSet2
    Left = 155
    Top = 259
  end
  object ClientDataSet3: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = FDM.SC
    Left = 107
    Top = 314
  end
  object DataSource3: TDataSource
    DataSet = ClientDataSet3
    Left = 155
    Top = 315
  end
end
