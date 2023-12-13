part of 'main_bloc.dart';

@immutable
class MainState {
  final Status? status;
  final PhotoModel? photoModel;
  final PhotoModel? searchPhotoModel;
  final VideoModel? videoModel;
  final int? page;

  MainState({this.status, this.photoModel, this.searchPhotoModel,this.videoModel,this.page=1});

  MainState copyWith({
    Status? status,
    PhotoModel? photoModel,
    PhotoModel? searchPhotoModel,
    VideoModel? videoModel,
    int? page,
  }) {
    return MainState(
      status: status ?? this.status,
      photoModel: photoModel ?? this.photoModel,
      searchPhotoModel: searchPhotoModel ?? this.searchPhotoModel,
      videoModel: videoModel?? this.videoModel,
      page: page?? this.page,
    );
  }
}
