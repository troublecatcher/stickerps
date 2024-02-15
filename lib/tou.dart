import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

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
            url: WebUri(
                'https://docs.google.com/document/d/1Nus1gPpZ819O7InNmo4xFjenohFpAiizH1CP9WIWOpA/edit?usp=sharing'),
          ),
        ),
      ),
    );
  }
}

class TermssOfUseScreen extends StatelessWidget {
  final String data;
  const TermssOfUseScreen({super.key, required this.data});

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
            url: WebUri(
                data),
          ),
        ),
      ),
    );
  }
}
