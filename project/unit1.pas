unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, Windows, Unit2, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ButtonDefine: TButton;
    EditDefine: TEdit;
    EditMagnitude: TEdit;
    EditDirection: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image5: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LabelDefine: TLabel;
    LabelMagnitude: TLabel;
    LabelDirection: TLabel;
    LabelWarning: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem36: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuCompressao: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Separator1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ButtonDefineClick(Sender: TObject);
    procedure EditDefineChange(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure EditDefineKeyPress(Sender: TObject; var Key: char);
    procedure EditMagnitudeChange(Sender: TObject);
    procedure EditDirectionChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem22Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
    procedure MenuItem26Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem29Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem30Click(Sender: TObject);
    procedure MenuItem32Click(Sender: TObject);
    procedure MenuItem33Click(Sender: TObject);
    procedure MenuItem34Click(Sender: TObject);
    procedure MenuItem36Click(Sender: TObject);
    procedure MenuItem37Click(Sender: TObject);
    procedure MenuItem38Click(Sender: TObject);
    procedure MenuCompressaoClick(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
  private
    magnitudeArray: array of array of Double;
    directionArray: array of array of Integer;
    activatedMag: Boolean;
    c, gama: Double;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

//Operacao inverter horizontal
procedure TForm1.MenuItem21Click(Sender: TObject);
var
  i, j: Integer;
begin
  for j:=1 to Image1.Height do
   for i:=1 to Image1.Width do
    begin
      Image2.Canvas.Pixels[i,Image1.Height-j] := Image1.Canvas.Pixels[i,j];
    end;
end;

//Operacao inverter vertical
procedure TForm1.MenuItem22Click(Sender: TObject);
var
  i, j: Integer;
begin
  for j:=1 to Image1.Height do
   for i:=1 to Image1.Width do
    begin
      Image2.Canvas.Pixels[Image1.Width-i,j] := Image1.Canvas.Pixels[i,j];
    end;
end;

//Operacao interpolacao vizinho mais proximo (10% maior)
procedure TForm1.MenuItem24Click(Sender: TObject);
var
  newWidth,newHeight, x, y, srcX, srcY: Integer;
  scaleX, scaleY: Double;
  pixelColor: TColor;
begin
  newWidth := Image1.Width + round(Image1.Width*1/10);
  newHeight := Image1.Height + round(Image1.Height*1/10);

  scaleX := Image1.Width/newWidth;
  scaleY := Image1.Height/newHeight;

  Image2.Width := newWidth;
  Image2.Height := newHeight;

  for y := 0 to newHeight-1 do
  begin
    for x := 0 to newWidth-1 do
    begin
      srcX := round(x*scaleX);
      srcY := round(y*scaleY);

      if srcX >= Image1.Width then srcX := Image1.Width-1;
      if srcY >= Image1.Height then srcY := Image1.Height-1;

      pixelColor := Image1.Canvas.Pixels[srcX,srcY];
      Image2.Canvas.Pixels[x,y] := pixelColor;
    end;
  end;
end;

//Operacao interpolacao bilinear (10% maior)
procedure TForm1.MenuItem25Click(Sender: TObject);
var
  newWidth, newHeight, x, y: Integer;
  srcX, srcY: Double;
  x0, y0, x1, y1: Integer;
  dx, dy: Double;
  pixel00, pixel01, pixel10, pixel11: TColor;
  r, g, b: Byte;
  r00, g00, b00, r01, g01, b01, r10, g10, b10, r11, g11, b11: Integer;
  pixelColor: TColor;
begin
  newWidth := Image1.Width + Round(Image1.Width*0.1);
  newHeight := Image1.Height + Round(Image1.Height*0.1);

  Image2.Width := newWidth;
  Image2.Height := newHeight;

  for y := 0 to newHeight-1 do
  begin
    for x := 0 to newWidth-1 do
    begin
      srcX := (x/newWidth) * Image1.Width;
      srcY := (y/newHeight) * Image1.Height;

      x0 := Trunc(srcX);
      y0 := Trunc(srcY);
      x1 := x0+1;
      y1 := y0+1;

      if x1 >= Image1.Width then x1 := Image1.Width-1;
      if y1 >= Image1.Height then y1 := Image1.Height-1;

      dx := srcX - x0;
      dy := srcY - y0;

      pixel00 := Image1.Canvas.Pixels[x0, y0];
      pixel01 := Image1.Canvas.Pixels[x0, y1];
      pixel10 := Image1.Canvas.Pixels[x1, y0];
      pixel11 := Image1.Canvas.Pixels[x1, y1];

      r00 := GetRValue(pixel00);
      g00 := GetGValue(pixel00);
      b00 := GetBValue(pixel00);

      r01 := GetRValue(pixel01);
      g01 := GetGValue(pixel01);
      b01 := GetBValue(pixel01);

      r10 := GetRValue(pixel10);
      g10 := GetGValue(pixel10);
      b10 := GetBValue(pixel10);

      r11 := GetRValue(pixel11);
      g11 := GetGValue(pixel11);
      b11 := GetBValue(pixel11);

      r := Round((1 - dx) * (1 - dy) * r00 + dx * (1 - dy) * r10 + (1 - dx) * dy * r01 + dx * dy * r11);
      g := Round((1 - dx) * (1 - dy) * g00 + dx * (1 - dy) * g10 + (1 - dx) * dy * g01 + dx * dy * g11);
      b := Round((1 - dx) * (1 - dy) * b00 + dx * (1 - dy) * b10 + (1 - dx) * dy * b01 + dx * dy * b11);

      pixelColor := RGB(r, g, b);
      Image2.Canvas.Pixels[x, y] := pixelColor;
    end;
  end;
end;

procedure TForm1.MenuItem26Click(Sender: TObject);
begin

end;

//Converter sistemas de cor
procedure TForm1.MenuItem27Click(Sender: TObject);
begin
  Form2 := TForm2.Create(Self);
  Form2.Show;
end;


//Operacao equalizar
procedure TForm1.MenuItem28Click(Sender: TObject);
var
  i, j, gray: Integer;
  hist, acumFreq, newValue: array[0..255] of Integer;
  pixelColor: TColor;
begin
  for i:=0 to 255 do
  begin
    hist[i] := 0;
    acumFreq[i] := 0;
  end;

  for i:=0 to 255 do
    for j:=0 to 255 do
    begin
      pixelColor := Image2.Canvas.Pixels[i,j];
      gray := GetRValue(pixelColor);
      hist[gray] := hist[gray] + 1;
    end;

  acumFreq[0] := hist[0];
  for i:=1 to 255 do
  begin
    acumFreq[i] := acumFreq[i-1] + hist[i];
  end;

  for i:=0 to 255 do
  begin
    newValue[i] := max(0, round((255*acumFreq[i])/(Image1.Height*Image1.Width)));
  end;

  for j:=0 to Image1.Height do
    for i:=0 to Image1.Width do
    begin
      pixelColor := Image1.Canvas.Pixels[i,j];
      gray := GetRValue(pixelColor);
      Image2.Canvas.Pixels[i,j] := RGB(newValue[gray], newValue[gray], newValue[gray]);
    end;
end;

//Operacao gerar ruido cores aleatorias (10 por cento)
procedure TForm1.MenuItem29Click(Sender: TObject);
var
  r, g, b, i, j, size, totalNoise, x, y: Integer;
  pixelColor: TColor;
begin
  for j:=1 to Image1.Height do
    for i:=1 to Image1.Width do
    begin
      Image2.Canvas.Pixels[i,j] := Image1.Canvas.Pixels[i,j];
    end;

  size := Image2.Width*Image2.Height;
  totalNoise := size div 10;

  for i := 0 to totalNoise do
  begin
    x := random(Image2.Width);
    y := random(Image2.Height);

    r := random(256);
    g := random(256);
    b := random(256);

    pixelColor := RGB(r,g,b);

    Image2.Canvas.Pixels[x,y] := pixelColor;
  end;
end;

//Botao de retornar a imagem para a entrada
procedure TForm1.Button1Click(Sender: TObject);
begin
  Image1.Picture := Image2.Picture;
end;

//Botao sair
procedure TForm1.Button2Click(Sender: TObject);
begin
  Close();
end;

//Botao definir
procedure TForm1.ButtonDefineClick(Sender: TObject);
var
  r, g, b, i, j, s, input: Integer;
  normR, normG, normB: Double;
  pixelColor: TColor;
  fs: TFormatSettings;
begin
  GetLocaleFormatSettings(0, fs);  // usa configurações do sistema
  fs.DecimalSeparator := ',';      // força o separador como vírgula

  if LabelDefine.Caption = 'Defina T:' then
  begin
    if TryStrToInt(EditDefine.Text, input) then
    begin
      if input > 255 then
        LabelWarning.Visible := True
      else
      begin
        LabelWarning.Visible := False;
        LabelDefine.Visible := False;
        EditDefine.Visible := False;
        ButtonDefine.Visible := False;

        for j := 1 to Image1.Height do
          for i := 1 to Image1.Width do
          begin
            pixelColor := Image1.Canvas.Pixels[i, j];
            r := GetRValue(pixelColor);
            g := GetGValue(pixelColor);
            b := GetBValue(pixelColor);

            if (r + g + b) / 3 < input then
              Image2.Canvas.Pixels[i, j] := 0
            else
              Image2.Canvas.Pixels[i, j] := RGB(r, g, b);
          end;
      end;
    end
    else
      LabelWarning.Visible := True;
  end
  else if LabelDefine.Caption = 'Defina C:' then
  begin
    if TryStrToFloat(EditDefine.Text, c, fs) and (c > 0) then
    begin
      c := StrToFloat(EditDefine.Text, fs);
      EditDefine.Clear;
      LabelDefine.Caption := 'Defina Gama:';
      EditDefine.SetFocus;
      LabelWarning.Visible := False;
    end
    else
      LabelWarning.Visible := True;
  end
  else if LabelDefine.Caption = 'Defina Gama:' then
  begin
    if TryStrToFloat(EditDefine.Text, gama, fs) and (gama > 0) then
    begin
      gama := StrToFloat(EditDefine.Text, fs);
      LabelWarning.Visible := False;
      LabelDefine.Visible := False;
      EditDefine.Visible := False;
      ButtonDefine.Visible := False;
      EditDefine.Clear;

      for i := 0 to Image1.Width - 1 do
        for j := 0 to Image1.Height - 1 do
        begin
          pixelColor := Image1.Canvas.Pixels[i, j];
          r := GetRValue(pixelColor);
          g := GetGValue(pixelColor);
          b := GetBValue(pixelColor);

          if (r = g) and (r = b) then
          begin
            normR := r / 255;
            s := Round(c * Power(normR, gama) * 255);
            s := EnsureRange(s, 0, 255);
            Image2.Canvas.Pixels[i,j] := RGB(s, s, s);
          end
          else
          begin
            normR := r / 255.0;
            normG := g / 255.0;
            normB := b / 255.0;

            r := Round(c * Power(normR, gama) * 255);
            g := Round(c * Power(normG, gama) * 255);
            b := Round(c * Power(normB, gama) * 255);

            r := EnsureRange(r, 0, 255);
            g := EnsureRange(g, 0, 255);
            b := EnsureRange(b, 0, 255);

            Image2.Canvas.Pixels[i,j] := RGB(r, g, b);
          end;
        end;
    end
    else
      LabelWarning.Visible := True;
  end;
end;

//Caixa de texto limiarizar
procedure TForm1.EditDefineChange(Sender: TObject);
begin

end;

//Evento caixa de texto limiarizar
procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then ButtonDefine.Click;
end;

//Evento editdefine keypress
procedure TForm1.EditDefineKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    ButtonDefine.SetFocus;
  end;
end;


//EditMagnitude
procedure TForm1.EditMagnitudeChange(Sender: TObject);
begin

end;

//EditDirection
procedure TForm1.EditDirectionChange(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

//Evento capturar coordenadas e rgb imagem 1
procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; x,y: Integer);
var
  pixelColor: TColor;
  r, g, b: Byte;
begin
  if (x >= 0) and (x < Image1.Width) and (y >= 0) and (y < Image1.Height) then
  begin
    pixelColor := Image1.Canvas.Pixels[x,y];
    r := GetRValue(pixelColor);
    g := GetGValue(pixelColor);
    b := GetBValue(pixelColor);

    Label3.Caption := Format('X: %d  Y: %d   Cor: RGB(%d, %d, %d)', [x, y, r, g, b]);
  end;
end;

//Evento capturar coordenadas e rgb imagem 2
procedure TForm1.Image2MouseMove(Sender: TObject; Shift: TShiftState; x,y: Integer);
var
  pixelColor: TColor;
  r, g, b: Byte;
begin
  if (x>=0) and (x<Image2.Width) and (y>=0) and (y<Image2.Height) then
  begin
    pixelColor := Image2.Canvas.Pixels[x,y];
    r := GetRValue(pixelColor);
    g := GetGValue(pixelColor);
    b := GetBValue(pixelColor);

    Label3.Caption := Format('X: %d  Y: %d   Cor: RGB(%d, %d, %d)', [x, y, r, g, b]);
  end;

  if (x >= 0) and (x < Length(magnitudeArray)) and
     (y >= 0) and (y < Length(magnitudeArray[0])) and
     (EditMagnitude.Visible = true) then
  begin
    EditMagnitude.Caption := FormatFloat('0.00', magnitudeArray[x,y]);
  end;

  if (x >= 0) and (x < Image2.Width) and (y >= 0) and (y < Image2.Height) and (activatedMag = true) then
  begin
    EditDirection.Caption := Format('%d°', [directionArray[x, y]]);
  end;
end;

//Operacao separar canal vermelho
procedure TForm1.MenuItem10Click(Sender: TObject);
var
  r, i, j: Integer;
  pixelColor : TColor;
begin
  for j:=1 to Image1.Height do
   for i:=1 to Image1.Width do
    begin
      pixelColor := Image1.Canvas.Pixels[i,j];
      r := GetRValue(pixelColor);
      Image2.Canvas.Pixels[i,j] := RGB(r,0,0);
    end;
end;

//Operacao separar canal verde
procedure TForm1.MenuItem11Click(Sender: TObject);
var
  g, i, j: Integer;
  pixelColor : TColor;
begin
  for j:=1 to Image1.Height do
   for i:=1 to Image1.Width do
    begin
      pixelColor := Image1.Canvas.Pixels[i,j];
      g := GetGValue(pixelColor);
      Image2.Canvas.Pixels[i,j] := RGB(0,g,0);
    end;
end;

//Operacao separar canal azul
procedure TForm1.MenuItem12Click(Sender: TObject);
var
  b, i, j: Integer;
  pixelColor : TColor;
begin
  for j:=1 to Image1.Height do
   for i:=1 to Image1.Width do
    begin
      pixelColor := Image1.Canvas.Pixels[i,j];
      b := GetBValue(pixelColor);
      Image2.Canvas.Pixels[i,j] := RGB(0,0,b);
    end;
end;

//Operacao separar canal cinza/vermelho
procedure TForm1.MenuItem13Click(Sender: TObject);
var
  r, i, j: Integer;
  pixelColor : TColor;
begin
  for j:=1 to Image1.Height do
   for i:=1 to Image1.Width do
    begin
      pixelColor := Image1.Canvas.Pixels[i,j];
      r := GetRValue(pixelColor);
      Image2.Canvas.Pixels[i,j] := RGB(r,r,r);
    end;
end;

//Operacao separar canal cinza/verde
procedure TForm1.MenuItem14Click(Sender: TObject);
var
  g, i, j: Integer;
  pixelColor : TColor;
begin
  for j:=1 to Image1.Height do
   for i:=1 to Image1.Width do
    begin
      pixelColor := Image1.Canvas.Pixels[i,j];
      g := GetGValue(pixelColor);
      Image2.Canvas.Pixels[i,j] := RGB(g,g,g);
    end;
end;

//Operacao separar canal cinza/azul
procedure TForm1.MenuItem15Click(Sender: TObject);
var
  b, i, j: Integer;
  pixelColor : TColor;
begin
  for j:=1 to Image1.Height do
   for i:=1 to Image1.Width do
    begin
      pixelColor := Image1.Canvas.Pixels[i,j];
      b := GetBValue(pixelColor);
      Image2.Canvas.Pixels[i,j] := RGB(b,b,b);
    end;
end;

//Operacao negativa cinza
procedure TForm1.MenuItem16Click(Sender: TObject);
var
  r, g, b, i, j, gray: Integer;
  pixelColor: TColor;
begin
  for j:=1 to Image1.Height do
    for i:=1 to Image1.Width do
    begin
      pixelColor := Image1.Canvas.Pixels[i, j];
      r := GetRValue(pixelColor);
      g := GetGValue(pixelColor);
      b := GetBValue(pixelColor);
      gray := round(0.299*r + 0.587*g + 0.114*b);

      gray := 255-gray;
      Image2.Canvas.Pixels[i,j] := RGB(gray,gray,gray);
    end;
end;


//Operacao negativa pixelColorida
procedure TForm1.MenuItem17Click(Sender: TObject);
var
  r, g, b, i, j: Integer;
  pixelColor : TColor;
begin
  for j:=1 to Image1.Height do
   for i:=1 to Image1.Width do
    begin
      pixelColor := Image1.Canvas.Pixels[i,j];
      r := GetRValue(pixelColor);
      g := GetGValue(pixelColor);
      b := GetBValue(pixelColor);
      Image2.Canvas.Pixels[i,j] := RGB(255-r,255-g,255-b);
    end;
end;

//Operacao filtro media (vizinhanca 4)
procedure TForm1.MenuItem18Click(Sender: TObject);
var
  somaR, somaG, somaB: Integer;
  i, j: Integer;
  pixelColor: TColor;
begin
  for j := 1 to Image1.Height-1 do
    for i := 1 to Image1.Width-1 do
    begin
      somaR := 0; somaG := 0; somaB := 0;

      pixelColor := Image1.Canvas.Pixels[i,j];
      somaR := GetRValue(pixelColor);
      somaG := GetGValue(pixelColor);
      somaB := GetBValue(pixelColor);

      pixelColor := Image1.Canvas.Pixels[i-1,j];
      somaR := somaR + GetRValue(pixelColor);
      somaG := somaG + GetGValue(pixelColor);
      somaB := somaB + GetBValue(pixelColor);

      pixelColor := Image1.Canvas.Pixels[i+1,j];
      somaR := somaR + GetRValue(pixelColor);
      somaG := somaG + GetGValue(pixelColor);
      somaB := somaB + GetBValue(pixelColor);

      pixelColor := Image1.Canvas.Pixels[i,j-1];
      somaR := somaR + GetRValue(pixelColor);
      somaG := somaG + GetGValue(pixelColor);
      somaB := somaB + GetBValue(pixelColor);

      pixelColor := Image1.Canvas.Pixels[i,j+1];
      somaR := somaR + GetRValue(pixelColor);
      somaG := somaG + GetGValue(pixelColor);
      somaB := somaB + GetBValue(pixelColor);

      Image2.Canvas.Pixels[i,j] := RGB(round(somaR/5),round(somaG/5),round(somaB/5));
    end;
end;

//Operacao filtro mediana 3x3
procedure TForm1.MenuItem19Click(Sender: TObject);
var
  i, j, k, l, aux: Integer;
  vetor: array[0..8] of TColor;
begin
  for j := 1 to Image1.Height-1 do
    for i := 1 to Image1.Width-1 do
    begin
      vetor[0] := Image1.Canvas.Pixels[i,j];
      vetor[1] := Image1.Canvas.Pixels[i-1,j];
      vetor[2] := Image1.Canvas.Pixels[i+1,j];
      vetor[3] := Image1.Canvas.Pixels[i,j-1];
      vetor[4] := Image1.Canvas.Pixels[i,j+1];
      vetor[5] := Image1.Canvas.Pixels[i-1,j-1];
      vetor[6] := Image1.Canvas.Pixels[i-1,j+1];
      vetor[7] := Image1.Canvas.Pixels[i+1,j+1];
      vetor[8] := Image1.Canvas.Pixels[i+1,j-1];

      for k := 0 to 7 do
        for l := k+1 to 8 do
          if vetor[k] > vetor[l] then
            begin
              aux := vetor[l];
              vetor[l] := vetor[k];
              vetor[k] := aux;
            end;

      Image2.Canvas.Pixels[i,j] := vetor[4];
    end;
end;

//Carregar imagem de entrada
procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  if (OpenDialog1.Execute)
   then Image1.Picture.LoadFromFile(OpenDialog1.FileName);
end;

//Operacao gerar ruido sal e pimenta (10 por cento)
procedure TForm1.MenuItem30Click(Sender: TObject);
var
  i, j, size, totalNoise, x, y: Integer;
  pixelColor: TColor;
begin
  for j:=1 to Image1.Height do
    for i:=1 to Image1.Width do
    begin
      Image2.Canvas.Pixels[i,j] := Image1.Canvas.Pixels[i,j];
    end;

  size := Image2.Width*Image2.Height;
  totalNoise := size div 10;

  for i := 0 to totalNoise do
  begin
    x := Random(Image2.Width);
    y := Random(Image2.Height);

    if Random(2) = 0 then
      pixelColor := RGB(0,0,0)
    else
      pixelColor := RGB(255,255,255);

    Image2.Canvas.Pixels[x,y] := pixelColor;
  end;
end;

//Operacao bilinearizar
procedure TForm1.MenuItem32Click(Sender: TObject);
var
  i, j, r, g, b: Integer;
  pixelColor: TColor;
begin
  for j:=1 to Image1.Height do
    for i:=1 to Image1.Width do
    begin
    pixelColor := Image1.Canvas.Pixels[i,j];
    r := GetRValue(pixelColor);
    g := GetGValue(pixelColor);
    b := GetBValue(pixelColor);

    if (r+g+b)/3 < 128 then
      Image2.Canvas.Pixels[i,j] := 0
    else
      Image2.Canvas.Pixels[i,j] := RGB(255,255,255);
    end;

end;

//Operacao laplaciano
procedure TForm1.MenuItem33Click(Sender: TObject);
var
  i, j: Integer;
begin
  for j:=1 to Image1.Height-1 do
    for i:=1 to Image1.Width-1 do
    begin
      Image2.Canvas.Pixels[i,j] := Image1.Canvas.Pixels[i,j]*4-
                                   Image1.Canvas.Pixels[i+1,j]-
                                   Image1.Canvas.Pixels[i-1,j]-
                                   Image1.Canvas.Pixels[i,j+1]-
                                   Image1.Canvas.Pixels[i,j-1];
    end;
end;

//Operacao limiarizar
procedure TForm1.MenuItem34Click(Sender: TObject);
  begin
    LabelMagnitude.Visible := false;
    LabelDirection.Visible := false;
    EditMagnitude.Visible := false;
    EditDirection.Visible := false;

    EditDefine.Visible := True;
    EditDefine.SetFocus;

    LabelDefine.Visible := True;
    ButtonDefine.Visible := True;
  end;

//Operacao passa alta sobel (horizontal)
procedure TForm1.MenuItem36Click(Sender: TObject);
var
  i, j, grayValue: Integer;
begin
  for i:=1 to Image1.Width-1 do
    for j:=1 to Image1.Height-1 do
    begin
    grayValue := 2*GetRValue(Image1.Canvas.Pixels[i,j+1]) + GetRValue(Image1.Canvas.Pixels[i-1,j+1]) +
                 GetRValue(Image1.Canvas.Pixels[i+1,j+1]) - 2*GetRValue(Image1.Canvas.Pixels[i,j-1]) -
                 GetRValue(Image1.Canvas.Pixels[i-1,j-1]) - GetRValue(Image1.Canvas.Pixels[i+1,j-1]);

    if grayValue < 0 then grayValue := 0;
    if grayValue > 255 then grayValue := 255;

    Image2.Canvas.Pixels[i,j] := RGB(grayValue, grayValue, grayValue);
    end;
end;

//Operacao passa alta sobel (vertical)
procedure TForm1.MenuItem37Click(Sender: TObject);
var
  i, j, grayValue: Integer;
begin
  for i:=1 to Image1.Width-1 do
    for j:=1 to Image1.Height-1 do
    begin
    grayValue := 2*GetRValue(Image1.Canvas.Pixels[i+1,j]) + GetRValue(Image1.Canvas.Pixels[i+1,j-1]) +
                 GetRValue(Image1.Canvas.Pixels[i+1,j+1]) - 2*GetRValue(Image1.Canvas.Pixels[i-1,j]) -
                 GetRValue(Image1.Canvas.Pixels[i-1,j-1]) - GetRValue(Image1.Canvas.Pixels[i-1,j+1]);

    if grayValue < 0 then grayValue := 0;
    if grayValue > 255 then grayValue := 255;

    Image2.Canvas.Pixels[i,j] := RGB(grayValue, grayValue, grayValue);
    end;
end;

//Operacao magnitude
procedure TForm1.MenuItem38Click(Sender: TObject);
var
  i, j, x, y, z, grayValue: Integer;
  gx, gy, mag: Double;
  pi: Double = 3.141592653589793;
begin
  SetLength(MagnitudeArray, Image2.Width, Image2.Height);
  SetLength(directionArray, Image2.Width, Image2.Height);

  activatedMag := true;

  for i:=1 to Image1.Width-1 do
    for j:=1 to Image1.Height-1 do
    begin
      gx := 2*GetRValue(Image1.Canvas.Pixels[i+1,j]) + GetRValue(Image1.Canvas.Pixels[i+1,j-1]) +
            GetRValue(Image1.Canvas.Pixels[i+1,j+1]) - 2*GetRValue(Image1.Canvas.Pixels[i-1,j]) -
            GetRValue(Image1.Canvas.Pixels[i-1,j-1]) - GetRValue(Image1.Canvas.Pixels[i-1,j+1]);

      gy := 2*GetRValue(Image1.Canvas.Pixels[i,j+1]) + GetRValue(Image1.Canvas.Pixels[i-1,j+1]) +
            GetRValue(Image1.Canvas.Pixels[i+1,j+1]) - 2*GetRValue(Image1.Canvas.Pixels[i,j-1]) -
            GetRValue(Image1.Canvas.Pixels[i-1,j-1]) - GetRValue(Image1.Canvas.Pixels[i+1,j-1]);

      mag := sqrt(gx*gx + gy*gy);
      magnitudeArray[i,j] := mag;

      grayValue := Round(mag*2/3);
      if grayValue < 0 then grayValue := 0;
      if grayValue > 255 then grayValue := 255;

      Image2.Canvas.Pixels[i,j] := RGB(grayValue, grayValue, grayValue);

      if gx = 0 then x:=1 else x:=0;
      if gy = 0 then y:=1 else y:=0;
      z := y*2 + x;

      case z of
        0:
        begin
          directionArray[i,j] := Round(ArcTan2(gy,gx)*180 / pi);
          if directionArray[i,j] < 0 then
            directionArray[i,j] := directionArray[i,j] + 360;
        end;
        1:
          if gy > 0 then directionArray[i,j] := 90
          else directionArray[i,j] := 270;
        2:
          if gx > 0 then directionArray[i,j] := 0
          else directionArray[i,j] := 180;
      else
        directionArray[i,j] := -1;
      end;
    end;

  for j := 0 to Image1.Height - 1 do
    for i in [0, 1, Image1.Width - 2, Image1.Width - 1] do
    begin
      Image2.Canvas.Pixels[i,j] := 0;
      directionArray[i,j] := -1;
    end;

  for i := 0 to Image1.Width - 1 do
    for j in [0, 1, Image1.Height - 2, Image1.Height - 1] do
    begin
      Image2.Canvas.Pixels[i,j] := 0;
      directionArray[i,j] := -1;
    end;

  LabelMagnitude.Visible := true;
  LabelDirection.Visible := true;
  EditMagnitude.Visible := true;
  EditDirection.Visible := true;
end;

//Menu compressao
procedure TForm1.MenuCompressaoClick(Sender: TObject);
begin
  LabelDefine.Caption := 'Defina C:';
  LabelDefine.Visible := true;
  EditDefine.Visible := true;
  ButtonDefine.Visible := true;
  EditDefine.SetFocus;
end;

//Salvar imagem de saida
procedure TForm1.MenuItem3Click(Sender: TObject);
begin
   if SaveDialog1.Execute then
    Image2.Picture.SaveToFile(SaveDialog1.Filename);
end;

//Operacao filtro media (vizinhanca 8)
procedure TForm1.MenuItem4Click(Sender: TObject);
var
  somaR, somaG, somaB, i, j: Integer;
  pixelColor: TColor;
begin
  for j:=1 to Image1.Picture.Height-1 do
    for i:=1 to Image1.Picture.Width-1 do
      begin
        somaR:=0; somaG:=0; somaB:=0;

        pixelColor := Image1.Canvas.Pixels[i,j];
        somaR := GetRValue(pixelColor);
        somaG := GetGValue(pixelColor);
        somaB := GetBValue(pixelColor);

        pixelColor := Image1.Canvas.Pixels[i-1,j];
        somaR := somaR + GetRValue(pixelColor);
        somaG := somaG + GetGValue(pixelColor);
        somaB := somaB + GetBValue(pixelColor);

        pixelColor := Image1.Canvas.Pixels[i+1,j];
        somaR := somaR + GetRValue(pixelColor);
        somaG := somaG + GetGValue(pixelColor);
        somaB := somaB + GetBValue(pixelColor);

        pixelColor := Image1.Canvas.Pixels[i,j-1];
        somaR := somaR + GetRValue(pixelColor);
        somaG := somaG + GetGValue(pixelColor);
        somaB := somaB + GetBValue(pixelColor);

        pixelColor := Image1.Canvas.Pixels[i,j+1];
        somaR := somaR + GetRValue(pixelColor);
        somaG := somaG + GetGValue(pixelColor);
        somaB := somaB + GetBValue(pixelColor);

        pixelColor := Image1.Canvas.Pixels[i-1,j-1];
        somaR := somaR + GetRValue(pixelColor);
        somaG := somaG + GetGValue(pixelColor);
        somaB := somaB + GetBValue(pixelColor);

        pixelColor := Image1.Canvas.Pixels[i-1,j+1];
        somaR := somaR + GetRValue(pixelColor);
        somaG := somaG + GetGValue(pixelColor);
        somaB := somaB + GetBValue(pixelColor);

        pixelColor := Image1.Canvas.Pixels[i+1,j+1];
        somaR := somaR + GetRValue(pixelColor);
        somaG := somaG + GetGValue(pixelColor);
        somaB := somaB + GetBValue(pixelColor);

        pixelColor := Image1.Canvas.Pixels[i+1,j-1];
        somaR := somaR + GetRValue(pixelColor);
        somaG := somaG + GetGValue(pixelColor);
        somaB := somaB + GetBValue(pixelColor);

        Image2.Canvas.Pixels[i,j] := RGB(round(somaR/9),round(SomaG/9),round(SomaB/9));

      end;
end;

//Menu operacao
procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  LabelWarning.Visible := false;
  LabelDefine.Visible := false;
  EditDefine.Visible := false;
  ButtonDefine.Visible := false;

  LabelMagnitude.Visible := false;
  LabelDirection.Visible := false;
  EditMagnitude.Visible := false;
  EditDirection.Visible := false;

  activatedMag := false;
end;

//Operacao converte para cinza
procedure TForm1.MenuItem6Click(Sender: TObject);
var
  r, g, b, gray, i, j: Integer;
  pixelColor: TColor;
begin
  for j:=1 to Image1.Height do
   for i:=1 to Image1.Width do
    begin
      pixelColor := Image1.Canvas.Pixels[i,j];
      r := GetRValue(pixelColor);
      g := GetGValue(pixelColor);
      b := GetBValue(pixelColor);
      gray := round(0.299*r + 0.587*g + 0.114*b);
      Image2.Canvas.Pixels[i,j] := RGB(gray,gray,gray);
    end;
  end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin

  end;

end.

