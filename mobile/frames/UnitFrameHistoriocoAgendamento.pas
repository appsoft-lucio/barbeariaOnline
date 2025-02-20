unit UnitFrameHistoriocoAgendamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
  TFrameHistoriocoAgendamento = class(TFrame)
    RectangleProfissional: TRectangle;
    LabelProfissionalDataHora: TLabel;
    LabelServico: TLabel;
    ImageExcluir: TImage;
    Layout1: TLayout;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
