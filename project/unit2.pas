{******************************************************************************
  Unit Name    : ColorModelConverter
  Purpose      : Color model conversion between RGB and HSV
  Description  : This unit implements functionality to convert color values
                 between RGB (Red, Green, Blue) and HSV (Hue, Saturation, Value)
                 models, using a graphical user interface for input and output.
  Author       : Daniel Servejeira & Raphael Leiva
  Date Started : April, 2025
******************************************************************************}

unit Unit2;

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
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label1: TLabel;
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
    LabelWarning: TLabel;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    procedure ConvertButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure OutputComboBoxChange(Sender: TObject);
    procedure ResetButtonClick(Sender: TObject);
    procedure InputComboBoxChange(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure Edit1MouseUp(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: char);
    procedure Edit2MouseUp(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: char);
    procedure Edit3MouseUp(Sender: TObject);
    procedure Edit4MouseUp(Sender: TObject);
    procedure Edit5MouseUp(Sender: TObject);
    procedure Edit6MouseUp(Sender: TObject);
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

{------------------------------------------------------------------------------
  Procedure Name: ExitButtonClick
  Purpose       : Handles the click event of the Exit button. Closes the application window.
  Parameters    : Sender - the component that triggered the event (Exit button)
  Notes         : This procedure is called when the user clicks the Exit button. It closes
                  the application window, terminating the program.
------------------------------------------------------------------------------}
procedure TForm2.ExitButtonClick(Sender: TObject);
begin
  Close;
end;

{------------------------------------------------------------------------------
  Procedure Name: OutputComboBoxChange
  Purpose       : Updates the captions of Label4, Label5, and Label6 according
                  to the selected color model in the OutputComboBox.
  Parameters    : Sender - the component that triggered the event (OutputComboBox)
  Notes         : This procedure ensures that the output labels reflect the
                  chosen output color model (RGB or HSV) by displaying the
                  corresponding channel names (R/G/B or H/S/V).
------------------------------------------------------------------------------}
procedure TForm2.OutputComboBoxChange(Sender: TObject);
begin
  if OutputComboBox.Text = 'RGB' then
  begin
    Label4.Caption := 'R';
    Label5.Caption := 'G';
    Label6.Caption := 'B'
  end
  else if OutputComboBox.Text = 'HSV' then
  begin
    Label4.Caption := 'H';
    Label5.Caption := 'S';
    Label6.Caption := 'V';
  end;
end;

{------------------------------------------------------------------------------
  Procedure Name: ResetButtonClick
  Purpose       : Resets all input and output fields to their default values.
                  Sets all the text fields (Edit1, Edit2, Edit3, Edit4, Edit5, Edit6)
                  to '0' and places the focus on Edit1.
  Parameters    : Sender - the component that triggered the event (ResetButton)
  Notes         : This procedure is typically used to clear all user inputs and
                  reset the form to its initial state.
------------------------------------------------------------------------------}
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

{------------------------------------------------------------------------------
  Procedure Name: InputComboBoxChange
  Purpose       : Resets the positions of TrackBar1, TrackBar2, and TrackBar3
                  to 0 and updates label captions according to the selected
                  color model in the InputComboBox.
  Parameters    : Sender - the component that triggered the event (InputComboBox)
  Notes         : This procedure ensures that the UI reflects the selected
                  input color model (RGB or HSV) by resetting the trackbars and
                  updating Label1, Label2, and Label3 captions to R/G/B or H/S/V.
------------------------------------------------------------------------------}
procedure TForm2.InputComboBoxChange(Sender: TObject);
begin
  TrackBar1.Position := 0;
  TrackBar2.Position := 0;
  TrackBar3.Position := 0;

  if InputComboBox.Text = 'RGB' then
  begin
    Label1.Caption := 'R';
    Label2.Caption := 'G';
    Label3.Caption := 'B'
  end
  else if InputComboBox.Text = 'HSV' then
  begin
    Label1.Caption := 'H';
    Label2.Caption := 'S';
    Label3.Caption := 'V';
  end;
end;

{------------------------------------------------------------------------------
  Procedure Name: Edit1KeyPress
  Purpose       : Handles the KeyPress event for Edit1. When the Enter key is pressed,
                  the value in Edit1 is transferred to TrackBar1, and the focus is
                  shifted to Edit2.
  Parameters    : Sender - the component that triggered the event (Edit1)
                  Key    - the character key that was pressed
  Notes         : This procedure ensures that when the Enter key is pressed,
                  the value from Edit1 is used to update TrackBar1 and the focus
                  is moved to Edit2.
------------------------------------------------------------------------------}
procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Trackbar1.Position := StrToInt(Edit1.Text);
    Edit2.SetFocus;
  end;
end;

{------------------------------------------------------------------------------
  Procedure Name: Edit1MouseUp
  Purpose       : Handles the mouse-up event on the Edit1 component.
                  Selects all text in the Edit1 field when there is no text selected.
  Parameters    : Sender - the component that triggered the event (Edit1)
  Notes         : This procedure ensures that if no text is selected, the entire
                  content of Edit1 is selected when the user clicks inside the field.
------------------------------------------------------------------------------}
procedure TForm2.Edit1MouseUp(Sender: TObject);
begin
  if Edit1.SelLength = 0 then
  begin
    Edit1.SelStart := 0;
    Edit1.SelLength := Length(Edit1.Text);
  end;
end;

{------------------------------------------------------------------------------
  Procedure Name: Edit2KeyPress
  Purpose       : Handles the KeyPress event for Edit2. When the Enter key is pressed,
                  the value in Edit2 is transferred to TrackBar2, and the focus is
                  shifted to Edit3.
  Parameters    : Sender - the component that triggered the event (Edit2)
                  Key    - the character key that was pressed
  Notes         : This procedure ensures that when the Enter key is pressed,
                  the value from Edit2 is used to update TrackBar2 and the focus
                  is moved to Edit3.
------------------------------------------------------------------------------}
procedure TForm2.Edit2KeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Trackbar2.Position := StrToInt(Edit2.Text);
    Edit3.SetFocus;
  end;
end;

{------------------------------------------------------------------------------
  Procedure Name: Edit2MouseUp
  Purpose       : Handles the mouse-up event on the Edit2 component.
                  Selects all text in the Edit2 field when there is no text selected.
  Parameters    : Sender - the component that triggered the event (Edit2)
  Notes         : This procedure ensures that if no text is selected, the entire
                  content of Edit2 is selected when the user clicks inside the field.
------------------------------------------------------------------------------}
procedure TForm2.Edit2MouseUp(Sender: TObject);
begin
  if Edit2.SelLength = 0 then
  begin
    Edit2.SelStart := 0;
    Edit2.SelLength := Length(Edit2.Text);
  end;
end;

{------------------------------------------------------------------------------
  Procedure Name: Edit2KeyPress
  Purpose       : Handles the KeyPress event for Edit3. When the Enter key is pressed,
                  the value in Edit3 is transferred to TrackBar3, and the focus is
                  shifted to ConvertButton.
  Parameters    : Sender - the component that triggered the event (Edit3)
                  Key    - the character key that was pressed
  Notes         : This procedure ensures that when the Enter key is pressed,
                  the value from Edit3 is used to update TrackBar3 and the focus
                  is moved to ConvertButton.
------------------------------------------------------------------------------}
procedure TForm2.Edit3KeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Trackbar3.Position := StrToInt(Edit3.Text);
    ConvertButton.SetFocus;
  end;
end;

{------------------------------------------------------------------------------
  Procedure Name: Edit3MouseUp
  Purpose       : Handles the mouse-up event on the Edit3 component.
                  Selects all text in the Edit3 field when there is no text selected.
  Parameters    : Sender - the component that triggered the event (Edit3)
  Notes         : This procedure ensures that if no text is selected, the entire
                  content of Edit3 is selected when the user clicks inside the field.
------------------------------------------------------------------------------}
procedure TForm2.Edit3MouseUp(Sender: TObject);
begin
  if Edit3.SelLength = 0 then
  begin
    Edit3.SelStart := 0;
    Edit3.SelLength := Length(Edit3.Text);
  end;
end;

{------------------------------------------------------------------------------
  Procedure Name: Edit4MouseUp
  Purpose       : Handles the mouse-up event on the Edit4 component.
                  Selects all text in the Edit4 field when there is no text selected.
  Parameters    : Sender - the component that triggered the event (Edit4)
  Notes         : This procedure ensures that if no text is selected, the entire
                  content of Edit4 is selected when the user clicks inside the field.
------------------------------------------------------------------------------}
procedure TForm2.Edit4MouseUp(Sender: TObject);
begin
  if Edit4.SelLength = 0 then
  begin
    Edit4.SelStart := 0;
    Edit4.SelLength := Length(Edit4.Text);
  end;
end;

{------------------------------------------------------------------------------
  Procedure Name: Edit5MouseUp
  Purpose       : Handles the mouse-up event on the Edit5 component.
                  Selects all text in the Edit5 field when there is no text selected.
  Parameters    : Sender - the component that triggered the event (Edit5)
  Notes         : This procedure ensures that if no text is selected, the entire
                  content of Edit5 is selected when the user clicks inside the field.
------------------------------------------------------------------------------}
procedure TForm2.Edit5MouseUp(Sender: TObject);
begin
  if Edit5.SelLength = 0 then
  begin
    Edit5.SelStart := 0;
    Edit5.SelLength := Length(Edit5.Text);
  end;
end;

{------------------------------------------------------------------------------
  Procedure Name: Edit6MouseUp
  Purpose       : Handles the mouse-up event on the Edit6 component.
                  Selects all text in the Edit6 field when there is no text selected.
  Parameters    : Sender - the component that triggered the event (Edit6)
  Notes         : This procedure ensures that if no text is selected, the entire
                  content of Edit6 is selected when the user clicks inside the field.
------------------------------------------------------------------------------}
procedure TForm2.Edit6MouseUp(Sender: TObject);
begin
  if Edit6.SelLength = 0 then
  begin
    Edit6.SelStart := 0;
    Edit6.SelLength := Length(Edit6.Text);
  end;
end;

{------------------------------------------------------------------------------
  Procedure Name: FormShow
  Purpose       : Handles initialization actions when the form is displayed
  Parameters    : Sender - the component that triggered the event (usually Form1)
  Notes         : Sets focus to Edit1 when the form becomes visible
------------------------------------------------------------------------------}
procedure TForm2.FormShow(Sender: TObject);
begin
  Edit1.SetFocus;
end;

{------------------------------------------------------------------------------
  Procedure Name: TrackBar1Change
  Purpose       : Updates the first trackbar's maximum value and related text field
  Parameters    : Sender - the component that triggered the event (usually TrackBar1)
  Notes         : Sets the maximum range based on the selected color model (RGB or HSV)
                  and updates Edit1 with the current trackbar position
------------------------------------------------------------------------------}
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

{------------------------------------------------------------------------------
  Procedure Name: TrackBar2Change
  Purpose       : Updates the second trackbar's maximum value and related text field
  Parameters    : Sender - the component that triggered the event (usually TrackBar2)
  Notes         : Sets the maximum range based on the selected color model (RGB or HSV)
                  and updates Edit2 with the current trackbar position
------------------------------------------------------------------------------}
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

{------------------------------------------------------------------------------
  Procedure Name: TrackBar3Change
  Purpose       : Updates the third trackbar's maximum value and related text field
  Parameters    : Sender - the component that triggered the event (usually TrackBar3)
  Notes         : Sets the maximum range based on the selected color model (RGB or HSV)
                  and updates Edit3 with the current trackbar position
------------------------------------------------------------------------------}
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

{------------------------------------------------------------------------------
  Procedure Name: ConvertButtonClick
  Purpose       : Converts between RGB and HSV depending on the selected options
  Parameters    : Sender - the event source (usually the Convert button)
  Notes         : Validates input and updates output fields accordingly
------------------------------------------------------------------------------}
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
    LabelWarning.Caption := 'Valor de entrada inválido.';
    Exit;
  end;

  text1 := StrToInt(Edit1.Text);
  text2 := StrToInt(Edit2.Text);
  text3 := StrToInt(Edit3.Text);

  if ((inputComboBoxText = 'RGB') and ((text1 > 255) or (text2 > 255) or (text3 > 255))) or
     ((inputComboBoxText = 'HSV') and ((text1 > 360) or (text2 > 100) or (text3 > 100))) then
  begin
    LabelWarning.Caption := 'Valor de entrada inválido.';
  end
  else
  begin
    LabelWarning.Caption := '';

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

{------------------------------------------------------------------------------
  Procedure Name: Edit1Change
  Purpose       : Handles the Change event for Edit1. Ensures that only numeric characters
                  and commas are allowed in the input. If any invalid character is entered,
                  the last character is removed.
  Parameters    : Sender - the component that triggered the event (Edit1)
  Notes         : This procedure prevents users from entering non-numeric characters
                  or anything other than commas in the Edit1 input field. If an invalid
                  character is entered, it is removed from the input.
------------------------------------------------------------------------------}
procedure TForm2.Edit1Change(Sender: TObject);
begin
  if not ((Edit1.Text = '') or (Edit1.Text[Length(Edit1.Text)] in ['0'..'9', ','])) then
  begin
    Edit1.Text := Copy(Edit1.Text, 1, Length(Edit1.Text) - 1);
    Exit;
  end;
end;

{------------------------------------------------------------------------------
  Procedure Name: Edit2Change
  Purpose       : Handles the Change event for Edit2. Ensures that only numeric characters
                  and commas are allowed in the input. If any invalid character is entered,
                  the last character is removed.
  Parameters    : Sender - the component that triggered the event (Edit2)
  Notes         : This procedure prevents users from entering non-numeric characters
                  or anything other than commas in the Edit2 input field. If an invalid
                  character is entered, it is removed from the input.
------------------------------------------------------------------------------}
procedure TForm2.Edit2Change(Sender: TObject);
begin
  if not ((Edit2.Text = '') or (Edit2.Text[Length(Edit2.Text)] in ['0'..'9', ','])) then
  begin
    Edit2.Text := Copy(Edit2.Text, 1, Length(Edit2.Text) - 1);
    Exit;
  end;
end;

{------------------------------------------------------------------------------
  Procedure Name: Edit3Change
  Purpose       : Handles the Change event for Edit3. Ensures that only numeric characters
                  and commas are allowed in the input. If any invalid character is entered,
                  the last character is removed.
  Parameters    : Sender - the component that triggered the event (Edit3)
  Notes         : This procedure prevents users from entering non-numeric characters
                  or anything other than commas in the Edit3 input field. If an invalid
                  character is entered, it is removed from the input.
------------------------------------------------------------------------------}
procedure TForm2.Edit3Change(Sender: TObject);
begin
  if not ((Edit3.Text = '') or (Edit3.Text[Length(Edit3.Text)] in ['0'..'9', ','])) then
  begin
    Edit3.Text := Copy(Edit3.Text, 1, Length(Edit3.Text) - 1);
    Exit;
  end;
end;

end.

