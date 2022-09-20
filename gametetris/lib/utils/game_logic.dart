class Game {
  final String hiddenCardPath = 'assets/images/questionForGame.png';
  List<String>? gameImg;
  // ignore: non_constant_identifier_names 
  final List<String> cards_list = [
    "assets/images/blackSmile.png", 
    "assets/images/studentSmile.png", 
    "assets/images/blackSmile.png",
    "assets/images/smile.png", 
    "assets/images/blueSmile.png", 
    "assets/images/studentSmile.png", 
    "assets/images/blueSmile.png", 
    "assets/images/smile.png", 
  ];

  List<Map<int, String>> matchCheck = [];

  final int cardCount = 8;

  //init the game => oyundu bashtoo
  void initGame() {
    gameImg = List.generate(cardCount, (index) => hiddenCardPath);
  }
}
