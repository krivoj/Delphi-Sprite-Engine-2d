object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Sprite Engine - Custom Controls'
  ClientHeight = 720
  ClientWidth = 1280
  Color = clBlack
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
    Width = 1280
    Height = 720
    Align = alClient
    BackColor = 1052688
    AnimationInterval = 20
    CollisionDelay = 0
    MousePan = False
    MouseScroll = False
    MouseScrollRate = 1.000000000000000000
    MouseWheelInvert = False
    MouseWheelValue = 10
    MouseWheelZoom = False
    ShowPerformance = False
    VirtualWidth = 1280
    Virtualheight = 720
    TabOrder = 0
  end
  object ControlsEngine: TSpriteEngine
    PixelCollision = False
    HitTest = True
    IsoPriority = False
    Priority = 10
    Theater = Theater1
    Left = 32
    Top = 32
  end
  object AnimationTimer: TTimer
    Interval = 100
    OnTimer = AnimationTimerTimer
    Left = 96
    Top = 32
  end
end
