import 'package:assignment_project/bloc/home_bloc.dart';
import 'package:assignment_project/home_page.dart';
import 'package:assignment_project/utils/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  router(RouteSettings setting) {
    switch (setting.name) {
      case Screens.homeScreen:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider<HomeBloc>(
                  create: (BuildContext context) => HomeBloc(),
                )
              ],
              child: const HomePage(),
            ));

      default:
        return MaterialPageRoute(builder: (context) => const HomePage());
    }
  }
}