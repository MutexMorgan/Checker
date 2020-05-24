unit TConstants;

interface

const
  CPicsPath = './pics/';
  CFileExt = '.bmp';
  CBoard_BoardPath = CPicsPath + 'Field' + CFileExt;
  CBoard_WhiteCheckPath = CPicsPath + 'BMen' + CFileExt;
  CBoard_BlackCheckPath = CPicsPath + 'WMen' + CFileExt;
  CBorderSize = 500;
  CBorderWidth = 50;
  CFieldSize = CBorderSize - CBorderWidth * 2;
  CCellAmount = 8;
  CAllCellAmount = CCellAmount * CCellAmount;
  CTeamSize = 12;
  CCellSize = CFieldSize div CCellAmount;
  CMenSize = CCellSize;

implementation

end.
 