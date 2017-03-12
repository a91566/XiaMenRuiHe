object F_GetEndProtLot: TF_GetEndProtLot
  Left = 158
  Top = 105
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = #35831#36873#25321#31934#30830#30340#25209#27425
  ClientHeight = 471
  ClientWidth = 1149
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
    Width = 1149
    Height = 471
    Align = alClient
    BevelInner = bvLowered
    Color = clWhite
    TabOrder = 0
    Visible = False
    object Image1: TImage
      Left = 1033
      Top = 2
      Width = 114
      Height = 467
      Align = alRight
    end
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 1031
      Height = 467
      Align = alClient
      BevelInner = bvLowered
      Color = clWhite
      TabOrder = 0
      object Panel3: TPanel
        Left = 2
        Top = 362
        Width = 1027
        Height = 103
        Align = alBottom
        BevelInner = bvLowered
        Color = clWhite
        TabOrder = 0
        DesignSize = (
          1027
          103)
        object Image2: TImage
          Left = 2
          Top = 2
          Width = 1023
          Height = 99
          Align = alClient
        end
        object Button1: TButton
          Left = 254
          Top = 29
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
          Left = 584
          Top = 29
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
      object RzPageControl1: TRzPageControl
        Left = 2
        Top = 2
        Width = 1027
        Height = 360
        ActivePage = TabSheet3
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
        object TabSheet3: TRzTabSheet
          Color = clWhite
          Caption = #30456#20851#20449#24687
          object DBGridEh2: TDBGridEh
            Left = 0
            Top = 0
            Width = 1023
            Height = 332
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
                FieldName = 'EndProtCode'
                Footers = <>
                Title.Caption = #21697#30058
                Width = 121
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
                FieldName = 'EndProtVer'
                Footers = <>
                Title.Caption = #29256#27425
                Width = 114
              end
              item
                IsCurrency = False
                DisplayNullIfZero = False
                EditButtons = <>
                FieldName = 'CustCode'
                Footers = <>
                Title.Caption = #23458#25143#20195#30721
                Width = 133
              end
              item
                IsCurrency = False
                DisplayNullIfZero = False
                EditButtons = <>
                FieldName = 'Tips'
                Footers = <>
                Title.Caption = #20135#21697#25551#36848
                Width = 331
              end
              item
                IsCurrency = False
                DisplayNullIfZero = False
                EditButtons = <>
                FieldName = 'EndProtQuat'
                Footers = <>
                Title.Caption = #25968#37327
                Width = 92
              end>
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
