unit TGraphicsLoader;

interface

uses ExtCtrls, Graphics, TConstants;

type
  PTPicture = ^TPicture;
  PGraphicsLoader = ^GraphicsLoader;
  GraphicsLoader = class
  private
    BoardPicture: TPicture;
    SelectedPicture: TPicture;
    WhiteCheckPicture: TPicture;
    BlackCheckPicture: TPicture;
    WhiteKingPicture: TPicture;
    BlackKingPicture: TPicture;
    function LoadPicture(Path: String): TPicture;
  public
    function GetBoardPicture: PTPicture;
    function GetSelectedPicture: PTPicture;
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
  if not assigned(self.BoardPicture) then self.BoardPicture := LoadPicture(CBoard_BoardPath);
  GetBoardPicture := @self.BoardPicture;
end;

function GraphicsLoader.GetSelectedPicture: PTPicture;
begin
  if not assigned(self.SelectedPicture) then self.SelectedPicture := LoadPicture(CBoard_SelectedPath);
  GetSelectedPicture := @self.SelectedPicture;
end;

function GraphicsLoader.GetWhiteCheckPicture: PTPicture;
begin
  if not assigned(self.WhiteCheckPicture) then self.WhiteCheckPicture := LoadPicture(CBoard_WhiteCheckPath);
  GetWhiteCheckPicture := @self.WhiteCheckPicture;
end;

function GraphicsLoader.GetBlackCheckPicture: PTPicture;
begin
  if not assigned(self.BlackCheckPicture) then self.BlackCheckPicture := LoadPicture(CBoard_BlackCheckPath);
  GetBlackCheckPicture := @self.BlackCheckPicture;
end;

function GraphicsLoader.GetCheckPicture(IsWhite: Boolean): PTPicture;
begin
  if IsWhite then GetCheckPicture := GetWhiteCheckPicture()
  else GetCheckPicture := GetBlackCheckPicture();
end;

function GraphicsLoader.GetWhiteKingPicture: PTPicture;
begin
  if not assigned(self.WhiteKingPicture) then self.WhiteKingPicture := LoadPicture(CBoard_WhiteKingPath);
  GetWhiteKingPicture := @self.WhiteKingPicture;
end;

function GraphicsLoader.GetBlackKingPicture: PTPicture;
begin
  if not assigned(self.BlackKingPicture) then self.BlackKingPicture := LoadPicture(CBoard_BlackKingPath);
  GetBlackKingPicture := @self.BlackKingPicture;
end;

function GraphicsLoader.GetKingPicture(IsWhite: Boolean): PTPicture;
begin
  if IsWhite then GetKingPicture := GetWhiteKingPicture()
  else GetKingPicture := GetBlackKingPicture();
end;

end.
