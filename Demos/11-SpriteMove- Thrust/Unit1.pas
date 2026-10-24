unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,System.Math,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SpriteEngine.Core, Vcl.ExtCtrls, Vcl.StdCtrls, System.Generics.Collections ,System.Generics.Defaults, SpriteEngine.Bitmap,
  SpriteEngine.Timer, SpriteEngine.Controls;

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
  Ship,ShipFire: TSpritePolygon;

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


  Ship := SpriteEngine1.CreatePolygon('ship', Theater1.VirtualWidth div 2,
    Theater1.VirtualHeight div 2, '0.-10,8.10,0.5,-8.10', 1);
  Ship.BorderColor := clAqua;
  Ship.FillColor := clBlue;
  Ship.TransparentColor := clWhite;
  Ship.Filled := True;

  Ship.MoverData.MoveMode := Thrust;
  Ship.MoverData.MoveModeThrust_Thrust := 0;//0.3;
  Ship.MoverData.MoveModeThrust_Friction := 0.1;
  Ship.MoverData.MoveModeThrust_MaximumSpeed := 8;

  ShipFire := SpriteEngine1.CreatePolygon('shipfire', Theater1.VirtualWidth div 2,
    Theater1.VirtualHeight div 2, '0.0,4.8,0.13,-4.8', 1);
  ShipFire.BorderColor := clRed;
  ShipFire.FillColor := clYellow;
  ShipFire.TransparentColor := clWhite;

  ShipFire.MoverData.MoveMode := Thrust;
  ShipFire.MoverData.MoveModeThrust_Thrust := 0;//0.3;
  ShipFire.MoverData.MoveModeThrust_Friction := 0.1;
  ShipFire.MoverData.MoveModeThrust_MaximumSpeed := 8;
  ShipFire.Filled := True;

  ShipFire.Visible := False;

  Theater1.Active := True;

  Randomize;

end;
procedure TForm1.Theater1AfterVisibleRender(Sender: TObject; VirtualBitmap, VisibleBitmap: TSpriteBitmap);
begin
  if GetAsyncKeyState (VK_LEFT) < 0 then begin
    Ship.Angle := Ship.Angle - 10;
    ShipFire.Angle := ShipFire.Angle - 10;

  end;
  if GetAsyncKeyState (VK_RIGHT) < 0 then  begin
    Ship.Angle := Ship.Angle + 10;
    ShipFire.Angle := ShipFire.Angle + 10;
  end;

  if GetAsyncKeyState (VK_UP) < 0 then begin
    Ship.MoverData.MoveModeThrust_Thrust := 0.3;
    ShipFire.MoverData.MoveModeThrust_Thrust := 0.3;
    ShipFire.Visible := True;
  end
  else begin
    Ship.MoverData.MoveModeThrust_Thrust := 0;
    ShipFire.MoverData.MoveModeThrust_Thrust := 0;
    ShipFire.Visible := False;
  end;


    //    VK_UP:
//    VK_DOWN:
end;

end.
