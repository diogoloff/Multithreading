object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'MultiThread'
  ClientHeight = 441
  ClientWidth = 967
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Gauge1: TGauge
    Left = 0
    Top = 145
    Width = 967
    Height = 48
    Align = alTop
    Progress = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 967
    Height = 145
    Align = alTop
    TabOrder = 0
    object Button1: TButton
      Left = 1
      Top = 1
      Width = 241
      Height = 143
      Align = alLeft
      Caption = 'Sem Thread'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 242
      Top = 1
      Width = 241
      Height = 143
      Align = alLeft
      Caption = 'Com Thread'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 483
      Top = 1
      Width = 241
      Height = 143
      Align = alLeft
      Caption = 'Threads Concorrentes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 724
      Top = 1
      Width = 241
      Height = 143
      Align = alLeft
      Caption = 'Cancelar Processo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = Button4Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 193
    Width = 967
    Height = 248
    Align = alClient
    DataSource = DsDados
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object CdDados: TClientDataSet
    PersistDataPacket.Data = {
      420000009619E0BD010000001800000002000000000003000000420006434F44
      49474F0400010000000000044E4F4D4501004900000001000557494454480200
      02001E000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 648
    Top = 280
    object CdDadosCODIGO: TIntegerField
      DisplayWidth = 20
      FieldName = 'CODIGO'
    end
    object CdDadosNOME: TStringField
      DisplayWidth = 57
      FieldName = 'NOME'
      Size = 30
    end
  end
  object DsDados: TDataSource
    DataSet = CdDados
    Left = 648
    Top = 344
  end
end
