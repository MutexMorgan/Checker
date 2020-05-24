unit TCheckerTeam;

interface

uses Math, TCheckerList, TChecker, TVector2, TGraphicsLoader, MainInterface, TConstants, TBoardCell,
ExtCtrls;

type
  CheckerTeam = class
  private
    Checkers: array[0..(CTeamSize - 1)] of Checker;
    IsTop: Boolean;
  public
    constructor Create(Loader: GraphicsLoader; BoardCells: array of BoardCell; isTop: Boolean);

  end;
implementation

constructor CheckerTeam.Create(Loader: GraphicsLoader; BoardCells: array of BoardCell; isTop: Boolean);
var i, Ind: Integer; Tmp: TImage;
begin
  for i := 0 to (CTeamSize - 1) do
  begin
    Tmp := TImage.Create(Form1.GamePanel);
    Tmp.Parent := Form1;
    Tmp.Transparent := true;
    Tmp.Stretch := true;
    Tmp.Height := CMenSize;
    Tmp.Width := CMenSize;
    Tmp.Picture := Loader.GetCheckPicture(isTop);
    Ind := i * 2 + (i * 2 div CCellAmount mod 2);
    Ind := IfThen(isTop, Ind, CAllCellAmount - Ind - 1);
    Checkers[i] := Checker.Create(BoardCells[Ind],  Tmp);
  end;
  IsTop := isTop;
end;

end.
 