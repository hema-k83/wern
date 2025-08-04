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
            children: Data.getData(widget.category)
                .map<Widget>(
                  (String word) => Padding(
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
                          Expanded(
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: word.characters
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
                                  print("Clicked");
                                  setState(() {
                                    isReading = !isReading;
                                  });
                                  if (isReading) {
                                    readingIndex = 0;
                                    var chars = word.characters.toList();
                                    for (
                                      readingIndex = 0;
                                      readingIndex < chars.length;
                                      readingIndex++
                                    ) {
                                      if (!isReading) break;
                                      await widget.tts.speak(
                                        chars[readingIndex],
                                      );
                                      await Future.delayed(
                                        Duration(milliseconds: 20),
                                      );
                                    }
                                    if (isReading) await widget.tts.speak(word);
                                    setState(() {
                                      isReading = false;
                                      readingIndex = -1;
                                    });
                                  } else {
                                    readingIndex = -1;
                                  }
                                },
                                icon: isReading
                                    ? Icon(
                                        Icons.stop,
                                        color: Colors.red,
                                        size: 60,
                                      )
                                    : Icon(
                                        Icons.play_arrow,
                                        color: Color(0xFF06923E),
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
