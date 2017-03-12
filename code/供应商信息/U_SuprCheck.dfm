object F_SuprCheck: TF_SuprCheck
  Left = 391
  Top = 115
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = #20379#24212#21830#26597#35810
  ClientHeight = 470
  ClientWidth = 709
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 709
    Height = 470
    Align = alClient
    BevelInner = bvLowered
    Color = clWhite
    TabOrder = 0
    Visible = False
    object Image1: TImage
      Left = 593
      Top = 2
      Width = 114
      Height = 466
      Align = alRight
    end
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 591
      Height = 466
      Align = alClient
      BevelInner = bvLowered
      Color = clWhite
      TabOrder = 0
      object Panel3: TPanel
        Left = 2
        Top = 391
        Width = 587
        Height = 73
        Align = alClient
        BevelInner = bvLowered
        Color = clWhite
        TabOrder = 0
        DesignSize = (
          587
          73)
        object Image2: TImage
          Left = 2
          Top = 2
          Width = 583
          Height = 69
          Align = alClient
        end
        object Button1: TButton
          Left = 49
          Top = 14
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
          Left = 351
          Top = 14
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
      object DBGridEh1: TDBGridEh
        Left = 2
        Top = 2
        Width = 587
        Height = 389
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
        Align = alTop
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
        TabOrder = 1
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
            Title.Caption = #23458#25143#20195#21495
            Width = 95
          end
          item
            IsCurrency = False
            DisplayNullIfZero = False
            EditButtons = <>
            FieldName = 'SuprName'
            Footers = <>
            Title.Caption = #20840#31216
            Width = 260
          end
          item
            IsCurrency = False
            DisplayNullIfZero = False
            EditButtons = <>
            FieldName = 'SuprType'
            Footers = <>
            Title.Caption = #31867#21035
            Width = 92
          end
          item
            IsCurrency = False
            DisplayNullIfZero = False
            EditButtons = <>
            FieldName = 'State'
            Footers = <>
            Title.Caption = #29366#24577
            Width = 55
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
