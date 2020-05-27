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
    function Sum(Add: Vector2): Vector2;
    function Sub(Rem: Vector2): Vector2;
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

function Vector2.Sum(Add: Vector2): Vector2;
begin
  Sum := Vector2.Create(self.X + Add.X, self.Y + Add.Y);
end;

function Vector2.Sub(Rem: Vector2): Vector2;
begin
  Sub := Vector2.Create(self.X - Rem.X, self.Y - Rem.Y);
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
