import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../routing/router.dart';
import 'auth/login.screen.dart';

class IndexScreen extends StatelessWidget {
  static const String route = '/';
  static const String name = 'Profile Screen';

  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -75,
            child: Image.asset(
              'assets/images/profile_bg.png',
              fit: BoxFit.cover,
              width: size.width,
              height: size.height * .5,
            ),
          ),
          Positioned(
            top: 100,
            left: (size.width / 2) - 75,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/user.png',
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('John Doe',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
                const SizedBox(
                  height: 200,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF242F9B),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(150, 48),
                  ),
                  onPressed: () {
                    AuthController.I.logout();
                    GlobalRouter.I.router.go(LoginScreen.route);
                  },
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('logout'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
