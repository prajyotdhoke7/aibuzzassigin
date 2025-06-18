import '../model/bookmark_model.dart';

abstract class BookmarkEvent {}

class AddBookmark extends BookmarkEvent {
  final BookmarkModel article;
  AddBookmark(this.article);
}

class RemoveBookmark extends BookmarkEvent {
  final BookmarkModel article;
  RemoveBookmark(this.article);
}

class LoadBookmarks extends BookmarkEvent {}
