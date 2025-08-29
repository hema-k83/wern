class Data {
  static final List<String> general = [
    "ANT",
    "BOX",
    "CAMP",
    "DRUM",
    "EAR",
    "FAN",
    "GAME",
    "HELP",
    "INK",
    "JAR",
    "KITE",
    "LOG",
    "MOON",
    "NET",
    "OWL",
    "PEN",
    "QUICK",
    "ROW",
    "SUN",
    "TRUNK",
    "ULTRA",
    "VAN",
    "WEB",
    "XYLEM",
    "YARD",
    "ZONE",
  ];
  static final List<String> fruits = [
    "APPLE",
    "BANANA",
    "GRAPES",
    "GUAVA",
    "MANGO",
    "ORANGE",
    "PAPAYA",
    "PINEAPPLE",
  ];
  static final List<String> colors = [
    "AQUA",
    "BLACK",
    "BLUE",
    "BROWN",
    "GREEN",
    "ORANGE",
    "RED",
    "PURPLE",
    "WHITE",
    "YELLOW",
  ];
  static final List<String> vegetables = [
    "BEETROOT",
    "BRINJAL",
    "CABBAGE",
    "CARROT",
    "CUCUMBER",
    "OKRA",
    "POTATO",
    "RADISH",
    "SPINACH",
    "TOMATO",
  ];
  static final List<String> places = [
    "HOME",
    "SHOP",
    "SCHOOL",
    "TEMPLE",
    "OFFICE",
  ];
  static final List<String> people = [
    "BOY",
    "DAD",
    "GIRL",
    "KID",
    "MAN",
    "MOM",
    "PAL",
    "TEACHER",
    "WOMAN",
  ];
  static final List<String> numbers = [
    "ONE",
    "TWO",
    "THREE",
    "FOUR",
    "FIVE",
    "SIX",
    "SEVEN",
    "EIGHT",
    "NINE",
    "TEN",
    "TWENTY",
    "THIRTY",
    "FORTY",
    "FIFTY",
    "SIXTY",
    "SEVENTY",
    "EIGHTY",
    "NINETY",
    "HUNDRED",
  ];

  static getData(String category) {
    switch (category) {
      case "General":
        return general;
      case "Fruits":
        return fruits;
      case "Colors":
        return colors;
      case "Vegetables":
        return vegetables;
      case "Places":
        return places;
      case "People":
        return people;
      case "Numbers":
        return numbers;
      default:
        return myList;
    }
  }

  static List<String> myList = [];
}
