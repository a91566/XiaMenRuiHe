object F_main: TF_main
  Left = 240
  Top = 98
  BorderStyle = bsSingle
  Caption = #21147#30495#36861#28335#31649#29702#31995#32479
  ClientHeight = 554
  ClientWidth = 1077
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #23435#20307
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object RzStatusBar1: TRzStatusBar
    Left = 0
    Top = 535
    Width = 1077
    Height = 19
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
    BorderWidth = 0
    Color = clSkyBlue
    FlatColor = clSkyBlue
    TabOrder = 3
    Visible = False
    DesignSize = (
      1077
      19)
    object RzStatusPane1: TRzStatusPane
      Left = 368
      Top = 0
      Width = 73
      Height = 19
      Align = alLeft
      Color = clSkyBlue
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = -15
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkIntervalOff = 1000
      BlinkIntervalOn = 1000
      Caption = #20351#29992#21333#20301
    end
    object RzStatusPane3: TRzStatusPane
      Left = 441
      Top = 0
      Width = 160
      Height = 19
      Align = alLeft
      Color = clSkyBlue
      Font.Charset = GB2312_CHARSET
      Font.Color = clTeal
      Font.Height = -15
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      AutoSize = True
      BlinkIntervalOff = 1000
      BlinkIntervalOn = 1000
      Caption = #21414#38376#30591#21644#30005#23376#26377#38480#20844#21496
    end
    object RzStatusPane4: TRzStatusPane
      Left = 181
      Top = 0
      Width = 55
      Height = 19
      Align = alLeft
      Color = clSkyBlue
      Font.Charset = GB2312_CHARSET
      Font.Color = clGreen
      Font.Height = -15
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Alignment = taCenter
      AutoSize = True
      BlinkIntervalOff = 1000
      BlinkIntervalOn = 1000
      Caption = #25805#20316#21592
    end
    object RzStatusPane2: TRzStatusPane
      Left = 0
      Top = 0
      Width = 181
      Height = 19
      Align = alLeft
      BlinkIntervalOff = 1000
      BlinkIntervalOn = 1000
    end
    object RzStatusPane5: TRzStatusPane
      Left = 236
      Top = 0
      Width = 132
      Height = 19
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      BlinkIntervalOff = 1000
      BlinkIntervalOn = 1000
    end
    object RzClockStatus2: TRzClockStatus
      Left = 857
      Top = -5
      Width = 215
      Height = 28
      FrameStyle = fsNone
      Anchors = [akRight, akBottom]
      Color = clSkyBlue
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Format = 'yyyy-mm-dd HH:mm:ss ddd'
      Alignment = taRightJustify
      AutoSize = True
      BlinkIntervalOff = 1000
      BlinkIntervalOn = 1000
    end
    object RzStatusPane6: TRzStatusPane
      Left = 601
      Top = 0
      Width = 40
      Height = 19
      Align = alLeft
      Color = clSkyBlue
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      AutoSize = True
      BlinkIntervalOff = 1000
      BlinkIntervalOn = 1000
    end
    object CheckBox1: TCheckBox
      Left = 4
      Top = 2
      Width = 162
      Height = 17
      Caption = #20801#35768#21516#19968#31383#20307#25171#24320#22810#20010
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object RzSizePanel1: TRzSizePanel
    Left = 0
    Top = 94
    Width = 188
    Height = 441
    AlignmentVertical = avTop
    BorderColor = clSkyBlue
    BorderHighlight = clSkyBlue
    BorderShadow = clSkyBlue
    Color = clSkyBlue
    Ctl3D = False
    FlatColor = clSkyBlue
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307'-PUA'
    Font.Style = []
    HotSpotHighlight = clWhite
    HotSpotSizePercent = 10
    HotSpotVisible = True
    LockBar = True
    Locked = True
    ParentCtl3D = False
    ParentFont = False
    SizeBarWidth = 7
    TabOrder = 0
    object RzGroupBar1: TRzGroupBar
      Left = 0
      Top = 0
      Width = 180
      Height = 441
      BorderColor = clSkyBlue
      BorderHighlight = clSkyBlue
      BorderShadow = clSkyBlue
      GroupBorderSize = 8
      FlatColor = clSkyBlue
      UseGradients = True
      Align = alClient
      BiDiMode = bdLeftToRight
      Color = 16776176
      Ctl3D = False
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307'-PUA'
      Font.Style = []
      ParentBiDiMode = False
      ParentColor = False
      ParentCtl3D = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      Visible = False
      object RzGroup0: TRzGroup
        BorderColor = clSkyBlue
        Color = clSkyBlue
        ColorDefault = False
        Items = <
          item
            Caption = #20379#24212#21830#20449#24687#23383#20856
            ImageIndex = 0
            OnClick = RzGroup0Items0Click
          end
          item
            Caption = #26448#26009#20449#24687#23383#20856
            ImageIndex = 1
            OnClick = RzGroup0Items1Click
          end
          item
            Caption = #25104#21697#20449#24687#23383#20856
            OnClick = RzGroup0Items2Click
          end
          item
            Caption = #21592#24037#20449#24687#23383#20856
            ImageIndex = 2
            OnClick = RzGroup0Items3Click
          end
          item
            Caption = #37096#38376#20449#24687#23383#20856
            ImageIndex = 30
            OnClick = RzGroup0Items4Click
          end
          item
            Caption = #22269#20869#21697#30058#20449#24687
            OnClick = RzGroup0Items5Click
          end
          item
            Caption = #20445#36136#26399#25209#37327#31649#29702
            OnClick = RzGroup0Items6Click
          end
          item
            Caption = #36135#26550#20449#24687#23383#20856' --'
            ImageIndex = 30
            OnClick = RzGroup0Items7Click
          end
          item
            Caption = #20179#24211#20449#24687#23383#20856' --'
            ImageIndex = 30
            OnClick = RzGroup0Items8Click
          end>
        ItemHotColor = clRed
        Opened = False
        OpenedHeight = 208
        SelectionColor = clWhite
        SelectionShadowColor = clLime
        SelectionFrameColor = clGreen
        ItemSelectionStyle = issCaption
        UseGradients = True
        Caption = #22522#30784#36164#26009
        ParentColor = False
        ParentShowHint = False
        ShowHint = True
      end
      object RzGroup1: TRzGroup
        BorderColor = clSkyBlue
        Color = clSkyBlue
        ColorDefault = False
        Items = <
          item
            Caption = #20179#24211#36827#36135#21333#26597#30475' '
            ImageIndex = 36
            OnClick = RzGroup1Items0Click
          end
          item
            Caption = #20179#24211#36827#36135#21333#20462#25913
            ImageIndex = 38
            OnClick = RzGroup1Items1Click
          end
          item
            Caption = #20179#24211#36864#36135#21333#26597#30475
            OnClick = RzGroup1Items2Click
          end
          item
            Caption = #20179#24211#36864#36135#21333#20462#25913
            OnClick = RzGroup1Items3Click
          end
          item
            Caption = #21407#26009#22833#25928#26399#31649#29702
            OnClick = RzGroup1Items4Click
          end
          item
            Caption = #20179#24211#36827#36135#21333#39564#35777
            OnClick = RzGroup1Items5Click
          end
          item
            Caption = #21407#26448#26009#36827#36135#21333#26126#32454#34920
            OnClick = RzGroup1Items6Click
          end
          item
            Caption = #21407#26448#26009#36827#36135#21333#27719#24635#34920
            OnClick = RzGroup1Items7Click
          end>
        ItemHotColor = clRed
        Opened = False
        OpenedHeight = 220
        SelectionColor = clWhite
        SelectionShadowColor = clLime
        SelectionFrameColor = clGreen
        UseGradients = True
        Caption = #37319#36141#31649#29702
        ParentColor = False
        ParentShowHint = False
        ShowHint = True
      end
      object RzGroup2: TRzGroup
        BorderColor = 16776176
        CaptionColor = clWhite
        CaptionColorDefault = False
        Color = 16776176
        ColorDefault = False
        Items = <
          item
            Caption = #29616#22330#25195#25551
            OnClick = RzGroup2Items0Click
          end
          item
            Caption = #21069#24037#25195#25551#26126#32454
            OnClick = RzGroup2Items1Click
          end
          item
            Caption = #21069#24037#31243#26410#23436#21333#25454#26597#35810
            OnClick = RzGroup2Items2Click
          end
          item
            Caption = #21069#24037#31243#21457#26009#26126#32454#34920
            OnClick = RzGroup2Items3Click
          end
          item
            Caption = #21069#24037#31243#21457#26009#27719#24635#34920
            OnClick = RzGroup2Items4Click
          end
          item
            Caption = #21069#24037#31243#21457#26009#26597#35810' --'
            OnClick = RzGroup2Items5Click
          end>
        Opened = False
        OpenedHeight = 164
        SelectionColor = clWhite
        SelectionShadowColor = clLime
        SelectionFrameColor = clGreen
        UseGradients = True
        Caption = #21069#24037#31243#20316#19994
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #23435#20307'-PUA'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object RzGroup3: TRzGroup
        BorderColor = clSkyBlue
        Color = clSkyBlue
        ColorDefault = False
        Items = <
          item
            Caption = 'ERP '#29983#20135#39046#26009#21333#19979#36733
            OnClick = RzGroup3Items0Click
          end
          item
            Caption = #29983#20135#39046#26009#21333#26597#30475
            ImageIndex = 24
            OnClick = RzGroup3Items1Click
          end
          item
            Caption = #29983#20135#39046#26009#21333#20462#25913
            OnClick = RzGroup3Items2Click
          end
          item
            Caption = #29983#20135#36864#24211#21333#26597#30475
            OnClick = RzGroup3Items3Click
          end
          item
            Caption = #29983#20135#36864#24211#21333#20462#25913
            OnClick = RzGroup3Items4Click
          end
          item
            Caption = #21518#24037#31243#26410#23436#21333#25454#26597#35810
            OnClick = RzGroup3Items5Click
          end
          item
            Caption = #21518#24037#31243#21457#26009#26126#32454#34920
            OnClick = RzGroup3Items6Click
          end
          item
            Caption = #38750#29983#20135#39046#26009#21333' --'
            OnClick = RzGroup3Items7Click
          end>
        ItemHotColor = clRed
        Opened = False
        OpenedHeight = 220
        SelectionColor = clWhite
        SelectionShadowColor = clLime
        SelectionFrameColor = clGreen
        UseGradients = True
        Caption = #21518#24037#31243#20316#19994
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #23435#20307'-PUA'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
      object RzGroup4: TRzGroup
        Items = <
          item
            Caption = #25104#21697#20837#24211#21333#26597#30475
            OnClick = RzGroup4Items0Click
          end
          item
            Caption = #25104#21697#20837#24211#21333#20462#25913
            OnClick = RzGroup4Items1Click
          end
          item
            Caption = #25104#21697#20986#24211#21333#26597#30475
            OnClick = RzGroup4Items2Click
          end
          item
            Caption = #25104#21697#20986#24211#21333#20462#25913
            OnClick = RzGroup4Items3Click
          end
          item
            Caption = #25104#21697#20837#24211#26126#32454#34920
            OnClick = RzGroup4Items4Click
          end
          item
            Caption = #25104#21697#20837#24211#27719#24635#34920
            OnClick = RzGroup4Items5Click
          end
          item
            Caption = #25104#21697#20986#24211#26126#32454#34920
            OnClick = RzGroup4Items6Click
          end
          item
            Caption = #25104#21697#20986#24211#27719#24635#34920
            OnClick = RzGroup4Items7Click
          end>
        Opened = False
        OpenedHeight = 188
        UseGradients = True
        Caption = #25104#21697#31649#29702
        ParentColor = False
      end
      object RzGroup5: TRzGroup
        BorderColor = clSkyBlue
        Color = clSkyBlue
        ColorDefault = False
        Items = <
          item
            Caption = #21407#26448#26009#24211#23384#26597#35810
            ImageIndex = 28
            OnClick = RzGroup5Items0Click
          end
          item
            Caption = #25104#21697#24211#23384#26597#35810
            ImageIndex = 28
            OnClick = RzGroup5Items1Click
          end
          item
            Caption = #36229#24453#21457#24211#23384
            OnClick = RzGroup5Items2Click
          end
          item
            Caption = #19981#33391#21697#31649#29702' --'
            OnClick = RzGroup5Items3Click
          end>
        ItemHotColor = clRed
        Opened = False
        OpenedHeight = 108
        SelectionColor = clWhite
        SelectionShadowColor = clLime
        SelectionFrameColor = clGreen
        UseGradients = True
        Caption = #24211#23384#31649#29702
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #23435#20307'-PUA'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
      object RzGroup6: TRzGroup
        Items = <
          item
            Caption = #21407#26448#26009#26631#31614#25171#21360
            OnClick = RzGroup6Items0Click
          end
          item
            Caption = #25104#21697#26631#31614#25171#21360
            OnClick = RzGroup6Items1Click
          end
          item
            Caption = #25104#21697#20986#36135#22823#26631#31614#25171#21360
            OnClick = RzGroup6Items2Click
          end
          item
            Caption = #24322#24120#25104#21697#26631#31614#25171#21360
            OnClick = RzGroup6Items3Click
          end>
        Opened = False
        OpenedHeight = 108
        UseGradients = True
        Caption = #26631#31614#31649#29702
        ParentColor = False
      end
      object RzGroup7: TRzGroup
        BorderColor = clSkyBlue
        Color = clSkyBlue
        ColorDefault = False
        Items = <
          item
            Caption = #21407#26448#26009#36827#36135#26126#32454#34920
            OnClick = RzGroup7Items0Click
          end
          item
            Caption = #21069#24037#31243#21457#26009#26126#32454#34920
            OnClick = RzGroup7Items1Click
          end
          item
            Caption = #21518#24037#31243#21457#26009#26126#32454#34920
            OnClick = RzGroup7Items2Click
          end>
        ItemHotColor = clWhite
        Opened = False
        OpenedHeight = 88
        SelectionColor = clWhite
        SelectionShadowColor = clLime
        SelectionFrameColor = clGreen
        UseGradients = True
        Caption = #25253#34920#31649#29702
        ParentColor = False
        ParentShowHint = False
        ShowHint = True
      end
      object RzGroup8: TRzGroup
        BorderColor = 16776176
        Color = 16776176
        ColorDefault = False
        Items = <
          item
            Caption = #25104#21697#36861#28335#26597#35810
            OnClick = RzGroup8Items0Click
          end>
        ItemHotColor = clRed
        Opened = False
        OpenedHeight = 48
        SelectionColor = clWhite
        SelectionShadowColor = clLime
        SelectionFrameColor = clGreen
        UseGradients = True
        Caption = #36136#37327#36861#28335
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #23435#20307'-PUA'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
      object RzGroup9: TRzGroup
        BorderColor = clSkyBlue
        CaptionColor = clWhite
        CaptionColorDefault = False
        Color = clSkyBlue
        ColorDefault = False
        Items = <
          item
            Caption = #20462#25913#30331#24405#23494#30721
            ImageIndex = 34
            OnClick = RzGroup9Items0Click
          end
          item
            Caption = #26435#38480#35774#32622
            OnClick = RzGroup9Items1Click
          end
          item
            Caption = #31995#32479#35774#32622
            OnClick = RzGroup9Items2Click
          end
          item
            Caption = #19979#36733#26368#26032#29256#26412
            OnClick = RzGroup9Items3Click
          end
          item
            Caption = #21457#24067#26032#29256#26412
            OnClick = RzGroup9Items4Click
          end
          item
            Caption = #29992#25143#22312#32447#24773#20917
            OnClick = RzGroup9Items5Click
          end>
        ItemHotColor = clWhite
        Opened = False
        OpenedHeight = 148
        SelectionColor = clWhite
        SelectionShadowColor = clLime
        SelectionFrameColor = clGreen
        UseGradients = True
        Caption = #31995#32479#31649#29702
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #23435#20307'-PUA'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
      object RzGroup99: TRzGroup
        BorderColor = 16776176
        CaptionColor = clWhite
        CaptionColorDefault = False
        Color = 16776176
        ColorDefault = False
        Items = <
          item
            Caption = #20851#20110
            OnClick = RzGroup99Items0Click
          end
          item
            Caption = #25925#38556#30003#21578'BUG'
            OnClick = RzGroup99Items1Click
          end>
        ItemHotColor = clRed
        Opened = False
        OpenedHeight = 68
        SelectionColor = clWhite
        SelectionShadowColor = clLime
        SelectionFrameColor = clGreen
        UseGradients = True
        Caption = #24110#21161
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #23435#20307'-PUA'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
    end
  end
  object RzPanel1: TRzPanel
    Left = 188
    Top = 94
    Width = 889
    Height = 441
    Align = alClient
    BorderOuter = fsNone
    BorderColor = clWhite
    BorderHighlight = clWhite
    BorderShadow = clWhite
    Color = clSkyBlue
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
    Visible = False
    object RzPageControl1: TRzPageControl
      Left = 0
      Top = 0
      Width = 889
      Height = 441
      ActivePage = TabSheet2
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
      TabIndex = 1
      TabOrder = 0
      TabStyle = tsRoundCorners
      TextColors.Unselected = clBlack
      FixedDimension = 21
      object TabSheet1: TRzTabSheet
        Color = clSkyBlue
        Caption = #31995#32479#21021#22987#21270
        DesignSize = (
          885
          413)
        object RzLabel3: TRzLabel
          Left = 17
          Top = 15
          Width = 864
          Height = 352
          Caption = 
            #27491#24335#21551#29992#21069#27880#24847#20107#39033#13#10'=====================================================' +
            '======================================================='#13#10#26381#21153#22120#31471#13#10#13 +
            #10'1'#12289#30830#20445#26381#21153#31243#24207#22312#36816#34892'     {ZSBDBServerForOracleOrSQLServer.exe} {scktsrvr' +
            '.exe}'#12290#13#10#13#10'2'#12289#37197#32622#22909#25968#25454#24211#36830#25509#25991#20214'  {server.ini}'#65292'[SYSTEM]'#19982'[OTHERSYSTEM]'#39033#12290' [O' +
            'THERSYSTEM]'#26159'ERP'#25968#25454#24211#36830#25509#20449#24687#12290#13#10#13#10'3'#12289#36335#30001#22120#24320#25918' {scktsrvr.exe}'#25152#38656#35201#30340#31471#21475#21495#12290#13#10#13#10'4'#12289#24517 +
            #35201#26102#21487#33021#38656#35201#20851#38381#38450#28779#22681#12290#13#10#13#10'================================================' +
            '============================================================'#13#10#23458#25143 +
            #31471#13#10#13#10'1'#12289#19982#26381#21153#22120#30456#36890'(Ping'#36890#21363#21487')'#12290#13#10#13#10'2'#12289#30830#20445#23433#35013#21253#23436#22909#27809#26377#20002#22833#25991#20214#12290#13#10#13#10'3'#12289#27880#20876#32452#20214'{midas.dll}' +
            #12290#13#10#13#10'4'#12289'360'#23433#20840#21355#22763#26377#26102#20250#25318#25130#65292#35831#20801#35768#20854#30456#24212#25805#20316#12290
          Font.Charset = GB2312_CHARSET
          Font.Color = clGreen
          Font.Height = -16
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          BlinkIntervalOff = 1000
          BlinkIntervalOn = 1000
        end
        object Image5: TImage
          Left = 0
          Top = 370
          Width = 559
          Height = 32
          Anchors = [akLeft, akBottom]
        end
      end
      object TabSheet2: TRzTabSheet
        Color = clSkyBlue
        Caption = #19994#21153#27969#31243
        DesignSize = (
          885
          413)
        object RzLabel12: TRzLabel
          Left = 190
          Top = 10
          Width = 64
          Height = 16
          Cursor = crHandPoint
          Hint = 'xdbb0403'
          Caption = #37319#36141#20837#24211
          Color = clPurple
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -16
          Font.Name = #23435#20307
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
          BlinkIntervalOff = 1000
          BlinkIntervalOn = 1000
          FlyByEnabled = True
          LightTextStyle = True
          TextStyle = tsRaised
        end
        object Image32: TImage
          Left = 205
          Top = 30
          Width = 32
          Height = 32
          Picture.Data = {
            0A544A504547496D6167652F050000FFD8FFE000104A46494600010101004800
            480000FFDB004300040303030303040303040504030405070504040507080606
            070606080A0808080808080A080A0A0B0A0A080D0D0E0E0D0D12121212121414
            1414141414141414FFDB0043010505050807080F0A0A0F120F0C0F1216151515
            1516161414141414141414141414141414141414141414141414141414141414
            14141414141414141414141414FFC0001108003C004203011100021101031101
            FFC4001C0001000300030101000000000000000000000506070203040801FFC4
            0036100001030302030603050900000000000001000203040511062112315113
            223241617181B2C114153452B416233335364273A1A2FFC4001B010003010003
            01000000000000000000000004060301020507FFC4002C110001040102030704
            030000000000000000010203041121311281B105142232334151234261B25291
            F1FFDA000C03010002110311003F00FA215413C1007455CDF67A79263FD81766
            A6570747AE1325724D46D6E7BC9D4AA79BDFB514DA91B3388CF98FF670B8756C
            1AB6D64B2C0FED230EEA92720F357276AE0EC10010010010042EAD9CD369DAF9
            C736307CC13151B9951056E3B86255317AEBCCADCEE555A40842B2D2A8B0DE25
            91951264F70C1FF550C6FD52F3C29A73E87A514EBD3AA1B9DA24ED286371F30A
            6664C38AC8172C3DEB2360800800800802BFAE3FA56E5FE36FCED4D52F59A277
            FD071845CF939591F3C88FDD39F87ACF7A5FD54695B1BA73FD54F562F7E5D50F
            A12C7FCBA2F65273F9CB2ADE44249623010010010071ED19F982E707057B5BBD
            9FB2B72C387F0DBF3B535493EB3452FF00A0E30ABA781FEC5589F3C8773969CF
            C3D5FBD2FEAA34AD8DD39FEAA7AB17BF2EA87D05637B3EEE8B71C94A4E9E32CA
            BF91092E36F50B0C1BE4E48390803C378A6AAACB6D453D14823AA7B7F76E2E7B
            0641CF097465AF687631969C85DE354476BB1D5C9A18E8B7DC232E8AA2EB7865
            54278278E4AA771B5FD0E36F5046C46E15542C8646E511082ED0BD76B4AAD55D
            3D83CD5D2B2569AEAAA98A785F0C915549DBB386418C80FCE1C39B5C37056BDD
            63F8C63E34126F6C59765157392AF75F049EC53475877222292434B3D187B9B0
            D48609780963B11BC4830E182376F92113C48EF8FF0007D25566C4FD2DF6F51B
            431970AA6B47202472C16BC6BF6A1D16E4DFC97FB27AD0DD4D7DAD82386F15F0
            4313B8A61190E0FE8D739F9C7C06FE8B0996BC2D5CB1AAA37425B12BF195536A
            A38E48A9D8C90F13C0DCA9491515742CE34544D4F42E868100406A3D38CBBB3E
            D54BC315D626E2394F8646F3ECA5C6E5BD0F369DC7982DD5B4E85DF811BF4596
            99C2E332AF6C8C2F8A68DD14F13B82685FE263BA1EB91B82362392AA86649132
            87CEACD27D59385C54EEBE07FB15B9AC3B90B02E46DC5A74F58AAAED52D86269
            036E377E507EA7C87C52962C3624C9A57A8E99D8436FB05869ACF4AC8E36F7B1
            B9F3CA96B365D2B8B2A951B0B7084D25874200200200AF6A7D3115F21EDA0E18
            6E9137114A7C2F6F3ECE4C73693F169DC7AB752DAC2EFC08DEA2CB2CC2EE61F7
            EA4A8A4926A7A98DD14D192D9227736BB1C8F5CF3046C42AC865491328444955
            D5DFC2E3A34CD86AAF154D8A16EDB71BF190C1F53D07C4FAE766C246D1D82B3A
            57610DF34F69FA6B2D2B238DBDFE64F3393CC93E64A95B1616552B2AD56C2DD0
            9C4B0E040040040040040151D79A7EDF74B71AB983A3AB8785AD9E3C071639C0
            163B883811BE796C7927E858746FC26C79F7EB3246657743D5A52C96FB5D2065
            247C21BE67727D49EA5676A773D7534AB0358DD0B225070200200200FFD9}
          Stretch = True
        end
        object RzLabel1: TRzLabel
          Left = 190
          Top = 66
          Width = 64
          Height = 16
          Cursor = crHandPoint
          Hint = 'xdbb0403'
          Caption = #39046#26009#20986#24211
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -16
          Font.Name = #26032#23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = True
          BlinkIntervalOff = 1000
          BlinkIntervalOn = 1000
          TextStyle = tsRaised
        end
        object RzLabel2: TRzLabel
          Left = 190
          Top = 122
          Width = 64
          Height = 16
          Cursor = crHandPoint
          Hint = 'xdbb0403'
          Caption = #25104#21697#20837#24211
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -16
          Font.Name = #26032#23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = True
          BlinkIntervalOff = 1000
          BlinkIntervalOn = 1000
          TextStyle = tsRaised
        end
        object RzLabel5: TRzLabel
          Left = 190
          Top = 175
          Width = 64
          Height = 16
          Cursor = crHandPoint
          Hint = 'xdbb0403'
          Caption = #25104#21697#20986#24211
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -16
          Font.Name = #26032#23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = True
          BlinkIntervalOff = 1000
          BlinkIntervalOn = 1000
          TextStyle = tsRaised
        end
        object RzLabel4: TRzLabel
          Left = 175
          Top = 232
          Width = 96
          Height = 16
          Cursor = crHandPoint
          Hint = 'xdbb0403'
          Caption = #25104#21697#36861#28335#31649#29702
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -16
          Font.Name = #26032#23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = True
          Visible = False
          BlinkIntervalOff = 1000
          BlinkIntervalOn = 1000
          TextStyle = tsRaised
        end
        object RzLabel6: TRzLabel
          Left = 49
          Top = 177
          Width = 96
          Height = 16
          Cursor = crHandPoint
          Hint = 'xdbb0403'
          Caption = #30452#25509#39564#25910#20837#24211
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -16
          Font.Name = #26032#23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = True
          Visible = False
          BlinkIntervalOff = 1000
          BlinkIntervalOn = 1000
          TextStyle = tsRaised
        end
        object Image17: TImage
          Left = 146
          Top = 169
          Width = 32
          Height = 32
          Picture.Data = {
            0A544A504547496D61676511050000FFD8FFE000104A46494600010101004800
            480000FFDB004300040303030303040303040504030405070504040507080606
            070606080A0808080808080A080A0A0B0A0A080D0D0E0E0D0D12121212121414
            1414141414141414FFDB0043010505050807080F0A0A0F120F0C0F1216151515
            1516161414141414141414141414141414141414141414141414141414141414
            14141414141414141414141414FFC0001108003C004203011100021101031101
            FFC4001C0001000202030100000000000000000000000507010602030408FFC4
            003C100001030301050307090900000000000001000203040511120613213141
            155261071617225581D1142426519394C1D3F0446365717283B2B3C3FFC4001A
            010100030101010000000000000000000000040506010302FFC4003311000103
            0202070507050000000000000000010204031105121331415271A1E114153291
            F0162122335181C106234361D1FFDA000C03010002110311003F00FA216A0CF0
            40100406B177DB4A2B3DE1B699A191E772CA895ECC92D89CE7B4BC3434E74168
            D4339C1E00F152E944754666422D6974E93911CB6B9B1C334551132781ED9219
            1A1F1C8C396B9A788208E7951552C4945B9D8B874200802008020080A9F6B07D
            3979FE18CFF73D69709F94BC4C57EA9F134F6582FF00258A5D12664B448ED534
            4389849E72C63BBD5ED1FD438E41F89F033FC4DD67D6098DFF00155FB2FAF4BC
            75D9314B14F132785ED92191A1CC7B4E5A5A78820859E54B1B245B9CD70E8407
            9EAAADB4ACD6E195F6D6663CDEF46A1ACD7EDDC1459F99BA4C7EF00FC14EA787
            39FB4ADAD8BD3A645FA518FD9527DB33E0A47733F7887ED151FA7AF21E9463F6
            549F6CCF827733F78EFB4547E9EBC8D5EF37BA5BBDC45DD914D4F59BA34F242E
            2C7C5BA07531C1E0EAD592EC8D38E5C559C28CFA08AD5B58A1C6265397955B7B
            A1E3ED023883C54EB145A327B6636B7B166DC4F975A6476648C713038F39231D
            DEF347F31D42A89F033FC4DD66B307C5D5BFB757CCB5629639E364D0BC491480
            398F69C820F10410B3AA9635E8B739AE1D21EF8ED3012A447D64495A8A7B692B
            431CEE2B4914C9CCA775354ED41E2AC0ADD018ED5F0720D00ED6F077EBDE8340
            3B5BC1DFAF7A0D019176C1C8D408E452C340595E4BF686E52D5BAD5BB73ED9A0
            BC93C04321C1019E0FC925BD39F55438AC762266DA69F079153C0EF7A16D2A13
            4446DD69CD4445A067DF85ED49D653C2B36E857179D979A6738FC8B7BFDF2DFF
            0099571465226DE5D4A39111CBB39F4207CCF93D927EF87F214AED69BDCBA90B
            B13B779F41E67C9EC93F7C3F909DAD37B9751D89DBBCFA1ADDEE80D0D60A375B
            DD4988C49BE351BE0FD448D21BA18469D3CFC54E8EECCDCD9AFF006B7E48B269
            68ADB1DF823772BD889989AB0ECD555DEA9B144DFAB53B190C07F13D07BCF8C6
            912529A12E2C7755717AECDECE5258A9191C4CC3F1C4F5C9E649EA565A4C95AA
            A6BE2C64A4D279452598C21C31A187980971631BA8FBA176E2C3751F7425C58A
            73CA7C2D37E8748FD987F9B969708F94BC4C7E3CB6AC9C0D7AC960A8BB55B618
            5BC01F5DF8C86FC4FD414D915DB49B752BE2467567590BB367F67E96CD4CD8E3
            67ADD4F3393CC93D4ACAC892B554DAC58ADA2DB136A31302008020080202B4DB
            1D9CBADE76B28E5870DB53696464EEE05C65CFA9CFA0C92AFE04AA74A33AFE3B
            FBB86D33D89415AF56FF00D7FA6E562B0D2D9E99B1C6D1ABA9EB9553264BAAB8
            B3870DB41B64265462704010040100401018D2339C71438650E840100407FFD9}
          Stretch = True
          Visible = False
        end
        object Image18: TImage
          Left = 313
          Top = 171
          Width = 45
          Height = 32
          Picture.Data = {
            0A544A504547496D616765EA040000FFD8FFE000104A46494600010101004800
            480000FFDB004300040303030303040303040504030405070504040507080606
            070606080A0808080808080A080A0A0B0A0A080D0D0E0E0D0D12121212121414
            1414141414141414FFDB0043010505050807080F0A0A0F120F0C0F1216151515
            1516161414141414141414141414141414141414141414141414141414141414
            14141414141414141414141414FFC0001108003C004203011100021101031101
            FFC4001B00010003010101010000000000000000000001060705040308FFC400
            4210000102040303050A0C070000000000000100020304051106122113316115
            22415155071617324252537181C1142325263443449394D1D3F0626384A1B2B3
            C3FFC4001B01010003010101010000000000000000000004050601030207FFC4
            0032110001030202070605050000000000000000010203041105F01213314152
            A1E114152151619116323342B10622247181FFDA000C03010002110311003F00
            FD10B5067820209B6A77202AF0B1CD3662B9028F2EC73D932E7325E6B5CB10C3
            639EF7334B160CA05F30B93CD046AA5AD1BD23D352236B23749A08BFB8B4A884
            B0802008020080826DA9DC80CF712624E572F909075A9239B1A337ED246F6B4F
            A2EB3E5EEF16F7BCA0A0FB9F9CF2FEF665B1AC69224D5C7F3673D36D7A9E3E76
            D00F54498FF41561887D052A3F4E3956A555769B22C99FA00401004010104DB5
            3B9019A62DC60CA839F4CA7C4F9345DB3119A7E907A58D23EABCE3E56E1A5EF7
            B4187FDEFCF5FC199C5F17D04D5C7B739CF8D579438857A896314E62AADD769F
            690A9CACA546055261B1A2C6930E32D061E40D73E2598768E7105A0309B581D6
            CA355C2E959A2DDFB4B5C227652C8AF7797816EF0A30FB2A27DF33F254FDCCFE
            2349F1143E59F61E1461F6544FBE67E49DCCFE21F1143E59F63DF23DD020CE90
            0C8BA1DFF98D3EE5E32618E66F24C38CC52167939F64E37335B97FBA80F8F44B
            48E547EC3D8BCCF5339EEA15EA8C840854F96639B23301C2663337B8E9961706
            BB5BF5EE56F85C0C7AE92ED4CDCA6C5AA2463745BBCC85D5624DCE6BFA969110
            C82C2ABE2A472B7077EFDABA7350395B83BF7ED41A81CABC1C83504F2A0E2873
            505870FCF87BDBAA87524EA58ACA6C3879F9E10F52CDD4ED359469E0589432C0
            E5D6A8B2B59957CBCC3038385B55ED0CCB1ADD0F09E1491B6530BC4D846668D3
            4458BA0B8FC5C4EBFE1771EA3D3EBDFA9A5AB4950C8D6523A15F42B5B0534AFD
            23D94B9531E7E0CA89274EEDC96E91B61B3B02ECE798FCDBAD65E72AD98AB7B5
            BD2F724D331245B6FDC5ABBCF89D927F167F4157F6B4E2E5D499D89DC3CFA0EF
            3E27649FC61FD04ED69C5CBA8EC4EE1E7D0EBD230AC686E07E01B2FEA0BBFE4D
            51E6AA4E2E5D493052393773E868D469374B3002DCBEDBFB82A799F72F606689
            DA51C94101CDABD1E5AAD2CF811D81D985B55ED0CCB1ADD08F3C0D95B65314C4
            9862628F327302E80E3CC89EE771E3D3EB5A9A4AA4953D4C5D7D1BA077A1F5C0
            9000C512771E93FC0AF9C47E829DC217F92DFF007F06EBB287E68593B9B9B0D9
            43F3425CED890C60DCD0971626C1701287420080E7556932D54977418CC0ECC2
            DAAF686658D6E846A8A76CADB299ED2B0A552938CE4A62173A90C831846CDE30
            884F3083D3A1B7B15E4D5B1CB4AE45F9EE9EDBCA3A4C37533A2E779A9ACE9A40
            8742008020080200808CA2F7B6A870943A10040100407FFFD9}
          Stretch = True
          Visible = False
        end
        object Image2: TImage
          Left = 205
          Top = 87
          Width = 32
          Height = 32
          Picture.Data = {
            0A544A504547496D6167652F050000FFD8FFE000104A46494600010101004800
            480000FFDB004300040303030303040303040504030405070504040507080606
            070606080A0808080808080A080A0A0B0A0A080D0D0E0E0D0D12121212121414
            1414141414141414FFDB0043010505050807080F0A0A0F120F0C0F1216151515
            1516161414141414141414141414141414141414141414141414141414141414
            14141414141414141414141414FFC0001108003C004203011100021101031101
            FFC4001C0001000300030101000000000000000000000506070203040801FFC4
            0036100001030302030603050900000000000001000203040511062112315113
            223241617181B2C114153452B416233335364273A1A2FFC4001B010003010003
            01000000000000000000000004060301020507FFC4002C110001040102030704
            030000000000000000010203041121311281B105142232334151234261B25291
            F1FFDA000C03010002110311003F00FA215413C1007455CDF67A79263FD81766
            A6570747AE1325724D46D6E7BC9D4AA79BDFB514DA91B3388CF98FF670B8756C
            1AB6D64B2C0FED230EEA92720F357276AE0EC10010010010042EAD9CD369DAF9
            C736307CC13151B9951056E3B86255317AEBCCADCEE555A40842B2D2A8B0DE25
            91951264F70C1FF550C6FD52F3C29A73E87A514EBD3AA1B9DA24ED286371F30A
            6664C38AC8172C3DEB2360800800800802BFAE3FA56E5FE36FCED4D52F59A277
            FD071845CF939591F3C88FDD39F87ACF7A5FD54695B1BA73FD54F562F7E5D50F
            A12C7FCBA2F65273F9CB2ADE44249623010010010071ED19F982E707057B5BBD
            9FB2B72C387F0DBF3B535493EB3452FF00A0E30ABA781FEC5589F3C8773969CF
            C3D5FBD2FEAA34AD8DD39FEAA7AB17BF2EA87D05637B3EEE8B71C94A4E9E32CA
            BF91092E36F50B0C1BE4E48390803C378A6AAACB6D453D14823AA7B7F76E2E7B
            0641CF097465AF687631969C85DE354476BB1D5C9A18E8B7DC232E8AA2EB7865
            54278278E4AA771B5FD0E36F5046C46E15542C8646E511082ED0BD76B4AAD55D
            3D83CD5D2B2569AEAAA98A785F0C915549DBB386418C80FCE1C39B5C37056BDD
            63F8C63E34126F6C59765157392AF75F049EC53475877222292434B3D187B9B0
            D48609780963B11BC4830E182376F92113C48EF8FF0007D25566C4FD2DF6F51B
            431970AA6B47202472C16BC6BF6A1D16E4DFC97FB27AD0DD4D7DAD82386F15F0
            4313B8A61190E0FE8D739F9C7C06FE8B0996BC2D5CB1AAA37425B12BF195536A
            A38E48A9D8C90F13C0DCA9491515742CE34544D4F42E868100406A3D38CBBB3E
            D54BC315D626E2394F8646F3ECA5C6E5BD0F369DC7982DD5B4E85DF811BF4596
            99C2E332AF6C8C2F8A68DD14F13B82685FE263BA1EB91B82362392AA86649132
            87CEACD27D59385C54EEBE07FB15B9AC3B90B02E46DC5A74F58AAAED52D86269
            036E377E507EA7C87C52962C3624C9A57A8E99D8436FB05869ACF4AC8E36F7B1
            B9F3CA96B365D2B8B2A951B0B7084D25874200200200AF6A7D3115F21EDA0E18
            6E9137114A7C2F6F3ECE4C73693F169DC7AB752DAC2EFC08DEA2CB2CC2EE61F7
            EA4A8A4926A7A98DD14D192D9227736BB1C8F5CF3046C42AC865491328444955
            D5DFC2E3A34CD86AAF154D8A16EDB71BF190C1F53D07C4FAE766C246D1D82B3A
            57610DF34F69FA6B2D2B238DBDFE64F3393CC93E64A95B1616552B2AD56C2DD0
            9C4B0E040040040040040151D79A7EDF74B71AB983A3AB8785AD9E3C071639C0
            163B883811BE796C7927E858746FC26C79F7EB3246657743D5A52C96FB5D2065
            247C21BE67727D49EA5676A773D7534AB0358DD0B225070200200200FFD9}
          Stretch = True
        end
        object Image3: TImage
          Left = 205
          Top = 141
          Width = 32
          Height = 32
          Picture.Data = {
            0A544A504547496D6167652F050000FFD8FFE000104A46494600010101004800
            480000FFDB004300040303030303040303040504030405070504040507080606
            070606080A0808080808080A080A0A0B0A0A080D0D0E0E0D0D12121212121414
            1414141414141414FFDB0043010505050807080F0A0A0F120F0C0F1216151515
            1516161414141414141414141414141414141414141414141414141414141414
            14141414141414141414141414FFC0001108003C004203011100021101031101
            FFC4001C0001000300030101000000000000000000000506070203040801FFC4
            0036100001030302030603050900000000000001000203040511062112315113
            223241617181B2C114153452B416233335364273A1A2FFC4001B010003010003
            01000000000000000000000004060301020507FFC4002C110001040102030704
            030000000000000000010203041121311281B105142232334151234261B25291
            F1FFDA000C03010002110311003F00FA215413C1007455CDF67A79263FD81766
            A6570747AE1325724D46D6E7BC9D4AA79BDFB514DA91B3388CF98FF670B8756C
            1AB6D64B2C0FED230EEA92720F357276AE0EC10010010010042EAD9CD369DAF9
            C736307CC13151B9951056E3B86255317AEBCCADCEE555A40842B2D2A8B0DE25
            91951264F70C1FF550C6FD52F3C29A73E87A514EBD3AA1B9DA24ED286371F30A
            6664C38AC8172C3DEB2360800800800802BFAE3FA56E5FE36FCED4D52F59A277
            FD071845CF939591F3C88FDD39F87ACF7A5FD54695B1BA73FD54F562F7E5D50F
            A12C7FCBA2F65273F9CB2ADE44249623010010010071ED19F982E707057B5BBD
            9FB2B72C387F0DBF3B535493EB3452FF00A0E30ABA781FEC5589F3C8773969CF
            C3D5FBD2FEAA34AD8DD39FEAA7AB17BF2EA87D05637B3EEE8B71C94A4E9E32CA
            BF91092E36F50B0C1BE4E48390803C378A6AAACB6D453D14823AA7B7F76E2E7B
            0641CF097465AF687631969C85DE354476BB1D5C9A18E8B7DC232E8AA2EB7865
            54278278E4AA771B5FD0E36F5046C46E15542C8646E511082ED0BD76B4AAD55D
            3D83CD5D2B2569AEAAA98A785F0C915549DBB386418C80FCE1C39B5C37056BDD
            63F8C63E34126F6C59765157392AF75F049EC53475877222292434B3D187B9B0
            D48609780963B11BC4830E182376F92113C48EF8FF0007D25566C4FD2DF6F51B
            431970AA6B47202472C16BC6BF6A1D16E4DFC97FB27AD0DD4D7DAD82386F15F0
            4313B8A61190E0FE8D739F9C7C06FE8B0996BC2D5CB1AAA37425B12BF195536A
            A38E48A9D8C90F13C0DCA9491515742CE34544D4F42E868100406A3D38CBBB3E
            D54BC315D626E2394F8646F3ECA5C6E5BD0F369DC7982DD5B4E85DF811BF4596
            99C2E332AF6C8C2F8A68DD14F13B82685FE263BA1EB91B82362392AA86649132
            87CEACD27D59385C54EEBE07FB15B9AC3B90B02E46DC5A74F58AAAED52D86269
            036E377E507EA7C87C52962C3624C9A57A8E99D8436FB05869ACF4AC8E36F7B1
            B9F3CA96B365D2B8B2A951B0B7084D25874200200200AF6A7D3115F21EDA0E18
            6E9137114A7C2F6F3ECE4C73693F169DC7AB752DAC2EFC08DEA2CB2CC2EE61F7
            EA4A8A4926A7A98DD14D192D9227736BB1C8F5CF3046C42AC865491328444955
            D5DFC2E3A34CD86AAF154D8A16EDB71BF190C1F53D07C4FAE766C246D1D82B3A
            57610DF34F69FA6B2D2B238DBDFE64F3393CC93E64A95B1616552B2AD56C2DD0
            9C4B0E040040040040040151D79A7EDF74B71AB983A3AB8785AD9E3C071639C0
            163B883811BE796C7927E858746FC26C79F7EB3246657743D5A52C96FB5D2065
            247C21BE67727D49EA5676A773D7534AB0358DD0B225070200200200FFD9}
          Stretch = True
        end
        object Image4: TImage
          Left = 205
          Top = 197
          Width = 32
          Height = 32
          Picture.Data = {
            0A544A504547496D6167652F050000FFD8FFE000104A46494600010101004800
            480000FFDB004300040303030303040303040504030405070504040507080606
            070606080A0808080808080A080A0A0B0A0A080D0D0E0E0D0D12121212121414
            1414141414141414FFDB0043010505050807080F0A0A0F120F0C0F1216151515
            1516161414141414141414141414141414141414141414141414141414141414
            14141414141414141414141414FFC0001108003C004203011100021101031101
            FFC4001C0001000300030101000000000000000000000506070203040801FFC4
            0036100001030302030603050900000000000001000203040511062112315113
            223241617181B2C114153452B416233335364273A1A2FFC4001B010003010003
            01000000000000000000000004060301020507FFC4002C110001040102030704
            030000000000000000010203041121311281B105142232334151234261B25291
            F1FFDA000C03010002110311003F00FA215413C1007455CDF67A79263FD81766
            A6570747AE1325724D46D6E7BC9D4AA79BDFB514DA91B3388CF98FF670B8756C
            1AB6D64B2C0FED230EEA92720F357276AE0EC10010010010042EAD9CD369DAF9
            C736307CC13151B9951056E3B86255317AEBCCADCEE555A40842B2D2A8B0DE25
            91951264F70C1FF550C6FD52F3C29A73E87A514EBD3AA1B9DA24ED286371F30A
            6664C38AC8172C3DEB2360800800800802BFAE3FA56E5FE36FCED4D52F59A277
            FD071845CF939591F3C88FDD39F87ACF7A5FD54695B1BA73FD54F562F7E5D50F
            A12C7FCBA2F65273F9CB2ADE44249623010010010071ED19F982E707057B5BBD
            9FB2B72C387F0DBF3B535493EB3452FF00A0E30ABA781FEC5589F3C8773969CF
            C3D5FBD2FEAA34AD8DD39FEAA7AB17BF2EA87D05637B3EEE8B71C94A4E9E32CA
            BF91092E36F50B0C1BE4E48390803C378A6AAACB6D453D14823AA7B7F76E2E7B
            0641CF097465AF687631969C85DE354476BB1D5C9A18E8B7DC232E8AA2EB7865
            54278278E4AA771B5FD0E36F5046C46E15542C8646E511082ED0BD76B4AAD55D
            3D83CD5D2B2569AEAAA98A785F0C915549DBB386418C80FCE1C39B5C37056BDD
            63F8C63E34126F6C59765157392AF75F049EC53475877222292434B3D187B9B0
            D48609780963B11BC4830E182376F92113C48EF8FF0007D25566C4FD2DF6F51B
            431970AA6B47202472C16BC6BF6A1D16E4DFC97FB27AD0DD4D7DAD82386F15F0
            4313B8A61190E0FE8D739F9C7C06FE8B0996BC2D5CB1AAA37425B12BF195536A
            A38E48A9D8C90F13C0DCA9491515742CE34544D4F42E868100406A3D38CBBB3E
            D54BC315D626E2394F8646F3ECA5C6E5BD0F369DC7982DD5B4E85DF811BF4596
            99C2E332AF6C8C2F8A68DD14F13B82685FE263BA1EB91B82362392AA86649132
            87CEACD27D59385C54EEBE07FB15B9AC3B90B02E46DC5A74F58AAAED52D86269
            036E377E507EA7C87C52962C3624C9A57A8E99D8436FB05869ACF4AC8E36F7B1
            B9F3CA96B365D2B8B2A951B0B7084D25874200200200AF6A7D3115F21EDA0E18
            6E9137114A7C2F6F3ECE4C73693F169DC7AB752DAC2EFC08DEA2CB2CC2EE61F7
            EA4A8A4926A7A98DD14D192D9227736BB1C8F5CF3046C42AC865491328444955
            D5DFC2E3A34CD86AAF154D8A16EDB71BF190C1F53D07C4FAE766C246D1D82B3A
            57610DF34F69FA6B2D2B238DBDFE64F3393CC93E64A95B1616552B2AD56C2DD0
            9C4B0E040040040040040151D79A7EDF74B71AB983A3AB8785AD9E3C071639C0
            163B883811BE796C7927E858746FC26C79F7EB3246657743D5A52C96FB5D2065
            247C21BE67727D49EA5676A773D7534AB0358DD0B225070200200200FFD9}
          Stretch = True
        end
        object Image6: TImage
          Left = 0
          Top = 370
          Width = 559
          Height = 32
          Anchors = [akLeft, akBottom]
        end
        object RzLabel7: TRzLabel
          Left = 81
          Top = 122
          Width = 64
          Height = 16
          Cursor = crHandPoint
          Hint = 'xdbb0403'
          Caption = #25171#21360#26631#31614
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -16
          Font.Name = #26032#23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = True
          Visible = False
          BlinkIntervalOff = 1000
          BlinkIntervalOn = 1000
          TextStyle = tsRaised
        end
        object Image7: TImage
          Left = 154
          Top = 116
          Width = 32
          Height = 32
          Picture.Data = {
            0A544A504547496D61676511050000FFD8FFE000104A46494600010101004800
            480000FFDB004300040303030303040303040504030405070504040507080606
            070606080A0808080808080A080A0A0B0A0A080D0D0E0E0D0D12121212121414
            1414141414141414FFDB0043010505050807080F0A0A0F120F0C0F1216151515
            1516161414141414141414141414141414141414141414141414141414141414
            14141414141414141414141414FFC0001108003C004203011100021101031101
            FFC4001C0001000202030100000000000000000000000507010602030408FFC4
            003C100001030301050307090900000000000001000203040511120613213141
            155261071617225581D1142426519394C1D3F0446365717283B2B3C3FFC4001A
            010100030101010000000000000000000000040506010302FFC4003311000103
            0202070507050000000000000000010204031105121331415271A1E114153291
            F0162122335181C106234361D1FFDA000C03010002110311003F00FA216A0CF0
            40100406B177DB4A2B3DE1B699A191E772CA895ECC92D89CE7B4BC3434E74168
            D4339C1E00F152E944754666422D6974E93911CB6B9B1C334551132781ED9219
            1A1F1C8C396B9A788208E7951552C4945B9D8B874200802008020080A9F6B07D
            3979FE18CFF73D69709F94BC4C57EA9F134F6582FF00258A5D12664B448ED534
            4389849E72C63BBD5ED1FD438E41F89F033FC4DD67D6098DFF00155FB2FAF4BC
            75D9314B14F132785ED92191A1CC7B4E5A5A78820859E54B1B245B9CD70E8407
            9EAAADB4ACD6E195F6D6663CDEF46A1ACD7EDDC1459F99BA4C7EF00FC14EA787
            39FB4ADAD8BD3A645FA518FD9527DB33E0A47733F7887ED151FA7AF21E9463F6
            549F6CCF827733F78EFB4547E9EBC8D5EF37BA5BBDC45DD914D4F59BA34F242E
            2C7C5BA07531C1E0EAD592EC8D38E5C559C28CFA08AD5B58A1C6265397955B7B
            A1E3ED023883C54EB145A327B6636B7B166DC4F975A6476648C713038F39231D
            DEF347F31D42A89F033FC4DD66B307C5D5BFB757CCB5629639E364D0BC491480
            398F69C820F10410B3AA9635E8B739AE1D21EF8ED3012A447D64495A8A7B692B
            431CEE2B4914C9CCA775354ED41E2AC0ADD018ED5F0720D00ED6F077EBDE8340
            3B5BC1DFAF7A0D019176C1C8D408E452C340595E4BF686E52D5BAD5BB73ED9A0
            BC93C04321C1019E0FC925BD39F55438AC762266DA69F079153C0EF7A16D2A13
            4446DD69CD4445A067DF85ED49D653C2B36E857179D979A6738FC8B7BFDF2DFF
            0099571465226DE5D4A39111CBB39F4207CCF93D927EF87F214AED69BDCBA90B
            B13B779F41E67C9EC93F7C3F909DAD37B9751D89DBBCFA1ADDEE80D0D60A375B
            DD4988C49BE351BE0FD448D21BA18469D3CFC54E8EECCDCD9AFF006B7E48B269
            68ADB1DF823772BD889989AB0ECD555DEA9B144DFAB53B190C07F13D07BCF8C6
            912529A12E2C7755717AECDECE5258A9191C4CC3F1C4F5C9E649EA565A4C95AA
            A6BE2C64A4D279452598C21C31A187980971631BA8FBA176E2C3751F7425C58A
            73CA7C2D37E8748FD987F9B969708F94BC4C7E3CB6AC9C0D7AC960A8BB55B618
            5BC01F5DF8C86FC4FD414D915DB49B752BE2467567590BB367F67E96CD4CD8E3
            67ADD4F3393CC93D4ACAC892B554DAC58ADA2DB136A31302008020080202B4DB
            1D9CBADE76B28E5870DB53696464EEE05C65CFA9CFA0C92AFE04AA74A33AFE3B
            FBB86D33D89415AF56FF00D7FA6E562B0D2D9E99B1C6D1ABA9EB9553264BAAB8
            B3870DB41B64265462704010040100401018D2339C71438650E840100407FFD9}
          Stretch = True
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1077
    Height = 94
    Align = alTop
    BevelOuter = bvNone
    Color = 16776176
    TabOrder = 1
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 1077
      Height = 94
      Align = alClient
    end
    object RzGroupBox1: TRzGroupBox
      Left = 360
      Top = 54
      Width = 583
      Height = 26
      BorderColor = 16776176
      BorderSides = []
      Color = clBlack
      Ctl3D = True
      FlatColor = clTeal
      GroupStyle = gsCustom
      ParentCtl3D = False
      TabOrder = 0
      Transparent = True
      ThemeAware = False
      Visible = False
      object Label1: TLabel
        Left = 10
        Top = 7
        Width = 57
        Height = 17
        Cursor = crHandPoint
        AutoSize = False
        Caption = #20008#33756#21333#20008
        Font.Charset = GB2312_CHARSET
        Font.Color = clGreen
        Font.Height = -16
        Font.Name = #23435#20307'-PUA'
        Font.Style = []
        ParentFont = False
        Transparent = True
        OnClick = Label1Click
      end
      object Label4: TLabel
        Left = 277
        Top = 7
        Width = 83
        Height = 17
        Cursor = crHandPoint
        AutoSize = False
        Caption = #20008#37325#26032#30331#24405#20008
        Font.Charset = GB2312_CHARSET
        Font.Color = clGreen
        Font.Height = -16
        Font.Name = #23435#20307'-PUA'
        Font.Style = []
        ParentFont = False
        Transparent = True
        OnClick = Label4Click
      end
      object Label3: TLabel
        Left = 463
        Top = 7
        Width = 57
        Height = 17
        Cursor = crHandPoint
        AutoSize = False
        Caption = #20008#36864#20986#20008
        Font.Charset = GB2312_CHARSET
        Font.Color = clGreen
        Font.Height = -16
        Font.Name = #23435#20307'-PUA'
        Font.Style = []
        ParentFont = False
        Transparent = True
        OnClick = Label3Click
      end
      object Label2: TLabel
        Left = 169
        Top = 7
        Width = 88
        Height = 17
        Cursor = crHandPoint
        AutoSize = False
        Caption = #20008#25171#21360#26631#31614#20008
        Font.Charset = GB2312_CHARSET
        Font.Color = clGreen
        Font.Height = -16
        Font.Name = #23435#20307'-PUA'
        Font.Style = []
        ParentFont = False
        Transparent = True
        OnClick = Label2Click
      end
      object Label5: TLabel
        Left = 89
        Top = 7
        Width = 57
        Height = 17
        Cursor = crHandPoint
        AutoSize = False
        Caption = #20008#20027#39029#20008
        Font.Charset = GB2312_CHARSET
        Font.Color = clGreen
        Font.Height = -16
        Font.Name = #23435#20307'-PUA'
        Font.Style = []
        ParentFont = False
        Transparent = True
        OnClick = Label5Click
      end
      object Label6: TLabel
        Left = 385
        Top = 7
        Width = 62
        Height = 17
        Cursor = crHandPoint
        AutoSize = False
        Caption = #20008#20840#23631#20008
        Font.Charset = GB2312_CHARSET
        Font.Color = clGreen
        Font.Height = -16
        Font.Name = #23435#20307'-PUA'
        Font.Style = []
        ParentFont = False
        Transparent = True
        OnClick = Label6Click
      end
    end
  end
  object XPManifest1: TXPManifest
    Left = 750
    Top = 442
  end
  object MainMenu1: TMainMenu
    Left = 912
    Top = 376
    object ShowArrayAndFoms1: TMenuItem
      Caption = 'Show_ArrayAndFoms'
      Visible = False
      object ShowArrayAndFoms2: TMenuItem
        Caption = 'Show_ArrayAndFoms'
        ShortCut = 16449
      end
    end
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 788
    Top = 441
  end
  object TimClosePage: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimClosePageTimer
    Left = 790
    Top = 489
  end
  object TimLinkDB: TTimer
    OnTimer = TimLinkDBTimer
    Left = 823
    Top = 442
  end
  object TimerPleaseWait: TTimer
    Enabled = False
    OnTimer = TimerPleaseWaitTimer
    Left = 827
    Top = 490
  end
  object TNewVer: TTimer
    Interval = 10000
    OnTimer = TNewVerTimer
    Left = 861
    Top = 439
  end
  object Timer2: TTimer
    Interval = 5000
    OnTimer = Timer2Timer
    Left = 901
    Top = 439
  end
  object IdIPWatch1: TIdIPWatch
    Active = False
    HistoryFilename = 'iphist.dat'
    Left = 669
    Top = 447
  end
  object Timer3: TTimer
    Interval = 18000
    OnTimer = Timer3Timer
    Left = 941
    Top = 439
  end
  object Timer4: TTimer
    Interval = 15000
    OnTimer = Timer4Timer
    Left = 981
    Top = 439
  end
end
