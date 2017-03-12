object F_SelectPrintSupply: TF_SelectPrintSupply
  Left = 325
  Top = 126
  BorderStyle = bsSingle
  Caption = #25171#21360#21407#26009#26631#31614'-'#36873#25321#20379#24212#21830
  ClientHeight = 477
  ClientWidth = 666
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 666
    Height = 477
    Align = alClient
    BevelInner = bvLowered
    Color = clWhite
    TabOrder = 0
    Visible = False
    object Image1: TImage
      Left = 550
      Top = 2
      Width = 114
      Height = 473
      Align = alRight
    end
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 548
      Height = 473
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object Panel3: TPanel
        Left = 0
        Top = 370
        Width = 548
        Height = 103
        Align = alBottom
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        DesignSize = (
          548
          103)
        object Image2: TImage
          Left = 0
          Top = 0
          Width = 548
          Height = 103
          Align = alClient
        end
        object Button1: TButton
          Left = 22
          Top = 26
          Width = 188
          Height = 45
          Caption = #30830#23450
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 338
          Top = 26
          Width = 188
          Height = 45
          Anchors = [akTop, akRight]
          Caption = #21462#28040
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = Button2Click
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 548
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 1
        object Button3: TButton
          Left = 352
          Top = 4
          Width = 75
          Height = 33
          Caption = #21047#26032
          TabOrder = 0
          OnClick = Button3Click
        end
        object LabeledEdit1: TLabeledEdit
          Left = 64
          Top = 8
          Width = 257
          Height = 24
          EditLabel.Width = 48
          EditLabel.Height = 16
          EditLabel.Caption = #20851#38190#23383
          LabelPosition = lpLeft
          TabOrder = 1
        end
      end
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 41
        Width = 548
        Height = 329
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
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        SumList.Active = True
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -16
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitleLines = 1
        UseMultiTitle = True
        OnDblClick = DBGridEh1DblClick
        Columns = <
          item
            IsCurrency = False
            DisplayNullIfZero = False
            EditButtons = <>
            FieldName = 'SuprCode'
            Footers = <>
            Title.Caption = #20195#30721
            Width = 134
          end
          item
            IsCurrency = False
            DisplayNullIfZero = False
            EditButtons = <>
            FieldName = 'SuprName'
            Footers = <>
            Title.Caption = #21517#31216
            Width = 336
          end>
      end
    end
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = FDM.SC
    Left = 35
    Top = 303
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 72
    Top = 307
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 114
    Top = 303
  end
end
