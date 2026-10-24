unit Unit1;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.ExtCtrls, SpriteEngine.Core, SpriteEngine.Controls;

type
  TForm1 = class(TForm)
    Theater1: TTheater;
    ControlsEngine: TSpriteEngine;
    AnimationTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure AnimationTimerTimer(Sender: TObject);
  private
    FHealthBar: TSpriteProgressBar;
    FShieldBar: TSpriteProgressBar;
    FTargetPanel: TSpritePanel;
    FEngageButton: TSpriteButton;
    FSystemButton: TSpriteButton;
    FHoveredButton: TSpriteButton;
    FPressedButton: TSpriteButton;
    procedure SpriteMouseMove(Sender: TObject; ASprite: TSprite;
      Shift: TShiftState);
    procedure SpriteMouseDown(Sender: TObject; ASprite: TSprite;
      Button: TMouseButton; Shift: TShiftState);
    procedure SpriteMouseUp(Sender: TObject; ASprite: TSprite;
      Button: TMouseButton; Shift: TShiftState);
    procedure EngageTarget(Sender: TObject);
    procedure ToggleSystem(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  TargetMarker: TSpritePolygon;
begin
  Theater1.Align := alClient;
  Theater1.SendToBack;
  Theater1.VirtualWidth := 1280;
  Theater1.VirtualHeight := 720;

  Theater1.OnSpriteMouseMove := SpriteMouseMove;
  Theater1.OnSpriteMouseDown := SpriteMouseDown;
  Theater1.OnSpriteMouseUp := SpriteMouseUp;

  FTargetPanel := ControlsEngine.CreatePanel('target-panel', 340, 220, 420, 260, 1);
  FTargetPanel.Theme := ctSciFi;
  FTargetPanel.Title := 'TARGET DATA';
  FTargetPanel.HitTest := False;

  FHealthBar := ControlsEngine.CreateProgressBar('health', 340, 180, 360, 34, 3);
  FHealthBar.Theme := ctRPG;
  FHealthBar.Caption := 'HEALTH';
  FHealthBar.FillColor := $003C55D8;
  FHealthBar.Value := 82;
  FHealthBar.HitTest := False;

  FShieldBar := ControlsEngine.CreateProgressBar('shield', 340, 230, 360, 28, 3);
  FShieldBar.Theme := ctSciFi;
  FShieldBar.Caption := 'SHIELD';
  FShieldBar.FillColor := $00E7B83F;
  FShieldBar.Value := 64;
  FShieldBar.HitTest := False;

  FEngageButton := ControlsEngine.CreateButton('engage', 260, 330, 160, 46, 4);
  FEngageButton.Theme := ctSciFi;
  FEngageButton.Caption := 'ENGAGE TARGET';
  FEngageButton.OnClick := EngageTarget;

  FSystemButton := ControlsEngine.CreateButton('system', 440, 330, 160, 46, 4);
  FSystemButton.Theme := ctRPG;
  FSystemButton.Caption := 'DISABLE SYSTEM';
  FSystemButton.OnClick := ToggleSystem;

  TargetMarker := ControlsEngine.CreatePolygon('target-marker', 760, 220,
    '0.-36,36.0,0.36,-36.0', 2);
  TargetMarker.BorderColor := $00FFD45A;
  TargetMarker.FillColor := $00201912;
  TargetMarker.BorderWidth := 3;
  TargetMarker.Filled := False;
  TargetMarker.HitTest := False;

  Theater1.Active := True;
end;

procedure TForm1.AnimationTimerTimer(Sender: TObject);
begin
  FShieldBar.Value := FShieldBar.Value - 1;
  if FShieldBar.Value <= FShieldBar.Minimum then
    FShieldBar.Value := FShieldBar.Maximum;
end;

procedure TForm1.SpriteMouseMove(Sender: TObject; ASprite: TSprite;
  Shift: TShiftState);
var
  Button: TSpriteButton;
begin
  Button := nil;
  if ASprite is TSpriteButton then
    Button := TSpriteButton(ASprite);
  if Button = FHoveredButton then Exit;
  if Assigned(FHoveredButton) and (FHoveredButton.State <> bsDisabled) then
    FHoveredButton.State := bsNormal;
  FHoveredButton := Button;
  if Assigned(FHoveredButton) and (FHoveredButton.State <> bsDisabled) then
    FHoveredButton.State := bsHover;
end;

procedure TForm1.SpriteMouseDown(Sender: TObject; ASprite: TSprite;
  Button: TMouseButton; Shift: TShiftState);
begin
  FPressedButton := nil;
  if (Button = mbLeft) and (ASprite is TSpriteButton) then
  begin
    FPressedButton := TSpriteButton(ASprite);
    if FPressedButton.State <> bsDisabled then
      FPressedButton.State := bsPressed;
  end;
end;

procedure TForm1.SpriteMouseUp(Sender: TObject; ASprite: TSprite;
  Button: TMouseButton; Shift: TShiftState);
var
  ReleasedButton: TSpriteButton;
begin
  ReleasedButton := nil;
  if ASprite is TSpriteButton then
    ReleasedButton := TSpriteButton(ASprite);
  if Assigned(FPressedButton) and (FPressedButton.State <> bsDisabled) then
  begin
    if ReleasedButton = FPressedButton then
    begin
      FPressedButton.State := bsHover;
      FPressedButton.Click;
    end
    else
      FPressedButton.State := bsNormal;
  end;
  FPressedButton := nil;
end;

procedure TForm1.EngageTarget(Sender: TObject);
begin
  FTargetPanel.Title := 'TARGET LOCKED';
  FHealthBar.Value := Random(101);
end;

procedure TForm1.ToggleSystem(Sender: TObject);
begin
  if FEngageButton.State = bsDisabled then
  begin
    FEngageButton.State := bsNormal;
    FSystemButton.Caption := 'DISABLE SYSTEM';
  end
  else
  begin
    FEngageButton.State := bsDisabled;
    FSystemButton.Caption := 'ENABLE SYSTEM';
  end;
end;

end.
