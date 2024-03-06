import 'package:dqed1/pay_attention/customization.dart';
import 'package:dqed1/screens/home_screen.dart';
import 'package:dqed1/screens/privacy_policy.dart';
import 'package:dqed1/screens/terms_of_use.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.only(right: 16, top: 20, left: 16),
      child: Column(
        children: [
          Builder(builder: (context) {
            return CupertinoButton(
              onPressed: () async {
                if (ableToCallShareWindow) {
                  ableToCallShareWindow = false;
                  final box = context.findRenderObject() as RenderBox?;
                  await Share.shareWithResult(
                          'Check out these stickers! https://appstoreconnect.apple.com/apps/6477932011/distribution/ios/version/inflight',
                          sharePositionOrigin:
                              box!.localToGlobal(Offset.zero) & box.size)
                      .whenComplete(() => ableToCallShareWindow = true);
                }
              },
              padding: EdgeInsets.zero,
              child: Container(
                margin: settingsInsets,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(settingsItemBorderRadius)),
                child: ListTile(
                  leading: SvgPicture.asset('assets/icons/settings/share.svg',
                      color: secondaryColor),
                  title: Text('Share with friends',
                      style: TextStyle(color: textColor)),
                  trailing: SvgPicture.asset('assets/icons/forward.svg',
                      color: accentColor),
                ),
              ),
            );
          }),
          Builder(builder: (context) {
            return CupertinoButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const PrivacyPolicyScreen()));
              },
              padding: EdgeInsets.zero,
              child: Container(
                margin: settingsInsets,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(settingsItemBorderRadius)),
                child: ListTile(
                  leading: SvgPicture.asset('assets/icons/settings/privacy.svg',
                      color: secondaryColor),
                  title: Text('Privacy Policy',
                      style: TextStyle(color: textColor)),
                  trailing: SvgPicture.asset('assets/icons/forward.svg',
                      color: accentColor),
                ),
              ),
            );
          }),
          Builder(builder: (context) {
            return CupertinoButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const TermsOfUseScreen()));
              },
              padding: EdgeInsets.zero,
              child: Container(
                margin: settingsInsets,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(settingsItemBorderRadius)),
                child: ListTile(
                  leading: SvgPicture.asset('assets/icons/settings/terms.svg',
                      color: secondaryColor),
                  title:
                      Text('Terms of use', style: TextStyle(color: textColor)),
                  trailing: SvgPicture.asset('assets/icons/forward.svg',
                      color: accentColor),
                ),
              ),
            );
          }),
        ],
      ),
    ));
  }
}
