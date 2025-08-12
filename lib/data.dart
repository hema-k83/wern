import 'package:wern/app_variables.dart';

class Data {
  static final Map<String, List<String>> General = {
    "te": [
      "అర",
      "ఆన",
      "ఇనుము",
      "ఈక",
      "ఉలి",
      "ఊరు",
      "ఋషి",
      "ఎలుక",
      "ఏనుగు",
      "ఐదు",
      "ఒంటె",
      "ఓడ",
      "ఔషధం",
      "అంచు",
      "కలం",
      "ఖండం",
      "గడప",
      "ఘటం",
      "చదరం",
      "ఛత్రం",
      "జలం",
      "ఝరి",
      "టమాట",
      "డాబు",
      "ఢమరుకం",
      "కరుణ",
      "తల",
      "దరువు",
      "ధనం",
      "నగ",
      "పలక",
      "ఫణి",
      "బలం",
      "భజన",
      "మలుపు",
      "యమున",
      "రజతం",
      "లత",
      "వరి",
      "సతతం",
      "సరము",
      "నిముషం",
      "హారతి",
      "అక్షరం",
      "కళ",
      "గుర్రం",
    ],
    "en": [
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
    ],
  };
  static final Map<String, List<String>> Fruits = {
    "te": [
      "జామ",
      "అరటి",
      "కమల",
      "దానిమ్మ",
      "నారింజ",
      "ద్రాక్ష",
      "సపోటా",
      "అనాస",
      "మామిడి",
    ],
    "en": ["Apple", "Papaya", "Mango", "Guava", "Banana", "Orange", "Grapes"],
  };
  static final Map<String, List<String>> Colors = {
    "te": ["నలుపు", "నారింజ", "తెలుపు", "ఎరుపు", "నీలం", "పసుపు", "ఆకుపచ్చ"],
    "en": [
      "White",
      "Yellow",
      "Black",
      "Orange",
      "Blue",
      "Red",
      "Green",
      "Brown",
      "Purple",
    ],
  };
  static final Map<String, List<String>> Vegetables = {
    "te": ["కాకర", "దొండ", "బెండ", "బీర", "సొర", "వంకాయ", "మిరప"],
    "en": [
      "Potato",
      "Banana",
      "Okra",
      "Tomato",
      "Brinjal",
      "Radish",
      "Spinach",
      "Carrot",
    ],
  };
  static final Map<String, List<String>> Places = {
    "te": [
      "ఇల్లు",
      "అచట",
      "ఇచట",
      "ఎచట",
      "గుడి",
      "బడి",
      "అంగడి",
      "అక్కడ",
      "ఇక్కడ",
      "ఎక్కడ",
      "ఆస్పత్రి",
      "కార్యాలయం",
    ],
    "en": [
      "Home",
      "Shop",
      "School",
      "Temple",
      "There",
      "Here",
      "Where",
      "Office",
    ],
  };
  static final Map<String, List<String>> People = {
    "te": [
      "అతడు",
      "ఆమె",
      "ఇతడు",
      "ఈమె",
      "ఎవరు",
      "బాలిక",
      "బాలుడు",
      "యువకుడు",
      "యువతి",
      "గురువు",
      "వ్యక్తి",
    ],
    "en": ["She", "He", "Girl", "Boy", "Man", "Woman", "Who", "Sir", "Teacher"],
  };
  static final Map<String, List<String>> Numbers = {
    "te": [
      "ఒకటి",
      "రెండు",
      "మూడు",
      "నాలుగు",
      "ఐదు",
      "ఆరు",
      "ఏడు",
      "ఎనిమిది",
      "తొమ్మిది",
      "పది",
    ],
    "en": [
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
    ],
  };

  static getData(String category) {
    switch (category) {
      case "General":
        return General[AppVariables.Language];
      case "Fruits":
        return Fruits[AppVariables.Language];
      case "Colors":
        return Colors[AppVariables.Language];
      case "Vegetables":
        return Vegetables[AppVariables.Language];
      case "Places":
        return Places[AppVariables.Language];
      case "People":
        return People[AppVariables.Language];
      case "Numbers":
        return Numbers[AppVariables.Language];
      default:
        return myList[AppVariables.Language];
    }
  }

  static Map<String, List<String>> myList = {"en": [], "te": []};
}
