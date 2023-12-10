part of 'main_bloc.dart';

@immutable
class MainState {
  final Status? status;
  final PhotoModel? photoModel;
  final PhotoModel? searchPhotoModel;

  MainState({this.status, this.photoModel, this.searchPhotoModel});

  MainState copyWith({
    Status? status,
    PhotoModel? photoModel,
    PhotoModel? searchPhotoModel,
  }) {
    return MainState(
      status: status ?? this.status,
      photoModel: photoModel ?? this.photoModel,
      searchPhotoModel: searchPhotoModel ?? this.searchPhotoModel,
    );
  }
}
