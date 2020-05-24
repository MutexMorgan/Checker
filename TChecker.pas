unit TChecker;

interface

uses TVector2, TBoardCell, ExtCtrls;

type
  Checker = class
  private
    Pos: BoardCell;
    Graphics: TImage;  
    procedure UpdateGraphic;
  public
    constructor Create(P: BoardCell; I: TImage);
    destructor Destroy; override;
    procedure MoveTo(P: BoardCell);
    function GetCell: BoardCell;
    procedure Eat(Opponent: Checker);
    procedure Die;
  end;

implementation

constructor Checker.Create(P: BoardCell; I: TImage);
begin
  Graphics := I;
  MoveTo(P);
end;

destructor Checker.Destroy;
begin
  inherited;
  Pos.Destroy;
  Graphics.Destroy;
end;

procedure Checker.MoveTo(P: BoardCell);
begin
  Pos := P;
  UpdateGraphic;
end;

procedure Checker.UpdateGraphic;
begin
  Graphics.Top := Pos.GetPos.GetY;
  Graphics.Left := Pos.GetPos.GetX;
end;

function Checker.GetCell: BoardCell;
begin
  GetCell := Pos;
end;

procedure Checker.Eat(Opponent: Checker);
begin
  Opponent.Die;
end;

procedure Checker.Die;
begin
  Destroy;
end;

end.
