object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Sprite Engine Controls - Progress Bar'
  ClientHeight = 722
  ClientWidth = 1032
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Theater1: TTheater
    Left = 0
    Top = 0
    Width = 1024
    Height = 600
    Align = alClient
    MouseScrollRate = 1.000000000000000000
    MouseWheelInvert = False
    MouseWheelValue = 10
    MouseWheelZoom = True
    MousePan = True
    MouseScroll = False
    BackColor = clBlack
    AnimationInterval = 20
    CollisionDelay = 0
    ShowPerformance = False
    VirtualWidth = 1200
    Virtualheight = 1920
    TabOrder = 0
  end
  object Button1: TButton
    Left = 632
    Top = 656
    Width = 75
    Height = 25
    Caption = 'Random'
    TabOrder = 1
    OnClick = Button1Click
  end
  object BackgroundEngine: TSpriteEngine
    HitTest = False
    PixelCollision = False
    IsoPriority = False
    Priority = 0
    Theater = Theater1
    Left = 280
    Top = 656
  end
  object CharacterEngine: TSpriteEngine
    PixelCollision = False
    IsoPriority = False
    Priority = 1
    Theater = Theater1
    Left = 520
    Top = 656
  end
end
