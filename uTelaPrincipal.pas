unit uTelaPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.Imaging.jpeg, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompRectangle, uUsuario, System.Hash,
  Vcl.Buttons, DMBanco;

type
  TLoginState = class;

  TfrTelaLogin = class(TForm)
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
    procedure pnBtnMouseEnter(Sender: TObject);
    procedure pnBtnMouseLeave(Sender: TObject);
    procedure pnBtnRegisterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ItemMenuSetSelected(Sender: TObject);
    procedure lbItemMenuClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure pnBtnLoginClick(Sender: TObject);
    procedure pnBtnLogoutClick(Sender: TObject);
  private
    FState : TLoginState;
  public
    DMBanco : TDataModule1;
    procedure ControleMensagens(prMsg : String);
    procedure Logar;
    procedure Deslogar;
  end;

  TLoginState = class abstract
  protected
    FTelaLogin: TfrTelaLogin;
    constructor Create(ATelaLogin: TfrTelaLogin); virtual;
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
  frTelaLogin: TfrTelaLogin;

implementation

{$R *.dfm}

{$REGION 'Tela de login'}
procedure TfrTelaLogin.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrTelaLogin.Deslogar;
begin
  FState.Deslogar;
end;

procedure TfrTelaLogin.Logar;
begin
  FState.Logar;
end;

procedure TfrTelaLogin.ControleMensagens(prMsg: String);
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

procedure TfrTelaLogin.pnBtnRegisterClick(Sender: TObject);
var
  wUsuario : TUsuario;
begin
  wUsuario := TUsuario.GetInstance;
  try
    wUsuario.nome_usuario := edUsuario.Text;
    wUsuario.senha_usuario := edSenha.Text;
    if wUsuario.salvar then
    begin
      edUsuario.Text := '';
      edSenha.Text := '';
    end;
  finally
    ControleMensagens(wUsuario.fMsgExec);
  end;
end;

procedure TfrTelaLogin.pnBtnLoginClick(Sender: TObject);
var
  wUsuario : TUsuario;
begin
  wUsuario := TUsuario.GetInstance;
  try
    wUsuario.nome_usuario := edUsuario.Text;
    wUsuario.senha_usuario := edSenha.Text;
    if wUsuario.logar then
    begin
      edUsuario.Text := '';
      edSenha.Text := '';
      Logar;
    end;
  finally
    ControleMensagens(wUsuario.fMsgExec);
  end;
end;

procedure TfrTelaLogin.pnBtnLogoutClick(Sender: TObject);
begin
  TUsuario.GetInstance.Destroy;
  Deslogar;
end;

procedure TfrTelaLogin.ItemMenuSetSelected(Sender: TObject);
begin
  shpItemSelected.Top := pnLeftMenu.Top + TPanel(Sender).Top - (TPanel(Sender).Margins.Top - 5);
  shpItemSelected.Repaint;
end;

procedure TfrTelaLogin.lbItemMenuClick(Sender: TObject);
begin
  ItemMenuSetSelected(TLabel(Sender).Parent);
end;

procedure TfrTelaLogin.FormShow(Sender: TObject);
begin
  FState := TDeslogadoState.Create(Self);
  DMBanco := TDataModule1.Create(Self);
  try
    DMBanco.ConBD.Connected := True;
  except on E: Exception do
    ShowMessage('Erro ao conectar no banco: ' + E.Message);
  end;
end;

procedure TfrTelaLogin.pnBtnMouseEnter(Sender: TObject);
begin
  TPanel(Sender).Color := TPanel(Sender).Color + $250E0F;
end;

procedure TfrTelaLogin.pnBtnMouseLeave(Sender: TObject);
begin
  TPanel(Sender).Color := TPanel(Sender).Color - $250E0F;
end;
{$ENDREGION}

{$REGION 'Estados da tela'}
{ TUsuarioState }

constructor TLoginState.Create(ATelaLogin: TfrTelaLogin);
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

    //Mostrar menu
    pnRightHead.Visible := True;
    pnRightBody.Visible := True;
    pnRightBottom.Visible := True;
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
