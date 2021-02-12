import 'package:flutter/material.dart';
import 'screens/news_detail.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return StoriesProvider(
      child: MaterialApp(
        title: 'News!',
        onGenerateRoute: routes,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        {
          return MaterialPageRoute(builder: (context) {
            return NewsList();
          });
        }
        break;

      default:
        {
          return MaterialPageRoute(builder: (context) {
            return NewsDetail();
          });
        }
        break;
    }
  }
}
