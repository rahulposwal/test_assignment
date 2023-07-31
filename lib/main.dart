import 'package:assignment_project/router/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRoute appRoute = AppRoute();
  final navigatorKey = GlobalKey<NavigatorState>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo App',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (setting) => appRoute.router(setting),
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
    );
  }
}
