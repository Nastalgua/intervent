import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:intervent/router/route_constants.dart';

import 'package:intervent/router/route_generator.dart';

import 'package:provider/provider.dart';
import 'package:intervent/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider())
      ], 
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: HomeViewRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
  
}
