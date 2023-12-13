part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class MainGetPhotos extends MainEvent {}

class MainGetMorePhotos extends MainEvent {}

class MainSearchPhotos extends MainEvent {
  final String url;

  MainSearchPhotos(this.url);
}

class MainDownloadPhotos extends MainEvent {
  final String Url;

  MainDownloadPhotos(this.Url);
}

class MainGetVideos extends MainEvent {}
