import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../controllers/auth_controller.dart';
import '../routing/router.dart';
import 'auth/login.screen.dart';
import '../routing/router.dart';

class IndexScreen extends StatelessWidget {
  static const String route = '/';
  static const String name = 'Index Screen';

  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(IndexScreen.name),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250,
                ),
                Center(
                    child: Text(
                  'You are inside Index',
                )),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF242F9B),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    AuthController.I.logout();
                    GlobalRouter.I.router.go(LoginScreen.route);
                  },
                  icon: Icon(Icons.logout_rounded),
                  label: Text('logout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
