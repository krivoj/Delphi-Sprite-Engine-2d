unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,System.Math,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SpriteEngine.Core, Vcl.ExtCtrls, Vcl.StdCtrls, System.Generics.Collections ,System.Generics.Defaults, SpriteEngine.Bitmap,
  SpriteEngine.Timer;

type
  TForm1 = class(TForm)
    Theater1: TTheater;
    BackgroundEngine: TSpriteEngine;
    SpriteEngine1: TSpriteEngine;
    procedure FormCreate(Sender: TObject);
    procedure Theater1AfterVisibleRender(Sender: TObject; VirtualBitmap, VisibleBitmap: TSpriteBitmap);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Ship: TSprite;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Theater1.Align := alClient;
  Theater1.SendToBack;

  Theater1.VirtualWidth := 1024;
  Theater1.VirtualHeight := 600;

  BackgroundEngine.Priority := 0;
  SpriteEngine1.Priority := 1;

  Ship:= SpriteEngine1.CreateSprite('..\!media\spacecraft.bmp','ship',{framesX}1,{framesY}1,{Delay}0,{X}Theater1.Width div 2,{Y}Theater1.Height div 2,{transparent}true,0);
  Ship.MoverData.MoveMode := Thrust;
  Ship.MoverData.MoveModeThrust_Thrust := 0;//0.3;
  Ship.MoverData.MoveModeThrust_Friction := 0.1;
  Ship.MoverData.MoveModeThrust_MaximumSpeed := 8;

  Theater1.Active := True;


end;
procedure TForm1.Theater1AfterVisibleRender(Sender: TObject; VirtualBitmap, VisibleBitmap: TSpriteBitmap);
begin
  if GetAsyncKeyState (VK_LEFT) < 0 then begin
    Ship.Angle := Ship.Angle - 10;

  end;
  if GetAsyncKeyState (VK_RIGHT) < 0 then  begin
    Ship.Angle := Ship.Angle + 10;
  end;

  if GetAsyncKeyState (VK_UP) < 0 then begin
    Ship.MoverData.MoveModeThrust_Thrust := 0.3;
  end
  else begin
    Ship.MoverData.MoveModeThrust_Thrust := 0;
  end;


    //    VK_UP:
//    VK_DOWN:
end;

end.
