class Data {
  static final List<String> general = [
    "Ant",
    "Box",
    "Camel",
    "Drum",
    "Eye",
    "Fan",
    "Game",
    "Hut",
    "Ink",
    "Jar",
    "Kite",
    "Log",
    "Moon",
    "Net",
    "Owl",
    "Pen",
    "Quiet",
    "Row",
    "Sun",
    "Trunk",
    "Ultra",
    "Van",
    "Web",
    "xylem",
    "Yard",
    "Zone",
  ];
  static final List<String> fruits = [
    "Apple",
    "Papaya",
    "Mango",
    "Guava",
    "Banana",
    "Orange",
    "Grapes",
  ];
  static final List<String> colors = [
    "White",
    "Yellow",
    "Black",
    "Orange",
    "Blue",
    "Red",
    "Green",
    "Brown",
    "Purple",
  ];
  static final List<String> vegetables = [
    "Potato",
    "Banana",
    "Okra",
    "Tomato",
    "Brinjal",
    "Radish",
    "Spinach",
    "Carrot",
  ];
  static final List<String> places = [
    "Home",
    "Shop",
    "School",
    "Temple",
    "There",
    "Here",
    "Where",
    "Office",
  ];
  static final List<String> people = [
    "She",
    "He",
    "Girl",
    "Boy",
    "Man",
    "Woman",
    "Who",
    "Sir",
    "Teacher",
    "Us",
    "We",
    "They",
    "Them",
    "Me",
  ];
  static final List<String> numbers = [
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "Nine",
    "Ten",
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
