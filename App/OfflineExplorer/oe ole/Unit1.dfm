object Form1: TForm1
  Left = 189
  Top = 104
  Width = 696
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 312
    Top = 56
    Width = 25
    Height = 13
    Caption = 'URL:'
  end
  object Label2: TLabel
    Left = 352
    Top = 56
    Width = 329
    Height = 13
    AutoSize = False
  end
  object Label3: TLabel
    Left = 312
    Top = 72
    Width = 29
    Height = 13
    Caption = 'Level:'
  end
  object Label4: TLabel
    Left = 352
    Top = 72
    Width = 3
    Height = 13
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Load OE'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 608
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Destroy'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 96
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Set persistent'
    TabOrder = 2
    OnClick = Button3Click
  end
  object List: TListBox
    Left = 0
    Top = 304
    Width = 688
    Height = 149
    Align = alBottom
    ItemHeight = 13
    TabOrder = 3
  end
  object Tree: TTreeView
    Left = 8
    Top = 48
    Width = 289
    Height = 217
    HideSelection = False
    Indent = 19
    TabOrder = 4
    OnChange = TreeChange
  end
  object btnStart: TButton
    Left = 312
    Top = 96
    Width = 75
    Height = 23
    Caption = 'Start'
    Enabled = False
    TabOrder = 5
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 400
    Top = 96
    Width = 75
    Height = 23
    Caption = 'Stop'
    Enabled = False
    TabOrder = 6
    OnClick = btnStopClick
  end
  object Timer1: TTimer
    OnTimer = Button4Click
    Top = 272
  end
end
