unit UnitLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects, FMX.Edit,
  uLoading;

type
  TFormLogin = class(TForm)
    TabControlInicio: TTabControl;
    TabLogin: TTabItem;
    TabCriarConta: TTabItem;
    RectangleFundoAcessar: TRectangle;
    ImgLogo: TImage;
    LayoutLogin: TLayout;
    LabelEmail: TLabel;
    LabelSenha: TLabel;
    Edit1: TEdit;
    EditSenha: TEdit;
    RectangleBtnLogin: TRectangle;
    SpeedButtonLogin: TSpeedButton;
    LabelCriarConta: TLabel;
    RectangleFundoCriarConta: TRectangle;
    ImageLogo: TImage;
    LabelNome: TLabel;
    LabelConfirmarEmail: TLabel;
    LabelEmailCriarConta: TLabel;
    LabelSenhaCriarConta: TLabel;
    LayoutCriarConta: TLayout;
    EditNome: TEdit;
    EditEmailCriarConta: TEdit;
    EditConfirmarSenha: TEdit;
    EditSenhaCriarConta: TEdit;
    RectangleBtnCriarConta: TRectangle;
    SpeedButtonCriarConta: TSpeedButton;
    LabelJaTemConta: TLabel;
    procedure LabelCriarContaClick(Sender: TObject);
    procedure LabelJaTemContaClick(Sender: TObject);
    procedure SpeedButtonLoginClick(Sender: TObject);
    procedure SpeedButtonCriarContaClick(Sender: TObject);
  private
    procedure TerminateLogin(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation

{$R *.fmx}

uses UnitPrincipal;

procedure TFormLogin.LabelCriarContaClick(Sender: TObject);
begin
      TabControlInicio.GotoVisibleTab(1);
end;

procedure TFormLogin.LabelJaTemContaClick(Sender: TObject);
begin
     TabControlInicio.GotoVisibleTab(0);
end;

procedure TFormLogin.TerminateLogin(Sender: TObject);
begin

    TLoading.Hide;

    if Assigned(TThread(Sender).FatalException) then
    begin
        showmessage(Exception(TThread(Sender).FatalException).Message);
        exit;
    end;

    if NOT Assigned(FormPrincipal) then
        Application.CreateForm(TFormPrincipal, FormPrincipal);

    FormPrincipal.Show;

end;

procedure TFormLogin.SpeedButtonCriarContaClick(Sender: TObject);
begin

    TLoading.Show(FormLogin, 'BarberPro...');

    TLoading.ExecuteThread(procedure
    begin
        sleep(0000);
    end, TerminateLogin);

end;

procedure TFormLogin.SpeedButtonLoginClick(Sender: TObject);
begin

     TLoading.Show(FormLogin, 'BarberPro...');

    TLoading.ExecuteThread(procedure
    begin
        sleep(0000);
    end, TerminateLogin);
end;

end.
