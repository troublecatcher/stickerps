import 'package:dqed1/pay_attention/customization.dart';
import 'package:dqed1/screens/news_details.dart';
import 'package:flutter/material.dart';

import '../pay_attention/news_list.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => NewsDetails(
                        news: newsList[index],
                        index: index,
                      ))),
          child: ListTile(
            leading: Hero(
              tag: 'item$index',
              child: Image.network(newsList[index].imageLink,
                  width: 100, height: 100, fit: BoxFit.cover),
            ),
            title: Text(
              newsList[index].title,
              style: TextStyle(color: textColor),
            ),
            subtitle: Text(
              newsList[index].content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).primaryColor),
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(
        indent: 30,
        endIndent: 30,
        color: secondaryColor,
      ),
    );
  }
}
