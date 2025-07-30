List<int> splitCLayout(int n) {
  int topRow = (n / 3).ceil();
  int sideRow = (n / 3).floor();
  int bottomRow = n - (topRow + sideRow);
  return [topRow, sideRow, bottomRow];
}
