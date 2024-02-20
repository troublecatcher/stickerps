import 'package:flutter/material.dart';

import 'news.dart';

class NewsDetails extends StatelessWidget {
  final News news;
  final int index;

  const NewsDetails({super.key, required this.news, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: 'item$index',
                child: Image.network(news.imageLink),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Text(news.title,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 20),
                    Text(news.content,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
