unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Edit1Change(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;

implementation

{$R *.lfm}

{ TForm3 }

//Evento janela aberta
procedure TForm3.FormShow(Sender: TObject);
begin
  Edit1.SetFocus;
end;

procedure TForm3.Edit1Change(Sender: TObject);
begin

end;

//Evento edit1 KeyPress
procedure TForm3.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Button1.SetFocus;
  end;
end;

end.

