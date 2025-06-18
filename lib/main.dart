import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/auth/bloc/auth_bloc.dart';
import 'presentation/auth/view/loginpage.dart';
import 'presentation/bookmark/bloc/bookmark_bloc.dart';
import 'presentation/bookmark/bloc/bookmark_event.dart';
import 'presentation/news/bloc/news_bloc.dart';
import 'presentation/news/bloc/news_event.dart';
import 'presentation/news/view/news_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return AppInitializer(isLoggedIn: isLoggedIn);
  }
}

class AppInitializer extends StatelessWidget {
  final bool isLoggedIn;
  const AppInitializer({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => NewsBloc()..add(FetchNews())),
        BlocProvider(create: (_) => BookmarkBloc()..add(LoadBookmarks())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Business News',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        home: isLoggedIn ? const NewsFeedPage() : const LoginPage(),
      ),
    );
  }
}
