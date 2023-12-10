import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pixels_app/model/photo_model.dart';
import 'package:pixels_app/service/network_service.dart';

part 'main_event.dart';

t 'main_state.dart
'
;

enum Status {
  loading,
  loaded,
  loadingMore,
  error,
}

class MainBloc extends Bloc<MainEvent, MainState> {
  final NetworkService networkService;

  MainBloc(this.networkService) : super(MainState()) {
    on<MainGetPhotos>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      PhotoModel? photoModel = await networkService.getPhotos();
      if (photoModel != null) {
        emit(state.copyWith(status: Status.loaded, photoModel: photoModel));
      } else if (photoModel == null) {
        emit(state.copyWith(status: Status.error));
      }
    });

    on<MainSearchPhotos>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      PhotoModel? searchPhotoModel =
      await networkService.searchPhotosModel(event.url);
      if (searchPhotoModel != null) {
        emit(state.copyWith(
            status: Status.loaded, searchPhotoModel: searchPhotoModel));
      } else if (searchPhotoModel == null) {
        emit(state.copyWith(status: Status.error));
      }
    });

    on<MainDownloadPhotos>((event, emit) async {
      await networkService.download(event.Url);
    });
  }
}
