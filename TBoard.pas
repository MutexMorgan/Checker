unit TBoard;

interface

uses TChecker, TGraphicsLoader, MainInterface, TVector2, TConstants, TBoardCell,
ExtCtrls, Math;

type
  PBoard = ^Board;
  Board = class
  private
    Loader: GraphicsLoader;
    BorderGraphic: TImage;
    BorderSize: Vector2;
    PrCheckers: AChecker;
    FieldGraphic: TImage; 
    PrBoardCells: ABoardCell;
    procedure CreateCells;
  public
    FieldSize: Vector2;
    constructor Create(LoaderInstance: GraphicsLoader);
    procedure RespawnChecker;
    function BoardCells: ABoardCell;
    function Checkers: AChecker;
    function IsCheckerSameTeam(A, B: Checker): Boolean;
    function GetChecker(Cell: BoardCell): Checker;
    function GetCell(Figure: Checker): BoardCell; overload;
    function GetCell(Pos: Vector2): BoardCell; overload;
    function GetCell(PosIndex: Integer): BoardCell; overload;
  end;

implementation

constructor Board.Create(LoaderInstance: GraphicsLoader);
begin
  BorderSize := Vector2.Create(CBorderSize, CBorderSize);
  FieldSize := Vector2.Create(CFieldSize, CFieldSize);
  Loader := LoaderInstance;
  FieldGraphic := TImage.Create(Form1);
  FieldGraphic.Picture := Loader.GetBoardPicture()^;
  FieldGraphic.Stretch := true;
  FieldGraphic.Height := FieldSize.GetX;
  FieldGraphic.Width := FieldSize.GetY;
  FieldGraphic.Enabled := true;
  FieldGraphic.Visible := true;
  FieldGraphic.Parent := Form1;
  FieldGraphic.OnClick := Form1.OnClick;
  CreateCells;
end;

procedure Board.CreateCells; 
var i: Integer; t: Vector2;
begin     
  SetLength(self.PrBoardCells, CAllCellAmount);
  for i := 0 to CAllCellAmount - 1 do
  begin
    t := Vector2.Create((i mod CCellAmount) * CCellSize, (i div CCellAmount) * CCellSize);
    PrBoardCells[i] := BoardCell.Create(t, i);
  end;
end;

procedure Board.RespawnChecker;
var i, mul, Ind: Integer; Tmp: TImage;
begin
  for i := 0 to (CCheckerAmount - 1) do
  begin
    Tmp := TImage.Create(Form1);
    Tmp.Parent := Form1;
    Tmp.Transparent := true;
    Tmp.Stretch := true;
    Tmp.Height := CMenSize;
    Tmp.Width := CMenSize;
    Tmp.OnClick := Form1.OnClick;
    mul := (i mod (CTeamSize)) * 2;
    Ind := mul + ((mul div (CCellAmount) + 1) mod 2);
    Ind := IfThen(i < CTeamSize, Ind, CAllCellAmount - Ind - 1);
    PrCheckers[i] := Checker.Create(PrBoardCells[Ind], i < CTeamSize, Tmp, Loader);
  end
end;

function Board.BoardCells: ABoardCell;
begin
  BoardCells := self.PrBoardCells;
end;

function Board.Checkers: AChecker;
begin
  Checkers := self.PrCheckers;
end;

function Board.IsCheckerSameTeam(A, B: Checker): Boolean;
begin
  if A.IsWhite = B.IsWhite then IsCheckerSameTeam := True
  else IsCheckerSameTeam := false;
end;

function Board.GetChecker(Cell: BoardCell): Checker;
var i: Integer;
begin
  for i := 0 to CCheckerAmount - 1 do
    if self.PrCheckers[i].GetCell = Cell then
    begin
      GetChecker := self.PrCheckers[i];
      exit;
    end;
  GetChecker := nil;
end;

function Board.GetCell(Figure: Checker): BoardCell;
var i: Integer;
begin
  if not Figure.IsDead then
    for i := 0 to CCheckerAmount - 1 do
      if self.PrCheckers[i] = Figure then
      begin
        GetCell := self.PrCheckers[i].GetCell;
      end;
  GetCell := nil
end;

function Board.GetCell(Pos: Vector2): BoardCell;
begin
  GetCell := nil;

  if Pos.GetX < 0 then exit;
  if Pos.GetY < 0 then exit;
  if Pos.GetX > CCellAmount - 1then exit;
  if Pos.GetY > CCellAmount - 1 then exit;

  GetCell := self.PrBoardCells[Pos.GetY * CCellAmount + Pos.GetX];
end;

function Board.GetCell(PosIndex: Integer): BoardCell;
begin
  GetCell := nil;

  if PosIndex < 0 then exit;
  if PosIndex > CAllCellAmount - 1 then exit;

  GetCell := self.GetCell(Vector2.Create(PosIndex mod CCellAmount, PosIndex div CCellAmount));
end;

end.
