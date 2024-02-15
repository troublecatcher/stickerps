import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 253, 168),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 253, 168),
      ),
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri('https://docs.google.com/document/d/1OEG9DZwC0sYA5kdkhikc3kTzv8fTtBAyxHaVhLxBRgE/edit?usp=sharing'),
          ),
        ),
      ),
    );
  }
}
