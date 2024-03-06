import 'package:dqed1/pay_attention/customization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(
                'https://docs.google.com/document/d/1OEG9DZwC0sYA5kdkhikc3kTzv8fTtBAyxHaVhLxBRgE/edit?usp=sharing'),
          ),
        ),
      ),
    );
  }
}
