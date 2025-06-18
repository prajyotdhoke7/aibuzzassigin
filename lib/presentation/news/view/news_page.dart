import 'package:aibuzzassgin/presentation/auth/bloc/auth_bloc.dart';
import 'package:aibuzzassgin/presentation/auth/bloc/auth_event.dart';
import 'package:aibuzzassgin/presentation/auth/bloc/auth_state.dart';
import 'package:aibuzzassgin/presentation/auth/view/loginpage.dart';
import 'package:aibuzzassgin/widget/navigation_bar.dart';
import 'package:aibuzzassgin/widget/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bookmark/bloc/bookmark_bloc.dart';
import '../../bookmark/bloc/bookmark_event.dart';
import '../../bookmark/model/bookmark_model.dart';
import '../bloc/news_bloc.dart';
import '../bloc/news_event.dart';
import '../bloc/news_state.dart';

class NewsFeedPage extends StatelessWidget {
  const NewsFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        bottomNavigationBar: const BottomNavBar(currentIndex: 0),
        appBar: AppBar(
          title: const Text("NewZy"),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (ctx) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              context.read<AuthBloc>().add(LogoutRequested());
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                );
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: PopScope(
          canPop: false,
          onPopInvoked: (didpop) {
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text('Exit App'),
                    content: const Text('Are you sure you want to Exit?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
            );
          },
          child: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is NewsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is NewsLoaded) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<NewsBloc>().add(RefreshNews());
                  },
                  child: ListView.builder(
                    itemCount: state.articles.length,
                    itemBuilder: (context, index) {
                      final article = state.articles[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => WebViewWidget1(url: article.url),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(12),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                                child: Image.network(
                                  article.imageUrl,
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (_, __, ___) => Container(
                                        height: 200,
                                        color: Colors.grey,
                                        child: const Center(
                                          child: Icon(
                                            Icons.broken_image,
                                            size: 50,
                                          ),
                                        ),
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  article.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
                                child: Text(
                                  article.description,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      "${article.source} • ${DateFormat('d MMM, y').format(article.publishedAt)}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.bookmark_add_outlined,
                                    ),
                                    onPressed: () {
                                      final bookmark = BookmarkModel(
                                        title: article.title,
                                        description: article.description,
                                        imageUrl: article.imageUrl,
                                        url: article.url,
                                        source: article.source,
                                        publishedAt: article.publishedAt,
                                      );
                                      context.read<BookmarkBloc>().add(
                                        AddBookmark(bookmark),
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text("Bookmarked"),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is NewsError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
