unit DMBanco;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  Data.DB, FireDAC.Comp.Client;

type
  TDataModule1 = class(TDataModule)
    ConBD: TFDConnection;
    FBDriver: TFDPhysFBDriverLink;
    FDWaitCursor: TFDGUIxWaitCursor;
  private
    { Private declarations }
    class var Finstance : TDataModule1;
    constructor Create(AOwner: TComponent); override;
  public
    class function GetInstance : TDataModule1;

  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

constructor TDataModule1.Create(AOwner: TComponent);
begin
  inherited;

end;

class function TDataModule1.GetInstance: TDataModule1;
begin
  if not Assigned(Finstance) then
     Finstance := Create(nil);
  Result := Finstance;
end;

end.
