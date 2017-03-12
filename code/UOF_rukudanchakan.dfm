inherited FOF_rukudanchakan: TFOF_rukudanchakan
  Caption = #20179#24211#36827#36135#21333#26597#30475' '
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 16
  inherited Panel1: TPanel
    inherited SpeedButton4: TSpeedButton
      Left = 418
      Caption = #20840#36873
      OnClick = SpeedButton4Click
    end
    inherited SpeedButton3: TSpeedButton
      Left = 278
      Width = 138
      Caption = #19982'ERP'#35831#36141#21333#39564#35777
      OnClick = SpeedButton3Click
    end
    inherited SpeedButton2: TSpeedButton
      Caption = #23548#20986#27719#24635
      OnClick = SpeedButton2Click
    end
    inherited SpeedButton1: TSpeedButton
      Caption = #26597#35810
      OnClick = SpeedButton1Click
    end
    object SpeedButton5: TSpeedButton
      Left = 186
      Top = 2
      Width = 90
      Height = 37
      Caption = #23548#20986#26126#32454
      OnClick = SpeedButton5Click
    end
  end
  inherited Panel2: TPanel
    Top = 91
    Height = 355
    Align = alClient
    object RzPageControl1: TRzPageControl
      Left = 2
      Top = 2
      Width = 916
      Height = 224
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
          Height = 196
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
              Checkboxes = True
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'isselect'
              Footers = <>
              Title.Caption = #36873#25321
              Width = 44
            end
            item
              IsCurrency = False
              Alignment = taCenter
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'MIDDONO'
              Footers = <>
              ReadOnly = True
              Title.Caption = #20837#24211#21333#21495
              Width = 112
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'SuprCode'
              Footers = <>
              ReadOnly = True
              Title.Caption = #20379#24212#21830#20195#21495
              Width = 111
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'DepotCode'
              Footers = <>
              ReadOnly = True
              Title.Caption = #25910#36135#20179#24211
              Width = 85
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'UserCode'
              Footers = <>
              ReadOnly = True
              Title.Caption = #25910#36135#20154
              Width = 127
            end
            item
              IsCurrency = False
              Alignment = taCenter
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'State'
              Footers = <>
              ReadOnly = True
              Title.Caption = #29366#24577
              Width = 42
            end
            item
              IsCurrency = False
              Alignment = taCenter
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'OpeeDT'
              Footers = <>
              ReadOnly = True
              Title.Caption = #26085#26399
              Width = 169
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'Tips'
              Footers = <>
              ReadOnly = True
              Title.Caption = #22791#27880
              Visible = False
              Width = 229
            end>
        end
        object RzPanel1: TRzPanel
          Left = 200
          Top = 48
          Width = 521
          Height = 113
          BorderOuter = fsNone
          BorderColor = clYellow
          BorderWidth = 1
          Color = clBlack
          Ctl3D = False
          Font.Charset = GB2312_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = #23435#20307
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          Visible = False
        end
      end
    end
    object RzPageControl2: TRzPageControl
      Left = 2
      Top = 226
      Width = 916
      Height = 127
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
          Height = 99
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
              Width = 114
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'MatlQuat'
              Footers = <>
              Title.Caption = #20837#24211#25968#37327
              Width = 71
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
              Width = 147
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'autoLot'
              Footers = <>
              Title.Caption = #27969#27700#21495
              Width = 124
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'lostusesdate'
              Footers = <>
              Title.Caption = #22833#25928#26399
              Width = 97
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'ProeNo'
              Footers = <>
              Title.Caption = #29983#20135#21333#21495
              Visible = False
              Width = 108
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'OccupyQuat'
              Footers = <>
              Title.Caption = #34987#21344#29992#25968
              Visible = False
              Width = 93
            end
            item
              IsCurrency = False
              DisplayNullIfZero = False
              EditButtons = <>
              FieldName = 'OccupyERPPDNO'
              Footers = <>
              Title.Caption = #21344#29992#21333#21495
              Visible = False
              Width = 78
            end>
        end
      end
    end
  end
  inherited Panel3: TPanel
    Top = 41
    Height = 50
    Align = alTop
    object Label1: TLabel
      Left = 10
      Top = 17
      Width = 48
      Height = 16
      Caption = #26085#26399#20174
    end
    object Label2: TLabel
      Left = 174
      Top = 17
      Width = 16
      Height = 16
      Caption = #21040
    end
    object Label3: TLabel
      Left = 728
      Top = 17
      Width = 32
      Height = 16
      Caption = #29366#24577
    end
    object DateTimePicker1: TDateTimePicker
      Left = 60
      Top = 13
      Width = 111
      Height = 24
      Date = 41354.568846388890000000
      Time = 41354.568846388890000000
      TabOrder = 0
    end
    object DateTimePicker2: TDateTimePicker
      Left = 195
      Top = 13
      Width = 111
      Height = 24
      Date = 41354.568846388890000000
      Time = 41354.568846388890000000
      TabOrder = 1
    end
    object LabeledEdit1: TLabeledEdit
      Left = 394
      Top = 13
      Width = 90
      Height = 24
      EditLabel.Width = 80
      EditLabel.Height = 16
      EditLabel.Caption = #20379#24212#21830#20195#21495
      LabelPosition = lpLeft
      TabOrder = 2
    end
    object LabeledEdit2: TLabeledEdit
      Left = 536
      Top = 13
      Width = 105
      Height = 24
      EditLabel.Width = 32
      EditLabel.Height = 16
      EditLabel.Caption = #26009#21495
      LabelPosition = lpLeft
      TabOrder = 3
    end
    object ComboBox1: TComboBox
      Left = 768
      Top = 13
      Width = 65
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      ItemIndex = 1
      TabOrder = 4
      Text = 'Y'
      OnChange = SpeedButton1Click
      Items.Strings = (
        ''
        'Y'
        'N')
    end
    object CheckBox1: TCheckBox
      Left = 648
      Top = 16
      Width = 65
      Height = 17
      Caption = #26597#35810
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
  end
  inherited Timer1: TTimer
    Left = 148
    Top = 394
  end
  object DataSource1: TDataSource [4]
    DataSet = ClientDataSet1
    Left = 115
    Top = 223
  end
  object ClientDataSet1: TClientDataSet [5]
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = FDM.SC
    Left = 67
    Top = 222
  end
  inherited Timer2: TTimer
    Left = 209
    Top = 389
  end
  object ClientDataSet2: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = FDM.SC
    Left = 67
    Top = 258
  end
  object DataSource2: TDataSource
    DataSet = ClientDataSet2
    Left = 115
    Top = 259
  end
  object ClientDataSet10: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = FDM.SC
    Left = 251
    Top = 382
  end
  object ClientDataSet11: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = FDM.SC
    Left = 275
    Top = 390
  end
end
