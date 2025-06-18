import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/bookmark_model.dart';
import 'bookmark_event.dart';
import 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  static const String _bookmarkKey = 'bookmarked_articles';

  BookmarkBloc() : super(BookmarkInitial()) {
    on<AddBookmark>(_onAdd);
    on<RemoveBookmark>(_onRemove);
    on<LoadBookmarks>(_onLoad);
  }

  Future<void> _onLoad(
      LoadBookmarks event, Emitter<BookmarkState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_bookmarkKey);
    if (data != null) {
      final bookmarks = BookmarkModel.decode(data);
      emit(BookmarkLoaded(bookmarks));
    } else {
      emit(BookmarkLoaded([]));
    }
  }

  Future<void> _onAdd(AddBookmark event, Emitter<BookmarkState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final current = state is BookmarkLoaded
        ? (state as BookmarkLoaded).bookmarks
        : [];
    final updated = List<BookmarkModel>.from(current)..add(event.article);
    await prefs.setString(_bookmarkKey, BookmarkModel.encode(updated));
    emit(BookmarkLoaded(updated));
  }

  Future<void> _onRemove(
      RemoveBookmark event, Emitter<BookmarkState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final current = state is BookmarkLoaded
        ? (state as BookmarkLoaded).bookmarks
        : [];
    final  updated =
        current.where((e) => e.url != event.article.url).toList();
    await prefs.setString(_bookmarkKey, BookmarkModel.encode(updated));
    emit(BookmarkLoaded(updated));
  }
}
