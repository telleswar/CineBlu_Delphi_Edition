unit uSingleton;

interface

type
  TSingleton = class(TObject)
  private
    class var _instance: TSingleton;
  public
    //Global point of access to the unique instance
    class function Create: TSingleton;

    destructor Destroy; override;
  end;

implementation

{ TSingleton }

class function TSingleton.Create: TSingleton;
begin
  if (_instance = nil) then
    _instance:= inherited Create as Self;

  result:= _instance;
end;

destructor TSingleton.Destroy;
begin
  _instance:= nil;
  inherited;
end;

end.
