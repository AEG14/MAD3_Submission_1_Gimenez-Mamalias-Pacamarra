import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'items.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 220,
      child: ListView.builder(
        itemCount: newsrItems.length,
        itemBuilder: (context, index) {
          final i = index % newsrItems.length;
          return HomeCardItem(
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

class HomeCardItem extends StatelessWidget {
  final String imageAssetPath;
  final String category;
  final String title;
  final String author;
  final DateTime date;
  const HomeCardItem(
      {super.key,
      required this.imageAssetPath,
      required this.category,
      required this.title,
      required this.author,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.amber,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imageAssetPath,
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '$author · ${AppDateFormatters.mdY(date)}',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppDateFormatters {
  static String mdY(DateTime dt) => DateFormat('MMM d,yyyy').format(dt);
}
