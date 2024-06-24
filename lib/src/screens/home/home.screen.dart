import 'package:flutter/material.dart';
import 'cards.dart';
import 'sliders.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/home';
  static const String path = "/home";
  static const String name = "Home Screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const HomeTopButtons(),
          HomeHeading(
            title: 'Breaking News',
            trailing: TextButton(
              child: const Text('View All'),
              onPressed: () {},
            ),
          ),
          const HomeSlider(),
          HomeHeading(
            title: 'Recommended News',
            trailing: TextButton(
              child: const Text('View All'),
              onPressed: () {},
            ),
          ),
          const HomeCard(),
        ],
      ),
    );
  }
}

class HomeTopButtons extends StatelessWidget {
  const HomeTopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          AppRoundedButtons(
            iconData: Icons.menu,
            onTap: () {},
          ),
          const Spacer(),
          AppRoundedButtons(
            iconData: Icons.search,
            onTap: () {},
          ),
          const SizedBox(
            width: 10,
          ),
          AppRoundedButtons(
            iconData: Icons.notifications_outlined,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class AppRoundedButtons extends StatelessWidget {
  final Function()? onTap;
  final IconData iconData;
  const AppRoundedButtons({super.key, this.onTap, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(255, 227, 227, 227),
      borderRadius: BorderRadius.circular(56),
      child: InkWell(
        borderRadius: BorderRadius.circular(56),
        onTap: onTap,
        child: SizedBox(
          width: 50,
          height: 50,
          child: Icon(size: 25, iconData),
        ),
      ),
    );
  }
}

class HomeHeading extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const HomeHeading({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 8),
      child: Row(
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          const Spacer(),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
