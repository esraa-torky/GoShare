import 'package:flutter/material.dart';
import 'package:go_share/Screens/Welcome/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_share/core/util/init/helper/size_config.dart';
import 'package:go_share/providers/home/home_provider.dart';
import 'package:go_share/providers/product/product_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    LayoutBuilder(
      builder: (context, constraints) => OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => HomeProvider()),
              ChangeNotifierProvider(create: (_) => ProductProvider()),
            ],
            child: const MyApp(),
          );
        },
      ),
    ),
  );
}

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);
  static const String _title = 'GoShare';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: WelcomeScreen(),
    );
  }
}
