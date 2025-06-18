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
    on<RefreshNews>(_onFetchNews);
  }

  Future<void> _onFetchNews(NewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());

    const String url =
        'https://newsdata.io/api/1/news?apikey=pub_4818665f982b850e8d1400c885f40571f1048&q=maharashtra&language=en'; // Example format

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List articles = data['results'] ?? data['articles'] ?? [];

        final List<NewsModel> newsList =
            articles.map((e) => NewsModel.fromJson(e)).toList();

        emit(NewsLoaded(newsList));
      } else {
        emit(NewsError("Failed to load news: ${response.reasonPhrase}"));
      }
    } catch (e) {
      emit(NewsError("Something went wrong: ${e.toString()}"));
    }
  }
}
