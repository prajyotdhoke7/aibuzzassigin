import 'package:aibuzzassgin/presentation/news/model/news_model.dart';



abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsModel> articles;

  NewsLoaded(this.articles);
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);
}
