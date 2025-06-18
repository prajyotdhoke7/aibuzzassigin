import 'package:aibuzzassgin/presentation/bookmark/view/bookmark_page.dart';
import 'package:aibuzzassgin/presentation/news/view/news_page.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const NewsFeedPage()),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const BookmarksPage()),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined), label: 'News'),
        BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border), label: 'Bookmarks'),
      ],
    );
  }
}
