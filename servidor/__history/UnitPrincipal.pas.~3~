unit UnitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TFormPrincipal = class(TForm)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

 uses Horse,
      Horse.Jhonson,
      Horse.CORS;
procedure TFormPrincipal.FormShow(Sender: TObject);
begin
    THorse.Use(Jhonson());
    THorse.Use(CORS);

    THorse.Listen(3000);
end;

end.
