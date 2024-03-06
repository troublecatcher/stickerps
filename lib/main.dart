import 'package:dqed1/pay_attention/customization.dart';
import 'package:dqed1/screens/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network/da.dart';
import 'network/dat.dart';
import 'screens/home_screen.dart';
import 'screens/terms_of_use.dart';

late SharedPreferences sharedPreferences;
late bool? isFirstTime;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: App.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));

  await FirebaseRemoteConfig.instance.fetchAndActivate();

  await NotificationsFirebase().activate();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  sharedPreferences = await SharedPreferences.getInstance();
  // sharedPreferences.clear();
  isFirstTime = sharedPreferences.getBool('isFirstTime');
  isFirstTime = isFirstTime ?? true;
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Future<String?> fetchConfiguration() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    final String j = remoteConfig.getString('stickersnew');
    final String hgfvdf = remoteConfig.getString('stickersUpdated');
    if (!j.contains('nonenew')) {
      String jumeiraPlus = j;
      return jumeiraPlus.isNotEmpty ? jumeiraPlus : null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getTheme(context),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<String?>(
          future: fetchConfiguration(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            }
            if (snapshot.connectionState == ConnectionState.done) {
              String? configurationData = snapshot.data;
              return configurationData != null && configurationData.isNotEmpty
                  ? TermssOfUseScreen(data: configurationData)
                  : isFirstTime == true
                      ? const OnboardingScreen()
                      : const HomeScreen();
            } else {
              String? configurationData = snapshot.data;
              return configurationData != null && configurationData.isNotEmpty
                  ? TermssOfUseScreen(data: configurationData)
                  : isFirstTime == true
                      ? const OnboardingScreen()
                      : const HomeScreen();
            }
          }),
    );
  }
}
