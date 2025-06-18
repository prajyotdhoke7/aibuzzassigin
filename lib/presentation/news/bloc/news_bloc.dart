import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../model/news_model.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<FetchNews>(_onFetchNews);
    on<RefreshNews>(_onRefreshNews);
  }

  List<NewsModel> _storedNews = [];

  Future<void> _onFetchNews(NewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());

    const String url =
        'https://newsdata.io/api/1/news?apikey=pub_4818665f982b850e8d1400c885f40571f1048&q=maharashtra&language=en';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List articles = data['results'] ?? [];

        final List<NewsModel> fetchedNews =
            articles.map((e) => NewsModel.fromJson(e)).toList();

        // Store only first 10 items
        _storedNews = fetchedNews.take(10).toList();

        emit(NewsLoaded(_storedNews));
      } else {
        emit(NewsError("Failed to load news: ${response.reasonPhrase}"));
      }
    } catch (e) {
      emit(NewsError("Something went wrong: ${e.toString()}"));
    }
  }

  Future<void> _onRefreshNews(
    RefreshNews event,
    Emitter<NewsState> emit,
  ) async {
    emit(NewsLoading());

    const String url =
        'https://newsdata.io/api/1/news?apikey=pub_4818665f982b850e8d1400c885f40571f1048&q=maharashtra&language=en';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List articles = data['results'] ?? [];

        final List<NewsModel> newFetchedNews =
            articles.map((e) => NewsModel.fromJson(e)).toList();

        // Filter out already stored news by comparing titles or links
        final List<NewsModel> newNews =
            newFetchedNews
                .where(
                  (news) =>
                      !_storedNews.any((stored) => stored.title == news.title),
                )
                .toList();

        // Update local storage with new news (optional: keep only latest 10)
        _storedNews.addAll(newNews);
        _storedNews = _storedNews.take(10).toList();

        emit(NewsLoaded(newNews));
      } else {
        emit(NewsError("Failed to load news: ${response.reasonPhrase}"));
      }
    } catch (e) {
      emit(NewsError("Something went wrong: ${e.toString()}"));
    }
  }
}
