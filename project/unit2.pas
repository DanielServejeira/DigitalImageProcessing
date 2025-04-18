{******************************************************************************
  Unit Name    : ColorModelConverter
  Purpose      : Color model conversion between RGB and HSV
  Description  : This unit implements functionality to convert color values
                 between RGB (Red, Green, Blue) and HSV (Hue, Saturation, Value)
                 models, using a graphical user interface for input and output.
  Author       : Daniel Servejeira and Raphael Leiva
  Date         : April, 2025
******************************************************************************}

unit Unit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  Math;

type

  { TForm2 }

  TForm2 = class(TForm)
    ConvertButton: TButton;
    ExitButton: TButton;
    ResetButton: TButton;
    InputComboBox: TComboBox;
    OutputComboBox: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    InputLabel: TLabel;
    OutputLabel: TLabel;
    Label3: TLabel;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    procedure ConvertButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure ResetButtonClick(Sender: TObject);
    procedure InputComboBoxChange(Sender: TObject);
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
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.ExitButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TForm2.ResetButtonClick(Sender: TObject);
begin
  Edit1.Text := '0';
  Edit2.Text := '0';
  Edit3.Text := '0';
  Edit4.Text := '0';
  Edit5.Text := '0';
  Edit6.Text := '0';

  Edit1.SetFocus;
end;

procedure TForm2.InputComboBoxChange(Sender: TObject);
begin
  TrackBar1.Position := 0;
  TrackBar2.Position := 0;
  TrackBar3.Position := 0;
end;

procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Trackbar1.Position := StrToInt(Edit1.Text);
    Edit2.SetFocus;
  end;
end;

procedure TForm2.Edit1MouseUp(Sender: TObject);
begin
  if Edit1.SelLength = 0 then
  begin
    Edit1.SelStart := 0;
    Edit1.SelLength := Length(Edit1.Text);
  end;
end;

procedure TForm2.Edit2Change(Sender: TObject);
begin
  if not ((Edit2.Text = '') or (Edit2.Text[Length(Edit2.Text)] in ['0'..'9', ','])) then
  begin
    Edit2.Text := Copy(Edit2.Text, 1, Length(Edit2.Text) - 1);
    Exit;
  end;
end;

procedure TForm2.Edit2KeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Edit3.SetFocus;
  end;
end;

procedure TForm2.Edit2MouseUp(Sender: TObject);
begin
  if Edit2.SelLength = 0 then
  begin
    Edit2.SelStart := 0;
    Edit2.SelLength := Length(Edit2.Text);
  end;
end;

procedure TForm2.Edit3KeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    ConvertButton.SetFocus;
  end;
end;

procedure TForm2.Edit3MouseUp(Sender: TObject);
begin
  if Edit3.SelLength = 0 then
  begin
    Edit3.SelStart := 0;
    Edit3.SelLength := Length(Edit3.Text);
  end;
end;

procedure TForm2.Edit4MouseUp(Sender: TObject);
begin
  if Edit4.SelLength = 0 then
  begin
    Edit4.SelStart := 0;
    Edit4.SelLength := Length(Edit4.Text);
  end;
end;

procedure TForm2.Edit5MouseUp(Sender: TObject);
begin
  if Edit5.SelLength = 0 then
  begin
    Edit5.SelStart := 0;
    Edit5.SelLength := Length(Edit5.Text);
  end;
end;

procedure TForm2.Edit6MouseUp(Sender: TObject);
begin
  if Edit6.SelLength = 0 then
  begin
    Edit6.SelStart := 0;
    Edit6.SelLength := Length(Edit6.Text);
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin

end;

procedure TForm2.FormShow(Sender: TObject);
begin
  Edit1.SetFocus;
end;

procedure TForm2.TrackBar1Change(Sender: TObject);
var
  inputComboBoxText: String;
begin
  inputComboBoxText := InputComboBox.Text;

  if inputComboBoxText = 'RGB' then
  begin
    TrackBar1.Max := 255
  end
  else if inputComboBoxText = 'HSV' then
  begin
    TrackBar1.Max := 360;
  end;

  Edit1.Text := IntToStr(Trackbar1.Position);
end;

procedure TForm2.TrackBar2Change(Sender: TObject);
var
  inputComboBoxText: String;
begin
  inputComboBoxText := InputComboBox.Text;

  if inputComboBoxText = 'RGB' then
  begin
    TrackBar2.Max := 255
  end
  else if inputComboBoxText = 'HSV' then
  begin
    TrackBar2.Max := 100;
  end;

  Edit2.Text := IntToStr(Trackbar2.Position);
end;

procedure TForm2.TrackBar3Change(Sender: TObject);
var
  inputComboBoxText: String;
begin
  inputComboBoxText := InputComboBox.Text;

  if inputComboBoxText = 'RGB' then
  begin
    TrackBar3.Max := 255
  end
  else if inputComboBoxText = 'HSV' then
  begin
    TrackBar3.Max := 100;
  end;

  Edit3.Text := IntToStr(Trackbar3.Position);
end;

procedure TForm2.ConvertButtonClick(Sender: TObject);
var
  text1, text2, text3: Integer;
  red, green, blue, hue, saturation, value, cMax, cMin, delta: Double;
  chroma, intermediateComponent, matchComponent: Double;
  inputComboBoxText, outputComboBoxText, output1, output2, output3: String;
begin
  inputComboBoxText := InputComboBox.Text;
  outputComboBoxText := OutputComboBox.Text;

  if (Trim(Edit1.Text) = '') or (Trim(Edit2.Text) = '') or (Trim(Edit3.Text) = '') or
     (Trim(Edit2.Text) = ',') or (Trim(Edit2.Text) = ',,') or (Trim(Edit2.Text) = ',,,') or (Trim(Edit1.Text) = ',,,,') or
     (Trim(Edit3.Text) = ',') or (Trim(Edit3.Text) = ',,') or (Trim(Edit3.Text) = ',,,') or (Trim(Edit1.Text) = ',,,,') then
  begin
    Label3.Caption := 'Valor de entrada inválido.';
    Exit;
  end;

  text1 := StrToInt(Edit1.Text);
  text2 := StrToInt(Edit2.Text);
  text3 := StrToInt(Edit3.Text);

  if ((inputComboBoxText = 'RGB') and ((text1 > 255) or (text2 > 255) or (text3 > 255))) or
     ((inputComboBoxText = 'HSV') and ((text1 > 360) or (text2 > 100) or (text3 > 100))) then
  begin
    Label3.Caption := 'Valor de entrada inválido.';
  end
  else
  begin
    Label3.Caption := '';

    if (inputComboBoxText = 'RGB') and (outputComboBoxText = 'HSV') then
    begin
      red := text1 / 255;
      green := text2 / 255;
      blue := text3 / 255;

      cMax := Max(red, Max(green, blue));
      cMin := Min(red, Min(green, blue));
      delta := cMax - cMin;

      if delta = 0 then
        hue := 0
      else if cMax = red then
        hue := 60 * ((green - blue) / delta)
      else if cMax = green then
        hue := 60 * ((blue - red) / delta) + 120
      else
        hue := 60 * ((red - green) / delta) + 240;

      if hue < 0 then
        hue := hue + 360;

      hue := Round(hue);

      if cMax = 0 then
        saturation := 0
      else
        saturation := delta / cMax;

      value := cMax;

      saturation := saturation * 100;
      value := value * 100;

      output1 := FloatToStr(hue);
      output2 := FloatToStr(saturation);
      output3 := FloatToStr(value);

      Edit4.Text := output1;
      Edit5.Text := output2;
      Edit6.Text := output3;

    end
    else if (inputComboBoxText = 'HSV') and (outputComboBoxText = 'RGB') then
    begin
      hue := text1;
      saturation := text2 / 100;
      value := text3 / 100;

      chroma := value * saturation;
      intermediateComponent := chroma * (1 - Abs((hue / 60) mod 2 - 1));
      matchComponent := value - chroma;

      if (hue >= 0) and (hue < 60) then
      begin
        red := chroma;
        green := intermediateComponent;
        blue := 0;
      end
      else if (hue >= 60) and (hue < 120) then
      begin
        red := intermediateComponent;
        green := chroma;
        blue := 0;
      end
      else if (hue >= 120) and (hue < 180) then
      begin
        red := 0;
        green := chroma;
        blue := intermediateComponent;
      end
      else if (hue >= 180) and (hue < 240) then
      begin
        red := 0;
        green := intermediateComponent;
        blue := chroma;
      end
      else if (hue >= 240) and (hue < 300) then
      begin
        red := intermediateComponent;
        green := 0;
        blue := chroma;
      end
      else
      begin
        red := chroma;
        green := 0;
        blue := intermediateComponent;
      end;

      red := (red + matchComponent) * 255;
      green := (green + matchComponent) * 255;
      blue := (blue + matchComponent) * 255;

      output1 := IntToStr(Round(red));
      output2 := IntToStr(Round(green));
      output3 := IntToStr(Round(blue));

      Edit4.Text := output1;
      Edit5.Text := output2;
      Edit6.Text := output3;
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

