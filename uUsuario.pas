unit uUsuario;

interface
uses
  System.Classes, DMBanco, FireDAC.Comp.Client,FireDAC.DApt, System.SysUtils;

type TUsuario = class(TObject)
  private
    Fsenha_usuario: String;
    Fnome_usuario: String;
    Fid: Integer;
    procedure Limpar;
    class var Finstance: TUsuario;
    procedure Setnome_usuario(const Value: String);
    procedure Setsenha_usuario(const Value: String);
    constructor Create(AOwner: TComponent);
    procedure SetConexao;
  public
    fMsgExec : string;
    fQuery : TFDQuery;
    fConexao : TFDConnection;
    function salvar : Boolean;
    function logar : Boolean;
    property id : Integer read Fid;
    property nome_usuario : String read Fnome_usuario write Setnome_usuario;
    property senha_usuario : String read Fsenha_usuario write Setsenha_usuario;
    function isLogado : Boolean;
    class function GetInstance: TUsuario;
    destructor Destroy; override;

end;

implementation

uses
  System.Hash;

{ Usuario }

procedure TUsuario.SetConexao;
begin
  if not Assigned(fQuery) then
     fQuery := TFDQuery.Create(nil);
  fConexao := TDataModule1.GetInstance.ConBD;
  fConexao.Connected := False;
  fConexao.Connected := True;
  fQuery.Connection := fConexao;
end;

function TUsuario.logar: Boolean;
begin
  //Logar
  Result := False;
  fMsgExec := '';
  if (Trim(nome_usuario) = '') or (Trim(senha_usuario) = '') then
  begin
    fMsgExec := 'Preencha todos os campos!';
    Exit;
  end;
  SetConexao;

  fQuery.SQL.Clear;
  fQuery.SQL.Add('select usu.id from USUARIOS usu where usu.nome_usuario = :nome_usuario and usu.senha_usuario = :senha_usuario');
  fQuery.ParamByName('nome_usuario').AsString := Trim(Fnome_usuario);
  fQuery.ParamByName('senha_usuario').AsString := THashMD5.GetHashString(Trim(Fsenha_usuario));
  fQuery.Open;

  if fQuery.IsEmpty then
     fMsgExec := 'Dados incorretos ou usuário não cadastrado!'
  else
  begin
    Result := True;
    Fid := fQuery.FieldByName('id').AsInteger;
  end;
  fQuery.Close;
end;

function TUsuario.salvar: Boolean;
begin
  Result := false;
  if (Trim(nome_usuario) = '') or (Trim(senha_usuario) = '') then
  begin
    fMsgExec := 'Preencha todos os campos!';
    Exit;
  end;

  fMsgExec := '';
  SetConexao;
  //Salvar
  if Fid <= 0 then
  begin
    fQuery.SQL.Clear;
    //Verificar se existe o Usuário
    fQuery.SQL.Add('select usu.id from USUARIOS usu where usu.nome_usuario = :nome_usuario');
    fQuery.ParamByName('nome_usuario').AsString := Fnome_usuario;
    fQuery.Open;
    if fQuery.IsEmpty then
    begin
      fQuery.SQL.Clear;
      fQuery.SQL.Add('insert into USUARIOS (nome_usuario, senha_usuario) values (:nome,:senha);');
      fQuery.ParamByName('nome').AsString := Trim(Fnome_usuario);
      fQuery.ParamByName('senha').AsString := THashMD5.GetHashString(Trim(Fsenha_usuario));
      fQuery.ExecSQL;
      fMsgExec := 'Usuário cadastrado com sucesso!';
      Result := True;
    end
    else
       fMsgExec := 'Usuário já cadastrado!';

    Limpar;
  end;

  fQuery.Close;
end;

constructor TUsuario.Create(AOwner: TComponent);
begin
  Fid := 0;
end;

destructor TUsuario.Destroy;
begin
  inherited;
  Finstance := nil;
end;

procedure TUsuario.Limpar;
begin
  Fid := 0;
  Fnome_usuario := '';
  Fsenha_usuario := '';
end;

class function TUsuario.GetInstance: TUsuario;
begin
  if not Assigned(Finstance) then
     Finstance := TUsuario.Create(nil);
  Result := Finstance;
end;

function TUsuario.isLogado: Boolean;
begin
  Result := Fid > 0;
end;

procedure TUsuario.Setnome_usuario(const Value: String);
begin
  Fnome_usuario := Value;
end;

procedure TUsuario.Setsenha_usuario(const Value: String);
begin
  Fsenha_usuario := Value;
end;

end.
