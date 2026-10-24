unit Unit1;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.Types,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.ExtCtrls, Vcl.StdCtrls, SpriteEngine.Core;

type
  TForm1 = class(TForm)
    InfoPanel: TPanel;
    SizeLabel: TLabel;
    MouseLabel: TLabel;
    HelpLabel: TLabel;
    Theater1: TTheater;
    BackgroundEngine: TSpriteEngine;
    TargetEngine: TSpriteEngine;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Theater1TheaterMouseMove(Sender: TObject; VisibleX,
      VisibleY, VirtualX, VirtualY: Integer; Shift: TShiftState);
    procedure Theater1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Theater1SpriteMouseDown(Sender: TObject;
      ASprite: TSprite; Button: TMouseButton;
      Shift: TShiftState);
  private
    procedure AddBackground;
    procedure AddTarget(const AGuid: string; X, Y: Integer; AColor: TColor);
    procedure UpdateSizeText;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.AddBackground;
var
  Bitmap: TBitmap;
begin
  Bitmap := TBitmap.Create;
  try
    Bitmap.PixelFormat := pf24bit;
    Bitmap.SetSize(Theater1.VirtualWidth, Theater1.VirtualHeight);
    Bitmap.Canvas.Brush.Color := $00382D24;
    Bitmap.Canvas.FillRect(Rect(0, 0, Bitmap.Width, Bitmap.Height));
    Bitmap.Canvas.Pen.Color := clSilver;
    Bitmap.Canvas.Pen.Width := 4;
    Bitmap.Canvas.Rectangle(2, 2, Bitmap.Width - 2, Bitmap.Height - 2);
    Bitmap.Canvas.Font.Name := 'Tahoma';
    Bitmap.Canvas.Font.Size := 18;
    Bitmap.Canvas.Font.Color := clWhite;
    Bitmap.Canvas.Brush.Style := bsClear;
    Bitmap.Canvas.TextOut(24, 20, 'Mondo virtuale: 1600 x 900');
    Bitmap.Canvas.TextOut(24, Bitmap.Height - 52, 'Angolo (0, 900)');
    Bitmap.Canvas.TextOut(Bitmap.Width - 190, 20, 'Angolo (1600, 0)');
    BackgroundEngine.CreateSprite(Bitmap, 'background', 1, 1, 0,
      Bitmap.Width div 2, Bitmap.Height div 2, False, 0).HitTest := False;
  finally
    Bitmap.Free;
  end;
end;

procedure TForm1.AddTarget(const AGuid: string; X, Y: Integer;
  AColor: TColor);
var
  Bitmap: TBitmap;
  S: string;
begin
  Bitmap := TBitmap.Create;
  try
    Bitmap.PixelFormat := pf24bit;
    Bitmap.SetSize(150, 84);
    Bitmap.Canvas.Brush.Color := AColor;
    Bitmap.Canvas.FillRect(Rect(0, 0, Bitmap.Width, Bitmap.Height));
    Bitmap.Canvas.Pen.Color := clWhite;
    Bitmap.Canvas.Pen.Width := 3;
    Bitmap.Canvas.Rectangle(1, 1, Bitmap.Width - 1, Bitmap.Height - 1);
    Bitmap.Canvas.Font.Name := 'Tahoma';
    Bitmap.Canvas.Font.Size := 11;
    Bitmap.Canvas.Font.Color := clWhite;
    Bitmap.Canvas.Brush.Style := bsClear;
    Bitmap.Canvas.TextOut(12, 12, AGuid);
    S := Format('centro: %d, %d', [X, Y]);
    Bitmap.Canvas.TextOut(12, 40, S);
    TargetEngine.CreateSprite(Bitmap, AGuid, 1, 1, 0, X, Y, False, 1).HitTest := True;
  finally
    Bitmap.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Theater1.Align := alClient;
  Theater1.SendToBack;
  Theater1.Active := False;
  Theater1.VirtualWidth := 1600;
  Theater1.VirtualHeight := 900;
  Theater1.KeepViewCenterOnResize := True;

  AddBackground;
  AddTarget('Bersaglio A', 260, 210, clMaroon);
  AddTarget('Bersaglio B', 800, 450, clGreen);
  AddTarget('Bersaglio C', 1340, 690, clNavy);

  Theater1.CenterTheater;
  Theater1.Active := True;
  UpdateSizeText;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  UpdateSizeText;
end;

procedure TForm1.Theater1SpriteMouseDown(Sender: TObject;
  ASprite: TSprite; Button: TMouseButton; Shift: TShiftState);
var
  P: TPoint;
begin
  GetCursorPos(P);
  P := Theater1.ScreenToClient(P);
  MouseLabel.Caption := Format('CLICK %s - client (%d, %d), virtuale (%d, %d)',
    [ASprite.Guid, P.X, P.Y, Theater1.XVisibleToVirtual(P.X),
     Theater1.YVisibleToVirtual(P.Y)]);
end;

procedure TForm1.Theater1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    MouseLabel.Caption := Format('CLICK sfondo - client (%d, %d), virtuale (%d, %d)',
      [X, Y, Theater1.XVisibleToVirtual(X), Theater1.YVisibleToVirtual(Y)]);
end;

procedure TForm1.Theater1TheaterMouseMove(Sender: TObject; VisibleX,
  VisibleY, VirtualX, VirtualY: Integer; Shift: TShiftState);
begin
  MouseLabel.Caption := Format('Mouse - client (%d, %d), virtuale (%d, %d)',
    [VisibleX, VisibleY, VirtualX, VirtualY]);
end;

procedure TForm1.UpdateSizeText;
begin
  if not Assigned(Theater1) then
    Exit;
  SizeLabel.Caption := Format(
    'Theater: %d x %d   Mondo: %d x %d   View: %d, %d   Zoom: %.0f%%',
    [Theater1.ClientWidth, Theater1.ClientHeight, Theater1.VirtualWidth,
     Theater1.VirtualHeight, Theater1.ViewX, Theater1.ViewY, Theater1.Zoom]);
end;

end.
