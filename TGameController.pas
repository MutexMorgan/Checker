unit TGameController;

interface

uses Forms, TBoard, TGraphicsLoader, MainInterface, TGameInteractor;

type
  GameController = class
  private
    GameBoard: Board;
    ResourceLoader: GraphicsLoader;
    Interactor: GameInteractor;
    procedure Custom(Sender: TObject);
  public
    constructor Create;
    procedure RespawnChecker;
    procedure LaunchForm;
  end;

implementation

constructor GameController.Create;
begin
  ResourceLoader := GraphicsLoader.Create;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  GameBoard := Board.Create(ResourceLoader);
  self.Interactor := GameInteractor.Create(GameBoard);
  Form1.OnEvent := Interactor.HandleTheClick;
  Form1.OnShow := Custom;
end;

procedure GameController.Custom(Sender: TObject);
begin
  RespawnChecker;
end;

procedure GameController.RespawnChecker;
begin
  GameBoard.RespawnChecker;
end;

procedure GameController.LaunchForm;
begin
  Application.Run;
end;

end.
