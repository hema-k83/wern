import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wern/analytics.dart';
import 'package:wern/custom_tts.dart';

import 'ad_helper.dart';
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
  BannerAd? _ad;

  @override
  void initState() {
    super.initState();
    Analytics.logPageView("learning_screen", widget.category);
    // TODO: Load a banner ad
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    ).load();
  }

  getTextSize(shortestSide) {
    if (shortestSide < 400) {
      return 0.10;
    } else if (shortestSide < 600) {
      return 0.12;
    } else {
      return 0.14;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryData = Data.getData(widget.category);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double shorterSide = MediaQuery.of(context).size.shortestSide;
    print("------------------- $shorterSide");

    double textSize = getTextSize(shorterSide);
    double textSizeSmall = textSize * shorterSide;
    double textSizeLarge = textSizeSmall * 1.2;
    double iconSize = width < 600 ? 60 : 30;

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
        child: SizedBox(
          height: height * 0.45,
          width: width * 0.9,
          child: PageView(
            physics: isReading
                ? NeverScrollableScrollPhysics()
                : BouncingScrollPhysics(),
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
                            padding: const EdgeInsets.only(right: 20, top: 15),
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
                        Padding(
                          padding: EdgeInsets.only(bottom: height * 0.05),
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
                                    await widget.tts.speak(chars[readingIndex]);
                                    await Future.delayed(
                                      Duration(milliseconds: 20),
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
                                size: iconSize,
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
      ),
      bottomNavigationBar: Visibility(
        visible: (_ad != null),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Container(
            width: _ad?.size.width.toDouble() ?? 0,
            height: 72.0,
            alignment: Alignment.center,
            child: _ad == null ? const SizedBox() : AdWidget(ad: _ad!),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.tts.stop();
    _ad?.dispose();
  }
}
