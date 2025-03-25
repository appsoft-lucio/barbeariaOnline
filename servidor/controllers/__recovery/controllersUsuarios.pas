unit controllersUsuarios;

interface

uses Horse,
     System.SysUtils,
     System.JSON,
     DataModuleGlobal;

procedure RegistrarRotas;
procedure Login(Req: THorseRequest; Res: THorseResponse; Nest: TProc);
procedure InserirNovoUsuario(Req: THorseRequest; Res: THorseResponse;
                             Nest: TProc);

implementation

procedure RegistrarRotas;
begin
    THorse.Post('/usuarios/login', Login);
    THorse.Post('/usuarios/registro', InserirNovoUsuario);
end;

procedure Login(Req: THorseRequest; Res: THorseResponse; Nest: TProc);
begin

end;

procedure InserirNovoUsuario(Req: THorseRequest; Res: THorseResponse;
                             Nest: TProc);
begin

end;

end.
