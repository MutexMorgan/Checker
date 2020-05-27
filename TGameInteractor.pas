unit TGameInteractor;

interface

uses Math, TChecker, TConstants, ExtCtrls, TGraphicsLoader, TBoard, TBoardCell, TVector2, Controls, MainInterface;

type
  MoveInfo = record
    CanMove: Boolean;
    CanEat: Boolean;
    WhoToEat: array of Checker;
  end;
  //Объявление класса взаимодействия с игрой
  GameInteractor = class
  private
    //Логическое значение Хода белых если правда, хода чёрных если ложь
    WhitesTurn: Boolean;
    //Игровое поле.
    Board: Board;
    //Переменная содержащая ссылку на пешку
    SelectedChecker: Checker;
    SelectedGraphics: TImage;
    //Процедура перевода координат клика на понятные системе координаты клеток
    procedure HandlePassedCoords(Pos: Vector2);
    //Обработка клика в случае если выбранная клетка имела на себе шашку
    procedure HandleChecker(Checker: Checker);
    //Обработка клика в случае клика по пустой клетке
    procedure HandleEmptyCell(Cell: BoardCell);
    function IsItFree(Cell: BoardCell): Boolean;
    //Функция проверки способности шашки походить возвращая код статуса
    function CanMoveThere(Who: Checker; To_v: BoardCell): MoveInfo;
  public
    //Конструктор класса
    constructor Create(Board: Board; GphcsLdr: GraphicsLoader);
    //Процедура обработки клика по игровому полю
    procedure HandleTheClick(Pos: Vector2);
  end;
implementation


//Конструктор класса взаимодействия с игрой
constructor GameInteractor.Create(Board: Board; GphcsLdr: GraphicsLoader);
begin
  self.SelectedGraphics := TImage.Create(Form1);
  self.SelectedGraphics.Parent := Form1; 
  self.SelectedGraphics.Transparent := true;
  self.SelectedGraphics.Picture := GphcsLdr.GetSelectedPicture^;
  self.SelectedGraphics.Stretch := true;
  self.SelectedGraphics.Visible := false;
  self.SelectedGraphics.Height := CCellSize;
  self.SelectedGraphics.Width := CCellSize;
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
  self.SelectedGraphics.Visible := true;
  self.SelectedGraphics.Top := self.SelectedChecker.GetCell.GetPos.GetY;
  self.SelectedGraphics.Left := self.SelectedChecker.GetCell.GetPos.GetX;
end;

function GameInteractor.CanMoveThere(Who: Checker; To_v: BoardCell): MoveInfo;
var nX, nY, oY, i: Integer; MiddlePos: Vector2; Middle: BoardCell; Occupant: Checker; Res: MoveInfo;
begin
  nX := Who.GetCell.GetCellPos.GetX - To_v.GetCellPos.GetX;
  nY := Who.GetCell.GetCellPos.GetY - To_v.GetCellPos.GetY;
  oY := IfThen(Who.IsKing, abs(nY), IfThen(Who.IsWhite, -nY, nY));
  Res.CanMove := false;
  if IsItFree(To_v) then
  begin
    if (abs(nX) = 1) and (oY = 1) then Res.CanMove := true
    else if ((abs(nX) = 2) and (abs(nY) = 2)) or (Who.IsKing and (abs(nX) = abs(nY))) then
    begin
      for i := 1 to Max(abs(nX), Abs(nY)) - 1 do
      begin
        MiddlePos := To_v.GetCellPos.Sum(Vector2.Create(i * abs(nX) div nX, i * abs(nY) div nY));
        Middle := self.Board.GetCell(MiddlePos);
        Occupant := self.Board.GetChecker(Middle);
        Res.CanMove := Who.IsKing;
        if Occupant <> nil then
          if (not IsItFree(Middle)) and (Occupant.IsWhite <> Who.IsWhite) then
          begin
            SetLength(Res.WhoToEat, IfThen(Length(Res.WhoToEat) < 1, 1, Length(Res.WhoToEat) + 1));
            Res.WhoToEat[High(Res.WhoToEat)] := Occupant;
            Res.CanEat := true;
            Res.CanMove := true;
          end
          else if (Length(Res.WhoToEat) > 0) and (Occupant.IsWhite = Who.IsWhite) then
          begin
            Res.CanEat := false;
            Res.CanMove := false;
            break;
          end;
      end;
    end;
  end;
  CanMoveThere := Res;
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
var StatusCode: MoveInfo; Chkr: Integer;
begin
  if not assigned(self.SelectedChecker) then exit;
  StatusCode := self.CanMoveThere(self.SelectedChecker, Cell);
  if (StatusCode.CanMove and (not StatusCode.CanEat)) then
  begin
    self.SelectedChecker.MoveTo(Cell);
    self.WhitesTurn := not self.WhitesTurn;
  end
  else if (StatusCode.CanMove and StatusCode.CanEat) then
  begin
    self.SelectedChecker.MoveTo(Cell);
    if StatusCode.CanEat then
      for Chkr := 0 to High(StatusCode.WhoToEat) do
        self.SelectedChecker.Eat(StatusCode.WhoToEat[Chkr]);
    self.WhitesTurn := not self.WhitesTurn;
  end;
  self.SelectedGraphics.Visible := false;
  self.SelectedChecker := nil;
end;


end.
 