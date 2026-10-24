unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,System.Math,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SpriteEngine.Core, Vcl.ExtCtrls, Vcl.StdCtrls, System.Generics.Collections ,System.Generics.Defaults, SpriteEngine.Bitmap,
  SpriteEngine.Timer;

type
  TForm1 = class(TForm)
    Theater1: TTheater;
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
    Button1: TButton;
    BackgroundEngine: TSpriteEngine;
    CharacterEngine: TSpriteEngine;
    Memo1: TMemo;
    CheckBox5: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CharacterEngineCollision(Sender: TObject; Sprite1, Sprite2: TSprite);
    procedure CharacterEngineSpriteDestinationReached(ASprite: TSprite);
    procedure CheckBox5Click(Sender: TObject);
    procedure Theater1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  Background,SpriteTree: TSprite;
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


  CharacterEngine.CreateSprite('..\!media\gabriel_WALK.bmp' ,'gabriel',{framesX}15,{framesY}6,{Delay}7,{X}100,{Y}100,{transparent}true,1);
  CharacterEngine.CreateSprite('..\!media\shahira_WALK.bmp','shahira',{framesX}15,{framesY}6,{Delay}7,{X}500,{Y}100,{transparent}true,1);

  SpriteTree := CharacterEngine.CreateSprite('..\!media\tree.bmp','tree',{framesX}2,{framesY}1,{Delay}5,{X}300,{Y}250,{transparent}true,1);
  SpriteTree.ModPriority := 170;

  CharacterEngine.CreateSprite('..\!media\barrel.bmp','barrel',{framesX}1,{framesY}1,{Delay}2000,{X}500,{Y}300,{transparent}true,1);

  Randomize;

end;

procedure TForm1.CharacterEngineCollision(Sender: TObject; Sprite1, Sprite2: TSprite);

begin
  memo1.Lines.Add( 'Collision ' + Sprite1.Guid + ' ' + Sprite2.guid );
  if ((Sprite1.guid= 'spell') and (Sprite2.guid = 'shahira' )) or ((Sprite1.guid= 'shahira') and (Sprite2.guid = 'spell' )) then begin

      if (Sprite1.LifeSpan = 0) and (Sprite1.Guid='spell') then Sprite1.LifeSpan := 10;
      if (Sprite2.LifeSpan = 0) and (Sprite2.Guid='spell') then Sprite2.LifeSpan := 10;
      if Sprite1.Guid = 'shahira' then Sprite1.DieAtEndX := True;
      if Sprite2.Guid = 'shahira' then Sprite2.DieAtEndX := True;
      if (Pos( 'shahira' , Sprite1.SpriteFileName, 1)  <> 0)  and (Pos( 'dead' , Sprite1.SpriteFileName, 1)  = 0) then
        Sprite1.ChangeBitmap('..\!media\shahira_dead.bmp', {framesX}15,{framesY}6,{Delay}5);
      if (Pos( 'shahira' , Sprite2.SpriteFileName, 1)  <> 0)  and (Pos( 'dead' , Sprite2.SpriteFileName, 1)  = 0) then
        Sprite2.ChangeBitmap('..\!media\shahira_dead.bmp', {framesX}15,{framesY}6,{Delay}5);
  end;

end;

procedure TForm1.CharacterEngineSpriteDestinationReached(ASprite: TSprite);
begin
  if aSprite.guid= 'spell' then
      if aSprite.LifeSpan = 0 then aSprite.LifeSpan := 10;

end;

procedure TForm1.Theater1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //Theater1.Angle:= Theater1.Angle+1;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  SpriteGabriel, SpriteShahira, SpriteSpell: TSprite;
begin
   SpriteShahira := CharacterEngine.FindSprite('shahira');
   if SpriteShahira = nil then
     CharacterEngine.CreateSprite('..\!media\shahira_WALK.bmp','shahira',{framesX}15,{framesY}6,{Delay}7,{X}500,{Y}100,{transparent}true,1);

   SpriteGabriel:= CharacterEngine.FindSprite('gabriel');
   SpriteShahira:= CharacterEngine.FindSprite('shahira');

   SpriteGabriel.ChangeBitmap('..\!media\gabriel_attack.bmp' ,{framesX}8,{framesY}6,{Delay}5);
   SpriteGabriel.StopAtEndX := True;
   SpriteGabriel.FrameY := 3;
   SpriteGabriel.FrameX := 1;

   SpriteSpell := CharacterEngine.CreateSprite('..\!media\spell.bmp' ,'spell',{framesX}9,{framesY}1,{Delay}5,
   {X}SpriteGabriel.Position.X ,{Y}SpriteGabriel.Position.Y,{transparent}true,2);

   SpriteSpell.MoverData.Speed := 4.0;
   SpriteSpell.MoverData.Destination := SpriteShahira.Position ;
   SpriteSpell.NotifyDestinationReached := true;
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

procedure TForm1.CheckBox5Click(Sender: TObject);
begin
  CharacterEngine.PixelCollision := CheckBox5.Checked ;
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
