import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Allow portrait up
  ]).then((_) {
    runApp(const WernApp()); // Your main application widget
  });
}

class WernApp extends StatelessWidget {
  const WernApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wern',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
