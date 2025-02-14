unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation, FMX.StdCtrls, uLoading,
  uFunctions;

type
  TFormPrincipal = class(TForm)
    LayoutTooBar: TLayout;
    Image1: TImage;
    ImageLogo: TImage;
    LabelServicos: TLabel;
    ListBoxServicos: TListBox;
    procedure ListBoxServicosItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    {procedure ListBoxServicosClick(Sender: TObject); }
  private
    procedure AddServicosListBox(id_servico: integer; descricao,
                                               url_icone: string);
    procedure RefreshServicos;
    procedure DownloadImageListBox(lb: TListBox);
    procedure TerminateServicos(Sender: TObject);


    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.fmx}

uses UnitFrameServico, UnitReserva;

procedure TFormPrincipal.DownloadImageListBox(lb : TListBox);

var
  t : TThread;
  foto : TBitmap;
  frame : TFrameServico;

begin
    t := TThread.CreateAnonymousThread(procedure
    var
      i : integer;
      begin
          for i := 0 to lb.items.count - 1 do
          begin
              frame := TFrameServico(lb.itemByIndex(i).Components[0]);

              if frame.ImageFrameServico.TagString <> '' then
              begin
              foto := TBitmap.Create;
              LoadImageFromURL(foto, frame.ImageFrameServico.TagString);

              frame.ImageFrameServico.TagString := '';
              frame.ImageFrameServico.bitmap := foto;
              end;
          end;

      end);
    t.Start;
end;

procedure TFormPrincipal.AddServicosListBox(id_servico: integer;
                                  descricao, url_icone: string);
      var
          item : TListBoxItem;
          frame : TFrameServico;
begin

    // Adicionar o item na lista
    item := TListBoxItem.Create(ListBoxServicos);
    item.Selectable := true;
    item.Text := '';
    item.Height := 140;
    item.Tag := id_servico;

    // Frame do servi�o
    frame := TFrameServico.Create(item);
    frame.LabelLegendaServico.Text := descricao;
    frame.ImageFrameServico.TagString := url_icone;

    item.AddObject(frame);

    ListBoxServicos.AddObject(item);
end;

procedure TFormPrincipal.TerminateServicos(Sender: TObject);
begin

    TLoading.Hide;

    if Assigned(TThread(Sender).FatalException) then
    begin
        showmessage(Exception(TThread(Sender).FatalException).Message);
        exit;
    end;

    AddServicosListBox(1, 'Barba', 'https://semana-mobile.s3.us-east-1.amazonaws.com/barba.png');
    AddServicosListBox(2, 'Corte', 'https://semana-mobile.s3.us-east-1.amazonaws.com/tesoura.png');
    AddServicosListBox(3, 'Hidrata��o', 'https://semana-mobile.s3.us-east-1.amazonaws.com/secador.png');
    AddServicosListBox(4, 'Limpeza de Pele', 'https://semana-mobile.s3.us-east-1.amazonaws.com/pele.png');
    AddServicosListBox(5, 'Sobrancelha', 'https://semana-mobile.s3.us-east-1.amazonaws.com/sobrancelha.png');
    AddServicosListBox(6, 'Tintura', 'https://semana-mobile.s3.us-east-1.amazonaws.com/tintura.png');

    DownloadImageListBox(ListBoxServicos);
end;

procedure TFormPrincipal.RefreshServicos;
begin

     ListBoxServicos.Items.Clear;
     TLoading.Show(FormPrincipal, 'BarberPro...');

    TLoading.ExecuteThread(procedure
    begin
        sleep(0000);
    end, TerminateServicos);
end;

procedure TFormPrincipal.FormResize(Sender: TObject);
begin
    ListBoxServicos.Columns := Trunc(ListBoxServicos.Width / 140);
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
    RefreshServicos;
end;

procedure TFormPrincipal.ListBoxServicosItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
    if NOT Assigned(FormReserva) then
         Application.CreateForm(TFormReserva, FormReserva);

    FormReserva.Show;

end;

end.
