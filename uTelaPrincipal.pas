unit uTelaPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.Imaging.jpeg,uUsuario, System.Hash,
  Vcl.Buttons, DMBanco, uConsultaGrid, uAdapters, uTelaCompra;

type
  TLoginState = class;

  TfrTelaPrincipal = class(TForm)
    pnMain: TPanel;
    pnLeftSide: TPanel;
    pnLeftHead: TPanel;
    imgLogo: TImage;
    pnLeftBody: TPanel;
    shpItemSelected: TShape;
    pnLeftForm: TPanel;
    lbFeedback: TLabel;
    pnlLeftCenterUsuario: TPanel;
    lbUsuario: TLabel;
    edUsuario: TEdit;
    pnOutlineUsuario: TPanel;
    pnLeftCenterSenha: TPanel;
    lbSenha: TLabel;
    edSenha: TEdit;
    pnOutlineSenha: TPanel;
    pnBtnRegister: TPanel;
    pnBtnLogin: TPanel;
    pnLeftMenu: TPanel;
    lbTituloMenu: TLabel;
    pnItemMenuFilmes: TPanel;
    imgIconFilmes: TImage;
    lbItemMenuFilmes: TLabel;
    pnItemMenuRecibos: TPanel;
    imgIconRecibos: TImage;
    lbItemMenuRecibos: TLabel;
    pnItemMenuComprar: TPanel;
    imgIconComprar: TImage;
    lbItemMenuComprar: TLabel;
    pnRightSide: TPanel;
    imgWallpaperRight: TImage;
    pnRightBottom: TPanel;
    pnRightBody: TPanel;
    pnRightHead: TPanel;
    pnLeftBottom: TPanel;
    lbVersao: TLabel;
    lbDescBottom: TLabel;
    btnClose: TSpeedButton;
    lbTipoTela: TLabel;
    lbTitTela: TLabel;
    pnLeftInfoUser: TPanel;
    pnBtnLogout: TPanel;
    lbNomeUsu: TLabel;
    btnCloseHead: TSpeedButton;
    procedure pnBtnMouseEnter(Sender: TObject);
    procedure pnBtnMouseLeave(Sender: TObject);
    procedure ProcessoLoginCadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ItemMenuSetSelected(Sender: TObject);
    procedure lbItemMenuClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure pnBtnLogoutClick(Sender: TObject);
  private
    FState : TLoginState;
    FTelaConsulta :  TfrConsulta;
    FTelaCompra : TfrTelaCompra;
  public
    DMBanco : TDataModule1;
    procedure ControleMensagens(prMsg : String);
    procedure Logar;
    procedure Deslogar;
  end;

  TLoginState = class abstract
  protected
    FTelaLogin: TfrTelaPrincipal;
    constructor Create(ATelaLogin: TfrTelaPrincipal); virtual;
  public
    procedure Logar; virtual; abstract;
    procedure Deslogar; virtual; abstract;
  end;

  TLogadoState = class(TLoginState)
  public
    procedure Logar; override;
    procedure Deslogar; override;
  end;

  TDeslogadoState = class(TLoginState)
  public
    procedure Logar; override;
    procedure Deslogar; override;
  end;

var
  frTelaPrincipal: TfrTelaPrincipal;

implementation

{$R *.dfm}

{$REGION 'Tela de login'}
procedure TfrTelaPrincipal.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrTelaPrincipal.Deslogar;
begin
  FState.Deslogar;
end;

procedure TfrTelaPrincipal.Logar;
begin
  FState.Logar;
end;

procedure TfrTelaPrincipal.ControleMensagens(prMsg: String);
begin
  lbFeedback.Visible := prMsg <> '';
  if not lbFeedback.Visible then
     Exit;

  lbFeedback.Caption := prMsg;
  if Pos('sucesso', prMsg) > 0 then
     lbFeedback.Font.Color := $0026BD00
  else
     lbFeedback.Font.Color := $00000090;
end;

procedure TfrTelaPrincipal.ProcessoLoginCadClick(Sender: TObject);
var
  wUsuario : TUsuario;
begin
  wUsuario := TUsuario.GetInstance;
  try
    wUsuario.nome_usuario := edUsuario.Text;
    wUsuario.senha_usuario := edSenha.Text;
    if Sender = pnBtnRegister then
    begin
      if wUsuario.salvar then
      begin
        edUsuario.Text := '';
        edSenha.Text := '';
      end;
    end
    else
    begin
      if wUsuario.logar then
      begin
        edUsuario.Text := '';
        edSenha.Text := '';
        Logar;
      end;
    end;

  finally
    ControleMensagens(wUsuario.fMsgExec);
  end;
end;

procedure TfrTelaPrincipal.FormShow(Sender: TObject);
begin
  FState := TDeslogadoState.Create(Self);
  DMBanco := TDataModule1.Create(Self);
//  //Login automatico
//  edUsuario.Text := 'antony';
//  edSenha.Text := '123';
//  ProcessoLoginCadClick(pnBtnLogin);
  try
    DMBanco.ConBD.Connected := True;
  except on E: Exception do
    ShowMessage('Erro ao conectar no banco: ' + E.Message);
  end;
end;

procedure TfrTelaPrincipal.pnBtnLogoutClick(Sender: TObject);
begin
  TUsuario.GetInstance.Destroy;
  Deslogar;
end;

procedure TfrTelaPrincipal.ItemMenuSetSelected(Sender: TObject);

  procedure ChamaTelaConsulta(prAdapter: TAdapter);
  begin
    if Assigned(FTelaCompra) then
       FTelaCompra.Close;

    if not Assigned(FTelaConsulta) then
    begin
       FTelaConsulta := TfrConsulta.Create(self);
       FTelaConsulta.Parent := pnRightBody;
    end;

    if Assigned(FTelaConsulta.FAdapter) then
       FTelaConsulta.FAdapter.Free;
    FTelaConsulta.FAdapter := prAdapter;
    FTelaConsulta.FAdapter.SetDBGrid(FTelaConsulta.DbGrid);
    FTelaConsulta.FAdapter.Consulta;
    FTelaConsulta.Show;
  end;

begin
  shpItemSelected.Top := pnLeftMenu.Top + TPanel(Sender).Top - (TPanel(Sender).Margins.Top - 5);
  shpItemSelected.Repaint;

  case TPanel(Sender).Tag of
    1:begin
      lbTipoTela.Caption := 'Consulta';
      lbTitTela.Caption := 'Ver Filmes';
      ChamaTelaConsulta(TFilmesAdapter.Create(Self));
    end;
    2:begin
      lbTipoTela.Caption := 'Consulta';
      lbTitTela.Caption := 'Meus ingressos';
      ChamaTelaConsulta(TRecibosAdapter.Create(Self));
    end;
    3: begin
      lbTipoTela.Caption := 'Compra';
      lbTitTela.Caption := 'Comprar ingresso';
      if Assigned(FTelaConsulta) then
         FTelaConsulta.Close;
      if not Assigned(FTelaCompra) then
      begin
         FTelaCompra := TfrTelaCompra.Create(self);
         FTelaCompra.Parent := pnRightBody;
      end;
      FTelaCompra.Show;
    end;
  end;
end;


procedure TfrTelaPrincipal.lbItemMenuClick(Sender: TObject);
begin
  ItemMenuSetSelected(TLabel(Sender).Parent);
end;

procedure TfrTelaPrincipal.pnBtnMouseEnter(Sender: TObject);
begin
  TPanel(Sender).Color := TPanel(Sender).Color + $250E0F;
end;

procedure TfrTelaPrincipal.pnBtnMouseLeave(Sender: TObject);
begin
  TPanel(Sender).Color := TPanel(Sender).Color - $250E0F;
end;
{$ENDREGION}

{$REGION 'Estados da tela'}
{ TUsuarioState }

constructor TLoginState.Create(ATelaLogin: TfrTelaPrincipal);
begin
  FTelaLogin := ATelaLogin;
end;


{ TDeslogado }

procedure TDeslogadoState.Deslogar;
begin
  ShowMessage('Você já esta deslogado!');
end;

procedure TDeslogadoState.Logar;
var
  wUsuario : TUsuario;
begin
  wUsuario := TUsuario.GetInstance;
  if not wUsuario.isLogado then
  begin
    ShowMessage('Você não efetuou o login no sistema!');
    Exit;
  end;

  with FTelaLogin do
  begin
    //Esconder tela de login
    pnLeftForm.Visible := False;
    btnClose.Visible := False;

    //Mostrar menu
    pnRightHead.Visible := True;
    pnRightBody.Visible := True;
    pnRightBottom.Visible := False;
    pnLeftMenu.Visible := True;
    shpItemSelected.Visible := True;
    pnLeftInfoUser.Visible := True;
    pnLeftMenu.Top := pnLeftForm.Top - 50;
    ItemMenuSetSelected(pnItemMenuFilmes);

    lbNomeUsu.Caption := wUsuario.nome_usuario;
  end;

  FTelaLogin.FState := TLogadoState.Create(FTelaLogin);
end;

{ TLogadoState }

procedure TLogadoState.Deslogar;
var
  wUsuario : TUsuario;
begin
  wUsuario := TUsuario.GetInstance;
  if wUsuario.isLogado then
  begin
    ShowMessage('Você não efetuou o logout no sistema!');
    Exit;
  end;

  with FTelaLogin do
  begin
    //Esconder tela de login
    pnLeftForm.Visible := True;
    btnClose.Visible := True;

    //Mostrar menu
    pnRightHead.Visible := False;
    pnRightBody.Visible := False;
    pnRightBottom.Visible := False;
    pnLeftMenu.Visible := False;
    shpItemSelected.Visible := False;
    pnLeftInfoUser.Visible := False;
  end;

  wUsuario.Destroy;
  FTelaLogin.FState := TDeslogadoState.Create(FTelaLogin);
end;

procedure TLogadoState.Logar;
begin
  ShowMessage('Você ja está logado!');
end;

{$ENDREGION}

end.
