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
    procedure Theater1TheaterMouseMove(Sender: TObject; VisibleX, VisibleY, VirtualX, VirtualY: Integer; Shift: TShiftState);
    procedure ThreadTimer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CharacterEngineSpriteDestinationReached(ASprite: TSprite);
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
  ShowMessage( ASprite.Guid + ' reached destination point.');
end;

procedure TForm1.Theater1TheaterMouseMove(Sender: TObject; VisibleX, VisibleY, VirtualX, VirtualY: Integer; Shift: TShiftState);
var
  SpriteGabriel, SpriteShahira: TSprite;
begin

   SpriteGabriel:= CharacterEngine.FindSprite('gabriel');
   SpriteShahira:= CharacterEngine.FindSprite('shahira');

   SpriteGabriel.MoverData.Destination := Point(VirtualX, VirtualY);
   SpriteShahira.MoverData.Destination := Point(VirtualX, VirtualY);
   SpriteGabriel.NotifyDestinationReached := True;
   SpriteShahira.NotifyDestinationReached := True;

   SpriteGabriel.MoverData.Speed := 2.0;
   SpriteShahira.MoverData.Speed := 2.0;

end;

procedure TForm1.ThreadTimer1Timer(Sender: TObject);
var
  SpriteGabriel, SpriteShahira: TSprite;
begin

   SpriteGabriel:= CharacterEngine.FindSprite('gabriel');
   SpriteShahira:= CharacterEngine.FindSprite('shahira');
   SpriteGabriel.FrameY :=  GetIsoDirection ( SpriteGabriel.Position.X, SpriteGabriel.Position.Y,
                                              SpriteGabriel.MoverData.Destination.X,SpriteGabriel.MoverData.Destination.Y);
   SpriteShahira.FrameY :=  GetIsoDirection ( SpriteShahira.Position.X, SpriteShahira.Position.Y,
                                              SpriteShahira.MoverData.Destination.X,SpriteShahira.MoverData.Destination.Y);

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  SpriteGabriel, SpriteShahira: TSprite;
begin

   SpriteGabriel:= CharacterEngine.FindSprite('gabriel');
   SpriteShahira:= CharacterEngine.FindSprite('shahira');
   SpriteGabriel.PositionX := 100;
   SpriteGabriel.PositionY := randomrange ( 50,580);
   SpriteShahira.PositionX := 1000;
   SpriteShahira.PositionY := randomrange ( 50,580);


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
