unit TBoard;

interface

uses TCheckerTeam, TGraphicsLoader, MainInterface, TVector2, TConstants, TBoardCell,
ExtCtrls;

type
  Board = class
  private
    Loader: GraphicsLoader;
    BorderGraphic: TImage;
    BorderSize: Vector2;
    FieldGraphic: TImage;
    procedure CreateCells;
  public     
    FieldSize: Vector2;
    White: CheckerTeam;
    Black: CheckerTeam;
    BoardCells: array[0.. (CCellAmount * CCellAmount - 1)] of BoardCell;
    constructor Create(LoaderInstance: GraphicsLoader);
    procedure RespawnChecker;
  end;

implementation

constructor Board.Create(LoaderInstance: GraphicsLoader);
begin
  BorderSize := Vector2.Create(CBorderSize, CBorderSize);
  FieldSize := Vector2.Create(CFieldSize, CFieldSize);
  Loader := LoaderInstance;
  FieldGraphic := TImage.Create(Form1.GamePanel);
  FieldGraphic.Picture := Loader.GetBoardPicture();
  FieldGraphic.Stretch := true;
  FieldGraphic.Height := FieldSize.GetX;
  FieldGraphic.Width := FieldSize.GetY;
  FieldGraphic.Enabled := true;
  FieldGraphic.Visible := true;
  FieldGraphic.Parent := Form1;
  CreateCells;
end;

procedure Board.CreateCells; 
var i: Integer; t: Vector2;
begin
  for i := 0 to CAllCellAmount - 1 do
  begin
    t := Vector2.Create((i mod CCellAmount) * CCellSize,
    (i div CCellAmount) * CCellSize);
    BoardCells[i] := BoardCell.Create(t, i);
  end;
end;

procedure Board.RespawnChecker;
begin
  if White <> nil then White.Destroy;
  if Black <> nil then Black.Destroy;
    
  White := CheckerTeam.Create(Loader, BoardCells, true);
  Black := CheckerTeam.Create(Loader, BoardCells, false);
end;

end.
