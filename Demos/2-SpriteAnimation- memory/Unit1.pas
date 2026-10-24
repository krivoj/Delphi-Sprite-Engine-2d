unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SpriteEngine.Core, Vcl.ExtCtrls, Vcl.StdCtrls, System.Generics.Collections ,System.Generics.Defaults, SpriteEngine.Bitmap;

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
    ArrowEngine: TSpriteEngine;
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Theater1SpriteMouseDown(Sender: TObject; ASprite: TSprite; Button: TMouseButton;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure ScaleArrows;
    procedure PreLoadMemoryBitmaps;
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
  Background.HitTest := False;

  Theater1.Active := True;

  ArrowEngine.CreateSprite('..\!media\arrow1.bmp','arrow1',{framesX}1,{framesY}1,{Delay}0,{X}100,{Y}560,{transparent}false,1);
  ArrowEngine.CreateSprite('..\!media\arrow2.bmp','arrow2',{framesX}1,{framesY}1,{Delay}0,{X}134,{Y}560,{transparent}false,1);
  ArrowEngine.CreateSprite('..\!media\arrow3.bmp','arrow3',{framesX}1,{framesY}1,{Delay}0,{X}134,{Y}524,{transparent}false,1);
  ArrowEngine.CreateSprite('..\!media\arrow4.bmp','arrow4',{framesX}1,{framesY}1,{Delay}0,{X}100,{Y}524,{transparent}false,1);
  ArrowEngine.CreateSprite('..\!media\arrow5.bmp','arrow5',{framesX}1,{framesY}1,{Delay}0,{X}66,{Y}524,{transparent}false,1);
  ArrowEngine.CreateSprite('..\!media\arrow6.bmp','arrow6',{framesX}1,{framesY}1,{Delay}0,{X}66,{Y}560,{transparent}false,1);


  ScaleArrows;

  PreLoadMemoryBitmaps;

  CharacterEngine.CreateSprite(gabriel.Bitmap ,'gabriel',{framesX}15,{framesY}6,{Delay}5,{X}100,{Y}100,{transparent}true,1);
  CharacterEngine.CreateSprite(shahira.Bitmap,'shahira',{framesX}15,{framesY}6,{Delay}5,{X}200,{Y}100,{transparent}true,1);
  gabriel.Free;
  shahira.Free;



end;
procedure TForm1.PreLoadMemoryBitmaps;
var
  i: Integer;
  tmp: TSpriteBitmap;
begin

  gabriel :=  TSpriteBitmap.Create ( 1920 , 128 * 6);

  tmp:= TSpriteBitmap.Create ( '..\!media\gabriel_IDLE.1.bmp');
  tmp.CopyRectTo(gabriel,0,0,0,0,1920,128, false ,0 ) ;
  tmp.Free;
  tmp:= TSpriteBitmap.Create ( '..\!media\gabriel_IDLE.2.bmp');
  tmp.CopyRectTo(gabriel,0,0,0,128,1920,128, false ,0 ) ;
  tmp.Free;
  tmp:= TSpriteBitmap.Create ( '..\!media\gabriel_IDLE.3.bmp');
  tmp.CopyRectTo(gabriel,0,0,0,256,1920,128, false ,0 ) ;
  tmp.Free;
  tmp:= TSpriteBitmap.Create ( '..\!media\gabriel_IDLE.4.bmp');
  tmp.CopyRectTo(gabriel,0,0,0,384,1920,128, false ,0 ) ;
  tmp.Free;
  tmp:= TSpriteBitmap.Create ( '..\!media\gabriel_IDLE.5.bmp');
  tmp.CopyRectTo(gabriel,0,0,0,512,1920,128, false ,0 ) ;
  tmp.Free;
  tmp:= TSpriteBitmap.Create ( '..\!media\gabriel_IDLE.6.bmp');
  tmp.CopyRectTo(gabriel,0,0,0,640,1920,128, false ,0 ) ;
  tmp.Free;

  shahira :=  TSpriteBitmap.Create ( 1920 , 128 * 6);

  tmp:= TSpriteBitmap.Create ( '..\!media\shahira_IDLE.1.bmp');
  tmp.CopyRectTo(shahira,0,0,0,0,1920,128, false ,0 ) ;
  tmp.Free;
  tmp:= TSpriteBitmap.Create ( '..\!media\shahira_IDLE.2.bmp');
  tmp.CopyRectTo(shahira,0,0,0,128,1920,128, false ,0 ) ;
  tmp.Free;
  tmp:= TSpriteBitmap.Create ( '..\!media\shahira_IDLE.3.bmp');
  tmp.CopyRectTo(shahira,0,0,0,256,1920,128, false ,0 ) ;
  tmp.Free;
  tmp:= TSpriteBitmap.Create ( '..\!media\shahira_IDLE.4.bmp');
  tmp.CopyRectTo(shahira,0,0,0,384,1920,128, false ,0 ) ;
  tmp.Free;
  tmp:= TSpriteBitmap.Create ( '..\!media\shahira_IDLE.5.bmp');
  tmp.CopyRectTo(shahira,0,0,0,512,1920,128, false ,0 ) ;
  tmp.Free;
  tmp:= TSpriteBitmap.Create ( '..\!media\shahira_IDLE.6.bmp');
  tmp.CopyRectTo(shahira,0,0,0,640,1920,128, false ,0 ) ;
  tmp.Free;


end;
procedure TForm1.ScaleArrows;
var
  i: Integer;
begin
  for I := 0 to ArrowEngine.SpriteCount -1 do begin
    ArrowEngine.Sprites [i].Scale := 50;
    ArrowEngine.Sprites[i].HitTest := True;
  end;


end;

procedure TForm1.Theater1SpriteMouseDown(Sender: TObject; ASprite: TSprite; Button: TMouseButton;
  Shift: TShiftState);
var
  SpriteGabriel, SpriteShahira: TSprite;
begin
   SpriteGabriel:= CharacterEngine.FindSprite('gabriel');
   SpriteShahira:= CharacterEngine.FindSprite('shahira');

  if ASprite.Engine = ArrowEngine then begin
    if ASprite.Guid = 'arrow1' then begin
      SpriteGabriel.FrameY := 1;
      SpriteShahira.FrameY := 1;
    end
    else if ASprite.Guid = 'arrow2' then begin
      SpriteGabriel.FrameY := 2;
      SpriteShahira.FrameY := 2;
    end
    else if ASprite.Guid = 'arrow3' then begin
      SpriteGabriel.FrameY := 3;
      SpriteShahira.FrameY := 3;
    end
    else if ASprite.Guid = 'arrow4' then begin
      SpriteGabriel.FrameY := 4;
      SpriteShahira.FrameY := 4;
    end
    else if ASprite.Guid = 'arrow5' then begin
      SpriteGabriel.FrameY := 5;
      SpriteShahira.FrameY := 5;
    end
    else if ASprite.Guid = 'arrow6' then begin
      SpriteGabriel.FrameY := 6;
      SpriteShahira.FrameY := 6;
    end

  end;


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
