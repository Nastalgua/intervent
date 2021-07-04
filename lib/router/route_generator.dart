import 'package:flutter/material.dart';
import 'package:intervent/router/route_constants.dart';
import 'package:intervent/ui/home.dart';
import 'package:intervent/ui/messages.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case HomeViewRoute:
        return MaterialPageRoute(builder: (_) => Home());
      case MessagesViewRoute:
        return MaterialPageRoute(
          builder: (_) => Messages(id: (args as String))
        );
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
