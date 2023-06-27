unit uConsultaGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls,uAdapters;

type
  TfrConsulta = class(TForm)
    pnCosultaBody: TPanel;
    DbGrid: TDBGrid;
    pnConsultaHead: TPanel;
    btnCloseHead: TSpeedButton;
    procedure btnCloseHeadClick(Sender: TObject);
  private
    { Private declarations }
  public
    FAdapter : TAdapter;
  end;

var
  frConsulta: TfrConsulta;

implementation

{$R *.dfm}

procedure TfrConsulta.btnCloseHeadClick(Sender: TObject);
begin
  Close;
end;

end.
