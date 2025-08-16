import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:wern/app_variables.dart';

class Analytics {
  static void logPageView(String pageName, String data) async {
    await FirebaseAnalytics.instance.logEvent(
      name: "wern_analytics",
      parameters: {
        "visited_page": pageName,
        "category_name": data,
        "language_code": AppVariables.Language,
      },
    );
  }
}
