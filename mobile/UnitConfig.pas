unit UnitConfig;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TFormConfg = class(TForm)
    LayoutTooBar: TLayout;
    LabelConfig: TLabel;
    ImageVoltar: TImage;
    RectangleMeusDados: TRectangle;
    Image1: TImage;
    LabelMeusDados: TLabel;
    RectangleAlterarSenha: TRectangle;
    Image2: TImage;
    LabelAlterarSenha: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ImageVoltarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormConfg: TFormConfg;

implementation

{$R *.fmx}

procedure TFormConfg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := TCloseAction.caFree;
    FormConfg := nil;
end;

procedure TFormConfg.ImageVoltarClick(Sender: TObject);
begin
    Close;
end;

end.
