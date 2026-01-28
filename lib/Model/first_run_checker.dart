import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isFirstRun() async {
  final prefs = await SharedPreferences.getInstance();
  bool firstRun = prefs.getBool('first_run') ?? true;
  if (firstRun) {
    prefs.setBool('first_run', false);
  }
  return firstRun;
}
