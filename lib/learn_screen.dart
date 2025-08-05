import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:characters/characters.dart';
import 'package:wern/custom_tts.dart';

import 'data.dart';

class LearnScreen extends StatefulWidget {
  final String category;
  final CustomTTS tts;

  const LearnScreen({super.key, required this.category, required this.tts});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  bool isReading = false;
  bool isLangauageSupported = false;
  int readingIndex = -1;

  @override
  void dispose() {
    super.dispose();
    widget.tts.stop();
  }

  @override
  Widget build(BuildContext context) {
    final categoryData = Data.getData(widget.category);
    return Scaffold(
      backgroundColor: Color(0xFFDFD0B8),
      appBar: AppBar(
        backgroundColor: Color(0xFF222831),
        centerTitle: true,
        title: Text(
          widget.category,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: PageView(
            physics: isReading
                ? NeverScrollableScrollPhysics()
                : BouncingScrollPhysics(),
            children: categoryData
                .asMap()
                .entries
                .map<Widget>(
                  (MapEntry<int, String> wordEntry) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: Colors.grey.shade700,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 20,
                                top: 15,
                              ),
                              child: Text(
                                "${wordEntry.key + 1} of ${categoryData.length}",
                                style: TextStyle(
                                  color: Colors.brown,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: wordEntry.value.characters
                                    .toList()
                                    .asMap()
                                    .entries
                                    .map<Widget>((MapEntry<int, String> entry) {
                                      final int index = entry.key;
                                      final String char = entry.value;
                                      return Text(
                                        char,
                                        style: GoogleFonts.ramabhadra(
                                          color: readingIndex == index
                                              ? Colors.red
                                              : Color(0xFF1A237E),
                                          fontSize: readingIndex == index
                                              ? 70
                                              : 50,
                                          letterSpacing: 7.0,
                                        ),
                                      );
                                    })
                                    .toList(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: IconButton(
                                onPressed: () async {
                                  setState(() {
                                    isReading = !isReading;
                                  });
                                  if (isReading) {
                                    readingIndex = 0;
                                    var chars = wordEntry.value.characters
                                        .toList();
                                    for (
                                      readingIndex = 0;
                                      readingIndex < chars.length;
                                      readingIndex++
                                    ) {
                                      if (!isReading) break;
                                      setState(
                                        //Don't delete
                                        () {},
                                      ); //Need these for Characters to scale up/down in sequence properly
                                      await widget.tts.speak(
                                        chars[readingIndex],
                                      );
                                      await Future.delayed(
                                        Duration(milliseconds: 20),
                                      );
                                      setState(
                                        //Don't delete
                                        () {},
                                      ); //Need these for last Character to scale down in sequence properly
                                    }
                                    if (isReading)
                                      await widget.tts.speak(
                                        wordEntry.value,
                                      ); //Reading entire word here
                                    setState(() {
                                      isReading = false;
                                      readingIndex = -1;
                                    });
                                  } else {
                                    setState(() {
                                      readingIndex = -1;
                                    });
                                  }
                                },
                                icon: Icon(
                                  isReading ? Icons.stop : Icons.play_arrow,
                                  color: isReading
                                      ? Colors.red
                                      : Color(0xFF06923E),
                                  size: 60,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
