unit Controllers;

interface

uses
  Horse,
  System.SysUtils,
  System.JSON,
  DataModuleGlobal;

procedure RegistarRotas;
procedure Login(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure InserirUsuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure RegistarRotas;
begin
  THorse.Post('/usuarios/login', Login);
  THorse.Post('/usuarios/registro', InserirUsuario);
end;

procedure Login(Req: THorseRequest; Res: THorseResponse; Next: TProc);

var
  Dm : TDmGlobal;
  body, json : TJSONObject;
  email, senha : string;

begin

  Dm := TDmGlobal.Create(nil);

  try

    try

      body := Req.Body<TJSONObject>;

      email := body.GetValue<string>('email', '');
      senha := body.GetValue<string>('senha', '');

      json := Dm.Login(email, senha);

      if json.Size = 0 then
      begin
        Res.Send('Emai ou senha iválido.').Status(401);
        FreeAndNil(json)
      end
      else
        Res.Send<TJSONObject>(json).Status(200);

    except on ex:exception do
      Res.Send('Ocorreu um erro ' + ex.Message + '.').Status(401);
    end;

  finally

    FreeAndNil(Dm);

  end;
end;

procedure InserirUsuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);

var
  Dm : TDmGlobal;
  body: TJSONObject;
  nome, email, senha : string;

begin

  Dm := TDmGlobal.Create(nil);

  try

    try

      body := Req.Body<TJSONObject>;

      nome := body.GetValue<string>('nome', '');
      email := body.GetValue<string>('email', '');
      senha := body.GetValue<string>('senha', '');

      Res.Send<TJSONObject>(Dm.InserirUsuario(nome, email, senha)).Status(201);

    except on ex:exception do
      Res.Send('Ocorreu um erro ' + ex.Message + '.').Status(401);
    end;

  finally

    FreeAndNil(Dm);

  end;
end;

end.
