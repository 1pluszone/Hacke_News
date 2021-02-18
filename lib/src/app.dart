import 'package:flutter/material.dart';
import 'screens/news_detail.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News!',
          initialRoute: '/',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        {
          return MaterialPageRoute(builder: (context) => NewsList());
        }
        break;

      case "/detail":
        {
          return MaterialPageRoute(builder: (context) {
            final commentsBloc = CommentsProvider.of(context);
            commentsBloc.fetchItemWithComments(args);
            return NewsDetail(
              newsId: args,
            );
          });
        }
        break;
      default:
        {
          return MaterialPageRoute(builder: (context) => ErrorPage());
        }
    }
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("this is an error page. nothing happens here"),
      ),
    );
  }
}
