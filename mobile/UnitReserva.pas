unit UnitReserva;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListBox,
  uLoading, FMX.TabControl, uCustomCalendar;

type
  TFormReserva = class(TForm)
    LayoutTooBar: TLayout;
    ImageVoltar: TImage;
    LabelReservas: TLabel;
    LabelHidrata��o: TLabel;
    LabelEscolhaProfissional: TLabel;
    ListBoxProfissionais: TListBox;
    TabControlReservas: TTabControl;
    TabItemProfissionais: TTabItem;
    TabItemCalendar: TTabItem;
    RectangleFundoProfissionais: TRectangle;
    RectangleFundoCalendar: TRectangle;
    Label1: TLabel;
    LabelEscolhaData: TLabel;
    ListBoxHorario: TListBox;
    LayoutCalendar: TLayout;
    LabelHorario: TLabel;
    RectangleBtnReserva: TRectangle;
    SpeedButtonReserva: TSpeedButton;
    LayoutMes: TLayout;
    LabelMes: TLabel;
    ImagePrevious: TImage;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure ImageVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListBoxProfissionaisItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListBoxHorarioItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure ImagePreviousClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    cal : TCustomCalendar;
    procedure RefreshProfissionais;
    procedure TerminateProfissionais(Sender: TObject);
    procedure AddProfissionalListBox(id_prestador: integer; nome: string;
      valor: double);
    procedure DayClick(Sender: TObject);
    procedure ListarHorarios;
    procedure TerminateHorario(Sender: TOBject);
    procedure AddHorarioListBox(id_horario: integer; hora: string);
    procedure SelecionarHorario(item: TListBoxItem);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormReserva: TFormReserva;

implementation

{$R *.fmx}

uses UnitFrameProfissional, UnitFrameHorario;

procedure TFormReserva.SelecionarHorario(item: TListBoxItem);

var
  frame : TFrameHorario;
  item_frame : TListBoxItem;
  i : integer;

begin

    SpeedButtonReserva.Enabled := true;
    RectangleBtnReserva.Opacity := 1;

    //Deixar o restantes dos frames escuros
    for i := 0 to ListBoxHorario.Items.Count -1 do
    begin
        item_frame := ListBoxHorario.ItemByIndex(i);

        frame := TFrameHorario(item_frame.Components[0]);
        frame.RectangleHorario.Fill.Color := $FF232323;
        frame.LabelHorario.FontColor := $FFFFFFFF;
        frame.LabelHorario.Font.Size := 14;
        frame.RectangleHorario.Stroke.Kind := TBrushKind.None;

    end;


    //Estilzar o frame selecionado
    frame := TFrameHorario(item.Components[0]);
    frame.RectangleHorario.Fill.Color := $FFFE9900;
    frame.LabelHorario.FontColor := $FF000000;
    frame.LabelHorario.Font.Size := 18;
    frame.RectangleHorario.Stroke.Kind := TBrushKind.Solid;
    frame.RectangleHorario.Stroke.Color := TAlphaColorRec.White;
    frame.RectangleHorario.Stroke.Thickness := 2;

end;

procedure TFormReserva.AddHorarioListBox(id_horario: integer;
                                  hora: string);
      var
          item : TListBoxItem;
          frame : TFrameHorario;
begin



    // Adicionar o item na lista
    item := TListBoxItem.Create(ListBoxHorario);
    item.Selectable := false;
    item.Text := '';
    item.Width := 60;
    item.Tag := id_horario;

    // Frame do Horario
    frame := TFrameHorario.Create(item);
    frame.LabelHorario.Text := hora;

    item.AddObject(frame);

    ListBoxHorario.AddObject(item);
end;

procedure TFormReserva.TerminateHorario(Sender: TOBject);
begin
    TLoading.Hide;

    if Assigned(TThread(Sender).FatalException) then
    begin
        showmessage(Exception(TThread(Sender).FatalException).Message);
        exit;
    end;
    AddHorarioListBox(1, '09:00');
    AddHorarioListBox(2, '10:00');
    AddHorarioListBox(3, '11:00');
    AddHorarioListBox(4, '13:00');
    AddHorarioListBox(5, '14:00');
end;

procedure TFormReserva.ListarHorarios;
begin

    SpeedButtonReserva.Enabled := false;
    RectangleBtnReserva.Opacity := 0.5;

    LabelMes.Text := cal.MonthName;
    ListBoxHorario.Items.clear;

    TLoading.Show(FormReserva);

    TLoading.ExecuteThread(procedure
    begin
        //Acessar API...
    end, TerminateHorario);
end;

procedure TFormReserva.AddProfissionalListBox(id_prestador: integer;
                                  nome: string; valor: double);
      var
          item : TListBoxItem;
          frame : TFrameProfissional;
begin

    // Adicionar o item na lista
    item := TListBoxItem.Create(ListBoxProfissionais);
    item.Selectable := false;
    item.Text := '';
    item.Height := 60;
    item.Tag := id_prestador;

    // Frame do servi�o
    frame := TFrameProfissional.Create(item);
    frame.LabelProfissional.Text := nome;
    frame.LabelValor.Text := FormatFloat('R$ #,##0.00', valor);

    item.AddObject(frame);

    ListBoxProfissionais.AddObject(item);
end;

procedure TFormReserva.TerminateProfissionais(Sender: TObject);
begin

    TLoading.Hide;

    if Assigned(TThread(Sender).FatalException) then
    begin
        showmessage(Exception(TThread(Sender).FatalException).Message);
        exit;
    end;

    AddProfissionalListBox(1, 'L�cio Cec�lio J�nior', 50);
    AddProfissionalListBox(2, 'L�cio Cec�lio J�nior', 35);
    AddProfissionalListBox(3, 'L�cio Cec�lio J�nior', 50);
    AddProfissionalListBox(4, 'L�cio Cec�lio J�nior', 120);
    AddProfissionalListBox(5, 'L�cio Cec�lio J�nior', 99.99);
    AddProfissionalListBox(6, 'L�cio Cec�lio J�nior', 12);
end;

procedure TFormReserva.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := TCloseAction.caFree;
    formReserva := nil;
end;

procedure TFormReserva.DayClick(Sender: TObject);
begin
    //showmessage(FormatDateTime('dd/mm/yyyy', cal.SelectedDate));
    ListarHorarios;
end;

procedure TFormReserva.FormCreate(Sender: TObject);
begin

    TabControlReservas.ActiveTab := TabItemProfissionais;

  
    //Montar calend�rio
    cal := TCustomCalendar.Create(LayoutCalendar);
    cal.OnClick := DayClick;

    //Setup calend�rio
    cal.DayFontSize := 14;
    cal.DayFontColor := $FFFFFFFF;
    cal.SelectedDayColor := $FFFE9900;
    cal.BackgroundColor := $FF232323;

    cal.ShowCalendar;

end;

procedure TFormReserva.FormDestroy(Sender: TObject);
begin
    cal.Free;
end;

procedure TFormReserva.FormShow(Sender: TObject);
begin
    RefreshProfissionais;
end;

procedure TFormReserva.Image1Click(Sender: TObject);
begin
    cal.NextMonth;
    ListarHorarios;
end;

procedure TFormReserva.ImagePreviousClick(Sender: TObject);
begin
    cal.PriorMonth;
    ListarHorarios;
end;

procedure TFormReserva.ImageVoltarClick(Sender: TObject);
begin
    close;
end;

procedure TFormReserva.ListBoxHorarioItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
    SelecionarHorario(Item);
end;

procedure TFormReserva.ListBoxProfissionaisItemClick(
  const Sender: TCustomListBox; const Item: TListBoxItem);
begin
    ListarHorarios;
    TabControlReservas.GotoVisibleTab(1);
end;

procedure TFormReserva.RefreshProfissionais;
begin

     ListBoxProfissionais.Items.Clear;
     TLoading.Show(FormReserva, 'BarberPro...');

    TLoading.ExecuteThread(procedure
    begin
        sleep(0000);
    end, TerminateProfissionais);
end;

end.
