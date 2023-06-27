unit uAdapters;

interface
uses
 Data.DB, DBClient, System.Classes, Vcl.DBGrids, DMBanco, FireDAC.Comp.Client,FireDAC.DApt;

type
  TAdapter = class abstract
  private
    FColunas : TStringList;
    FTitColunas : TStringList;
    FDataSource : TDataSource;
    FDbGrid : TDBGrid;
  protected
    fQuery : TFDQuery;
    fConexao : TFDConnection;
  public
    procedure SetTitColunas(prTitColunas : TStringList); virtual;
    procedure SetColunas(prColunas : TStringList); virtual;
    procedure SetDataSource(prDataSource: TDataSource); virtual;
    procedure SetDBGrid(prDbGrid : TDBGrid); virtual;
    procedure MontarDbgrid; virtual;
    procedure Consulta; virtual;
    function GetSql : String; virtual; abstract;
    destructor Destroy; override;

  end;

type
  TFilmesAdapter = class(TAdapter)
  public
    constructor Create(AOwner: TComponent);
    function GetSql: string; override;

  end;

type
  TRecibosAdapter = class(TAdapter)
  public
    constructor Create(AOwner: TComponent);
    function GetSql: string; override;


  end;

implementation


{ TFilmesAdapter }

constructor TFilmesAdapter.Create(AOwner: TComponent);
var
  wTitColunas : TStringList;
  wColunas : TStringList;
begin
  wTitColunas := TStringList.Create;
  wTitColunas.Add('Id');
  wTitColunas.Add('Título');
  wTitColunas.Add('Ano');
  wTitColunas.Add('Classificação');
  wTitColunas.Add('Categorias');
  SetTitColunas(wTitColunas);

  wColunas := TStringList.Create;
  wColunas.Add('ID');
  wColunas.Add('TITULO');
  wColunas.Add('ANO_LANC');
  wColunas.Add('CLASSIFICACAO');
  wColunas.Add('CATEGORIAS');
  SetColunas(wColunas);
end;

function TFilmesAdapter.GetSql: string;
begin
  Result := 'select flm.id, flm.titulo, flm.ano_lanc, flm.classificacao, flm.categorias from FILMES flm;';
end;

{ TRecibosAdapter }

constructor TRecibosAdapter.Create(AOwner: TComponent);
var
  wTitColunas : TStringList;
  wColunas : TStringList;
begin
  wTitColunas := TStringList.Create;
  wTitColunas.Add('Id');
  wTitColunas.Add('Id Sessão');
  wTitColunas.Add('Data');
  wTitColunas.Add('Horário');
  wTitColunas.Add('Asento');
  wTitColunas.Add('Total');
  wTitColunas.Add('Forma de pagamento');
  SetTitColunas(wTitColunas);

  wColunas := TStringList.Create;
  wColunas.Add('ID');
  wColunas.Add('ID_SESSAO');
  wColunas.Add('DATA');
  wColunas.Add('HORA');
  wColunas.Add('CADEIRA');
  wColunas.Add('VALOR');
  wColunas.Add('FORMA_PAGAMENTO');
  SetColunas(wColunas);
end;

function TRecibosAdapter.GetSql: string;
begin
  Result := 'select rec.id, rec.id_sessao, rec.data, rec.hora, rec.cadeira, rec.valor, rec.forma_pagamento from RECIBOS rec;';
end;

{ TAdapter }

destructor TAdapter.Destroy;
begin
  fQuery.Close;
  fQuery.Free;
  inherited;
end;

procedure TAdapter.MontarDbgrid;
var
  wI : Integer;
  wCol : TColumn;
begin
  FDbGrid.Columns.Clear;
  for wI := 0 to Pred(FTitColunas.Count) do
  begin
    wCol := FDbGrid.Columns.Add;
    wCol.Title.Caption := FTitColunas.Strings[wI];
    wCol.FieldName := FColunas.Strings[wI];
  end;
   FDbGrid.DataSource := FDataSource;
end;

procedure TAdapter.Consulta;
begin
  if not Assigned(fQuery) then
     fQuery := TFDQuery.Create(nil);
  fConexao := TDataModule1.GetInstance.ConBD;
  fConexao.Connected := False;
  fConexao.Connected := True;
  fQuery.Connection := fConexao;

  fQuery.SQL.Clear;
  fQuery.SQL.Add(GetSQl);
  fQuery.Open();

  SetDataSource(TDataSource.Create(nil));
  FDataSource.DataSet := fQuery;
  MontarDbgrid;
end;

procedure TAdapter.SetColunas(prColunas: TStringList);
begin
  FColunas := prColunas;
end;

procedure TAdapter.SetDataSource(prDataSource: TDataSource);
begin
  FDataSource := prDataSource;
end;

procedure TAdapter.SetDBGrid(prDbGrid: TDBGrid);
begin
  FDbGrid := prDbGrid;
end;

procedure TAdapter.SetTitColunas(prTitColunas: TStringList);
begin
  FTitColunas := prTitColunas;
end;

end.
