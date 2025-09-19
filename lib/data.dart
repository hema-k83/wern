import 'dart:ui';

import 'package:flutter/material.dart';

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
  static final List<Color> colors_v = [
    Colors.black,
    Colors.blue,
    Colors.brown,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.purple,
    Colors.white,
    Colors.yellow,
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
    "ZERO",
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

  static final List<String> numbers_v = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "20",
    "30",
    "40",
    "50",
    "60",
    "70",
    "80",
    "90",
    "100",
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

  static getVisualData(String category) {
    switch (category) {
      case "Colors":
        print("Sending lenght${colors_v.length}");
        return colors_v;
      case "Numbers":
        print("Sending lenght${numbers_v.length}");
        return numbers_v;
      default:
        print("Sending lenght 0");
        return [];
    }
  }

  static List<String> myList = [];
}
