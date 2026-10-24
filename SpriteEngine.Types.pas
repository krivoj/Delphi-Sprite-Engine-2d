unit SpriteEngine.Types;

interface

uses Winapi.Windows, Winapi.Messages, System.Classes, System.SysUtils, Vcl.Graphics;


type

  TSpriteDirection = ( dirForward, dirBackward );
  TFlipDirection = (FlipH, FlipV);
  TSpriteBlendMode = (
    bmNormal,
    bmAlpha,
    bmOr,
    bmAnd,
    bmXor,
    bmMaximum,
    bmMinimum,
    bmAverage,
    bmHardLight,
    bmSoftLight,
    bmReflect,
    bmStamp,
    bmLuminosity,
    bmLuminosity2
    );

  PRGB = ^TRGB;
  PRGBROW = ^RGBROW;

  PBitmapInfoHeader256 = ^TBitmapInfoHeader256;
  TBitmapInfoHeader256 = packed record
    biSize: DWORD;
    biWidth: Longint;
    biHeight: Longint;
    biPlanes: Word;
    biBitCount: Word;
    biCompression: DWORD;
    biSizeImage: DWORD;
    biXPelsPerMeter: Longint;
    biYPelsPerMeter: Longint;
    biClrUsed: DWORD;
    biClrImportant: DWORD;
    Palette: array[0..1] of TRGBQUAD;
  end;

  TRGB = packed record
    b: byte;
    g: byte;
    r: byte;
  end;
  RGBROW = array[0..Maxint div 16] of TRGB;



implementation

end.
