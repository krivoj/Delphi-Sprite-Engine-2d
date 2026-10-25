unit SpriteEngine.Controls;

interface

uses
  Winapi.Windows, System.Classes, System.SysUtils, System.Types,
  Vcl.Graphics, SpriteEngine.Core;

type
  TSpriteButtonState = (bsNormal, bsHover, bsPressed, bsDisabled);
  TSpriteProgressOrientation = (poHorizontal, poVertical);
  TSpritePointArray = array of TPoint;

  TSpriteControl = class(TSprite)
  private
    FControlWidth: Integer;
    FControlHeight: Integer;
    FBackgroundColor: TColor;
    FBorderColor: TColor;
    FBorderWidth: Integer;
    FAccentColor: TColor;
    FTextColor: TColor;
    FFontName: string;
    FFontSize: Integer;
    FFontStyle: TFontStyles;
    FCornerSize: Integer;
    FPadding: Integer;
    FDirty: Boolean;
    procedure SetBackgroundColor(const Value: TColor);
    procedure SetBorderColor(const Value: TColor);
    procedure SetBorderWidth(const Value: Integer);
    procedure SetAccentColor(const Value: TColor);
    procedure SetTextColor(const Value: TColor);
    procedure SetFontName(const Value: string);
    procedure SetFontSize(const Value: Integer);
    procedure SetFontStyle(const Value: TFontStyles);
    procedure SetCornerSize(const Value: Integer);
    procedure SetPadding(const Value: Integer);
  protected
    procedure Changed;
    procedure PaintControl(const Canvas: TCanvas); virtual;
    procedure PaintBackground(const Canvas: TCanvas); virtual;
    procedure PaintText(const Canvas: TCanvas; const AText: string;
      const ARect: TRect; Alignment: Cardinal = DT_CENTER); virtual;
  public
    constructor Create(const Guid: string; X, Y, Width, Height: Integer); virtual;
    procedure DrawFrame(Interval: Integer); override;
    property ControlWidth: Integer read FControlWidth;
    property ControlHeight: Integer read FControlHeight;
    property BackgroundColor: TColor read FBackgroundColor write SetBackgroundColor;
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property BorderWidth: Integer read FBorderWidth write SetBorderWidth;
    property AccentColor: TColor read FAccentColor write SetAccentColor;
    property TextColor: TColor read FTextColor write SetTextColor;
    property FontName: string read FFontName write SetFontName;
    property FontSize: Integer read FFontSize write SetFontSize;
    property FontStyle: TFontStyles read FFontStyle write SetFontStyle;
    property CornerSize: Integer read FCornerSize write SetCornerSize;
    property Padding: Integer read FPadding write SetPadding;
  end;

  TSpriteProgressBar = class(TSpriteControl)
  private
    FMinimum: Integer;
    FMaximum: Integer;
    FValue: Integer;
    FFillColor: TColor;
    FCaption: string;
    FShowValue: Boolean;
    FOrientation: TSpriteProgressOrientation;
    procedure SetMinimum(const Value: Integer);
    procedure SetMaximum(const Value: Integer);
    procedure SetValue(const Value: Integer);
    procedure SetFillColor(const Value: TColor);
    procedure SetCaption(const Value: string);
    procedure SetShowValue(const Value: Boolean);
    procedure SetOrientation(const Value: TSpriteProgressOrientation);
  protected
    procedure PaintControl(const Canvas: TCanvas); override;
  public
    constructor Create(const Guid: string; X, Y, Width, Height: Integer); override;
    property Minimum: Integer read FMinimum write SetMinimum;
    property Maximum: Integer read FMaximum write SetMaximum;
    property Value: Integer read FValue write SetValue;
    property FillColor: TColor read FFillColor write SetFillColor;
    property Caption: string read FCaption write SetCaption;
    property ShowValue: Boolean read FShowValue write SetShowValue;
    property Orientation: TSpriteProgressOrientation read FOrientation write SetOrientation;
  end;

  TSpritePanel = class(TSpriteControl)
  private
    FTitle: string;
    FHeaderHeight: Integer;
    FHeaderColor: TColor;
    procedure SetTitle(const Value: string);
    procedure SetHeaderHeight(const Value: Integer);
    procedure SetHeaderColor(const Value: TColor);
  protected
    procedure PaintControl(const Canvas: TCanvas); override;
  public
    constructor Create(const Guid: string; X, Y, Width, Height: Integer); override;
    property Title: string read FTitle write SetTitle;
    property HeaderHeight: Integer read FHeaderHeight write SetHeaderHeight;
    property HeaderColor: TColor read FHeaderColor write SetHeaderColor;
  end;

  TSpriteButton = class(TSpriteControl)
  private
    FCaption: string;
    FState: TSpriteButtonState;
    FHoverColor: TColor;
    FPressedColor: TColor;
    FDisabledColor: TColor;
    FOnClick: TNotifyEvent;
    procedure SetCaption(const Value: string);
    procedure SetState(const Value: TSpriteButtonState);
    procedure SetHoverColor(const Value: TColor);
    procedure SetPressedColor(const Value: TColor);
    procedure SetDisabledColor(const Value: TColor);
  protected
    procedure PaintControl(const Canvas: TCanvas); override;
  public
    constructor Create(const Guid: string; X, Y, Width, Height: Integer); override;
    procedure Click;
    property Caption: string read FCaption write SetCaption;
    property State: TSpriteButtonState read FState write SetState;
    property HoverColor: TColor read FHoverColor write SetHoverColor;
    property PressedColor: TColor read FPressedColor write SetPressedColor;
    property DisabledColor: TColor read FDisabledColor write SetDisabledColor;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TSpritePolygon = class(TSprite)
  private
    FPoints: TSpritePointArray;
    FDrawPoints: TSpritePointArray;
    FBorderColor: TColor;
    FFillColor: TColor;
    FBorderWidth: Integer;
    FFilled: Boolean;
    FDirty: Boolean;
    procedure ParseVertices(const Vertices: string; out Bounds: TRect);
    procedure SetBorderColor(const Value: TColor);
    procedure SetFillColor(const Value: TColor);
    procedure SetBorderWidth(const Value: Integer);
    procedure SetFilled(const Value: Boolean);
    procedure PaintPolygon;
  public
    constructor Create(const Guid: string; X, Y: Integer; const Vertices: string);
    procedure DrawFrame(Interval: Integer); override;
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property VertexColor: TColor read FBorderColor write SetBorderColor;
    property FillColor: TColor read FFillColor write SetFillColor;
    property BorderWidth: Integer read FBorderWidth write SetBorderWidth;
    property Filled: Boolean read FFilled write SetFilled;
  end;

  TSpriteEngineControls = class helper for TSpriteEngine
  public
    function CreateProgressBar(const Guid: string; X, Y, Width, Height,
      Priority: Integer): TSpriteProgressBar;
    function CreatePanel(const Guid: string; X, Y, Width, Height,
      Priority: Integer): TSpritePanel;
    function CreateButton(const Guid: string; X, Y, Width, Height,
      Priority: Integer): TSpriteButton;
    function CreatePolygon(const Guid: string; X, Y: Integer;
      const Vertices: string; Priority: Integer): TSpritePolygon;
  end;

implementation

function NewControlBitmap(Width, Height: Integer): TBitmap;
begin
  Result := TBitmap.Create;
  Result.PixelFormat := pf24bit;
  Result.SetSize(Width, Height);
  Result.Canvas.Brush.Color := clBlack;
  Result.Canvas.FillRect(Rect(0, 0, Width, Height));
end;

{ TSpriteControl }

constructor TSpriteControl.Create(const Guid: string; X, Y, Width, Height: Integer);
var
  Bitmap: TBitmap;
begin
  if Width < 1 then Width := 1;
  if Height < 1 then Height := 1;
  Bitmap := NewControlBitmap(Width, Height);
  try
    inherited Create(Bitmap, Guid, 1, 1, 1000, X, Y, False);
  finally
    Bitmap.Free;
  end;
  SpriteFileName := ClassName;
  FControlWidth := Width;
  FControlHeight := Height;
  FFontName := 'Segoe UI';
  FFontSize := 10;
  FFontStyle := [];
  FPadding := 6;
  FBackgroundColor := $001D2633;
  FBorderColor := $004C7AA3;
  FAccentColor := $0037B7E5;
  FTextColor := clWhite;
  FBorderWidth := 2;
  FCornerSize := 8;
  FDirty := True;
end;

procedure TSpriteControl.Changed;
begin
  FDirty := True;
end;

procedure TSpriteControl.DrawFrame(Interval: Integer);
begin
  if FDirty then
  begin
    PaintControl(BMP.Bitmap.Canvas);
    FDirty := False;
  end;
  inherited DrawFrame(Interval);
end;

procedure TSpriteControl.PaintBackground(const Canvas: TCanvas);
var
  R: TRect;
begin
  R := Rect(0, 0, FControlWidth, FControlHeight);
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := FBackgroundColor;
  Canvas.Pen.Color := FBorderColor;
  Canvas.Pen.Width := FBorderWidth;
  if FCornerSize > 0 then
    Canvas.RoundRect(R.Left, R.Top, R.Right, R.Bottom, FCornerSize, FCornerSize)
  else
    Canvas.Rectangle(R);
end;

procedure TSpriteControl.PaintControl(const Canvas: TCanvas);
begin
  PaintBackground(Canvas);
end;

procedure TSpriteControl.PaintText(const Canvas: TCanvas; const AText: string;
  const ARect: TRect; Alignment: Cardinal);
var
  R: TRect;
begin
  R := ARect;
  Canvas.Font.Name := FFontName;
  Canvas.Font.Size := FFontSize;
  Canvas.Font.Style := FFontStyle;
  Canvas.Font.Color := FTextColor;
  Canvas.Brush.Style := bsClear;
  SetBkMode(Canvas.Handle, Winapi.Windows.TRANSPARENT);
  DrawText(Canvas.Handle, PChar(AText), Length(AText), R,
    Alignment or DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS);
end;

procedure TSpriteControl.SetBackgroundColor(const Value: TColor); begin FBackgroundColor := Value; Changed; end;
procedure TSpriteControl.SetBorderColor(const Value: TColor); begin FBorderColor := Value; Changed; end;
procedure TSpriteControl.SetBorderWidth(const Value: Integer); begin if Value < 0 then FBorderWidth := 0 else FBorderWidth := Value; Changed; end;
procedure TSpriteControl.SetAccentColor(const Value: TColor); begin FAccentColor := Value; Changed; end;
procedure TSpriteControl.SetTextColor(const Value: TColor); begin FTextColor := Value; Changed; end;
procedure TSpriteControl.SetFontName(const Value: string); begin FFontName := Value; Changed; end;
procedure TSpriteControl.SetFontSize(const Value: Integer); begin FFontSize := Value; Changed; end;
procedure TSpriteControl.SetFontStyle(const Value: TFontStyles); begin FFontStyle := Value; Changed; end;
procedure TSpriteControl.SetCornerSize(const Value: Integer); begin if Value < 0 then FCornerSize := 0 else FCornerSize := Value; Changed; end;
procedure TSpriteControl.SetPadding(const Value: Integer); begin if Value < 0 then FPadding := 0 else FPadding := Value; Changed; end;

{ TSpriteProgressBar }

constructor TSpriteProgressBar.Create(const Guid: string; X, Y, Width, Height: Integer);
begin
  inherited;
  FMinimum := 0;
  FMaximum := 100;
  FValue := 50;
  FFillColor := AccentColor;
  FShowValue := True;
  FOrientation := poHorizontal;
  Changed;
end;

procedure TSpriteProgressBar.PaintControl(const Canvas: TCanvas);
var
  R, FillRect: TRect;
  Range, FilledPixels: Integer;
  DisplayText: string;
begin
  inherited PaintControl(Canvas);
  R := Rect(Padding, Padding, ControlWidth - Padding, ControlHeight - Padding);
  Range := FMaximum - FMinimum;
  if Range < 1 then Range := 1;
  if FOrientation = poHorizontal then
  begin
    FilledPixels := ((R.Right - R.Left) * (FValue - FMinimum)) div Range;
    FillRect := Rect(R.Left, R.Top, R.Left + FilledPixels, R.Bottom);
  end
  else
  begin
    FilledPixels := ((R.Bottom - R.Top) * (FValue - FMinimum)) div Range;
    FillRect := Rect(R.Left, R.Bottom - FilledPixels, R.Right, R.Bottom);
  end;
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := FFillColor;
  Canvas.Pen.Style := psClear;
  Canvas.FillRect(FillRect);
  Canvas.Pen.Style := psSolid;
  DisplayText := FCaption;
  if FShowValue then
  begin
    if DisplayText <> '' then DisplayText := DisplayText + ' ';
    DisplayText := DisplayText + IntToStr(FValue) + '%';
  end;
  PaintText(Canvas, DisplayText, Rect(Padding, 0, ControlWidth - Padding, ControlHeight));
end;

procedure TSpriteProgressBar.SetMinimum(const Value: Integer); begin FMinimum := Value; if FMaximum <= FMinimum then FMaximum := FMinimum + 1; SetValue(FValue); end;
procedure TSpriteProgressBar.SetMaximum(const Value: Integer); begin FMaximum := Value; if FMaximum <= FMinimum then FMaximum := FMinimum + 1; SetValue(FValue); end;
procedure TSpriteProgressBar.SetValue(const Value: Integer); begin FValue := Value; if FValue < FMinimum then FValue := FMinimum; if FValue > FMaximum then FValue := FMaximum; Changed; end;
procedure TSpriteProgressBar.SetFillColor(const Value: TColor); begin FFillColor := Value; Changed; end;
procedure TSpriteProgressBar.SetCaption(const Value: string); begin FCaption := Value; Changed; end;
procedure TSpriteProgressBar.SetShowValue(const Value: Boolean); begin FShowValue := Value; Changed; end;
procedure TSpriteProgressBar.SetOrientation(const Value: TSpriteProgressOrientation); begin FOrientation := Value; Changed; end;

{ TSpritePanel }

constructor TSpritePanel.Create(const Guid: string; X, Y, Width, Height: Integer);
begin
  inherited;
  FHeaderHeight := 32;
  FHeaderColor := AccentColor;
  Changed;
end;

procedure TSpritePanel.PaintControl(const Canvas: TCanvas);
var
  H: Integer;
begin
  inherited PaintControl(Canvas);
  H := FHeaderHeight;
  if H > ControlHeight then H := ControlHeight;
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := FHeaderColor;
  Canvas.Pen.Style := psClear;
  Canvas.FillRect(Rect(BorderWidth, BorderWidth, ControlWidth - BorderWidth, H));
  Canvas.Pen.Style := psSolid;
  PaintText(Canvas, FTitle, Rect(Padding, 0, ControlWidth - Padding, H), DT_LEFT);
end;

procedure TSpritePanel.SetTitle(const Value: string); begin FTitle := Value; Changed; end;
procedure TSpritePanel.SetHeaderHeight(const Value: Integer); begin if Value < 0 then FHeaderHeight := 0 else FHeaderHeight := Value; Changed; end;
procedure TSpritePanel.SetHeaderColor(const Value: TColor); begin FHeaderColor := Value; Changed; end;

{ TSpriteButton }

constructor TSpriteButton.Create(const Guid: string; X, Y, Width, Height: Integer);
begin
  inherited;
  FHoverColor := $00454F5C;
  FPressedColor := AccentColor;
  FDisabledColor := clGray;
  FState := bsNormal;
  Changed;
end;

procedure TSpriteButton.PaintControl(const Canvas: TCanvas);
var
  SavedColor: TColor;
begin
  SavedColor := BackgroundColor;
  case FState of
    bsHover: FBackgroundColor := FHoverColor;
    bsPressed: FBackgroundColor := FPressedColor;
    bsDisabled: FBackgroundColor := FDisabledColor;
  end;
  inherited PaintControl(Canvas);
  FBackgroundColor := SavedColor;
  PaintText(Canvas, FCaption, Rect(Padding, 0, ControlWidth - Padding, ControlHeight));
end;

procedure TSpriteButton.Click;
begin
  if FState = bsDisabled then Exit;
  if Assigned(FOnClick) then FOnClick(Self);
end;

procedure TSpriteButton.SetCaption(const Value: string); begin FCaption := Value; Changed; end;
procedure TSpriteButton.SetState(const Value: TSpriteButtonState); begin FState := Value; HitTest := Value <> bsDisabled; Changed; end;
procedure TSpriteButton.SetHoverColor(const Value: TColor); begin FHoverColor := Value; Changed; end;
procedure TSpriteButton.SetPressedColor(const Value: TColor); begin FPressedColor := Value; Changed; end;
procedure TSpriteButton.SetDisabledColor(const Value: TColor); begin FDisabledColor := Value; Changed; end;

{ TSpritePolygon }

constructor TSpritePolygon.Create(const Guid: string; X, Y: Integer; const Vertices: string);
var
  Bounds: TRect;
  Bitmap: TBitmap;
  I, Width, Height: Integer;
begin
  ParseVertices(Vertices, Bounds);
  Width := Bounds.Right - Bounds.Left + 3;
  Height := Bounds.Bottom - Bounds.Top + 3;
  if Width < 1 then Width := 1;
  if Height < 1 then Height := 1;
  SetLength(FDrawPoints, Length(FPoints));
  for I := 0 to High(FPoints) do
    FDrawPoints[I] := Point(FPoints[I].X - Bounds.Left + 1,
      FPoints[I].Y - Bounds.Top + 1);
  Bitmap := NewControlBitmap(Width, Height);
  try
    inherited Create(Bitmap, Guid, 1, 1, 1000, X, Y, True);
  finally
    Bitmap.Free;
  end;
  SpriteFileName := ClassName;
  FBorderColor := clAqua;
  FFillColor := clNavy;
  FBorderWidth := 1;
  FFilled := True;
  TransparentColor := clBlack;
  TransparentForced := True;
  FDirty := True;
end;

procedure TSpritePolygon.ParseVertices(const Vertices: string; out Bounds: TRect);
var
  Items: TStringList;
  I: Integer;
begin
  Bounds := Rect(MaxInt, MaxInt, -MaxInt, -MaxInt);
  Items := TStringList.Create;
  try
    Items.CommaText := Vertices;
    SetLength(FPoints, Items.Count);
    for I := 0 to Items.Count - 1 do
    begin
      FPoints[I].X := StrToIntDef(Copy(Items[I], 1, Pos('.', Items[I]) - 1), 0);
      FPoints[I].Y := StrToIntDef(Copy(Items[I], Pos('.', Items[I]) + 1, MaxInt), 0);
      if FPoints[I].X < Bounds.Left then Bounds.Left := FPoints[I].X;
      if FPoints[I].Y < Bounds.Top then Bounds.Top := FPoints[I].Y;
      if FPoints[I].X > Bounds.Right then Bounds.Right := FPoints[I].X;
      if FPoints[I].Y > Bounds.Bottom then Bounds.Bottom := FPoints[I].Y;
    end;
  finally
    Items.Free;
  end;
  if Length(FPoints) = 0 then
  begin
    Bounds := Rect(0, 0, 1, 1);
    SetLength(FPoints, 1);
    FPoints[0] := Point(0, 0);
  end;
end;

procedure TSpritePolygon.PaintPolygon;
begin
  BMP.Bitmap.Canvas.Brush.Color := clBlack;
  BMP.Bitmap.Canvas.FillRect(Rect(0, 0, BMP.Width, BMP.Height));
  BMP.Bitmap.Canvas.Pen.Color := FBorderColor;
  BMP.Bitmap.Canvas.Pen.Width := FBorderWidth;
  if FFilled then
    BMP.Bitmap.Canvas.Brush.Color := FFillColor
  else
    BMP.Bitmap.Canvas.Brush.Style := bsClear;
  if Length(FDrawPoints) > 1 then
    BMP.Bitmap.Canvas.Polygon(FDrawPoints);
  BMP.Bitmap.Canvas.Brush.Style := bsSolid;
end;

procedure TSpritePolygon.DrawFrame(Interval: Integer);
begin
  if FDirty then
  begin
    PaintPolygon;
    FDirty := False;
  end;
  inherited DrawFrame(Interval);
end;

procedure TSpritePolygon.SetBorderColor(const Value: TColor); begin FBorderColor := Value; FDirty := True; end;
procedure TSpritePolygon.SetFillColor(const Value: TColor); begin FFillColor := Value; FDirty := True; end;
procedure TSpritePolygon.SetBorderWidth(const Value: Integer); begin if Value < 1 then FBorderWidth := 1 else FBorderWidth := Value; FDirty := True; end;
procedure TSpritePolygon.SetFilled(const Value: Boolean); begin FFilled := Value; FDirty := True; end;

{ TSpriteEngineControls }

function TSpriteEngineControls.CreateProgressBar(const Guid: string; X, Y,
  Width, Height, Priority: Integer): TSpriteProgressBar;
begin
  Result := TSpriteProgressBar.Create(Guid, X, Y, Width, Height);
  Result.Priority := Priority;
  Self.AddSprite(Result);
end;

function TSpriteEngineControls.CreatePanel(const Guid: string; X, Y, Width,
  Height, Priority: Integer): TSpritePanel;
begin
  Result := TSpritePanel.Create(Guid, X, Y, Width, Height);
  Result.Priority := Priority;
  Self.AddSprite(Result);
end;

function TSpriteEngineControls.CreateButton(const Guid: string; X, Y, Width,
  Height, Priority: Integer): TSpriteButton;
begin
  Result := TSpriteButton.Create(Guid, X, Y, Width, Height);
  Result.Priority := Priority;
  Self.AddSprite(Result);
end;

function TSpriteEngineControls.CreatePolygon(const Guid: string; X, Y: Integer;
  const Vertices: string; Priority: Integer): TSpritePolygon;
begin
  Result := TSpritePolygon.Create(Guid, X, Y, Vertices);
  Result.Priority := Priority;
  Self.AddSprite(Result);
end;

end.
