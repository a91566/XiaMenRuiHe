inherited FOF_chengpinrukudanchakan: TFOF_chengpinrukudanchakan
  Width = 1052
  Caption = #25104#21697#20837#24211#21333#26597#30475
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 16
  inherited Panel1: TPanel
    Width = 1044
    inherited SpeedButton999: TSpeedButton
      Left = 952
    end
    inherited SpeedButton4: TSpeedButton
      Visible = False
    end
    inherited SpeedButton3: TSpeedButton
      Visible = False
    end
    inherited SpeedButton2: TSpeedButton
      Caption = #23548#20986
      OnClick = SpeedButton2Click
    end
    inherited SpeedButton1: TSpeedButton
      Caption = #25628#32034
      OnClick = SpeedButton1Click
    end
  end
  inherited Panel2: TPanel
    Width = 1044
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
    object LabeledEdit2: TLabeledEdit
      Left = 561
      Top = 11
      Width = 148
      Height = 24
      EditLabel.Width = 64
      EditLabel.Height = 16
      EditLabel.Caption = #20837#24211#21333#21495
      LabelPosition = lpLeft
      TabOrder = 0
    end
    object LabeledEdit1: TLabeledEdit
      Left = 353
      Top = 10
      Width = 125
      Height = 24
      EditLabel.Width = 32
      EditLabel.Height = 16
      EditLabel.Caption = #21697#30058
      LabelPosition = lpLeft
      TabOrder = 1
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
  end
  inherited Panel3: TPanel
    Width = 1044
    object RzPageControl1: TRzPageControl
      Left = 2
      Top = 2
      Width = 1040
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
          Width = 1036
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
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'InNo'
              Footers = <>
              Title.Caption = #20837#24211#21333#21495
              Width = 112
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'DepotCode'
              Footers = <>
              Title.Caption = #25910#36135#20179#24211
              Width = 114
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'UserCode'
              Footers = <>
              Title.Caption = #25805#20316#21592
              Width = 109
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'OpeeDT'
              Footers = <>
              Title.Caption = #25805#20316#26102#38388
              Width = 183
            end
            item
              IsCurrency = False
              Alignment = taCenter
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'State'
              Footers = <>
              Title.Caption = #29366#24577
              Width = 58
            end>
        end
      end
    end
    object RzPageControl2: TRzPageControl
      Left = 2
      Top = 195
      Width = 1040
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
          Width = 1036
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
          Columns = <
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'ERPPDNO'
              Footers = <>
              Title.Caption = #21046#20196#21333
              Width = 108
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'EndProtCode'
              Footers = <>
              Title.Caption = #21697#30058
              Width = 191
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'EndProtLot'
              Footers = <>
              Title.Caption = #25209#21495
              Width = 151
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'EndProtQuat'
              Footers = <>
              Title.Caption = #25968#37327
              Width = 92
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'DEP'
              Footers = <>
              Title.Caption = #21046#36896#37096#38376
              Width = 110
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'ShefCode'
              Footers = <>
              Title.Caption = #24211#20301
              Width = 99
            end
            item
              IsCurrency = False
              Alignment = taCenter
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'State'
              Footers = <>
              Title.Caption = #29366#24577
              Width = 58
            end>
        end
      end
    end
    object CheckBox1: TCheckBox
      Left = 110
      Top = 198
      Width = 97
      Height = 17
      Caption = #26174#31034#25253#24223
      TabOrder = 2
    end
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = FDM.SC
    Left = 107
    Top = 184
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 155
    Top = 185
  end
  object ClientDataSet2: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = FDM.SC
    Left = 107
    Top = 220
  end
  object DataSource2: TDataSource
    DataSet = ClientDataSet2
    Left = 155
    Top = 221
  end
  object ClientDataSet10: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = FDM.SC
    Left = 218
    Top = 179
  end
  object ClientDataSet11: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = FDM.SC
    Left = 306
    Top = 219
  end
end
