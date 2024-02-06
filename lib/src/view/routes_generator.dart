import 'package:flutter/material.dart';
import 'package:flutter_application_login_with_bloc/src/blocs/auth/auth_bloc.dart';
import 'package:flutter_application_login_with_bloc/src/blocs/home/home_bloc.dart';
import 'package:flutter_application_login_with_bloc/src/view/pages/home/home_page.dart';
import 'package:flutter_application_login_with_bloc/src/view/pages/login/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  final AuthBloc _authBloc = AuthBloc();
  final HomeBloc _homeBloc = HomeBloc();

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AuthBloc>.value(
            value: _authBloc,
            child: const LoginPage(title: "Login page with overlay"),
          ),
        );

      case '/home':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider<HomeBloc>.value(
              value: _homeBloc,
              child: HomePage(title: "Home", username: args),
            ),
          );
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR IN NAVIGATION'),
        ),
      );
    });
  }
}