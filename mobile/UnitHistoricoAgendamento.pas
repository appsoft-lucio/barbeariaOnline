unit UnitHistoricoAgendamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox,
  uLoading;

type
  TFormAgendamento = class(TForm)
    LayoutTooBar: TLayout;
    LabelAgendamentos: TLabel;
    ImageVoltar: TImage;
    ListBoxHistorico: TListBox;
    procedure ImageVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    procedure AddHistoricoListBox(id_reserva: integer; servico, prestador, dt,
      hora: string; ind_exclusao: boolean);
    procedure RefreshHistorico;
    procedure TerminateHistorico(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAgendamento: TFormAgendamento;

implementation

{$R *.fmx}

uses UnitFrameHistoriocoAgendamento;

procedure TFormAgendamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := TCloseAction.caFree;
    FormAgendamento := nil;
end;

procedure TFormAgendamento.FormShow(Sender: TObject);
begin
    RefreshHistorico;
end;

procedure TFormAgendamento.ImageVoltarClick(Sender: TObject);
begin
    close;
end;

procedure TFormAgendamento.AddHistoricoListBox(id_reserva: integer;
                                  servico, prestador, dt, hora: string;
                                   ind_exclusao: boolean);
      var
          item : TListBoxItem;
          frame : TFrameHistoriocoAgendamento;
begin



    // Adicionar o item na lista
    item := TListBoxItem.Create(ListBoxHistorico);
    item.Selectable := false;
    item.Text := '';
    item.height := 73;
    item.Tag := id_reserva ;

    // Frame do Horario
    frame := TFrameHistoriocoAgendamento.Create(item);
    frame.LabelServico.Text := servico;
    frame.LabelProfissionalDataHora.Text := prestador + ' - ' + dt +
                                            ' ' + hora;
    frame.ImageExcluir.Visible := ind_exclusao;

    item.AddObject(frame);

    ListBoxHistorico.AddObject(item);
end;

procedure TFormAgendamento.RefreshHistorico;
begin

     ListBoxHistorico.Items.Clear;
     TLoading.Show(FormAgendamento, 'BarberPro...');

    TLoading.ExecuteThread(procedure
    begin
        sleep(0000);
    end, TerminateHistorico);
end;

procedure TFormAgendamento.TerminateHistorico(Sender: TObject);
begin

    TLoading.Hide;

    if Assigned(TThread(Sender).FatalException) then
    begin
        showmessage(Exception(TThread(Sender).FatalException).Message);
        exit;
    end;

    AddHistoricoListBox(1, 'Corte Cabelo', 'Lúcio Cecílio', '19/01', '09:00', false);
    AddHistoricoListBox(2, 'Barba', 'Marcos Tadeu', '19/01', '10:30', false);
    AddHistoricoListBox(3, 'Hidratação', 'Fernanda Alves', '19/02', '14:00', true);
    AddHistoricoListBox(4, 'Tintura', 'Carlos Eduardo', '20/02', '09:15', true);
    AddHistoricoListBox(5, 'Corte Feminino', 'Juliana Souza', '20/02', '11:45', true);
    AddHistoricoListBox(6, 'Sobrancelha', 'Amanda Rocha', '21/02', '08:00', true);
    AddHistoricoListBox(7, 'Manicure', 'Bianca Torres', '21/02', '13:30', true);
    AddHistoricoListBox(8, 'Pedicure', 'Marta Oliveira', '21/02', '15:00', true);
    AddHistoricoListBox(9, 'Massagem', 'Rodrigo Mendes', '22/02', '17:00', true);
    AddHistoricoListBox(10, 'Depilação', 'Patrícia Silva', '22/02', '18:30', true);
    AddHistoricoListBox(11, 'Tratamento Capilar', 'Letícia Nunes', '23/02', '10:00', true);
    AddHistoricoListBox(12, 'Limpeza de Pele', 'Tatiane Ribeiro', '23/02', '14:45', true);
    AddHistoricoListBox(13, 'Maquiagem', 'Bruna Cardoso', '24/02', '16:30', true);
end;

end.
