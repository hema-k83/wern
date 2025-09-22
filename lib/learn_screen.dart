import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wern/analytics.dart';
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
  int readingIndex = -1;
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    Analytics.logPageView("learning_screen", widget.category);
  }

  getTextSize(shortestSide) {
    if (shortestSide < 400) {
      return 0.039;
    } else if (shortestSide < 600) {
      return 0.06;
    } else {
      return 0.09;
    }
  }

  getTextSizeForInfo(shortestSide) {
    if (shortestSide < 400) {
      return 10;
    } else if (shortestSide < 600) {
      return 12;
    } else {
      return 16;
    }
  }

  getHeight(shortestSide) {
    if (shortestSide < 400) {
      return 0.35;
    } else if (shortestSide < 600) {
      return 0.4;
    } else {
      return 0.6;
    }
  }

  getWidth(shortestSide) {
    if (shortestSide < 400) {
      return 0.55;
    } else if (shortestSide < 600) {
      return 0.55;
    } else {
      return 0.65;
    }
  }

  getIconSize(shortestSide) {
    if (shortestSide < 400) {
      return 25;
    } else if (shortestSide < 600) {
      return 35;
    } else {
      return 50;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryData = Data.getData(widget.category);
    final categoryVisualData = Data.getVisualData(widget.category);
    double shortestSide = MediaQuery.of(context).size.shortestSide;
    double height =
        MediaQuery.of(context).size.height * getHeight(shortestSide);
    double width = MediaQuery.of(context).size.width * getWidth(shortestSide);

    double textSize = getTextSize(shortestSide);
    double textSizeSmall = textSize * shortestSide;
    double textSizeLarge = textSizeSmall * 1.2;
    double textSizeOther = getTextSizeForInfo(shortestSide);
    double iconSize = getIconSize(shortestSide);
    print(
      " Text size for ${shortestSide} textSize is ${textSize} textSizeSmall is ${textSizeSmall} and textSizeLarge is ${textSizeLarge}",
    );

    return Scaffold(
      backgroundColor: Color(0xFFBBDCE5),
      appBar: AppBar(
        backgroundColor: Color(0xFF065084),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Visibility(
                visible: currentPage > 0,
                replacement: SizedBox(width: 50),
                child: IconButton(
                  onPressed: () {
                    if (!isReading) {
                      pageController.previousPage(
                        duration: Duration(milliseconds: 1),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  icon: Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.indigo,
                    size: iconSize,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height,
              width: width,
              child: PageView(
                controller: pageController,
                physics: isReading
                    ? NeverScrollableScrollPhysics()
                    : BouncingScrollPhysics(),
                onPageChanged: (val) {
                  setState(() {
                    currentPage = val;
                  });
                },
                children: categoryData
                    .asMap()
                    .entries
                    .map<Widget>(
                      (MapEntry<int, String> wordEntry) => Card(
                        color: Color(0xFFF8FAFB),
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
                                    fontSize: textSizeOther,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
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
                                          fontSize: (readingIndex == index
                                              ? textSizeLarge
                                              : textSizeSmall),
                                          letterSpacing: 7.0,
                                        ),
                                      );
                                    })
                                    .toList(),
                              ),
                            ),
                            widget.category == "Colors"
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Container(
                                      height: height * 0.05,
                                      width: width * 0.1,

                                      decoration: widget.category == "Colors"
                                          ? BoxDecoration(
                                              color:
                                                  categoryVisualData[wordEntry
                                                      .key],
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 2,
                                              ),
                                            )
                                          : null,
                                    ),
                                  )
                                : SizedBox(),
                            widget.category == "Numbers"
                                ? Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 30,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          categoryVisualData[wordEntry.key],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: textSizeOther * 1.2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            Padding(
                              padding: EdgeInsets.only(bottom: height * 0.05),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: IconButton(
                                  onPressed: () async {
                                    isReading = !isReading;
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
                                        setState(
                                          //Don't delete
                                          () {},
                                        ); //Need these for last Character to scale down in sequence properly
                                      }
                                      if (isReading) {
                                        await widget.tts.speak(wordEntry.value);
                                      } //Reading entire word here
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
                                    size: iconSize + 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Visibility(
                visible: currentPage < (categoryData.length - 1),
                replacement: SizedBox(width: 50),
                child: IconButton(
                  onPressed: () {
                    if (!isReading) {
                      pageController.nextPage(
                        duration: Duration(milliseconds: 1),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  icon: Icon(
                    Icons.arrow_forward_sharp,
                    color: Colors.indigo,
                    size: iconSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    widget.tts.stop();
  }
}
