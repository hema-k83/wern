import 'package:flutter/material.dart';

class ShowInstrutions extends StatelessWidget {
  const ShowInstrutions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            "Required settings are missing please follow below steps and relaunch the app",
            softWrap: true,
            maxLines: 5,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 20,
            ),
          ),
          Text(
            "Go to Settings > General Management > Text-to-Speech Output > Preferred engine → Google Text-to-Speech",
            softWrap: true,
            maxLines: 5,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          Text(
            "Go to Google TTS settings > Install voice data > Telugu",
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
