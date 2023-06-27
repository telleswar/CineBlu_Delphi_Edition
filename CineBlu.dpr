program CineBlu;

uses
  Vcl.Forms,
  uTelaPrincipal in 'uTelaPrincipal.pas' {frTelaPrincipal},
  uUsuario in 'uUsuario.pas',
  DMBanco in 'DMBanco.pas' {DataModule1: TDataModule},
  uConsultaGrid in 'uConsultaGrid.pas' {frConsulta},
  uAdapters in 'uAdapters.pas',
  uTelaCompra in 'uTelaCompra.pas' {frTelaCompra};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrTelaPrincipal, frTelaPrincipal);
  Application.Run;
end.
