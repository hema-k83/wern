import 'package:flutter/material.dart';

import 'analytics.dart';

class ShowInstrutions extends StatelessWidget {
  ShowInstrutions({super.key, required this.language});
  String language;
  @override
  Widget build(BuildContext context) {
    Analytics.logPageView("instructions_screen", "No Support");
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 10,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.red,
            child: Text(
              "Required settings are missing please follow below steps and relaunch the app",
              softWrap: true,
              maxLines: 5,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "1. Go to Settings > General Management > Text-to-Speech Output > Preferred engine → Google Text-to-Speech",
            softWrap: true,
            maxLines: 5,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "2. Go to Google TTS settings > Install voice data > ${language}",
            softWrap: true,
            maxLines: 5,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
