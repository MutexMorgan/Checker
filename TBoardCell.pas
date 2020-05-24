unit TBoardCell;

interface

uses TVector2, TConstants;

type
  BoardCell = class
  private
    RealPos: Vector2;
    ID: Integer;
  public
    constructor Create(Pos: Vector2; IdentyNum: Integer);
    function GetPos(): Vector2;
    function GetIdentity(): Integer;
  end;
  
implementation

constructor BoardCell.Create(Pos: Vector2; IdentyNum: Integer);
begin
   RealPos := Pos;
   ID := IdentyNum
end;

function BoardCell.GetPos(): Vector2;
begin
  GetPos := RealPos;
end;

function BoardCell.GetIdentity(): Integer;
begin
  GetIdentity := ID;
end;


end.
 