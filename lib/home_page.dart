import 'package:flutter/material.dart';
import 'package:wern/add_words_screen.dart';
import 'package:wern/custom_tts.dart';
import 'package:wern/learn_screen.dart';
import 'package:wern/show_instructions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

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
    tts = CustomTTS(language: "te-IN");
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
    readData().then((data) {
      setState(() {
        if (categories.length > initialCategories) {
          categories.removeLast();
        }
        if (data.isNotEmpty) {
          categories.add(data);
        }
      });
    });
  }

  Future<String> readData() async {
    String name = "";
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      if (sharedPreferences.containsKey("listName")) {
        name = sharedPreferences.getString("listName") ?? "";
      }
      if (sharedPreferences.containsKey("words")) {
        List<String> words = sharedPreferences.getStringList("words") ?? [];
        if (words.isEmpty) {
          name = "";
          Data.myList.removeRange(0, Data.myList.length);
        } else {
          Data.myList.removeRange(0, Data.myList.length);
          Data.myList.addAll(words);
        }
      }
    } catch (e) {
      //TODO
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
          "Padhaalu",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        //backgroundColor: Colors.blueAccent,
        elevation: 10,
      ),
      body: isLanguageSupported == null
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder(
              future: isLanguageSupported,
              builder: (context, asyncSnapshot) {
                // setState(() {

                //});
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (asyncSnapshot.hasData) {
                  return Visibility(
                    visible: asyncSnapshot.data!,
                    replacement: ShowInstrutions(),
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
                                  Expanded(
                                    child: Image.asset(getImageName(index)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 20.0,
                                    ),
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
                                  builder: (BuildContext context) =>
                                      LearnScreen(
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
                  return ShowInstrutions();
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
      MaterialPageRoute(builder: (context) => AddWordsScreen()),
    );

    if (result == 'change') {
      initCategories();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Data Saved", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 500),
        ),
      );
    }
  }
}
