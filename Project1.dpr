program Project1;

uses
  Forms,
  MainInterface in 'MainInterface.pas',
  TVector2 in 'TVector2.pas',
  TGameController in 'TGameController.pas',
  TChecker in 'TChecker.pas',
  TCheckerTeam in 'TCheckerTeam.pas',
  TBoard in 'TBoard.pas',
  TGraphicsLoader in 'TGraphicsLoader.pas',
  TConstants in 'TConstants.pas',
  TGameInteractor in 'TGameInteractor.pas',
  TBoardCell in 'TBoardCell.pas';

{$R *.res}
var Controller: GameController;
begin
  Controller := GameController.Create;
  Controller.LaunchForm;
end.
