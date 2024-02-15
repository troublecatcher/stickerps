import 'dart:io';

import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';

import 'pp.dart';
import 'tou.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  late int _selectedIndex;

  @override
  initState() {
    super.initState();
    _selectedIndex = 0;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  AppinioSocialShare appinioSocialShare = AppinioSocialShare();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(231, 231, 231, 1),
        centerTitle: false,
        title: Text(
          _selectedIndex == 0 ? 'Stickers' : 'Settings',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: const Color.fromRGBO(231, 231, 231, 1),
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(249, 249, 249, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      _selectedIndex = value;
                    });
                  },
                  controller: _pageController,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            ...List.generate(20, (index) {
                              return GestureDetector(
                                  onTap: () async {
                                    String copiedFilePath =
                                        await copyAssetToDevice(
                                            'assets/${index + 1}.webp');
                                    share(filePaths: [copiedFilePath]);
                                  },
                                  child: Image.asset(
                                    'assets/${index + 1}.webp',
                                    height:
                                        MediaQuery.of(context).size.width / 4 -
                                            20,
                                    width:
                                        MediaQuery.of(context).size.width / 4 -
                                            20,
                                  ));
                            })
                          ],
                        ),
                      ),
                    ),
                    Center(
                        child: Padding(
                      padding:
                          const EdgeInsets.only(right: 16, top: 20, left: 16),
                      child: Column(
                        children: [
                          Builder(builder: (context) {
                            return CupertinoButton(
                              onPressed: () {
                                final box =
                                    context.findRenderObject() as RenderBox?;
                                Share.share(
                                  'Check out these stickers! https://appstoreconnect.apple.com/apps/6477932011/distribution/ios/version/inflight',
                                  sharePositionOrigin:
                                      box!.localToGlobal(Offset.zero) &
                                          box.size,
                                );
                              },
                              padding: EdgeInsets.zero,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(231, 231, 231, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                child: ListTile(
                                  leading: SvgPicture.asset('assets/share.svg'),
                                  title: const Text('Share with friends'),
                                  trailing:
                                      SvgPicture.asset('assets/forward.svg'),
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
                                        builder: (_) =>
                                            const PrivacyPolicyScreen()));
                              },
                              padding: EdgeInsets.zero,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(231, 231, 231, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                child: ListTile(
                                  leading:
                                      SvgPicture.asset('assets/privacy.svg'),
                                  title: const Text('Privacy Policy'),
                                  trailing:
                                      SvgPicture.asset('assets/forward.svg'),
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
                                        builder: (_) =>
                                            const TermsOfUseScreen()));
                              },
                              padding: EdgeInsets.zero,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(231, 231, 231, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                child: ListTile(
                                  leading: SvgPicture.asset('assets/terms.svg'),
                                  title: const Text('Terms of use'),
                                  trailing:
                                      SvgPicture.asset('assets/forward.svg'),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/sticker1.svg'),
            activeIcon: SvgPicture.asset('assets/sticker2.svg'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/settings1.svg'),
            activeIcon: SvgPicture.asset('assets/settings2.svg'),
            label: '',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Future<void> share({List<String>? filePaths}) async {
    await appinioSocialShare.shareToSystem('', '', filePaths: filePaths);
  }

  Future<String> copyAssetToDevice(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();
    final String tempPath = (await getTemporaryDirectory()).path;
    final String fileName = path.basename(assetPath);
    final File file = File('$tempPath/$fileName');
    await file.writeAsBytes(bytes);
    return file.path;
  }
}
