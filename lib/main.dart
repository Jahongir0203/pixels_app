import 'package:alice/alice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixels_app/pages/download_page.dart';
import 'package:pixels_app/pages/home_page.dart';
import 'package:pixels_app/pages/search_page.dart';
import 'package:pixels_app/pages/splash_page.dart';

Alice alice = Alice(
  showNotification: true,
  showInspectorOnShake: false,
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: alice.getNavigatorKey(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return CupertinoPageRoute(
              builder: (context) => SplashPage(),
            );

          case '/home':
            return CupertinoPageRoute(
              builder: (context) => HomePage(),
            );

          case '/search':
            return CupertinoPageRoute(
              builder: (context) =>
                  SearchPage(query: settings.arguments as String),
            );

          case '/download':
            return CupertinoPageRoute(
              builder: (context) =>
                  DownloadPage(url: settings.arguments as String),
            );
        }
      },
    );
  }
}
