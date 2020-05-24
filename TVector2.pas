unit TVector2;

interface

type
  Vector2 = class
  private
    X, Y: Integer;
  public
    constructor Create(sX, sY: Integer);
    function GetX: Integer;
    function GetY: Integer;
    procedure SetX(nX: Integer);
    procedure SetY(nY: Integer);
  end;

implementation

constructor Vector2.Create(sX, sY: Integer);
begin
  X := sX;
  Y := sY;
end;

function Vector2.GetX: Integer;
begin
  GetX := X;
end;

function Vector2.GetY: Integer;
begin
  GetY := Y;
end;

procedure Vector2.SetX(nX: Integer);
begin
  X := nX;
end;

procedure Vector2.SetY(nY: Integer);
begin
  Y := nY;
end;

end.
