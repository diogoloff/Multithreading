object frmMultithreading: TfrmMultithreading
  Left = 0
  Top = 0
  Caption = 'Multithreading'
  ClientHeight = 594
  ClientWidth = 722
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TextHeight = 13
  object lbHora: TLabel
    Left = 56
    Top = 40
    Width = 89
    Height = 39
    Caption = 'Hora:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -32
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Gauge1: TGauge
    Left = 208
    Top = 432
    Width = 289
    Height = 100
    Progress = 0
  end
  object Button1: TButton
    Left = 56
    Top = 112
    Width = 289
    Height = 73
    Caption = 'Processo sem Thread'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 352
    Top = 112
    Width = 289
    Height = 73
    Caption = 'Processo com Thread'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 128
    Top = 216
    Width = 433
    Height = 73
    Caption = 'Processo com Thread Visual Seguro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = Button3Click
  end
  object ckQueue: TCheckBox
    Left = 272
    Top = 384
    Width = 153
    Height = 33
    Caption = 'Usar Queue'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object Button4: TButton
    Left = 96
    Top = 296
    Width = 497
    Height = 73
    Caption = 'Processo com Thread Visual Seguro Objeto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = Button4Click
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 640
    Top = 32
  end
end
