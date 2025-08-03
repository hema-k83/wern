class Data {
  static final List<String> General = [
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
  ];
  static final List<String> Fruits = [
    "జామ",
    "అరటి",
    "కమల",
    "దానిమ్మ",
    "నారింజ",
    "ద్రాక్ష",
    "సపోటా",
    "అనాస",
    "మామిడి",
    "నిమ్మ",
  ];
  static final List<String> Colors = [
    "నలుపు",
    "నారింజ",
    "తెలుపు",
    "ఎరుపు",
    "నీలం",
    "పసుపు",
    "ఆకుపచ్చ",
  ];
  static final List<String> Vegetables = [
    "కాకర",
    "దొండ",
    "బెండ",
    "బీర",
    "సొర",
    "వంకాయ",
    "మిరప",
  ];
  static final List<String> Places = [
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
    "ఇల్లు",
  ];
  static final List<String> People = [
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
  ];
  static final List<String> Numbers = [
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
  ];

  static getData(String category) {
    switch (category) {
      case "General":
        return General;
      case "Fruits":
        return Fruits;
      case "Colors":
        return Colors;
      case "Vegetables":
        return Vegetables;
      case "Places":
        return Places;
      case "People":
        return People;
      case "Numbers":
        return Numbers;
      default:
        return myList;
    }
  }

  static List<String> myList = [];
}
