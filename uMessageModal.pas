unit uMessageModal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage;

type
  TfrMessageModal = class(TForm)
    pnBody: TPanel;
    pnHead: TPanel;
    btnCloseHead: TSpeedButton;
    pnBtnOk: TPanel;
    Panel1: TPanel;
    pnMessage: TPanel;
    imgError: TImage;
    lbTitTelaMsg: TLabel;
    lbMessage: TLabel;
    imgSucesso: TImage;
    procedure pnBtnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnBtnOkMouseEnter(Sender: TObject);
    procedure pnBtnOkMouseLeave(Sender: TObject);
  private
    FTitulo : string;
    FMessagem : string;
  public
    class procedure MostrarMensagem(Owner : TComponent; prTitulo, prMessagem : String; prErro : Boolean = True);

  end;

var
  frMessageModal: TfrMessageModal;

implementation

{$R *.dfm}


procedure TfrMessageModal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrMessageModal.FormShow(Sender: TObject);
begin
  lbTitTelaMsg.Caption := FTitulo;
  lbMessage.Caption := FMessagem;
end;

class procedure TfrMessageModal.MostrarMensagem(Owner : TComponent; prTitulo, prMessagem: String; prErro : Boolean = True);
var
  wTela : TfrMessageModal;
begin
  wTela := TfrMessageModal.Create(Owner);
  wTela.FTitulo := prTitulo;
  wTela.FMessagem := prMessagem;
  wTela.imgError.Visible := prErro;
  wTela.imgSucesso.Visible := not prErro;
  wTela.ShowModal;
end;

procedure TfrMessageModal.pnBtnOkClick(Sender: TObject);
begin
  Close;
end;

procedure TfrMessageModal.pnBtnOkMouseEnter(Sender: TObject);
begin
  TPanel(Sender).Color := TPanel(Sender).Color + $250E0F;
end;

procedure TfrMessageModal.pnBtnOkMouseLeave(Sender: TObject);
begin
   TPanel(Sender).Color := TPanel(Sender).Color - $250E0F;
end;

end.
