unit SpriteEngine.Panel;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Controls, Vcl.Graphics, Vcl.ExtCtrls, SpriteEngine.Bitmap;

type
  TSpritePanel = class(TPanel)
  private
    { Private declarations }
    fBackground: TSpriteBitmap;
    procedure SetBackground(const Value: TSpriteBitmap);
  protected
    { Protected declarations }
    procedure Paint; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property Background : TSpriteBitmap read fBackground write SetBackground;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Sprite Engine', [TSpritePanel]);
end;

{ TSpritePanel }

constructor TSpritePanel.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TSpritePanel.SetBackground(const Value: TSpriteBitmap);
begin
  if (FBackground <> Value) then begin
    if fBackground = nil then
      FBackground := TSpriteBitmap.Create (Value)
    else
    FBackground.Assign(Value);
  end;
end;

procedure TSpritePanel.Paint;
begin
  inherited;

  if not (csDesigning in ComponentState) then begin
    if fBackground <> nil then begin
      fBackground.Stretch( Width,Height );
      BitBlt(Canvas.Handle, 0, 0, Width, Height, fBackground.Canvas.Handle, 0, 0, SRCCOPY);
    end
    else begin
      Canvas.Brush.Color := Color;
      Canvas.FillRect( Rect(0,0, Width, Height) );
    end;
  end;

end;


end.






