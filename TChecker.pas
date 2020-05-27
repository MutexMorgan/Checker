unit TChecker;

interface

uses TVector2, MainInterface, TBoardCell, TGraphicsLoader, TConstants, ExtCtrls, Math;

type
  Checker = class
  private
    Pos: BoardCell;
    Graphics: TImage;
    AmIDead: Boolean;
    Loader: GraphicsLoader;
    procedure UpdateGraphic;
  public
    IsKing: Boolean;
    IsWhite: Boolean;
    constructor Create(P: BoardCell; IsWhite: Boolean; Img: TImage; Loader: GraphicsLoader);
    destructor Destroy; override;
    procedure MoveTo(P: BoardCell);
    function GetCell: BoardCell;
    function IsDead: Boolean;
    procedure Eat(Opponent: Checker);
    procedure Die;
  end;
  AChecker = array[0.. (CCheckerAmount - 1)] of Checker;

implementation

constructor Checker.Create(P: BoardCell; IsWhite: Boolean; Img: TImage; Loader: GraphicsLoader);
begin
  self.IsWhite := IsWhite;
  self.IsKing := false;
  self.AmIDead := false;
  self.Loader := Loader;
  self.Graphics := Img;
  Pos := P;
  UpdateGraphic;
end;

destructor Checker.Destroy;
begin
  inherited;
  Graphics.Destroy;
end;

procedure Checker.MoveTo(P: BoardCell);
begin
  if P.GetCellPos.GetY = IfThen(not self.IsWhite, 0, CCellAmount - 1) then
    self.IsKing := true;
  Pos := P;
  UpdateGraphic;
end;

procedure Checker.UpdateGraphic;
begin
  Graphics.Top := Pos.GetPos.GetY;
  Graphics.Left := Pos.GetPos.GetX;
  if self.IsKing then Graphics.Picture := self.Loader.GetKingPicture(self.IsWhite)^
  else Graphics.Picture := self.Loader.GetCheckPicture(self.IsWhite)^;

end;

function Checker.GetCell: BoardCell;
begin
  GetCell := Pos;
end;

function Checker.IsDead: Boolean;
begin
  IsDead := self.AmIDead;
end;

procedure Checker.Eat(Opponent: Checker);
begin
  Opponent.Die;
end;

procedure Checker.Die;
begin
  self.AmIDead := true;
  self.Graphics.OnClick := nil;
  self.Graphics.Visible := false;
  self.Graphics.Enabled := false;
  self.Pos := nil;
end;

end.
