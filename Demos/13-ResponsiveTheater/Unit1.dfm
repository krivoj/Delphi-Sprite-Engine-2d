object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Sprite Engine - Theater responsive'
  ClientHeight = 690
  ClientWidth = 1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object InfoPanel: TPanel
    Left = 0
    Top = 0
    Width = 1080
    Height = 72
    Align = alTop
    BevelOuter = bvNone
    Color = clBtnFace
    ParentBackground = False
    TabOrder = 0
    object SizeLabel: TLabel
      Left = 12
      Top = 8
      Width = 56
      Height = 13
      Caption = 'Dimensioni'
    end
    object MouseLabel: TLabel
      Left = 12
      Top = 29
      Width = 98
      Height = 13
      Caption = 'Sposta qui il mouse'
    end
    object HelpLabel: TLabel
      Left = 12
      Top = 50
      Width = 566
      Height = 13
      Caption = 'Ridimensiona o massimizza la finestra. Rotella = zoom, trascinamento = pan, click sui bersagli = test coordinate.'
    end
  end
  object Theater1: TTheater
    Left = 0
    Top = 72
    Width = 1080
    Height = 618
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
    KeepViewCenterOnResize = True
    OnMouseDown = Theater1MouseDown
    OnSpriteMouseDown = Theater1SpriteMouseDown
    OnTheaterMouseMove = Theater1TheaterMouseMove
    WrapHorizontal = False
    WrapVertical = False
    VirtualWidth = 1600
    Virtualheight = 900
    TabOrder = 1
  end
  object BackgroundEngine: TSpriteEngine
    HitTest = False
    PixelCollision = False
    IsoPriority = False
    Priority = 0
    Theater = Theater1
    Visible = True
    Left = 920
    Top = 16
  end
  object TargetEngine: TSpriteEngine
    PixelCollision = False
    IsoPriority = False
    Priority = 1
    Theater = Theater1
    Visible = True
    Left = 984
    Top = 16
  end
end
