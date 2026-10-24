unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SpriteEngine.Core, SpriteEngine.Controls,
  Vcl.ExtCtrls, Vcl.StdCtrls, System.Generics.Collections, System.Generics.Defaults;

type
  TForm1 = class(TForm)
    Theater1: TTheater;
    BackgroundEngine: TSpriteEngine;
    CharacterEngine: TSpriteEngine;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  HealthBar: TSpriteProgressBar;
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

  CharacterEngine.CreateSprite('..\!media\gabriel_IDLE.1.bmp','gabriel',{framesX}15,{framesY}1,{Delay}5,{X}100,{Y}100,{transparent}true,1);
  CharacterEngine.CreateSprite('..\!media\shahira_IDLE.1.bmp','shahira',{framesX}15,{framesY}1,{Delay}5,{X}200,{Y}100,{transparent}true,1);

  HealthBar := CharacterEngine.CreateProgressBar('health', 200, 200, 300, 36, 10);
  HealthBar.Caption := 'HEALTH';
  HealthBar.Value := 50;
  HealthBar.Theme := ctRPG;
  HealthBar.FillColor := clRed;
  HealthBar.FontName := 'Calibri';
  HealthBar.FontSize := 14;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  aRnd :  Integer;
begin
  aRnd := Random(100 );
  HealthBar.Value := aRnd;
end;

end.
