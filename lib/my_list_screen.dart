import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'analytics.dart';

class MyListScreen extends StatefulWidget {
  const MyListScreen({super.key});

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  String listName = "";
  List<String> words = [];
  final int maxWords = 30;
  late SharedPreferences sharedPreferences;
  TextEditingController nameController = TextEditingController();
  TextEditingController wordController = TextEditingController();
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );
  final _nameForm = GlobalKey<FormState>();
  final _wordForm = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    Analytics.logPageView("mylist_screen", "MyListScreen");
    getSavedData().then((data) {
      if (data == true) {
        setState(() {
          nameController.text = listName;
        });
      }
    });
  }

  Future<bool> getSavedData() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      if (sharedPreferences.containsKey("listName}")) {
        listName = sharedPreferences.getString("listName") ?? "";
      }
      if (sharedPreferences.containsKey("words")) {
        words = sharedPreferences.getStringList("words") ?? [];
      }
      return true;
    } catch (e) {
      //TODO
    }
    return false;
  }

  Future<void> saveData() async {
    try {
      await sharedPreferences.setString("listName", nameController.text);
      await sharedPreferences.setStringList("words", words);
    } catch (e) {
      //TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    String langRegex = getLanguageRegex();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF8FAFB),
      appBar: AppBar(
        backgroundColor: Color(0xFF065084),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "My List",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        //backgroundColor: Colors.blueAccent,
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              "List Name",
              style: TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Form(
              key: _nameForm,
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hint: Text(
                    "Enter List Name",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                maxLines: 1,
                maxLength: 10,
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black, fontSize: 18),
                validator: (data) {
                  if (data == null || data.trim().isEmpty) {
                    return "Enter valid name";
                  } else {
                    return null;
                  }
                },
              ),
            ),

            Text(
              "Word",
              style: TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Form(
              key: _wordForm,
              child: TextFormField(
                controller: wordController,
                decoration: InputDecoration(
                  hint: Text(
                    "Enter Word in English",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                maxLines: 1,
                maxLength: 5,
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black, fontSize: 18),
                validator: (data) {
                  if (data != null || data!.trim().isNotEmpty) {
                    RegExp exp = RegExp(langRegex);
                    if (exp.hasMatch(data)) {
                      return null;
                    }
                  }
                  return "Enter valid word";
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: ElevatedButton(
                  style: buttonStyle,
                  onPressed: words.length < maxWords
                      ? () {
                          if (!_nameForm.currentState!.validate() ||
                              !_wordForm.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Enter valid Data',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              words.insert(0, wordController.text.trim());
                              wordController.text = "";
                            });
                            if (words.length == maxWords) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'You have reached maximum number of words limit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  backgroundColor: Colors.black,
                                ),
                              );
                            }
                          }
                        }
                      : null,
                  child: Text(
                    "Add Word",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            Divider(color: Colors.grey, height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: words.length,
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(color: Colors.grey, height: 10);
                },

                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      words[index],
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          words.remove(words[index]);
                        });
                      },
                      icon: Icon(Icons.delete_forever_sharp, color: Colors.red),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: ElevatedButton(
                  onPressed: () async {
                    if (!_nameForm.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Enter valid Data',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      await saveData();
                      Navigator.pop(context, "change");
                    }
                  },
                  style: buttonStyle.copyWith(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      Colors.green,
                    ),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getLanguageRegex() {
    return r'^[A-Za-z]+$';
  }
}
