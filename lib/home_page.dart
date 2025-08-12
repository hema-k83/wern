import 'package:flutter/material.dart';
import 'package:wern/my_list_screen.dart';
import 'package:wern/custom_tts.dart';
import 'package:wern/learn_screen.dart';
import 'package:wern/show_instructions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_variables.dart';
import 'data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  void initState() {
    super.initState();
    tts = CustomTTS(language: "${AppVariables.Language}-IN");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initCategories();
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
    getSavedWords().then((data) {
      setState(() {
        if (categories.length > initialCategories) {
          categories
              .removeLast(); //User has created list before later modifies it, when we comeback to screen need to load updated data so need to remove previous data.
        }
        if (data.isNotEmpty) {
          categories.add(data);
        }
      });
    });
  }

  Future<String> getSavedWords() async {
    String name = "";
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      AppVariables.Language = sharedPreferences.getString("language") ?? "en";
      if (sharedPreferences.containsKey("listName_${AppVariables.Language}")) {
        name =
            sharedPreferences.getString("listName_${AppVariables.Language}") ??
            "";
      }
      if (sharedPreferences.containsKey("words_${AppVariables.Language}")) {
        List<String> words =
            sharedPreferences.getStringList("words_${AppVariables.Language}") ??
            [];
        if (words.isEmpty) {
          name = "";
          Data.myList[AppVariables.Language]?.removeRange(
            0,
            Data.myList[AppVariables.Language]!.length,
          );
        } else {
          Data.myList[AppVariables.Language]?.removeRange(
            0,
            Data.myList[AppVariables.Language]!.length,
          );
          Data.myList[AppVariables.Language]?.addAll(words);
        }
      } else {
        name = "";
        Data.myList[AppVariables.Language]?.removeRange(
          0,
          Data.myList[AppVariables.Language]!.length,
        );
      }
    } catch (e) {
      return "";
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF948979),
      appBar: AppBar(
        backgroundColor: Color(0xFF222831),
        centerTitle: true,
        title: Text(
          "Wern",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        elevation: 10,

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: PopupMenuButton<String>(
              onSelected: (val) {
                showDialog(
                  context: context,
                  builder: (BuildContext contxt) {
                    return AlertDialog(content: CircularProgressIndicator());
                  },
                );

                AppVariables.Language = val;
                sharedPreferences.setString("language", val);
                tts.setLanguage(AppVariables.Language);
                initCategories();
                setState(() {});
                Navigator.of(context).pop();
              },
              color: Color(0xFF222831),
              offset: Offset(0, 40),
              icon: Icon(Icons.settings, color: Colors.white, size: 30),
              itemBuilder: (context) => [
                PopupMenuItem<String>(
                  value: "en",
                  child: ListTile(
                    title: Text(
                      "English",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    trailing: Visibility(
                      visible: AppVariables.Language == "en",
                      child: const Icon(
                        Icons.check,
                        size: 20,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                PopupMenuDivider(color: Colors.white54),
                PopupMenuItem<String>(
                  value: "te",
                  child: ListTile(
                    title: Text(
                      "Telugu",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    trailing: Visibility(
                      visible: AppVariables.Language == "te",
                      child: const Icon(
                        Icons.check,
                        size: 20,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: isLanguageSupported,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (asyncSnapshot.hasData) {
            return Visibility(
              visible: asyncSnapshot.data!,
              replacement: ShowInstrutions(
                language: getLanguage(AppVariables.Language),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
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
                        color: Color(0xFFDFD0B8),
                        shadowColor: Colors.grey.shade700,
                        child: Column(
                          children: [
                            Expanded(child: Image.asset(getImageName(index))),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Text(
                                categories[index],
                                style: TextStyle(
                                  color: Colors.brown,
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
            return ShowInstrutions(
              language: getLanguage(AppVariables.Language),
            );
          }
        },
      ),
      floatingActionButton: Visibility(
        visible: canCreateList,
        child: FloatingActionButton(
          onPressed: () {
            onAddWords();
          },
          backgroundColor: Color(0xFFD96F32),
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

  String getLanguageCode(String val) {
    switch (val) {
      case "English":
        return "en";
      case "Telugu":
        return "te";
      default:
        return "en";
    }
  }

  String getLanguage(String val) {
    switch (val) {
      case "en":
        return "English";
      case "te":
        return "Telugu";
      default:
        return "English";
    }
  }
}
