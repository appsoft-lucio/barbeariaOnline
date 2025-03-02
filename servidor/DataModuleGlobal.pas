unit DataModuleGlobal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, DataSet.Serialize.Config, DataSet.Serialize;

type
  TDMGlobal = class(TDataModule)
    FDConnection1: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure CarregarConfigDBSQLite(Connection: TFDConnection);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMGlobal: TDMGlobal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMGlobal.CarregarConfigDBSQLite(Connection: TFDConnection);
begin
  Connection.DriverName := 'SQLite';

  with Connection.Params do
  begin
    Clear;
    Add('DriverID=SQLite');

    //Mudar para sua pasta
    Add('Database=E:\git_hub\barbeariaOnline\servidor\dataBase\banco.db'); //Maquina Local

    Add('User_Name=');
    Add('Password=');
    Add('Port=');
    Add('Server=');
    Add('Protocol=');
    Add('LockingMode=Normal');



  end;
end;

procedure TDMGlobal.DataModuleCreate(Sender: TObject);
begin

    TDataSetSeriaLizeConfig.GetInstance.CaseNameDefinition := cndLower;
    TDataSetSeriaLizeConfig.GetInstance.Import.DecimalSeparator := '.';

    CarregarConfigDBSQLite(FDConnection1);

    FDConnection1.Connected := true;
end;

end.
