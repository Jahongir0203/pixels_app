import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pixels_app/model/photo_model.dart';
import 'package:pixels_app/model/video_model.dart';
import 'package:pixels_app/service/network_service.dart';
import 'package:video_player/video_player.dart';

part 'main_event.dart';

part 'main_state.dart';

enum Status {
  loading,
  loaded,
  loadingMore,
  error,
}

class MainBloc extends Bloc<MainEvent, MainState> {
  ScrollController scrollController = ScrollController();
  final NetworkService networkService;
  late VideoPlayerController _controller;

  MainBloc(this.networkService) : super(MainState()) {
    scrollController.addListener(() {
      print('Jahongir');
      print(scrollController.position.extentAfter);
      if (scrollController.position.extentAfter <= 200 &&
          state.photoModel?.nextPage != null &&
          state.status != Status.loadingMore) {
        this.add(MainGetMorePhotos());
      }
    });

    on<MainGetPhotos>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      PhotoModel? photoModel = await networkService.getPhotos(page: state.page);
      if (photoModel != null) {
        int page = state.page!;
        print(page);
        print('SDFGHJ');
        emit(
          state.copyWith(
            status: Status.loaded,
            photoModel: photoModel,
            page: photoModel.nextPage != null ? ++page : page,
          ),
        );
        print(page);
        print('SDFGHJ');
      } else {
        emit(state.copyWith(status: Status.error));
      }
    });

    on<MainGetMorePhotos>((event, emit) async {
      print('GetMore');
      emit(state.copyWith(status: Status.loadingMore));
      PhotoModel? photoModel = await networkService.getPhotos(page: state.page);
      if (photoModel != null) {
        int page = state.page!;
        List<Photos> allPhotos = [...state.photoModel?.photos ?? []];
        allPhotos.addAll(photoModel.photos!);
        print(allPhotos.length);
        emit(
          state.copyWith(
            status: Status.loaded,
            photoModel: PhotoModel(
              photos: allPhotos,
              nextPage: photoModel.nextPage,
            ),
            page: photoModel.nextPage != null ? ++page : page,
          ),
        );
      } else {
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

    on<MainGetVideos>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      VideoModel? videoModel = await networkService.getVideos(page: state.page);
      if (videoModel != null) {
        int page = state.page!;
        print(page);
        print('SDFGHJ');
        emit(
          state.copyWith(
            status: Status.loaded,
            videoModel: videoModel,
            page: videoModel.nextPage != null ? ++page : page,
          ),
        );
        print(page);
        print('SDFGHJ');
      } else if (videoModel == null) {
        emit(state.copyWith(status: Status.error));
      }
    });

    on<MainDownloadPhotos>((event, emit) async {
      await networkService.download(event.Url);
    });
  }
}
