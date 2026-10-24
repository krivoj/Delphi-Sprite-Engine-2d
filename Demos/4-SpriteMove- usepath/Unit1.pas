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
    CharacterEngine: TSpriteEngine;
    Panel1: TPanel;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Edit1: TEdit;
    Panel2: TPanel;
    Label2: TLabel;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Edit2: TEdit;
    ThreadTimer1: TThreadTimer;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure ThreadTimer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CharacterEngineSpriteDestinationReached(ASprite: TSprite);
    procedure Theater1BeforeVisibleRender(Sender: TObject; VirtualBitmap, VisibleBitmap: TSpriteBitmap);
  private
    { Private declarations }
    function GetIsoDirection (X1,Y1,X2,Y2:integer): integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  gabriel,shahira: TSpriteBitmap;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  Background: TSprite;
begin
  Theater1.Align := alClient;
  Theater1.SendToBack;

  Theater1.VirtualWidth := 1920;
  Theater1.VirtualHeight := 1200;

  BackgroundEngine.Priority := 0;
  CharacterEngine.Priority := 1;


  Background:= BackgroundEngine.CreateSprite('..\!media\back1.bmp','background',{framesX}1,{framesY}1,{Delay}0,{X}0,{Y}0,{transparent}false,0);
  Background.Position := Point( Background.FrameWidth div 2 , Background.FrameHeight div 2 );

  Theater1.Active := True;

  gabriel :=  TSpriteBitmap.Create ( '..\!media\gabriel_WALK.bmp');
  shahira :=  TSpriteBitmap.Create ( '..\!media\shahira_WALK.bmp');

  CharacterEngine.CreateSprite(gabriel.Bitmap ,'gabriel',{framesX}15,{framesY}6,{Delay}7,{X}100,{Y}100,{transparent}true,1);
  CharacterEngine.CreateSprite(shahira.Bitmap,'shahira',{framesX}15,{framesY}6,{Delay}7,{X}200,{Y}100,{transparent}true,1);
  gabriel.Free;
  shahira.Free;

  CharacterEngine.CreateSprite('..\!media\barrel.bmp','barrel',{framesX}1,{framesY}1,{Delay}2000,{X}500,{Y}300,{transparent}true,1);
  Randomize;

end;
function TForm1.GetIsoDirection (X1,Y1,X2,Y2:integer): integer;
begin

  if (X2 = X1) and (Y2 = Y1) then Result:=1;

  if (X2 = X1) and (Y2 < Y1) then Result:=4;
  if (X2 = X1) and (Y2 > Y1) then Result:=1;

  if (X2 < X1) and (Y2 < Y1) then Result:=5;
  if (X2 > X1) and (Y2 < Y1) then Result:=3;

  if (X2 > X1) and (Y2 > Y1) then Result:=2;
  if (X2 < X1) and (Y2 > Y1) then Result:=6;

  if (X2 > X1) and (Y2 = Y1) then Result:=3;
  if (X2 < X1) and (Y2 = Y1) then Result:=5;


end;

procedure TForm1.CharacterEngineSpriteDestinationReached(ASprite: TSprite);
begin
  aSprite.MoverData.MoveModePath_MovePath.Reverse ;
  aSprite.NotifyDestinationReached := True;
  aSprite.MoverData.MoveMode := Path ;

end;

procedure TForm1.Theater1BeforeVisibleRender(Sender: TObject; VirtualBitmap, VisibleBitmap: TSpriteBitmap);
var
  SpriteGabriel,SpriteShahira: TSprite;
  I: Integer;
begin

   SpriteGabriel:= CharacterEngine.FindSprite('gabriel');
   SpriteShahira:= CharacterEngine.FindSprite('shahira');
  if SpriteGabriel.MoverData.MoveModePath_MovePath.Count > 0 then begin
    VirtualBitmap.Canvas.Pen.Color := clSilver;

    VirtualBitmap.Canvas.MoveTo( SpriteGabriel.MoverData.MoveModePath_MovePath[0].X,SpriteGabriel.MoverData.MoveModePath_MovePath[0].Y );
    for I := 1 to SpriteGabriel.MoverData.MoveModePath_MovePath.Count -1 do begin
     VirtualBitmap.Canvas.LineTo( SpriteGabriel.MoverData.MoveModePath_MovePath[i].X,SpriteGabriel.MoverData.MoveModePath_MovePath[i].Y );
    end;

  end;
  if SpriteShahira.MoverData.MoveModePath_MovePath.Count > 0 then begin
    VirtualBitmap.Canvas.Pen.Color := clRed;

    VirtualBitmap.Canvas.MoveTo( SpriteShahira.MoverData.MoveModePath_MovePath[0].X,SpriteShahira.MoverData.MoveModePath_MovePath[0].Y );
    for I := 1 to SpriteShahira.MoverData.MoveModePath_MovePath.Count -1 do begin
     VirtualBitmap.Canvas.LineTo( SpriteShahira.MoverData.MoveModePath_MovePath[i].X,SpriteShahira.MoverData.MoveModePath_MovePath[i].Y );
    end;

  end;
end;

procedure TForm1.ThreadTimer1Timer(Sender: TObject);
var
  SpriteGabriel, SpriteShahira: TSprite;
begin

   SpriteGabriel:= CharacterEngine.FindSprite('gabriel');
   SpriteShahira:= CharacterEngine.FindSprite('shahira');



   if SpriteGabriel.MoverData.MoveModePath_CurWP < SpriteGabriel.MoverData.MoveModePath_MovePath.Count -1 then begin
   SpriteGabriel.FrameY :=  GetIsoDirection ( SpriteGabriel.Position.X, SpriteGabriel.Position.Y,
                                              SpriteGabriel.MoverData.MoveModePath_MovePath [ SpriteGabriel.MoverData.MoveModePath_CurWP +1].X ,
                                              SpriteGabriel.MoverData.MoveModePath_MovePath [ SpriteGabriel.MoverData.MoveModePath_CurwP +1].Y);
   end;
   if SpriteShahira.MoverData.MoveModePath_CurwP < SpriteShahira.MoverData.MoveModePath_MovePath.Count -1 then begin
   SpriteShahira.FrameY :=  GetIsoDirection ( SpriteShahira.Position.X, SpriteShahira.Position.Y,
                                              SpriteShahira.MoverData.MoveModePath_MovePath [ SpriteShahira.MoverData.MoveModePath_CurWP +1].X ,
                                              SpriteShahira.MoverData.MoveModePath_MovePath [ SpriteShahira.MoverData.MoveModePath_CurwP +1].Y);
   end;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  SpriteGabriel, SpriteShahira: TSprite;
  Point,Point2,lastPoint :Tpoint;
  tmpPath: TList<TPoint>;
  I,wayPoints: Integer;
begin

   SpriteGabriel:= CharacterEngine.FindSprite('gabriel');
   SpriteGabriel.PositionX := 100;
   SpriteGabriel.PositionY := 100;
   SpriteGabriel.MoverData.MoveModePath_MovePath.Clear ;


   LastPoint := SpriteGabriel.Position;

   for WayPoints := 0 to 6 do begin
     Point.X:= randomrange ( 100,500);
     Point.Y:= randomrange ( 100,500);

     tmpPath:= TList<TPoint>.Create;
     GetLinePoints( LastPoint.X, LastPoint.Y,  Point.X, Point.Y,  tmpPath );

     for I := 0 to tmpPath.Count -1 do begin
       Point2:=tmpPath[i];
       SpriteGabriel.MoverData.MoveModePath_MovePath.Add(Point2);
     end;
     LastPoint := Point;
     tmpPath.Free ;


   end;

   SpriteGabriel.MoverData.MoveMode := Path;
   SpriteGabriel.MoverData.Speed := 1.0;  // minimum usepath
   SpriteGabriel.MoverData.MoveModePath_WPinterval  := 50; // delay
   SpriteGabriel.NotifyDestinationReached := True;

   //--------------------------------------------------

   SpriteShahira:= CharacterEngine.FindSprite('shahira');
   SpriteShahira.PositionX := 300;
   SpriteShahira.PositionY := 100;
   SpriteShahira.MoverData.MoveModePath_MovePath.Clear ;


   LastPoint := SpriteShahira.Position;

   for WayPoints := 0 to 6 do begin
     Point.X:= randomrange ( 100,500);
     Point.Y:= randomrange ( 100,500);

     tmpPath:= TList<TPoint>.Create;
     GetLinePoints( LastPoint.X, LastPoint.Y,  Point.X, Point.Y,  tmpPath );

     for I := 0 to tmpPath.Count -1 do begin
       Point2:=tmpPath[i];
       SpriteShahira.MoverData.MoveModePath_MovePath.Add(Point2);
     end;
     LastPoint := Point;
     tmpPath.Free ;


   end;

   SpriteShahira.MoverData.MoveMode := Path;
   SpriteShahira.MoverData.Speed := 1.0;  // minimum usepath
   SpriteShahira.MoverData.MoveModePath_WPinterval  := 50;
   SpriteShahira.NotifyDestinationReached := True;


end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  Theater1.MousePan := checkBox1.Checked ;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  Theater1.MouseScroll := checkBox2.Checked ;

end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  Theater1.MouseWheelZoom  :=  checkBox3.Checked ;
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
  Theater1.MouseWheelInvert  := checkBox4.Checked ;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  Theater1.MouseScrollRate  := StrToFloatDef ( edit1.Text ,0 );

end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
  Theater1.MouseWheelValue  := StrToIntDef ( edit2.Text ,0 );

end;

end.
