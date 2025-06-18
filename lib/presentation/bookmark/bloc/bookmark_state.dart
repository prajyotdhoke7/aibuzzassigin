

abstract class BookmarkState {}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoaded extends BookmarkState {
  final List<dynamic> bookmarks;
  BookmarkLoaded(this.bookmarks);
}
