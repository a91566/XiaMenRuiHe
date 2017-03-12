object FDM: TFDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 400
  Top = 209
  Height = 289
  Width = 243
  object SC: TSocketConnection
    ServerGUID = '{858142C7-44AE-4ABA-8FF8-81D4D99ED741}'
    ServerName = 'ylxxgl_server.bc_server'
    Port = 2106
    SupportCallbacks = False
    Left = 24
    Top = 8
  end
  object ClientDataSet2: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = SC
    Left = 27
    Top = 103
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = SC
    Left = 27
    Top = 55
  end
  object ClientDataSet3: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = SC
    Left = 27
    Top = 151
  end
  object GetDatetime: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = SC
    Left = 154
    Top = 56
  end
  object GetNewAppVer: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = SC
    Left = 27
    Top = 207
  end
  object ClientDataSet4: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DS_getdata'
    RemoteServer = SC
    Left = 123
    Top = 159
  end
end
