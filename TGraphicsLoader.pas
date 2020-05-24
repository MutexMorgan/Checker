unit TGraphicsLoader;

interface

uses ExtCtrls, Graphics, TConstants;

type
  GraphicsLoader = class
  private
    BoardPicture: TPicture;
    WhiteCheckPicture: TPicture;
    BlackCheckPicture: TPicture;
    function LoadPicture(Path: String): TPicture;
  public
    function GetBoardPicture: TPicture;
    function GetWhiteCheckPicture: TPicture;
    function GetBlackCheckPicture: TPicture;
    function GetCheckPicture(IsWhite: Boolean): TPicture;
  end;
  
implementation

function GraphicsLoader.LoadPicture(Path: String): TPicture;
begin
    LoadPicture := TPicture.Create;
    LoadPicture.LoadFromFile(Path);
end;

function GraphicsLoader.GetBoardPicture: TPicture;
begin
  if not assigned(BoardPicture) then BoardPicture := LoadPicture(CBoard_BoardPath);
  GetBoardPicture := BoardPicture;
end;

function GraphicsLoader.GetWhiteCheckPicture: TPicture;
begin
  if not assigned(WhiteCheckPicture) then WhiteCheckPicture := LoadPicture(CBoard_WhiteCheckPath);
  GetWhiteCheckPicture := WhiteCheckPicture;
end;

function GraphicsLoader.GetBlackCheckPicture: TPicture;
begin
  if not assigned(BlackCheckPicture) then BlackCheckPicture := LoadPicture(CBoard_BlackCheckPath);
  GetBlackCheckPicture := BlackCheckPicture;
end;

function GraphicsLoader.GetCheckPicture(IsWhite: Boolean): TPicture;
begin
  if IsWhite then GetCheckPicture := GetWhiteCheckPicture()
  else GetCheckPicture := GetBlackCheckPicture();

end;

end.
 