unit TGraphicsLoader;

interface

uses ExtCtrls, Graphics, TConstants;

type
  PTPicture = ^TPicture;
  PGraphicsLoader = ^GraphicsLoader;
  GraphicsLoader = class
  private
    BoardPicture: TPicture;
    WhiteCheckPicture: TPicture;
    BlackCheckPicture: TPicture;
    WhiteKingPicture: TPicture;
    BlackKingPicture: TPicture;
    function LoadPicture(Path: String): TPicture;
  public
    function GetBoardPicture: PTPicture;
    function GetWhiteCheckPicture: PTPicture;
    function GetBlackCheckPicture: PTPicture;
    function GetCheckPicture(IsWhite: Boolean): PTPicture;
    function GetWhiteKingPicture: PTPicture;
    function GetBlackKingPicture: PTPicture;
    function GetKingPicture(IsWhite: Boolean): PTPicture;
  end;

implementation

function GraphicsLoader.LoadPicture(Path: String): TPicture;
begin
    LoadPicture := TPicture.Create;
    LoadPicture.LoadFromFile(Path);
end;

function GraphicsLoader.GetBoardPicture: PTPicture;
begin
  if not assigned(BoardPicture) then BoardPicture := LoadPicture(CBoard_BoardPath);
  GetBoardPicture := @BoardPicture;
end;

function GraphicsLoader.GetWhiteCheckPicture: PTPicture;
begin
  if not assigned(WhiteCheckPicture) then WhiteCheckPicture := LoadPicture(CBoard_WhiteCheckPath);
  GetWhiteCheckPicture := @WhiteCheckPicture;
end;

function GraphicsLoader.GetBlackCheckPicture: PTPicture;
begin
  if not assigned(BlackCheckPicture) then BlackCheckPicture := LoadPicture(CBoard_BlackCheckPath);
  GetBlackCheckPicture := @BlackCheckPicture;
end;

function GraphicsLoader.GetCheckPicture(IsWhite: Boolean): PTPicture;
begin
  if IsWhite then GetCheckPicture := GetWhiteCheckPicture()
  else GetCheckPicture := GetBlackCheckPicture();
end;

function GraphicsLoader.GetWhiteKingPicture: PTPicture;
begin
  if not assigned(WhiteKingPicture) then WhiteKingPicture := LoadPicture(CBoard_WhiteKingPath);
  GetWhiteKingPicture := @WhiteKingPicture;
end;

function GraphicsLoader.GetBlackKingPicture: PTPicture;
begin
  if not assigned(BlackKingPicture) then BlackKingPicture := LoadPicture(CBoard_BlackKingPath);
  GetBlackKingPicture := @BlackKingPicture;
end;

function GraphicsLoader.GetKingPicture(IsWhite: Boolean): PTPicture;
begin
  if IsWhite then GetKingPicture := GetWhiteKingPicture()
  else GetKingPicture := GetBlackKingPicture();
end;

end.
