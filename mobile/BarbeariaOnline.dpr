program BarbeariaOnline;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitLogin in 'UnitLogin.pas' {FormLogin},
  UnitPrincipal in 'UnitPrincipal.pas' {FormPrincipal},
  UnitFrameServico in 'frames\UnitFrameServico.pas' {FrameServico: TFrame},
  uLoading in 'Utils\uLoading.pas',
  uFunctions in 'Utils\uFunctions.pas',
  UnitReserva in 'UnitReserva.pas' {FormReserva},
  UnitFrameProfissional in 'frames\UnitFrameProfissional.pas' {FrameProfissional: TFrame},
  uCustomCalendar in 'Utils\uCustomCalendar.pas',
  UnitFrameHorario in 'frames\UnitFrameHorario.pas' {FrameHorario: TFrame},
  UnitHistoricoAgendamento in 'UnitHistoricoAgendamento.pas' {FormAgendamento},
  UnitFrameHistoriocoAgendamento in 'frames\UnitFrameHistoriocoAgendamento.pas' {FrameHistoriocoAgendamento: TFrame},
  UnitConfig in 'UnitConfig.pas' {FormConfg};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormAgendamento, FormAgendamento);
  Application.CreateForm(TFormConfg, FormConfg);
  Application.Run;
end.
