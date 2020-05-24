unit TGameInteractor;

interface

uses TChecker, TConstants, TBoard, TBoardCell, TVector2, Controls;

type
  GameInteractor = class
  private
    WhitesTurn: Boolean;
    Board: Board;
    SelectedChecker: Checker;
    procedure HandlePassedCoords(Pos: Vector2);
    procedure HandleChecker(Checker: Checker);
    procedure HandleEmptyCell(Cell: BoardCell);
  public
    constructor Create(Board: Board);
    procedure HandleTheClick(Pos: Vector2);
  end;
implementation

constructor GameInteractor.Create(Board: Board);
begin
  self.Board := Board;
end;

procedure GameInteractor.HandleTheClick(Pos: Vector2);
begin
  if Pos.GetX < 1 then exit;
  if Pos.GetY < 1 then exit;
  if Pos.GetX > self.Board.FieldSize.GetX then exit;
  if Pos.GetY > self.Board.FieldSize.GetY then exit;
  self.HandlePassedCoords(Pos);
end;

procedure HandlePassedCoords(Pos: Vector2);
var i, XDot, YDot: Integer;
begin
  XDot := Pos.GetX div CCellSize;
  YDot := Pos.GetY div CCellSize;
  for i := 0 to CTeamSize do
  begin
    if self.Board.
  end;
  for i := 0 to CTeamSize do
  begin

  end;
end;

procedure HandleChecker(Checker: Checker);  
begin

end;

procedure HandleEmptyCell(Cell: BoardCell);  
begin

end;


end.
 