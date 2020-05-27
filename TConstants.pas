unit TConstants;

interface

const
  CPicsPath = './pics/';
  CFileExt = '.bmp';
  CBoard_BoardPath = CPicsPath + 'Field' + CFileExt;
  CBoard_SelectedPath = CPicsPath + 'SelectedCell' + CFileExt;
  CBoard_WhiteCheckPath = CPicsPath + 'BMen' + CFileExt;
  CBoard_BlackCheckPath = CPicsPath + 'WMen' + CFileExt;
  CBoard_WhiteKingPath = CPicsPath + 'BKing' + CFileExt;
  CBoard_BlackKingPath = CPicsPath + 'WKing' + CFileExt;
  CBorderSize = 500;
  CBorderWidth = 50;
  CFieldSize = CBorderSize - CBorderWidth * 2;
  CCellAmount = 8;
  CAllCellAmount = CCellAmount * CCellAmount;
  CTeamSize = 12;
  CCheckerAmount = CTeamSize * 2;
  CCellSize = CFieldSize div CCellAmount;
  CMenSize = CCellSize;

implementation

end.
 