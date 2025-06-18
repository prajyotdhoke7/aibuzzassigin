import 'package:aibuzzassgin/presentation/news/view/news_page.dart';
import 'package:aibuzzassgin/widget/navigation_bar.dart';
import 'package:aibuzzassgin/widget/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/bookmark_bloc.dart';
import '../bloc/bookmark_event.dart';
import '../bloc/bookmark_state.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      appBar: AppBar(title: const Text('Bookmarked Articles')),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) {
                return NewsFeedPage();
              },
            ),
            (route) => false,
          );
        },
        child: BlocBuilder<BookmarkBloc, BookmarkState>(
          builder: (context, state) {
            if (state is BookmarkLoaded && state.bookmarks.isNotEmpty) {
              return ListView.builder(
                itemCount: state.bookmarks.length,
                itemBuilder: (context, index) {
                  final article = state.bookmarks[index];
                  return ListTile(
                    leading: Image.network(
                      article.imageUrl,
                      width: 80,
                      errorBuilder: (_, __, ___) => const Icon(Icons.image),
                    ),
                    title: Text(article.title),
                    subtitle: Text(
                      "${article.source} • ${DateFormat('d MMMM, y').format(article.publishedAt)}",
                    ),
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WebViewWidget1(url: article.url),
                          ),
                        ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<BookmarkBloc>().add(
                          RemoveBookmark(article),
                        );
                      },
                    ),
                  );
                },
              );
            } else if (state is BookmarkLoaded && state.bookmarks.isEmpty) {
              return const Center(child: Text("No bookmarks yet."));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
