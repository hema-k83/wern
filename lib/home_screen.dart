import 'package:flutter/material.dart';
import 'package:wern/analytics.dart';
import 'package:wern/my_list_screen.dart';
import 'package:wern/custom_tts.dart';
import 'package:wern/learn_screen.dart';
import 'package:wern/show_instructions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool>? isLanguageSupported;
  late CustomTTS tts;
  bool canCreateList = false;

  final List<String> categories = [
    "General",
    "Fruits",
    "Colors",
    "Vegetables",
    "Places",
    "People",
    "Numbers",
  ];
  final int initialCategories = 7;
  late SharedPreferences sharedPreferences;
  int primary = 0xFF065084; //Appbar A7d8ff
  int primaryVariant = 0xFFBBDCE5;
  int secondary = 0xFFF8FAFB;
  int secondaryVariant = 0xFFEF4444;

  @override
  void initState() {
    super.initState();
    tts = CustomTTS();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initCategories();
      Analytics.logPageView("home_page", "HomePage");
    });
  }

  void initCategories() {
    isLanguageSupported = tts.initTTS().then((data) {
      if (data == true) {
        setState(() {
          canCreateList = true;
        });
      }
      return data;
    });
    getCategoriesData();
  }

  void getCategoriesData() {
    getSavedWords().then((data) {
      setState(() {
        if (categories.length > initialCategories) {
          categories
              .removeLast(); //User modifies previously created list, when we comeback to screen need to load updated data so need to remove previous data.
        }
        if (data.isNotEmpty) {
          categories.add(data);
        }
      });
    });
  }

  getCategoryNameDetails() {
    if (sharedPreferences.containsKey("listName")) {
      return sharedPreferences.getString("listName") ?? "";
    }
  }

  Future<String> getSavedWords() async {
    String name = "";
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      name = getCategoryNameDetails();
      Data.myList.removeRange(0, Data.myList.length);
      if (sharedPreferences.containsKey("words")) {
        List<String> words = sharedPreferences.getStringList("words") ?? [];
        if (words.isEmpty) {
          name = "";
        } else {
          Data.myList.addAll(words);
        }
      } else {
        name = "";
      }
    } catch (e) {
      return "";
    }
    return name;
  }

  getColumnCount(width) {
    if (width < 600) {
      return 2; // small phones
    } else if (width < 900) {
      return 3; // landscape phones / small tablets
    } else {
      return 4; // big tablets / desktops
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = getColumnCount(width);
    return Scaffold(
      backgroundColor: Color(primaryVariant),
      appBar: AppBar(
        backgroundColor: Color(primary),
        shadowColor: Colors.grey.shade50,
        centerTitle: true,
        elevation: 30,
        title: Column(
          children: [
            Text(
              "Wern",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "A Word Learning App",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: isLanguageSupported,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (asyncSnapshot.hasData) {
            return Visibility(
              visible: asyncSnapshot.data!,
              replacement: ShowInstructions(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Card(
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Color(secondary),
                        shadowColor: Colors.grey.shade700,
                        child: Column(
                          children: [
                            Expanded(child: Image.asset(getImageName(index))),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Text(
                                categories[index],
                                style: TextStyle(
                                  color: Color(0xFF111827),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => LearnScreen(
                              category: categories[index],
                              tts: tts,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            );
          } else {
            return ShowInstructions();
          }
        },
      ),
      floatingActionButton: Visibility(
        visible: canCreateList,
        child: FloatingActionButton(
          onPressed: () {
            onAddWords();
          },
          backgroundColor: Color(secondaryVariant),
          child: const Icon(Icons.create_rounded, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  getImageName(index) {
    if (index < initialCategories) {
      return "images/${categories[index].toLowerCase()}.png";
    } else {
      return "images/mylist.png";
    }
  }

  void onAddWords() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyListScreen()),
    );

    if (result == 'change') {
      initCategories();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Data Saved",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 500),
        ),
      );
    }
  }
}
