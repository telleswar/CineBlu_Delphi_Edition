object frConsulta: TfrConsulta
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'frConsulta'
  ClientHeight = 338
  ClientWidth = 651
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object pnCosultaBody: TPanel
    Left = 0
    Top = 0
    Width = 651
    Height = 338
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object DbGrid: TDBGrid
      Left = 0
      Top = 26
      Width = 651
      Height = 312
      Align = alClient
      BorderStyle = bsNone
      Color = 16448250
      GradientEndColor = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5526505
      Font.Height = -13
      Font.Name = 'JetBrainsMonoNL NFM'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = 5526505
      TitleFont.Height = -11
      TitleFont.Name = 'JetBrainsMonoNL NFM'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          Title.Caption = 'Teste'
          Visible = True
        end
        item
          Expanded = False
          Title.Caption = 'Teste'
          Visible = True
        end
        item
          Expanded = False
          Title.Caption = 'Teste'
          Visible = True
        end
        item
          Expanded = False
          Title.Caption = 'Teste'
          Visible = True
        end>
    end
    object pnConsultaHead: TPanel
      Left = 0
      Top = 0
      Width = 651
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      Color = 5526505
      ParentBackground = False
      TabOrder = 1
      object btnCloseHead: TSpeedButton
        Left = 626
        Top = 0
        Width = 25
        Height = 26
        Cursor = crHandPoint
        Align = alRight
        Caption = 'X'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnCloseHeadClick
        ExplicitTop = 3
        ExplicitHeight = 22
      end
    end
  end
end
