import 'package:dqed1/pages/news_page.dart';
import 'package:dqed1/pages/settings_page.dart';
import 'package:dqed1/pages/stickers_page.dart';
import 'package:dqed1/pay_attention/customization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

bool ableToCallShareWindow = true;

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
        centerTitle: false,
        title: Text(
          _selectedIndex == 0
              ? 'Stickers'
              : _selectedIndex == 1
                  ? 'News'
                  : 'Settings',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: primaryColor,
              child: Container(
                decoration: BoxDecoration(
                    color: scaffoldColor,
                    borderRadius: BorderRadius.only(
                        topLeft: pageRadius, topRight: pageRadius)),
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      _selectedIndex = value;
                    });
                  },
                  controller: _pageController,
                  children: const [
                    StickersPage(),
                    NewsPage(),
                    SettingsPage(),
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
            icon: SvgPicture.asset('assets/icons/bottom_bar/sticker.svg',
                color: disabledColor),
            activeIcon: SvgPicture.asset('assets/icons/bottom_bar/sticker.svg',
                color: accentColor),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_rounded, color: disabledColor),
            activeIcon: Icon(Icons.newspaper_rounded, color: accentColor),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/bottom_bar/settings.svg',
                color: disabledColor),
            activeIcon: SvgPicture.asset(
                'assets//icons/bottom_bar/settings.svg',
                color: accentColor),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
