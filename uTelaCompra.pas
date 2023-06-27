unit uTelaCompra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.DBCtrls, FireDAC.Comp.Client, FireDAC.DApt, DMBanco, Data.DB;

type
  TfrTelaCompra = class(TForm)
    pnCompraBody: TPanel;
    pnCompraHead: TPanel;
    btnCloseHead: TSpeedButton;
    pnBodyCenter: TPanel;
    lbFilmes: TLabel;
    lbHorario: TLabel;
    lb1: TLabel;
    lbAssento: TLabel;
    edAssento: TEdit;
    cbFormaPagamento: TComboBox;
    lbFormaPagamento: TLabel;
    pnBtnRealizarCompra: TPanel;
    cbDBFilmes: TDBLookupComboBox;
    cbDBSessao: TDBLookupComboBox;
    cbDBHorario: TDBLookupComboBox;
    lbValor: TLabel;
    procedure btnCloseHeadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbDBSessaoCloseUp(Sender: TObject);
    procedure cbDBFilmesCloseUp(Sender: TObject);
    procedure pnBtnMouseEnter(Sender: TObject);
    procedure pnBtnMouseLeave(Sender: TObject);
    procedure pnBtnRealizarCompraClick(Sender: TObject);
  private
    fQuery : TFDQuery;
    fConexao : TFDConnection;
    procedure CarregaCbFilmes;
    procedure CarregaCbSessao;
    procedure CarregaCbHorario;
    procedure LimparCombo(prCombo: TDBLookupComboBox; prKeyType : Integer);
  public
    { Public declarations }
  end;

var
  frTelaCompra: TfrTelaCompra;

implementation

{$R *.dfm}

procedure TfrTelaCompra.btnCloseHeadClick(Sender: TObject);
begin
  Close;
end;

procedure TfrTelaCompra.FormShow(Sender: TObject);
begin
  /////
  if not Assigned(fQuery) then
     fQuery := TFDQuery.Create(nil);
  fConexao := TDataModule1.GetInstance.ConBD;
  fConexao.Connected := False;
  fConexao.Connected := True;
  fQuery.Connection := fConexao;

  CarregaCbFilmes;

end;

procedure TfrTelaCompra.CarregaCbFilmes;
var
  wQuery : TFDQuery;
begin
  if not Assigned(cbDBFilmes.ListSource) then
     cbDBFilmes.ListSource := TDataSource.Create(Self);

  if (Assigned(cbDBFilmes.ListSource.DataSet)) and (cbDBFilmes.ListSource.DataSet is TFDQuery) then
     wQuery := cbDBFilmes.ListSource.DataSet as TFDQuery
  else
     wQuery := TFDQuery.Create(self);

  wQuery.Connection := fConexao;

  wQuery.SQL.Clear;
  wQuery.SQL.Add('select flm.id, flm.titulo from FILMES flm');
  wQuery.Open();

  cbDBFilmes.ListSource.DataSet := wQuery;
end;

procedure TfrTelaCompra.CarregaCbSessao;
var
  wQuery : TFDQuery;
  wKey: String;
begin
  if not Assigned(cbDBSessao.ListSource) then
     cbDBSessao.ListSource := TDataSource.Create(Self);

  if (Assigned(cbDBSessao.ListSource.DataSet)) and (cbDBSessao.ListSource.DataSet is TFDQuery) then
     wQuery := cbDBSessao.ListSource.DataSet as TFDQuery
  else
     wQuery := TFDQuery.Create(self);

  wQuery.Connection := fConexao;

  wkey := '-1';
  if Trim(VarToStr(cbDBFilmes.KeyValue)) <> '' then
    wKey := VarToStr(cbDBFilmes.KeyValue);

  wQuery.SQL.Clear;
  wQuery.SQL.Add('select distinct x.data from sessoes x where x.id_filme = '+ wKey+' order by data asc;');
  wQuery.Open();

  cbDBSessao.ListSource.DataSet := wQuery;
end;

procedure TfrTelaCompra.CarregaCbHorario;
var
  wQuery : TFDQuery;
  wKey: String;
  wData: TDateTime;
begin
  if not Assigned(cbDBHorario.ListSource) then
     cbDBHorario.ListSource := TDataSource.Create(Self);

  if (Assigned(cbDBHorario.ListSource.DataSet)) and (cbDBHorario.ListSource.DataSet is TFDQuery) then
     wQuery := cbDBHorario.ListSource.DataSet as TFDQuery
  else
     wQuery := TFDQuery.Create(self);

  wQuery.Connection := fConexao;

  wkey := '-1';
  if Trim(VarToStr(cbDBFilmes.KeyValue)) <> '' then
    wKey := VarToStr(cbDBFilmes.KeyValue);

  wData := 0;
  if Trim(VarToStr(cbDBSessao.KeyValue)) <> '' then
     wData := cbDBSessao.ListSource.DataSet.FieldByName('data').AsDateTime;

  wQuery.SQL.Clear;
  wQuery.SQL.Add(' select extract(HOUR from SESS.HORA_INCIO) || '+QuotedStr(':')+
                 ' || extract(MINUTE from SESS.HORA_INCIO) || '+QuotedStr(' | ')+
                 ' ||SL.NOME_SALA as HORARIO, SESS.ID, SESS.HORA_INCIO from '+
                 ' SESSOES SESS inner join SALAS SL on (SL.ID = SESS.ID_SALA) ' +
                 ' where SESS.ID_FILME = :id_filme and SESS.data = :data_sessao order by HORARIO asc');
  wQuery.ParamByName('id_filme').AsString := wKey;
  wQuery.ParamByName('data_sessao').AsDateTime := wData;
  wQuery.Open();

  cbDBHorario.ListSource.DataSet := wQuery;
end;

procedure TfrTelaCompra.cbDBFilmesCloseUp(Sender: TObject);
begin
  LimparCombo(cbDBHorario, 1);
  LimparCombo(cbDBSessao, 2);
  CarregaCbSessao;
end;

procedure TfrTelaCompra.cbDBSessaoCloseUp(Sender: TObject);
begin
  LimparCombo(cbDBHorario,1);
  CarregaCbHorario;
end;

procedure TfrTelaCompra.LimparCombo(prCombo : TDBLookupComboBox; prKeyType : Integer);
var
  wData : TDateTime;
begin
  wData := 0;
  if Assigned(prCombo.ListSource) and Assigned(prCombo.ListSource.DataSet) then
     prCombo.ListSource.DataSet.Destroy;

  case(prKeyType) of
    1: prCombo.KeyValue := -1;
    2: prCombo.KeyValue := wData;
    3: prCombo.KeyValue := '';
  end;

end;

procedure TfrTelaCompra.pnBtnMouseEnter(Sender: TObject);
begin
  TPanel(Sender).Color := TPanel(Sender).Color + $250E0F;
end;

procedure TfrTelaCompra.pnBtnMouseLeave(Sender: TObject);
begin
  TPanel(Sender).Color := TPanel(Sender).Color - $250E0F;
end;

procedure TfrTelaCompra.pnBtnRealizarCompraClick(Sender: TObject);
begin
  if (Trim(VarToStr(cbDBFilmes.KeyValue)) <> '') and
     (Trim(VarToStr(cbDBSessao.KeyValue)) <> '') and
     (Trim(VarToStr(cbDBHorario.KeyValue)) <> '') and
     (Trim(edAssento.Text) <> '') then
  begin
    fQuery.SQL.Clear;
    fQuery.SQL.Add('select count(*) from recibos rec where rec.id_sessao = :id_sessao '+
                   ' and  rec.cadeira = :assento having count(*) > 0;');
    fQuery.ParamByName('id_sessao').AsInteger := cbDBHorario.ListSource.DataSet.FieldByName('id').AsInteger;
    fQuery.ParamByName('assento').AsString := Trim(edAssento.Text);
    fQuery.Open();

    if not fQuery.IsEmpty then
    begin
      ShowMessage('Assento já ocupado!');
      edAssento.SetFocus;
      Exit;
    end;

    fQuery.SQL.Clear;
    fQuery.SQL.Add(' INSERT INTO RECIBOS (ID_SESSAO, DATA, HORA, CADEIRA, VALOR, FORMA_PAGAMENTO) ' +
               ' VALUES (:ID_SESSAO, :DATA, :HORA, :CADEIRA, :VALOR, :FORMA_PAGAMENTO); ');

    fQuery.ParamByName('ID_SESSAO').AsInteger := cbDBHorario.ListSource.DataSet.FieldByName('id').AsInteger;
    fQuery.ParamByName('DATA').AsDateTime := cbDBSessao.ListSource.DataSet.FieldByName('data').AsDateTime;
    fQuery.ParamByName('HORA').AsTime := cbDBHorario.ListSource.DataSet.FieldByName('HORA_INCIO').AsDateTime;
    fQuery.ParamByName('CADEIRA').AsString := Trim(edAssento.Text);
    fQuery.ParamByName('VALOR').AsFloat := 25;
    fQuery.ParamByName('FORMA_PAGAMENTO').AsString := cbFormaPagamento.Text;

    fQuery.ExecSQL;
    ShowMessage('Compra concluída com sucesso!');
    LimparCombo(cbDBHorario, 1);
    LimparCombo(cbDBFilmes, 1);
    LimparCombo(cbDBSessao, 2);
    edAssento.Text := '';
  end
  else
    ShowMessage('Preencha todos os campos!');

end;

end.
