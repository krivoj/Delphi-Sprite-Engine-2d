# SpriteEngine.Controls

`SpriteEngine.Controls` is an optional runtime package for drawing game-style UI
controls as sprites. The core `SpriteEngine` package has no dependency on these
controls.

Build the packages in this order:

1. `SpriteEngine.dpk`
2. `SpriteEngine.Controls.dpk`

Add `SpriteEngine.Controls` to a form unit when controls are needed. The unit
adds factory methods to `TSpriteEngine` through a class helper:

```pascal
uses
  SpriteEngine.Core, SpriteEngine.Controls;

HealthBar := ControlsEngine.CreateProgressBar(
  'health', 200, 100, 320, 36, 10);
HealthBar.Caption := 'HEALTH';
HealthBar.FillColor := clRed;
HealthBar.Value := 75;

EnergyBar := ControlsEngine.CreateProgressBar(
  'energy', 540, 100, 36, 240, 10);
EnergyBar.Orientation := poVertical;
EnergyBar.BackgroundColor := clBlack;
EnergyBar.BorderColor := clSilver;
EnergyBar.FillColor := clLime;

TargetButton := ControlsEngine.CreateButton(
  'target', 200, 160, 180, 44, 20);
TargetButton.Caption := 'ENGAGE TARGET';
TargetButton.BackgroundColor := clBlack;
TargetButton.BorderColor := clAqua;
```

## Controls

- `TSpriteProgressBar`: minimum, maximum, value, fill color, caption, value text,
  padding and horizontal or vertical orientation. Vertical bars fill from bottom
  to top.
- `TSpritePolygon`: vertices, fill, border color, border width, filled or outline.
- `TSpriteButton`: caption, normal/hover/pressed/disabled state, state colors and
  `OnClick`.
- `TSpritePanel`: title, header height and header color.

Every rectangular control exposes background, border, accent, text, font,
corner and padding properties. Controls have no themes: their appearance is
always defined directly through these properties.

Buttons use the engine's normal hit testing. The demo maps theater mouse events
to button states and calls `TSpriteButton.Click` after a valid mouse release.
See `Demos\14-CustomControls` for a complete custom-control example, including
a vertical progress bar.
