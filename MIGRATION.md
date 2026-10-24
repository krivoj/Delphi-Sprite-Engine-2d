# Sprite Engine naming migration

The public API now follows the usual Delphi naming convention and targets
Delphi 10 Seattle (CompilerVersion 30.0) or newer.

## Main type names

| Previous name | Current name |
| --- | --- |
| `SE_Sprite` | `TSprite` |
| `SE_Theater` | `TTheater` |
| `SE_Engine` | `TSpriteEngine` |
| `SE_Bitmap` | `TSpriteBitmap` |
| `SE_SubSprite` | `TSubSprite` |
| `SE_SpriteLabel` | `TSpriteLabel` |
| `SE_SpriteProgressBar` | `TSpriteProgressBar` (`SpriteEngine.Controls`) |
| `SE_SpritePolygon` | `TSpritePolygon` (`SpriteEngine.Controls`) |
| `SE_ThreadTimer` | `TThreadTimer` |
| `SE_Panel` | `TSpritePanel` |

Event, collection, file-search, blend-mode and helper types were renamed
in the same way: type names start with `T`, exception names with `E`, and enum
values use a short lowercase prefix such as `bmNormal`.

## Unit names

| Previous unit | Current unit |
| --- | --- |
| `DSE_theater` | `SpriteEngine.Core` |
| `DSE_Bitmap` | `SpriteEngine.Bitmap` |
| `DSE_defs` | `SpriteEngine.Types` |
| `DSE_list` | `SpriteEngine.Collections` |
| `DSE_misc` | `SpriteEngine.Utils` |
| `DSE_threadtimer` | `SpriteEngine.Timer` |
| `DSE_Panel` | Removed; use `TSpritePanel` from `SpriteEngine.Controls` |
| `DSE_PathPlanner` | `SpriteEngine.PathPlanner` |
| `DSE_SearchFiles` | `SpriteEngine.FileSearch` |
| `DSE_Random` | `SpriteEngine.Random` |

The package is now `SpriteEngine.dpk` / `SpriteEngine.dproj` and registers its
design-time components on the `Sprite Engine` palette page.

## Example

```pascal
uses
  SpriteEngine.Core,
  SpriteEngine.Bitmap;

var
  Theater: TTheater;
  Engine: TSpriteEngine;
  Sprite: TSprite;
```

This is a breaking source-level rename. All bundled demos and their DFM class
names have already been migrated. Old DCUs must not be mixed with the renamed
units.

## Responsive theater

`TTheater` can be placed on a form with `Align = alClient`. Runtime resizing now
updates the visible surface immediately and keeps mouse coordinates in the
virtual coordinate system accurate. `KeepViewCenterOnResize` is `True` by
default, so the same virtual point remains centered while the control changes
size.

See `Demos\13-ResponsiveTheater` for a complete example with resize, pan, zoom
and clickable sprites.

## Mouse hit testing

Mouse input is controlled at both engine and sprite level:

```pascal
Engine.HitTest := True;
Sprite.HitTest := True;
```

Setting `TSpriteEngine.HitTest` to `False` excludes every sprite owned by that
engine. When the engine accepts hit testing, only visible sprites whose own
`HitTest` property is `True` are considered. Engine priority is evaluated
first, followed by sprite priority within that engine.

`ClickSprites`, `PixelClick`, `HiddenSpritesMouseMove` and
`HiddenSpritesMouseClick` have been removed. Sprite mouse events now receive a
single `ASprite: TSprite`; the previous sprite list and `Handled` parameter no
longer exist.

## Seattle verification

The package and all 13 demo projects compile with the Delphi 10 Seattle Win32
compiler (`dcc32` 30.0). Verification products are created in a temporary
directory and removed after the build.

