object F_PrintAgain_Before: TF_PrintAgain_Before
  Left = 243
  Top = 150
  Width = 1030
  Height = 480
  Caption = #24322#24120#25104#21697#26631#31614#25171#21360' - '#20837#24211#21069
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 1022
    Height = 94
    Align = alTop
    OnDblClick = Image1DblClick
  end
  object RzPanel99: TRzPanel
    Left = 0
    Top = 94
    Width = 1022
    Height = 352
    Align = alClient
    BorderOuter = fsNone
    BorderColor = 16776176
    BorderHighlight = clWhite
    BorderShadow = clWhite
    Color = clWhite
    Ctl3D = True
    FlatColor = clLime
    FlatColorAdjustment = 100
    GradientColorStop = clWhite
    GridColor = clWhite
    GridStyle = gsSolidLines
    GridXSize = 1
    GridYSize = 1
    ParentCtl3D = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    Visible = False
    object RzPanel3: TRzPanel
      Left = 0
      Top = 0
      Width = 1022
      Height = 153
      Align = alTop
      BorderOuter = fsNone
      BorderColor = clTeal
      BorderHighlight = clWhite
      BorderShadow = clWhite
      BorderWidth = 1
      Color = clWhite
      Ctl3D = True
      FlatColor = clWhite
      FlatColorAdjustment = 100
      GradientColorStop = clWhite
      GridColor = clWhite
      GridStyle = gsSolidLines
      GridXSize = 1
      GridYSize = 1
      ParentCtl3D = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      object RzPanel1: TRzPanel
        Left = 1
        Top = 80
        Width = 1020
        Height = 72
        Align = alBottom
        BorderOuter = fsNone
        BorderColor = clTeal
        BorderHighlight = clWhite
        BorderShadow = clWhite
        BorderWidth = 1
        Color = clWhite
        Ctl3D = True
        FlatColor = clWhite
        FlatColorAdjustment = 100
        GradientColorStop = clWhite
        GridColor = clWhite
        GridStyle = gsSolidLines
        GridXSize = 1
        GridYSize = 1
        ParentCtl3D = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        DesignSize = (
          1020
          72)
        object Label1: TLabel
          Left = 816
          Top = 16
          Width = 201
          Height = 41
          Alignment = taCenter
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = #26032#26631#31614#25209#27425#20250#33258#21160#25913#21464
          Color = clRed
          ParentColor = False
          Transparent = False
          Layout = tlCenter
        end
        object Button2: TButton
          Left = 24
          Top = 17
          Width = 97
          Height = 41
          Caption = #37325#26032#25171#21360
          TabOrder = 1
          OnClick = Button2Click
        end
        object LabeledEdit10: TLabeledEdit
          Left = 225
          Top = 40
          Width = 153
          Height = 24
          EditLabel.Width = 64
          EditLabel.Height = 16
          EditLabel.Caption = #21253#35013#25968#37327
          Enabled = False
          LabelPosition = lpLeft
          TabOrder = 2
          OnChange = LabeledEdit10Change
        end
        object LabeledEdit7: TLabeledEdit
          Left = 225
          Top = 8
          Width = 153
          Height = 24
          EditLabel.Width = 64
          EditLabel.Height = 16
          EditLabel.Caption = #35013#26588#26085#26399
          Enabled = False
          LabelPosition = lpLeft
          TabOrder = 0
        end
        object LabeledEdit8: TLabeledEdit
          Left = 481
          Top = 8
          Width = 153
          Height = 24
          EditLabel.Width = 32
          EditLabel.Height = 16
          EditLabel.Caption = #29256#27425
          Enabled = False
          LabelPosition = lpLeft
          TabOrder = 3
        end
        object LabeledEdit9: TLabeledEdit
          Left = 481
          Top = 40
          Width = 153
          Height = 24
          EditLabel.Width = 64
          EditLabel.Height = 16
          EditLabel.Caption = #25253#20851#21697#30058
          Enabled = False
          LabelPosition = lpLeft
          TabOrder = 4
        end
        object CheckBox2: TCheckBox
          Left = 640
          Top = 48
          Width = 57
          Height = 17
          Caption = #26356#25913
          TabOrder = 5
          OnClick = CheckBox2Click
        end
        object CheckBox1: TCheckBox
          Left = 720
          Top = 48
          Width = 97
          Height = 17
          Caption = #26174#31034#20840#37096#21015
          TabOrder = 6
          OnClick = CheckBox1Click
        end
      end
      object RzPanel2: TRzPanel
        Left = 585
        Top = 1
        Width = 436
        Height = 79
        Align = alClient
        BorderOuter = fsNone
        BorderColor = clTeal
        BorderHighlight = clWhite
        BorderShadow = clWhite
        BorderWidth = 1
        Color = clWhite
        Ctl3D = True
        FlatColor = clWhite
        FlatColorAdjustment = 100
        GradientColorStop = clWhite
        GridColor = clWhite
        GridStyle = gsSolidLines
        GridXSize = 1
        GridYSize = 1
        ParentCtl3D = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 1
        Visible = False
        object Label7: TLabel
          Left = 485
          Top = 13
          Width = 80
          Height = 16
          Caption = #25171#21360#26085#26399#20174
        end
        object Label8: TLabel
          Left = 549
          Top = 45
          Width = 16
          Height = 16
          Caption = #21040
        end
        object DateTimePicker2: TDateTimePicker
          Left = 574
          Top = 41
          Width = 111
          Height = 24
          Date = 41354.568846388890000000
          Time = 41354.568846388890000000
          TabOrder = 0
        end
        object DateTimePicker1: TDateTimePicker
          Left = 574
          Top = 8
          Width = 111
          Height = 24
          Date = 41354.568846388890000000
          Time = 41354.568846388890000000
          TabOrder = 1
        end
        object LabeledEdit6: TLabeledEdit
          Left = 281
          Top = 40
          Width = 153
          Height = 24
          EditLabel.Width = 32
          EditLabel.Height = 16
          EditLabel.Caption = #25209#27425
          LabelPosition = lpLeft
          TabOrder = 2
        end
        object LabeledEdit5: TLabeledEdit
          Left = 281
          Top = 8
          Width = 153
          Height = 24
          EditLabel.Width = 64
          EditLabel.Height = 16
          EditLabel.Caption = #35013#26588#26085#26399
          LabelPosition = lpLeft
          TabOrder = 3
        end
        object LabeledEdit1: TLabeledEdit
          Left = 68
          Top = 8
          Width = 120
          Height = 24
          EditLabel.Width = 48
          EditLabel.Height = 16
          EditLabel.Caption = #21046#20196#21333
          LabelPosition = lpLeft
          TabOrder = 4
        end
        object LabeledEdit2: TLabeledEdit
          Left = 68
          Top = 40
          Width = 120
          Height = 24
          EditLabel.Width = 32
          EditLabel.Height = 16
          EditLabel.Caption = #21697#30058
          LabelPosition = lpLeft
          TabOrder = 5
        end
        object Button1: TButton
          Left = 708
          Top = 16
          Width = 97
          Height = 41
          Caption = #26597#35810
          TabOrder = 6
          OnClick = Button1Click
        end
      end
      object RzPanel4: TRzPanel
        Left = 201
        Top = 1
        Width = 120
        Height = 79
        Align = alLeft
        BorderOuter = fsNone
        BorderColor = clTeal
        BorderHighlight = clWhite
        BorderShadow = clWhite
        Color = clWhite
        Ctl3D = True
        FlatColor = clWhite
        FlatColorAdjustment = 100
        GradientColorStop = clWhite
        GridColor = clWhite
        GridStyle = gsSolidLines
        GridXSize = 1
        GridYSize = 1
        ParentCtl3D = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 2
        object RadioButton1: TRadioButton
          Left = 8
          Top = 19
          Width = 105
          Height = 17
          Caption = #20108#32500#30721#26597#35810
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          TabStop = True
          OnClick = RadioButton1Click
        end
        object RadioButton2: TRadioButton
          Left = 8
          Top = 43
          Width = 97
          Height = 17
          Caption = #20854#20182#26597#35810
          TabOrder = 1
          OnClick = RadioButton1Click
        end
      end
      object RzPanel5: TRzPanel
        Left = 321
        Top = 1
        Width = 264
        Height = 79
        Align = alLeft
        BorderOuter = fsNone
        BorderColor = clTeal
        BorderHighlight = clWhite
        BorderShadow = clWhite
        Color = clWhite
        Ctl3D = True
        FlatColor = clWhite
        FlatColorAdjustment = 100
        GradientColorStop = clWhite
        GridColor = clWhite
        GridStyle = gsSolidLines
        GridXSize = 1
        GridYSize = 1
        ParentCtl3D = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 3
        object Memo1: TMemo
          Left = 0
          Top = 0
          Width = 264
          Height = 79
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clSilver
          Font.Height = -16
          Font.Name = #23435#20307
          Font.Style = []
          Lines.Strings = (
            #35831#22312#27492#25195#25551#20108#32500#30721)
          ParentFont = False
          TabOrder = 0
          OnEnter = Memo1Enter
          OnExit = Memo1Exit
          OnKeyPress = Memo1KeyPress
        end
      end
      object RzPanel6: TRzPanel
        Left = 1
        Top = 1
        Width = 200
        Height = 79
        Align = alLeft
        BorderOuter = fsNone
        BorderColor = clTeal
        BorderHighlight = clWhite
        BorderShadow = clWhite
        Color = 16776176
        Ctl3D = True
        FlatColor = clWhite
        FlatColorAdjustment = 100
        GradientColorStop = clWhite
        GridColor = clWhite
        GridStyle = gsSolidLines
        GridXSize = 1
        GridYSize = 1
        ParentCtl3D = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 4
        object Label9: TLabel
          Left = 6
          Top = 15
          Width = 48
          Height = 16
          Caption = #25171#21360#32773
        end
        object ComboBox2: TComboBox
          Left = 5
          Top = 47
          Width = 191
          Height = 24
          Style = csDropDownList
          ItemHeight = 16
          TabOrder = 0
        end
      end
    end
    object DBGridEh1: TDBGridEh
      Left = 0
      Top = 153
      Width = 1022
      Height = 199
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
      RowColor1 = 16776176
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
      FrozenCols = 2
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
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
          Width = 40
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
          Width = 51
        end
        item
          IsCurrency = False
          DisplayNullIfZero = False
          EditButtons = <>
          FieldName = 'ScrapReason'
          Footers = <>
          Title.Caption = #25253#24223#21407#22240
          Width = 125
        end
        item
          IsCurrency = False
          Alignment = taCenter
          DisplayNullIfZero = False
          EditButtons = <>
          FieldName = 'ERPPDNO'
          Footers = <
            item
              Alignment = taCenter
              Color = clLime
              FieldName = 'ERPPDNO'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = #23435#20307
              Font.Style = []
              ValueType = fvtCount
            end>
          ReadOnly = True
          Title.Caption = #21046#20196#21333
          Width = 112
        end
        item
          IsCurrency = False
          DisplayNullIfZero = False
          EditButtons = <>
          FieldName = 'EndProtCode'
          Footers = <>
          ReadOnly = True
          Title.Caption = #21697#30058
          Width = 121
        end
        item
          IsCurrency = False
          DisplayNullIfZero = False
          EditButtons = <>
          FieldName = 'EndProtQuat'
          Footers = <
            item
              Alignment = taCenter
              Color = clYellow
              FieldName = 'EndProtQuat'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = #23435#20307
              Font.Style = []
              ValueType = fvtSum
            end>
          ReadOnly = True
          Title.Caption = #25968#37327
          Width = 92
        end
        item
          IsCurrency = False
          Alignment = taCenter
          DisplayNullIfZero = False
          EditButtons = <>
          FieldName = 'EndProtLot'
          Footers = <>
          ReadOnly = True
          Title.Caption = #25209#27425
          Width = 122
        end
        item
          IsCurrency = False
          DisplayNullIfZero = False
          EditButtons = <>
          FieldName = 'EndProtVer'
          Footers = <>
          ReadOnly = True
          Title.Caption = #29256#27425
          Width = 114
        end
        item
          IsCurrency = False
          DisplayNullIfZero = False
          EditButtons = <>
          FieldName = 'ShippingD'
          Footers = <>
          ReadOnly = True
          Title.Caption = #35013#26588#26085#26399
          Width = 91
        end
        item
          IsCurrency = False
          DisplayNullIfZero = False
          EditButtons = <>
          FieldName = 'ShefCode'
          Footers = <>
          ReadOnly = True
          Title.Caption = #24211#20301
          Width = 84
        end
        item
          IsCurrency = False
          DisplayNullIfZero = False
          EditButtons = <>
          FieldName = 'DEP'
          Footers = <>
          ReadOnly = True
          Title.Caption = #21046#36896#37096#38376
          Width = 74
        end
        item
          IsCurrency = False
          DisplayNullIfZero = False
          EditButtons = <>
          FieldName = 'iTime'
          Footers = <>
          Title.Caption = #25171#21360#27425#25968
          Width = 69
        end
        item
          IsCurrency = False
          DisplayNullIfZero = False
          EditButtons = <>
          FieldName = 'ML_NO'
          Footers = <>
          Title.Caption = #29983#20135#39046#26009#21333#21495
          Visible = False
          Width = 101
        end
        item
          IsCurrency = False
          DisplayNullIfZero = False
          EditButtons = <>
          FieldName = 'CustName'
          Footers = <>
          ReadOnly = True
          Title.Caption = #23458#25143
          Visible = False
          Width = 197
        end
        item
          IsCurrency = False
          Alignment = taCenter
          DisplayNullIfZero = False
          EditButtons = <>
          FieldName = 'PDT'
          Footers = <>
          Title.Caption = #25171#21360#26102#38388
          Visible = False
          Width = 166
        end
        item
          IsCurrency = False
          DisplayNullIfZero = False
          EditButtons = <>
          FieldName = 'pName'
          Footers = <>
          Title.Caption = #25171#21360#32773
          Visible = False
          Width = 99
        end
        item
          IsCurrency = False
          DisplayNullIfZero = False
          EditButtons = <>
          FieldName = 'cn'
          Footers = <>
          Title.Caption = 'C/N'
          Visible = False
          Width = 69
        end
        item
          IsCurrency = False
          Alignment = taCenter
          DisplayNullIfZero = False
          EditButtons = <>
          FieldName = 'OpeeDT'
          Footers = <>
          ReadOnly = True
          Title.Caption = #26631#31614#29983#25104#26102#38388
          Visible = False
          Width = 182
        end
        item
          IsCurrency = False
          DisplayNullIfZero = False
          EditButtons = <>
          FieldName = 'uName'
          Footers = <>
          Title.Caption = #29983#25104#32773
          Visible = False
          Width = 94
        end>
    end
  end
  object psBarcode1: TpsBarcode
    Left = 730
    Top = -14
    Width = 110
    Height = 110
    Hint = 
      'Symbology  name : QR Code'#13#10'Enumerated name : bcQRCode'#13#10'Symbology' +
      ' type  : stMatrix'#13#10'Current value   : L056,MWRA2268,1500M,2013012' +
      '8001,A00'#13#10'Charset         : '#13#10
    Visible = False
    BackgroundColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = 'Arial'
    Font.Style = []
    BarcodeSymbology = bcQRCode
    LinesColor = clBlack
    BarCode = 'L056,MWRA2268,1500M,20130128001,A00'
    CaptionUpper.Visible = True
    CaptionUpper.Font.Charset = DEFAULT_CHARSET
    CaptionUpper.Font.Color = clWindowText
    CaptionUpper.Font.Height = -13
    CaptionUpper.Font.Name = 'Arial'
    CaptionUpper.Font.Style = []
    CaptionUpper.AutoSize = True
    CaptionUpper.Alignment = taLeftJustify
    CaptionUpper.AutoCaption = False
    CaptionUpper.MaxHeight = 25
    CaptionUpper.ParentFont = False
    CaptionUpper.LineSpacing = 0
    CaptionUpper.BgColor = clNone
    CaptionBottom.Visible = True
    CaptionBottom.Font.Charset = DEFAULT_CHARSET
    CaptionBottom.Font.Color = clWindowText
    CaptionBottom.Font.Height = -13
    CaptionBottom.Font.Name = 'Arial'
    CaptionBottom.Font.Style = []
    CaptionBottom.AutoSize = True
    CaptionBottom.Alignment = taLeftJustify
    CaptionBottom.AutoCaption = False
    CaptionBottom.MaxHeight = 25
    CaptionBottom.ParentFont = False
    CaptionBottom.LineSpacing = 0
    CaptionBottom.BgColor = clNone
    CaptionHuman.Visible = True
    CaptionHuman.Font.Charset = DEFAULT_CHARSET
    CaptionHuman.Font.Color = clWindowText
    CaptionHuman.Font.Height = -13
    CaptionHuman.Font.Name = 'Arial'
    CaptionHuman.Font.Style = []
    CaptionHuman.AutoSize = True
    CaptionHuman.Alignment = taLeftJustify
    CaptionHuman.AutoCaption = False
    CaptionHuman.MaxHeight = 25
    CaptionHuman.ParentFont = False
    CaptionHuman.LineSpacing = 0
    CaptionHuman.BgColor = clNone
    Params.GS1.FNC1InputType = gs1Separators
    Params.GS1.FNC1Type = fnc1None
    Params.PDF417.Mode = psPDF417Alphanumeric
    Params.PDF417.SecurityLevel = psPDF417AutoEC
    Params.PDF417.FileSize = 0
    Params.PDF417.Kind = pkStandard
    Params.PDF417.Checksum = 0
    Params.PDF417.UseMacro = False
    Params.DataMatrix.Encoding = dmeAutomatic
    Params.DataMatrix.Version = psDMAutomatic
    Params.QRCode.EccLevel = QrEccLevelM
    Params.QRCode.Mode = QrAutomatic
    Params.QRCode.MicroQR = False
    Params.QRCode.Version = 0
    Params.QRCode.Mask = 0
    Params.QRCode.Checksum = 0
    Options = [boTransparent, boSecurity, boAddOnUp, boEnableEditor, boAutoSize, boAutoHint, boAutoCheckDigit, boEditorAfterCreate]
    ErrorInfo.Mode = emDrawErrorString
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 407
    Top = 22
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = FDM.SC
    Left = 370
    Top = 21
  end
  object Timer1: TTimer
    Interval = 400
    OnTimer = Timer1Timer
    Left = 450
    Top = 23
  end
  object ClientDataSet2: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = FDM.SC
    Left = 370
    Top = 61
  end
  object frxReport1: TfrxReport
    Version = '4.9.32'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41690.430854120400000000
    ReportOptions.LastChange = 41722.649007523100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 584
    Top = 32
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 95.000000000000000000
      PaperHeight = 75.000000000000000000
      PaperSize = 256
      object Memo1: TfrxMemoView
        Align = baCenter
        Left = -5.669295000000012000
        Top = 7.559060000000000000
        Width = 370.393940000000000000
        Height = 34.015770000000000000
        ShowHint = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8 = (
          'OMIN')
        ParentFont = False
      end
      object Memo2: TfrxMemoView
        Left = 120.944960000000000000
        Top = 234.551330000000000000
        Width = 86.929190000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Memo.UTF8 = (
          '2014-02-21')
      end
      object Memo3: TfrxMemoView
        Left = 102.047310000000000000
        Top = 260.787570000000000000
        Width = 86.929190000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Memo.UTF8 = (
          '615251')
      end
      object Memo4: TfrxMemoView
        Left = 253.228510000000000000
        Top = 234.551330000000000000
        Width = 68.031540000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Memo.UTF8 = (
          '50')
      end
      object Memo5: TfrxMemoView
        Left = 94.488188980000000000
        Top = 114.606267480000000000
        Width = 105.826840000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        Memo.UTF8 = (
          '5000PCS')
        ParentFont = False
      end
      object Memo6: TfrxMemoView
        Left = 3.779530000000000000
        Top = 260.787570000000000000
        Width = 98.267780000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Memo.UTF8 = (
          'CUSTOM NO:  ')
        ParentFont = False
      end
      object Memo7: TfrxMemoView
        Left = 215.433210000000000000
        Top = 234.551330000000000000
        Width = 41.574830000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Memo.UTF8 = (
          'C/N:')
        ParentFont = False
      end
      object Picture1: TfrxPictureView
        Left = 279.685220000000000000
        Top = 139.842610000000000000
        Width = 71.811070000000000000
        Height = 60.472480000000000000
        ShowHint = False
        HightQuality = False
        Transparent = False
        TransparentColor = clWhite
      end
      object BarCode1: TfrxBarCodeView
        Left = 94.488250000000000000
        Top = 41.574830000000000000
        Width = 129.000000000000000000
        Height = 26.456692913385800000
        ShowHint = False
        BarType = bcCode39
        Rotation = 0
        ShowText = False
        Text = '12345678'
        WideBarRatio = 2.000000000000000000
        Zoom = 1.000000000000000000
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
      end
      object BarCode2: TfrxBarCodeView
        Left = 94.488250000000000000
        Top = 90.708720000000000000
        Width = 90.000000000000000000
        Height = 26.456692910000000000
        ShowHint = False
        BarType = bcCode39
        Expression = '50000'
        Rotation = 0
        ShowText = False
        Text = '50000'
        WideBarRatio = 2.000000000000000000
        Zoom = 1.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
      end
      object BarCode3: TfrxBarCodeView
        Left = 94.488250000000000000
        Top = 188.976500000000000000
        Width = 129.000000000000000000
        Height = 26.456692913385800000
        ShowHint = False
        BarType = bcCode39
        Rotation = 0
        ShowText = False
        Text = '12345678'
        WideBarRatio = 2.000000000000000000
        Zoom = 1.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
      end
      object Memo8: TfrxMemoView
        Left = 3.779530000000000000
        Top = 41.574830000000000000
        Width = 71.811070000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Memo.UTF8 = (
          'PART NO:')
        ParentFont = False
      end
      object Memo9: TfrxMemoView
        Left = 3.779530000000000000
        Top = 90.708661417322800000
        Width = 83.149660000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Memo.UTF8 = (
          'QUANTITY:')
        ParentFont = False
      end
      object Memo10: TfrxMemoView
        Left = 3.779530000000000000
        Top = 188.976500000000000000
        Width = 68.031540000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Memo.UTF8 = (
          'LOT NO:')
        ParentFont = False
      end
      object Memo11: TfrxMemoView
        Left = 3.779530000000000000
        Top = 234.551330000000000000
        Width = 120.944960000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Memo.UTF8 = (
          'SHIPPING DATE:  ')
        ParentFont = False
      end
      object Memo12: TfrxMemoView
        Left = 204.094620000000000000
        Top = 94.488250000000000000
        Width = 113.385900000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Memo.UTF8 = (
          'WIRE HARNESS')
        ParentFont = False
      end
      object Memo13: TfrxMemoView
        Left = 215.433210000000000000
        Top = 260.787570000000000000
        Width = 113.385900000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Memo.UTF8 = (
          'MADE IN CHINA')
        ParentFont = False
      end
      object Memo14: TfrxMemoView
        Left = 94.488188980000000000
        Top = 65.472440940000000000
        Width = 143.622140000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        Memo.UTF8 = (
          '1234567890')
        ParentFont = False
      end
      object Memo15: TfrxMemoView
        Left = 94.488188980000000000
        Top = 211.874150000000000000
        Width = 143.622140000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        Memo.UTF8 = (
          '1234567890')
        ParentFont = False
      end
      object BarCode4: TfrxBarCodeView
        Left = 94.488311020000000000
        Top = 139.842610000000000000
        Width = 129.000000000000000000
        Height = 26.456692910000000000
        ShowHint = False
        BarType = bcCode39
        Rotation = 0
        ShowText = False
        Text = '12345678'
        WideBarRatio = 2.000000000000000000
        Zoom = 1.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
      end
      object Memo16: TfrxMemoView
        Left = 94.488250000000000000
        Top = 163.740260000000000000
        Width = 143.622140000000000000
        Height = 26.456710000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        Memo.UTF8 = (
          '1234567890')
        ParentFont = False
      end
      object Memo17: TfrxMemoView
        Left = 3.779530000000000000
        Top = 139.842519685039000000
        Width = 71.811070000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Memo.UTF8 = (
          'REVISION:')
        ParentFont = False
      end
    end
  end
  object ClientDataSet12: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = FDM.SC
    Left = 306
    Top = 61
  end
  object ClientDataSet11: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = FDM.SC
    Left = 298
    Top = 21
  end
end
