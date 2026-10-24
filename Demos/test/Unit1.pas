unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SpriteEngine.Core, Vcl.ExtCtrls, Vcl.StdCtrls, System.Generics.Collections ,System.Generics.Defaults;

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
  private
    { Private declarations }
    procedure ScaleArrows;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

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


  Background:= BackgroundEngine.CreateSprite('..\!media\nwn2.bmp','background',{framesX}1,{framesY}1,{Delay}0,{X}0,{Y}0,{transparent}false,0);
  Background.Position := Point( Background.FrameWidth div 2 , Background.FrameHeight div 2 );

  Theater1.Active := True;

  ArrowEngine.CreateSprite('..\!media\angel.bmp','xxx',{framesX}1,{framesY}1,{Delay}100,{X}300,{Y}360,{transparent}true,1);



end;
procedure TForm1.ScaleArrows;
var
  i: Integer;
begin


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
