import 'package:flutter/material.dart';
import 'package:intervent/router/route_constants.dart';
import 'package:intervent/ui/home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case HomeViewRoute:
        return MaterialPageRoute(builder: (_) => Home());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('error'),
          ),
          body: Center(
            child: Text('error'),
          ),
        );
      }
    );
  }
}
