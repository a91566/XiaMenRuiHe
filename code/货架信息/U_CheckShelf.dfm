object F_CheckShelf: TF_CheckShelf
  Left = 317
  Top = 74
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #36873#25321#36135#26550
  ClientHeight = 537
  ClientWidth = 799
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
    Width = 799
    Height = 537
    Align = alClient
    BevelInner = bvLowered
    Color = clWhite
    TabOrder = 0
    Visible = False
    object Image1: TImage
      Left = 683
      Top = 2
      Width = 114
      Height = 533
      Align = alRight
    end
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 681
      Height = 533
      Align = alClient
      BevelInner = bvLowered
      Color = clWhite
      TabOrder = 0
      object Panel3: TPanel
        Left = 2
        Top = 428
        Width = 677
        Height = 103
        Align = alBottom
        BevelInner = bvLowered
        Color = clWhite
        TabOrder = 0
        DesignSize = (
          677
          103)
        object Image2: TImage
          Left = 2
          Top = 2
          Width = 673
          Height = 99
          Align = alClient
        end
        object Button1: TButton
          Left = 109
          Top = 28
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
          Left = 381
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
        object RadioButton1: TRadioButton
          Left = 8
          Top = 47
          Width = 63
          Height = 17
          Caption = #32534#30721
          Checked = True
          TabOrder = 2
          TabStop = True
        end
        object RadioButton2: TRadioButton
          Left = 6
          Top = 76
          Width = 113
          Height = 17
          Caption = #32534#30721'/'#21517#31216
          TabOrder = 3
        end
      end
      object RzPageControl1: TRzPageControl
        Left = 2
        Top = 2
        Width = 677
        Height = 426
        ActivePage = TabSheet4
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
        object TabSheet4: TRzTabSheet
          Color = clWhite
          Caption = #36873#25321#36135#26550
          object DBGridEh1: TDBGridEh
            Left = 0
            Top = 0
            Width = 673
            Height = 398
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
            TabOrder = 0
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
                FieldName = 'ShefCode'
                Footers = <>
                Title.Caption = #32534#30721
                Width = 143
              end
              item
                IsCurrency = False
                DisplayNullIfZero = False
                EditButtons = <>
                FieldName = 'ShefName'
                Footers = <>
                Title.Caption = #21517#31216
                Width = 138
              end
              item
                IsCurrency = False
                DisplayNullIfZero = False
                EditButtons = <>
                FieldName = 'State'
                Footers = <>
                Title.Caption = #29366#24577
                Width = 59
              end
              item
                IsCurrency = False
                DisplayNullIfZero = False
                EditButtons = <>
                FieldName = 'Tips'
                Footers = <>
                Title.Caption = #22791#27880
                Width = 256
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
