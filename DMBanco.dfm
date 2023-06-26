object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 269
  Width = 352
  object ConBD: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\progunico45\Documents\Embarcadero\Studio\Proje' +
        'cts\CineBlu_Delphi_Edition\Banco\BANCO.FDB'
      'User_Name=SYSDBA'
      'Password=sci'
      'Server=localhost'
      'Port=3050'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 25
    Top = 24
  end
  object FBDriver: TFDPhysFBDriverLink
    VendorLib = 
      'C:\Users\progunico45\Documents\Embarcadero\Studio\Projects\CineB' +
      'lu_Delphi_Edition\Banco\FBCLIENT32.DLL'
    Left = 88
    Top = 24
  end
  object FDWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 152
    Top = 24
  end
end
