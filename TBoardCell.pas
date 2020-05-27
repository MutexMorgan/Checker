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
    function GetPos: Vector2;
    function GetIdentity: Integer;
    function GetCellPos: Vector2;
  end;
  ABoardCell = array of BoardCell;
  //PBoardCell = ^BoardCell;
  //APBoardCell = array of PBoardCell;
  //PABoardCell = ^ABoardCell;

implementation

constructor BoardCell.Create(Pos: Vector2; IdentyNum: Integer);
begin
   RealPos := Pos;
   ID := IdentyNum
end;

function BoardCell.GetPos: Vector2;
begin
  GetPos := RealPos;
end;

function BoardCell.GetIdentity: Integer;
begin
  GetIdentity := ID;
end;

function BoardCell.GetCellPos: Vector2;
begin
  GetCellPos := Vector2.Create(self.ID mod CCellAmount, self.ID div CCellAmount);
end;

end.
 