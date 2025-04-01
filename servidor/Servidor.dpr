program Servidor;

uses
  Vcl.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {FormPrincipal},
  DataModuleGlobal in 'DataModuleGlobal.pas' {DmGlobal: TDataModule},
  Controllers in 'Controllers\Controllers.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
