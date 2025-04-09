unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Math;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure Edit1MouseUp(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: char);
    procedure Edit2MouseUp(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: char);
    procedure Edit3MouseUp(Sender: TObject);
    procedure Edit4MouseUp(Sender: TObject);
    procedure Edit5MouseUp(Sender: TObject);
    procedure Edit6MouseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

//Botao sair
procedure TForm2.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  Edit1.Text := '0';
  Edit2.Text := '0';
  Edit3.Text := '0';
  Edit4.Text := '0';
  Edit5.Text := '0';
  Edit6.Text := '0';

  Edit1.SetFocus;
end;

//ComboBox entrada
procedure TForm2.ComboBox1Change(Sender: TObject);
begin

end;

//Evento edit1 KeyPress
procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Edit2.SetFocus;
  end;
end;

//Evento edit1 MouseUp
procedure TForm2.Edit1MouseUp(Sender: TObject);
begin
  if Edit1.SelLength = 0 then
  begin
    Edit1.SelStart := 0;
    Edit1.SelLength := Length(Edit1.Text);
  end;
end;

//Edit2 entrada
procedure TForm2.Edit2Change(Sender: TObject);
begin
  if not ((Edit2.Text = '') or (Edit2.Text[Length(Edit2.Text)] in ['0'..'9', ','])) then
  begin
    Edit2.Text := Copy(Edit2.Text, 1, Length(Edit2.Text) - 1);
    Exit;
  end;
end;

//Evento edit2 KeyPress
procedure TForm2.Edit2KeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Edit3.SetFocus;
  end;
end;

//Evento edit2 MouseUp
procedure TForm2.Edit2MouseUp(Sender: TObject);
begin
  if Edit2.SelLength = 0 then
  begin
    Edit2.SelStart := 0;
    Edit2.SelLength := Length(Edit2.Text);
  end;
end;

//Evento edit3 KeyPress
procedure TForm2.Edit3KeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Button1.SetFocus;
  end;
end;

//Evento edit3 MouseUp
procedure TForm2.Edit3MouseUp(Sender: TObject);
begin
  if Edit3.SelLength = 0 then
  begin
    Edit3.SelStart := 0;
    Edit3.SelLength := Length(Edit3.Text);
  end;
end;

//Evento edit4 MouseUp
procedure TForm2.Edit4MouseUp(Sender: TObject);
begin
  if Edit4.SelLength = 0 then
  begin
    Edit4.SelStart := 0;
    Edit4.SelLength := Length(Edit4.Text);
  end;
end;

//Evento edit5 MouseUp
procedure TForm2.Edit5MouseUp(Sender: TObject);
begin
  if Edit5.SelLength = 0 then
  begin
    Edit5.SelStart := 0;
    Edit5.SelLength := Length(Edit5.Text);
  end;
end;

//Evento edit6 MouseUp
procedure TForm2.Edit6MouseUp(Sender: TObject);
begin
  if Edit6.SelLength = 0 then
  begin
    Edit6.SelStart := 0;
    Edit6.SelLength := Length(Edit6.Text);
  end;
end;

//Evento janela aberta
procedure TForm2.FormShow(Sender: TObject);
begin
  Edit1.SetFocus;
end;

//Botao converter
procedure TForm2.Button1Click(Sender: TObject);
var
  Text1, Text2, Text3: Integer;
  red, green, blue, hue, saturation, value, Cmax, Cmin, delta, c, x, m: Double;
  InputComboBox, OutputComboBox, Output1, Output2, Output3: String;
begin
  InputComboBox := ComboBox1.Text;
  OutputComboBox := ComboBox2.Text;

  if (Trim(Edit1.Text) = '') or (Trim(Edit2.Text) = '') or (Trim(Edit3.Text) = '') or
     (Trim(Edit2.Text) = ',') or (Trim(Edit2.Text) = ',,') or (Trim(Edit2.Text) = ',,,') or (Trim(Edit1.Text) = ',,,,') or
     (Trim(Edit3.Text) = ',') or (Trim(Edit3.Text) = ',,') or (Trim(Edit3.Text) = ',,,') or (Trim(Edit1.Text) = ',,,,') then
  begin
    Label3.Caption := 'Valor de entrada inválido.';
    Exit;
  end;

  Text1 := StrToInt(Edit1.Text);
  Text2 := StrToInt(Edit2.Text);
  Text3 := StrToInt(Edit3.Text);

  if ((InputComboBox = 'RGB') and ((Text1 > 255) or (Text2 > 255) or (Text3 > 255))) or
     ((InputComboBox = 'HSV') and ((Text1 > 360) or (Text2 > 100) or (Text3 > 100))) then
  begin
    Label3.Caption := 'Valor de entrada inválido.';
  end
  else
  begin
    Label3.Caption := '';

    if (InputComboBox = 'RGB') and (OutputComboBox = 'HSV') then
    begin
      red := Text1/255;
      green := Text2/255;
      blue := Text3/255;

      Cmax := Max(red, Max(green, blue));
      Cmin := Min(red, Min(green, blue));
      delta := Cmax - Cmin;

      if delta = 0 then
        hue := 0
      else if Cmax = red then
        hue := 60 * ((green-blue)/delta)
      else if Cmax = green then
        hue := 60 * ((blue-red)/delta) + 120
      else
        hue := 60 * ((red-green)/delta) + 240;

      if hue < 0 then
        hue := hue + 360;

      hue := Round(hue);

      if Cmax = 0 then
        saturation := 0
      else
        saturation := delta/Cmax;

      value := Cmax;

      saturation := saturation*100;
      value := value*100;

      Output1 := FloatToStr(hue);
      Output2 := FloatToStr(saturation);
      Output3 := FloatToStr(value);

      Edit4.Text := Output1;
      Edit5.Text := Output2;
      Edit6.Text := Output3;

    end
    else if (InputComboBox = 'HSV') and (OutputComboBox = 'RGB') then
    begin
      hue := Text1;
      saturation := Text2/100;
      value := Text3/100;

      c := value * saturation;
      x := c * (1-(hue/60) mod 2 - 1);
      if x < 0 then
      begin
        x := x * (-1);
      end;
      m := value - c;

      if (hue >= 0) and (hue < 60) then
      begin
        red := c;
        green := x;
        blue := 0;
      end
      else if (hue >= 60) and (hue < 120) then
      begin
        red := x;
        green := c;
        blue := 0;
      end
      else if (hue >= 120) and (hue < 180) then
      begin
        red := 0;
        green := c;
        blue := x;
      end
      else if (hue >= 180) and (hue < 240) then
      begin
        red := 0;
        green := x;
        blue := c;
      end
      else if (hue >= 240) and (hue < 300) then
      begin
        red := x;
        green := 0;
        blue := c;
      end
      else
      begin
        red := c;
        green := 0;
        blue := x;
      end;

      red := (red+m)*255;
      green := (green+m)*255;
      blue := (blue+m)*255;

      Output1 := IntToStr(Round(red));
      Output2 := IntToStr(Round(green));
      Output3 := IntToStr(Round(blue));

      Edit4.Text := Output1;
      Edit5.Text := Output2;
      Edit6.Text := Output3;
    end
    else
    begin
      Edit4.Text := Edit1.Text;
      Edit5.Text := Edit2.Text;
      Edit6.Text := Edit3.Text;
    end;

    Edit1.SetFocus;
  end;
end;


end.

