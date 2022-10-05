unit utama;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtDlgs,
  ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    BinerBtn: TButton;
    ColorBtn: TButton;
    LoadBtn: TButton;
    EdgeDetectionBtn: TButton;
    GrayBtn: TButton;
    Image1: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure BinerBtnClick(Sender: TObject);
    procedure ColorBtnClick(Sender: TObject);
    procedure GrayBtnClick(Sender: TObject);
    procedure LoadBtnClick(Sender: TObject);
    procedure EdgeDetectionBtnClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
uses
  windows;
var
  bitmapR,bitmapG,bitmapB : array[0..10000,0..10000] of byte;

procedure TForm1.LoadBtnClick(Sender: TObject);
var
  x,y: Integer;
begin
   if OpenPictureDialog1.Execute then
   begin
     Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
     for y:= 0 to Image1.Height - 1 do
     begin
       for x:= 0 to Image1.Width - 1 do
       begin
         bitmapR[x,y]:= GetRValue(Image1.Canvas.Pixels[x,y]);
         bitmapG[x,y]:= GetGvalue(Image1.Canvas.Pixels[x,y]);
         bitmapB[x,y]:= GetBValue(Image1.Canvas.Pixels[x,y]);
       end;
     end;
   end;
end;

procedure TForm1.GrayBtnClick(Sender: TObject);
var
  x,y,gray,r,g,b,number: integer;
  pixels: array[0..8] of integer;
  isBlack: boolean;
  result: array [0..1000,0..1000] of integer;
  tempR,tempG,tempB: array[0..1000,0..1000] of byte;
begin
   //memasukan nilai setiap pixel kedalam variabel temporeri atau sementara
   for y:= 0 to Image1.Height -1 do
   begin
     for x:= 0 to Image1.Width - 1 do
     begin
         tempR[x,y]:= GetRValue(Image1.Canvas.Pixels[x,y]);
         tempG[x,y]:= GetGvalue(Image1.Canvas.Pixels[x,y]);
         tempB[x,y]:= GetBValue(Image1.Canvas.Pixels[x,y]);
     end;
   end;
   //proses binerisasi
   for y:= 0 to Image1.Height -1 do
   begin
     for x:= 0 to Image1.Width - 1 do
     begin
         r:= GetRValue(Image1.Canvas.Pixels[x,y]);
         g:= GetGvalue(Image1.Canvas.Pixels[x,y]);
         b:= GetBValue(Image1.Canvas.Pixels[x,y]);
         gray:= (r+g+b) div 3;

         if gray <= 127 then
         begin
         Image1.Canvas.Pixels[x,y]:= RGB(0,0,0);
         end
         else
         Image1.Canvas.Pixels[x,y]:= RGB(255,255,255);
     end;
   end;
   for y:= 0 to Image1.Height -1 do
   begin
     for x:= 0 to Image1.Width - 1 do
     begin
       number:=0;
       isBlack:= false;
       pixels[0]:= GetRValue(Image1.Canvas.Pixels[x-1,y+1]);
       pixels[1]:= GetRValue(Image1.Canvas.Pixels[x,Y+1]);
       pixels[2]:= GetRValue(Image1.Canvas.Pixels[x+1,y+1]);
       pixels[3]:= GetRValue(Image1.Canvas.Pixels[x-1,y]);
       pixels[4]:= GetRValue(Image1.Canvas.Pixels[x,y]);
       pixels[5]:= GetRValue(Image1.Canvas.Pixels[x+1,y]);
       pixels[6]:= GetRValue(Image1.Canvas.Pixels[x-1,y-1]);
       pixels[7]:= GetRValue(Image1.Canvas.pixels[x,y-1]);
       pixels[8]:= GetRValue(Image1.Canvas.Pixels[x+1,y-1]);

       while  number < 9  do
       begin
         if pixels[number] = 0 then
         begin
           isBlack:= True;
           break;
         end;
         number := number + 1;
       end;
       if isBlack = True then
         result[x,y]:= 0
       else
         result[x,y]:= 1;
     end;
   end;
   for y:= 0 to Image1.Height -1 do
   begin
     for x:= 0 to Image1.Width - 1 do
     begin
       r := tempR[x,y];
       g := tempG[x,y];
       b := tempB[x,y];
       gray:= (r+g+b) div 3;
       if result[x,y] = 0 then
         image1.Canvas.Pixels[x,y] := RGB(gray,gray,gray)
       else
         image1.Canvas.Pixels[x,y] := RGB(255,255,255);
     end;
   end;

end;

procedure TForm1.ColorBtnClick(Sender: TObject);
var
  x,y,gray,r,g,b,number: integer;
  pixels: array[0..8] of integer;
  isBlack: boolean;
  result,DE: array [0..1000,0..1000] of integer;
  tempR,tempG,tempB: array[0..1000,0..1000] of byte;
begin
   //memasukan nilai setiap pixel kedalam variabel temporeri atau sementara
   for y:= 0 to Image1.Height -1 do
   begin
     for x:= 0 to Image1.Width - 1 do
     begin
         tempR[x,y]:= GetRValue(Image1.Canvas.Pixels[x,y]);
         tempG[x,y]:= GetGvalue(Image1.Canvas.Pixels[x,y]);
         tempB[x,y]:= GetBValue(Image1.Canvas.Pixels[x,y]);
     end;
   end;
   //proses binerisasi
   for y:= 0 to Image1.Height -1 do
   begin
     for x:= 0 to Image1.Width - 1 do
     begin
         r:= GetRValue(Image1.Canvas.Pixels[x,y]);
         g:= GetGvalue(Image1.Canvas.Pixels[x,y]);
         b:= GetBValue(Image1.Canvas.Pixels[x,y]);
         gray:= (r+g+b) div 3;

         if gray <= 127 then
         begin
         Image1.Canvas.Pixels[x,y]:= RGB(0,0,0);
         end
         else
         Image1.Canvas.Pixels[x,y]:= RGB(255,255,255);
     end;
   end;
   for y:= 0 to Image1.Height -1 do
   begin
     for x:= 0 to Image1.Width - 1 do
     begin
       number:=0;
       isBlack:= false;
       pixels[0]:= GetRValue(Image1.Canvas.Pixels[x-1,y+1]);
       pixels[1]:= GetRValue(Image1.Canvas.Pixels[x,Y+1]);
       pixels[2]:= GetRValue(Image1.Canvas.Pixels[x+1,y+1]);
       pixels[3]:= GetRValue(Image1.Canvas.Pixels[x-1,y]);
       pixels[4]:= GetRValue(Image1.Canvas.Pixels[x,y]);
       pixels[5]:= GetRValue(Image1.Canvas.Pixels[x+1,y]);
       pixels[6]:= GetRValue(Image1.Canvas.Pixels[x-1,y-1]);
       pixels[7]:= GetRValue(Image1.Canvas.pixels[x,y-1]);
       pixels[8]:= GetRValue(Image1.Canvas.Pixels[x+1,y-1]);

       while  number < 9  do
       begin
         if pixels[number] = 0 then
         begin
           isBlack:= True;
           break;
         end;
         number := number + 1;
       end;
       if isBlack = True then
         result[x,y]:= 0
       else
         result[x,y]:= 1;
     end;
   end;
   for y:= 0 to Image1.Height -1 do
   begin
     for x:= 0 to Image1.Width - 1 do
     begin
       r := tempR[x,y];
       g := tempG[x,y];
       b := tempB[x,y];
       if result[x,y] = 0 then
         image1.Canvas.Pixels[x,y] :=RGB(r,g,b)
       else
         image1.Canvas.Pixels[x,y] := RGB(255,255,255);
     end;
   end;

end;

procedure TForm1.BinerBtnClick(Sender: TObject);
var
  x,y,gray,r,g,b,number: integer;
  pixels: array[0..8] of integer;
  isBlack: boolean;
  result: array [0..1000,0..1000] of integer;
begin
   //proses binerisasi
   for y:= 0 to Image1.Height -1 do
   begin
     for x:= 0 to Image1.Width - 1 do
     begin
         r:= GetRValue(Image1.Canvas.Pixels[x,y]);
         g:= GetGvalue(Image1.Canvas.Pixels[x,y]);
         b:= GetBValue(Image1.Canvas.Pixels[x,y]);
         gray:= (r+g+b) div 3;

         if gray <= 127 then
         begin
         Image1.Canvas.Pixels[x,y]:= RGB(0,0,0);
         end
         else
         Image1.Canvas.Pixels[x,y]:= RGB(255,255,255);
     end;
   end;
   for y:= 0 to Image1.Height -1 do
   begin
     for x:= 0 to Image1.Width - 1 do
     begin
       number:=0;
       isBlack:= false;
       pixels[0]:= GetRValue(Image1.Canvas.Pixels[x-1,y+1]);
       pixels[1]:= GetRValue(Image1.Canvas.Pixels[x,Y+1]);
       pixels[2]:= GetRValue(Image1.Canvas.Pixels[x+1,y+1]);
       pixels[3]:= GetRValue(Image1.Canvas.Pixels[x-1,y]);
       pixels[4]:= GetRValue(Image1.Canvas.Pixels[x,y]);
       pixels[5]:= GetRValue(Image1.Canvas.Pixels[x+1,y]);
       pixels[6]:= GetRValue(Image1.Canvas.Pixels[x-1,y-1]);
       pixels[7]:= GetRValue(Image1.Canvas.pixels[x,y-1]);
       pixels[8]:= GetRValue(Image1.Canvas.Pixels[x+1,y-1]);

       while  number < 9  do
       begin
         if pixels[number] = 0 then
         begin
           isBlack:= True;
           break;
         end;
         number := number + 1;
       end;
       if isBlack = True then
         result[x,y]:= 0
       else
         result[x,y]:= 1;
     end;
   end;
   for y:= 0 to Image1.Height -1 do
   begin
     for x:= 0 to Image1.Width - 1 do
     begin
       if result[x,y] = 0 then
         image1.Canvas.Pixels[x,y] := RGB(0,0,0)
       else
         image1.Canvas.Pixels[x,y] := RGB(255,255,255);
     end;
   end;

end;

procedure TForm1.EdgeDetectionBtnClick(Sender: TObject);
var
  x,y,gray,r,g,b,number: integer;
  pixels: array[0..8] of integer;
  isBlack: boolean;
  result,DE: array [0..1000,0..1000] of integer;
  tempR,tempG,tempB: array[0..1000,0..1000] of byte;

begin
   //memasukan nilai setiap pixel kedalam variabel temporeri atau sementara
   for y:= 0 to Image1.Height -1 do
   begin
     for x:= 0 to Image1.Width - 1 do
     begin
         tempR[x,y]:= GetRValue(Image1.Canvas.Pixels[x,y]);
         tempG[x,y]:= GetGvalue(Image1.Canvas.Pixels[x,y]);
         tempB[x,y]:= GetBValue(Image1.Canvas.Pixels[x,y]);
     end;
   end;
   //proses binerisasi
   for y:= 0 to Image1.Height -1 do
   begin
     for x:= 0 to Image1.Width - 1 do
     begin
         r:= GetRValue(Image1.Canvas.Pixels[x,y]);
         g:= GetGvalue(Image1.Canvas.Pixels[x,y]);
         b:= GetBValue(Image1.Canvas.Pixels[x,y]);
         gray:= (r+g+b) div 3;

         if gray <= 127 then
         begin
         Image1.Canvas.Pixels[x,y]:= RGB(0,0,0);
         end
         else
         Image1.Canvas.Pixels[x,y]:= RGB(255,255,255);
     end;
   end;
   for y:= 0 to Image1.Height -1 do
   begin
     for x:= 0 to Image1.Width - 1 do
     begin
       number:=0;
       isBlack:= false;
       pixels[0]:= GetRValue(Image1.Canvas.Pixels[x-1,y+1]);
       pixels[1]:= GetRValue(Image1.Canvas.Pixels[x,Y+1]);
       pixels[2]:= GetRValue(Image1.Canvas.Pixels[x+1,y+1]);
       pixels[3]:= GetRValue(Image1.Canvas.Pixels[x-1,y]);
       pixels[4]:= GetRValue(Image1.Canvas.Pixels[x,y]);
       pixels[5]:= GetRValue(Image1.Canvas.Pixels[x+1,y]);
       pixels[6]:= GetRValue(Image1.Canvas.Pixels[x-1,y-1]);
       pixels[7]:= GetRValue(Image1.Canvas.pixels[x,y-1]);
       pixels[8]:= GetRValue(Image1.Canvas.Pixels[x+1,y-1]);

       while  number < 9  do
       begin
         if pixels[number] = 0 then
         begin
           isBlack:= True;
           break;
         end;
         number := number + 1;
       end;
       if isBlack = True then
         result[x,y]:= 0
       else
         result[x,y]:= 1;
     end;
   end;
   for y:= 0 to Image1.Height -1 do
   begin
     for x:= 0 to Image1.Width - 1 do
     begin
       r := tempR[x,y];
       g := tempG[x,y];
       b := tempB[x,y];
       gray:= (r+g+b) div 3;
       if result[x,y] = 0 then
         image1.Canvas.Pixels[x,y] := RGB(gray,gray,gray)
       else
         image1.Canvas.Pixels[x,y] := RGB(255,255,255);
     end;
   end;

   for y:= 0 to Image1.Height -1 do
   begin
     for x:= 0 to Image1.Width - 1 do
     begin
       pixels[0]:= GetRValue(Image1.Canvas.Pixels[x-1,y+1]);
       pixels[1]:= GetRValue(Image1.Canvas.Pixels[x,Y+1]);
       pixels[2]:= GetRValue(Image1.Canvas.Pixels[x+1,y+1]);
       pixels[3]:= GetRValue(Image1.Canvas.Pixels[x-1,y]);
       pixels[4]:= GetRValue(Image1.Canvas.Pixels[x,y]);
       pixels[5]:= GetRValue(Image1.Canvas.Pixels[x+1,y]);
       pixels[6]:= GetRValue(Image1.Canvas.Pixels[x-1,y-1]);
       pixels[7]:= GetRValue(Image1.Canvas.pixels[x,y-1]);
       pixels[8]:= GetRValue(Image1.Canvas.Pixels[x+1,y-1]);

       DE[x,y] := (pixels[0]*(-1)) + (pixels[1]*(-1)) + (pixels[2]*(-1)) + (pixels[3]*(-1)) + (pixels[4]*8) + (pixels[5]*(-1)) + (pixels[6]*(-1)) + (pixels[7]*(-1)) + (pixels[8]*(-1));
     end;
   end;

   for y:= 0 to Image1.Height -1 do
   begin
     for x:= 0 to Image1.Width - 1 do
     begin
       if DE[x,y] <= 0 then
         image1.Canvas.Pixels[x,y] := RGB(255,255,255)
       else
         image1.Canvas.Pixels[x,y] := RGB(0,0,0);
     end;
   end;
end;


end.

