import 'package:flutter/material.dart';
import 'package:midterm_activity/src/controllers/auth_controller.dart';
import 'package:midterm_activity/src/routing/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthController.initialize();
  await AuthController.I.loadSession();
  GlobalRouter.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: GlobalRouter.I.router,
      title: 'Stateful Changes Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
