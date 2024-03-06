import 'package:flutter/material.dart';

Color textColor = AppColors.white.color;
Color accentColor = AppColors.blue.color;
Color primaryColor = AppColors.black.color;
Color secondaryColor = AppColors.white.w400();
Color disabledColor = AppColors.white.w300();
Color scaffoldColor = AppColors.white.w100();
Color backButtonColor = accentColor;

EdgeInsets settingsInsets = const EdgeInsets.only(bottom: 16);
Radius settingsItemBorderRadius = const Radius.circular(16);
Radius pageRadius = settingsItemBorderRadius * 2;

int stickersInRow = 3;
double stickersSpacing = 10;

ThemeData getTheme(BuildContext context) {
  return ThemeData(
    primaryColor: accentColor,
    splashColor: Colors.transparent,
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: textColor,
          displayColor: textColor,
        ),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: primaryColor),
    scaffoldBackgroundColor: primaryColor,
    appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        titleTextStyle:
            Theme.of(context).textTheme.titleLarge!.copyWith(color: textColor),
        iconTheme: IconThemeData(
          color: accentColor,
        )),
  );
}

enum AppColors {
  black(Colors.black),
  white(Colors.white),

  green(Color.fromRGBO(50, 195, 112, 1)),
  orange(Color.fromRGBO(242, 153, 74, 1)),
  red(Color.fromRGBO(235, 87, 87, 1)),
  blue(Color.fromRGBO(47, 128, 237, 1)),
  yellow(Color.fromRGBO(242, 201, 76, 1)),
  violet(Color.fromRGBO(155, 81, 224, 1));

  final Color color;

  const AppColors(this.color);
  Color main() => color.withOpacity(1);
  Color w600() => color.withOpacity(0.6);
  Color w500() => color.withOpacity(0.5);
  Color w400() => color.withOpacity(0.4);
  Color w300() => color.withOpacity(0.3);
  Color w200() => color.withOpacity(0.2);
  Color w100() => color.withOpacity(0.1);
}
