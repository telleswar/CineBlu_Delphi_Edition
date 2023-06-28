object frTelaCompra: TfrTelaCompra
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  ClientHeight = 557
  ClientWidth = 761
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  WindowState = wsMaximized
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnCompraBody: TPanel
    Left = 0
    Top = 0
    Width = 761
    Height = 557
    Align = alClient
    BevelOuter = bvNone
    Color = 16448250
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      761
      557)
    object pnCompraHead: TPanel
      Left = 0
      Top = 0
      Width = 761
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      Color = 5526505
      ParentBackground = False
      TabOrder = 0
      object btnCloseHead: TSpeedButton
        Left = 736
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
        ExplicitLeft = 626
        ExplicitTop = 3
        ExplicitHeight = 22
      end
    end
    object pnBodyCenter: TPanel
      Left = 217
      Top = 32
      Width = 335
      Height = 570
      Anchors = [akTop]
      BevelOuter = bvNone
      TabOrder = 1
      object lbFilmes: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 30
        Width = 329
        Height = 26
        Margins.Top = 30
        Align = alTop
        Caption = 'Filme'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -20
        Font.Name = 'JetBrainsMonoNL NFM'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 60
      end
      object lbHorario: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 222
        Width = 329
        Height = 26
        Margins.Top = 30
        Align = alTop
        Caption = 'Hor'#225'rio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -20
        Font.Name = 'JetBrainsMonoNL NFM'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 84
      end
      object lb1: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 126
        Width = 329
        Height = 26
        Margins.Top = 30
        Align = alTop
        Caption = 'Sess'#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -20
        Font.Name = 'JetBrainsMonoNL NFM'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 72
      end
      object lbAssento: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 318
        Width = 329
        Height = 26
        Margins.Top = 30
        Align = alTop
        Caption = 'Assento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -20
        Font.Name = 'JetBrainsMonoNL NFM'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 84
      end
      object lbFormaPagamento: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 414
        Width = 329
        Height = 26
        Margins.Top = 30
        Align = alTop
        Caption = 'Forma de pagamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -20
        Font.Name = 'JetBrainsMonoNL NFM'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 216
      end
      object lbValor: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 483
        Width = 329
        Height = 17
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Valor : R$ 25,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3421399
        Font.Height = -13
        Font.Name = 'JetBrainsMonoNL NFM'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 128
      end
      object edAssento: TEdit
        AlignWithMargins = True
        Left = 3
        Top = 352
        Width = 329
        Height = 29
        Margins.Top = 5
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'JetBrainsMono NFM'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        ExplicitWidth = 265
      end
      object cbFormaPagamento: TComboBox
        AlignWithMargins = True
        Left = 3
        Top = 448
        Width = 329
        Height = 29
        Margins.Top = 5
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'JetBrainsMono NFM'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 4
        Text = 'Pix'
        Items.Strings = (
          'Pix'
          'Boleto'
          'Cart'#227'o de Cr'#233'dito'
          'Cart'#227'o de D'#233'bito')
      end
      object pnBtnRealizarCompra: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 530
        Width = 329
        Height = 33
        Cursor = crHandPoint
        Margins.Top = 30
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Realizar compra'
        Color = 3421399
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'JetBrainsMonoNL NFM'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 5
        OnClick = pnBtnRealizarCompraClick
        OnMouseEnter = pnBtnMouseEnter
        OnMouseLeave = pnBtnMouseLeave
        ExplicitTop = 470
        ExplicitWidth = 265
      end
      object cbDBFilmes: TDBLookupComboBox
        AlignWithMargins = True
        Left = 3
        Top = 64
        Width = 329
        Height = 29
        Margins.Top = 5
        Align = alTop
        BevelInner = bvNone
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'JetBrainsMono NFM'
        Font.Style = []
        KeyField = 'id'
        ListField = 'titulo'
        ParentFont = False
        TabOrder = 0
        OnCloseUp = cbDBFilmesCloseUp
        ExplicitWidth = 265
      end
      object cbDBSessao: TDBLookupComboBox
        AlignWithMargins = True
        Left = 3
        Top = 160
        Width = 329
        Height = 29
        Margins.Top = 5
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'JetBrainsMonoNL NFM'
        Font.Style = []
        KeyField = 'data'
        ListField = 'data'
        ListFieldIndex = 1
        ParentFont = False
        TabOrder = 1
        OnCloseUp = cbDBSessaoCloseUp
        ExplicitTop = 152
        ExplicitWidth = 265
      end
      object cbDBHorario: TDBLookupComboBox
        AlignWithMargins = True
        Left = 3
        Top = 256
        Width = 329
        Height = 29
        Margins.Top = 5
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'JetBrainsMono NFM'
        Font.Style = []
        KeyField = 'id'
        ListField = 'HORARIO'
        ParentFont = False
        TabOrder = 2
        ExplicitWidth = 265
      end
    end
  end
end
