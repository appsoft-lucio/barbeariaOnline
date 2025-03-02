object DMGlobal: TDMGlobal
  OnCreate = DataModuleCreate
  Height = 449
  Width = 381
  object FDConnection1: TFDConnection
    Params.Strings = (
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 56
    Top = 56
  end
end
