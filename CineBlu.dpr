program CineBlu;

uses
  Vcl.Forms,
  uTelaPrincipal in 'uTelaPrincipal.pas' {frTelaPrincipal},
  uUsuario in 'uUsuario.pas',
  uSingleton in 'uSingleton.pas',
  DMBanco in 'DMBanco.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrTelaLogin, frTelaLogin);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
