import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'items.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  late final _pageController;

  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 999);
  }

  @override
  void dispose() {
    _pageController.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 235,
      child: PageView.builder(
        onPageChanged: (value) {
          setState(() {
            _pageIndex = value % newsrItems.length;
          });
        },
        controller: _pageController,
        itemBuilder: (context, index) {
          final i = index % newsrItems.length;
          return HomeSliderItem(
            isActive: _pageIndex == i,
            imageAssetPath: newsrItems[i]['imageAssetPath']!,
            category: newsrItems[i]['category']!,
            title: newsrItems[i]['title']!,
            author: newsrItems[i]['author']!,
            date: DateTime.parse(newsrItems[i]['date']!),
          );
        },
      ),
    );
  }
}

class HomeSliderItem extends StatelessWidget {
  final bool isActive;
  final String imageAssetPath;
  final String category;
  final String title;
  final String author;
  final DateTime date;
  const HomeSliderItem(
      {super.key,
      required this.isActive,
      required this.imageAssetPath,
      required this.category,
      required this.title,
      required this.author,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.08,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 400),
        scale: isActive ? 1 : 0.8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image.asset(
                imageAssetPath,
                fit: BoxFit.cover,
                width: double.maxFinite,
                height: double.maxFinite,
              ),
              Positioned(
                top: 15,
                left: 18,
                child: Chip(
                  label: Text(
                    category,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.black,
                    Colors.transparent,
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$author · ${AppDateFormatters.mdY(date)}',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(title,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppDateFormatters {
  static String mdY(DateTime dt) => DateFormat('MMM d,yyyy').format(dt);
}
