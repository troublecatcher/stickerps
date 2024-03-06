import 'package:dqed1/pay_attention/customization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import '../widgets/logo.dart';
import '../main.dart';
import 'privacy_policy.dart';
import 'terms_of_use.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
          child: Stack(
        children: [
          const Align(
            alignment: Alignment(0, -0.5),
            child: Logo(),
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                'Send stickers to any messenger with our app!',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: CupertinoButton(
                    color: accentColor,
                    child:
                        Text('Get started', style: TextStyle(color: textColor)),
                    onPressed: () async {
                      isFirstTime = false;
                      sharedPreferences.setBool('isFirstTime', isFirstTime!);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const HomeScreen()));
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const TermsOfUseScreen()));
                      },
                      child: Text('Terms of use',
                          style: TextStyle(color: textColor))),
                  const Text('/'),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const PrivacyPolicyScreen()));
                      },
                      child: Text('Privacy Policy',
                          style: TextStyle(color: textColor))),
                ],
              ),
            ],
          )
        ],
      )),
    );
  }
}
