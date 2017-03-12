object DataModule1: TDataModule1
  OldCreateOrder = False
  Left = 359
  Top = 141
  Height = 370
  Width = 697
  object SC: TSocketConnection
    ServerGUID = '{858142C7-44AE-4ABA-8FF8-81D4D99ED741}'
    ServerName = 'ylxxgl_server.bc_server'
    Port = 2106
    SupportCallbacks = False
    Left = 127
    Top = 34
  end
  object ClientDataSet2: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = SC
    Left = 122
    Top = 91
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = SC
    Left = 130
    Top = 171
  end
end
