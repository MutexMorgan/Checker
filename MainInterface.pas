unit MainInterface;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, TVector2;

type
  ClickedOnMenuEvent = procedure(Pos: Vector2) of object;
  TForm1 = class(TForm)
    procedure GamePanelClik(Sender: TObject);
  private
    Event: ClickedOnMenuEvent;
  public
    property OnEvent: ClickedOnMenuEvent read Event write Event;
    procedure WriteVector2(Pos: Vector2);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}




procedure TForm1.WriteVector2(Pos: Vector2);
begin
  self.Caption := 'X:' + IntToStr(Pos.GetX) + ';\nY:' + IntToStr(Pos.GetY);
end;

procedure TForm1.GamePanelClik(Sender: TObject);
var Pt: TPoint;
begin
  if assigned(self.OnEvent) then
  begin
    Pt := self.ScreenToClient(Mouse.CursorPos);
    self.OnEvent(Vector2.Create(Pt.X, Pt.Y));
  end;
end;


end.
