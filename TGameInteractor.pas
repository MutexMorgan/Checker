unit TGameInteractor;

interface

uses Math, TChecker, TConstants, TBoard, TBoardCell, TVector2, Controls, MainInterface;

type
  //Объявление класса взаимодействия с игрой
  GameInteractor = class
  private
    //Логическое значение Хода белых если правда, хода чёрных если ложь
    WhitesTurn: Boolean;
    //Игровое поле.
    Board: Board;
    //Переменная содержащая ссылку на пешку
    SelectedChecker: Checker;
    //Процедура перевода координат клика на понятные системе координаты клеток
    procedure HandlePassedCoords(Pos: Vector2);
    //Обработка клика в случае если выбранная клетка имела на себе шашку
    procedure HandleChecker(Checker: Checker);
    //Обработка клика в случае клика по пустой клетке
    procedure HandleEmptyCell(Cell: BoardCell);
    function IsItFree(Cell: BoardCell): Boolean;
    //Функция проверки способности шашки походить возвращая код статуса
    function CanMoveThere(Checker: Checker; To_v: BoardCell): Integer;
  public
    //Конструктор класса
    constructor Create(Board: Board);
    //Процедура обработки клика по игровому полю
    procedure HandleTheClick(Pos: Vector2);
  end;
implementation


//Конструктор класса взаимодействия с игрой
constructor GameInteractor.Create(Board: Board);
begin
  self.Board := Board;
end;

procedure GameInteractor.HandleTheClick(Pos: Vector2);
begin
  if Pos.GetX < 0 then exit;
  if Pos.GetY < 0 then exit;
  if Pos.GetX > self.Board.FieldSize.GetX then exit;
  if Pos.GetY > self.Board.FieldSize.GetY then exit;
  self.HandlePassedCoords(Pos);
end;

function CheckForCellFillness(ClickedCell: BoardCell; List: AChecker; IsWhites: Boolean): Checker;
var i: Integer;
begin
  for i := 0 to CCheckerAmount - 1 do
  begin
    if (List[i].IsWhite = IsWhites) and (List[i].GetCell = ClickedCell) then
    begin
      CheckForCellFillness := List[i];
      exit;
    end;
  end;
  CheckForCellFillness := nil;
end;

procedure GameInteractor.HandlePassedCoords(Pos: Vector2);
var XDot, YDot: Integer; ClickedCell: BoardCell; Selected: Checker;
begin
  XDot := Pos.GetX div CCellSize;
  YDot := Pos.GetY div CCellSize;
  ClickedCell := self.Board.BoardCells[YDot * CCellAmount + XDot];
  Selected := CheckForCellFillness(ClickedCell, self.Board.Checkers, self.WhitesTurn);
  if assigned(Selected) then self.HandleChecker(Selected)
  else if assigned(self.SelectedChecker) then self.HandleEmptyCell(ClickedCell);
end;

procedure GameInteractor.HandleChecker(Checker: Checker);
begin
  self.SelectedChecker := Checker;
end;

function GameInteractor.CanMoveThere(Checker: Checker; To_v: BoardCell): Integer;
var nX, nY, oY: Integer; MiddlePos: Vector2; Middle: BoardCell;
begin
  nX := Checker.GetCell.GetCellPos.GetX - To_v.GetCellPos.GetX;
  nY := Checker.GetCell.GetCellPos.GetY - To_v.GetCellPos.GetY;
  oY := IfThen(Checker.IsKing, abs(nY), IfThen(Checker.IsWhite, -nY, nY));
  CanMoveThere := -2;
  if IsItFree(To_v) then
  begin
    if (abs(nX) = 1) and (oY = 1) then CanMoveThere := -1
    else if (abs(nX) = 2) and (abs(nY) = 2) then
    begin
      MiddlePos := To_v.GetCellPos.Sum(Vector2.Create(nX div 2, nY div 2));
      Middle := self.Board.GetCell(MiddlePos);
      if not IsItFree(Middle) and self.Board.GetChecker(Middle).IsWhite <> Checker.IsWhite then
      begin
        CanMoveThere := MiddlePos.GetY * CCellAmount + MiddlePos.GetX;
      end;
    end;
  end;
end;

function GameInteractor.IsItFree(Cell: BoardCell): Boolean;
var i: Integer;
begin
  for i := 0 to CCheckerAmount - 1 do
    if self.Board.Checkers[i].GetCell = Cell then
    begin
      IsItFree := false;
      exit;
    end;
  IsItFree := true;
end;

procedure GameInteractor.HandleEmptyCell(Cell: BoardCell);
var StatusCode: Integer;
begin
  if not assigned(self.SelectedChecker) then exit;
  StatusCode := self.CanMoveThere(self.SelectedChecker, Cell);
  if StatusCode = -1 then
  begin
    self.SelectedChecker.MoveTo(Cell);
    self.WhitesTurn := not self.WhitesTurn;
  end
  else if StatusCode <> -2 then
  begin
    self.SelectedChecker.MoveTo(Cell);
    self.SelectedChecker.Eat(self.Board.GetChecker(self.Board.GetCell(StatusCode)));
    self.WhitesTurn := not self.WhitesTurn;
  end;
  self.SelectedChecker := nil;
end;


end.
 