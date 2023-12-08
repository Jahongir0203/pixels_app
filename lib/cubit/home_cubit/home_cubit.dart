import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pixels_app/model/photo_model.dart';
import 'package:pixels_app/service/network_service.dart';

part 'home_state.dart';

enum Status {
  loading,
  loaded,
  error,
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.networkService) : super(HomeState());
  final NetworkService networkService;

  getPhotos() async {
    emit(state.copyWith(status: Status.loading));
    PhotoModel? photoModel = await networkService.getPhotos();

    if (photoModel != null) {
      emit(state.copyWith(photoModel: photoModel, status: Status.loaded));
    } else {
      emit(state.copyWith(status: Status.error));
    }
  }

  searchPhotos(String query) async {
    emit(state.copyWith(status: Status.loading));
    PhotoModel? photoModel = await networkService.searchPhotosModel(query);
    if (photoModel != null) {
      emit(
        state.copyWith(searchPhotoModel: photoModel, status: Status.loaded),
      );
    } else {
      emit(state.copyWith(status: Status.error));
    }
  }

  downloadPhotos(String src)async{
    networkService.download(src);
  }
}
