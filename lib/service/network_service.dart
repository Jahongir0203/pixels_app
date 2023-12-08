import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:pixels_app/main.dart';

import '../model/photo_model.dart';

class NetworkService {
  static final NetworkService networkService = NetworkService._internal();

  factory NetworkService() {
    return networkService;
  }

  NetworkService._internal();

  final Dio _dio = Dio()..interceptors.add(alice.getDioInterceptor());
  static const String baseUrl = "https://api.pexels.com";
  static const String topPhotos = '${baseUrl}/v1/curated';
  static const String searchPhotos = '${baseUrl}/v1/search';
  static const String apiKey =
      'NsBU83EB08LGOQOKGUSLSg1NwnOl2BA7ml5tnkYbSy5c2HWtVpltWIcj';

  Future<PhotoModel?> getPhotos() async {
    try {
      var response = await _dio.get(topPhotos,
          queryParameters: {
            'page': 1,
            'per_page': 80,
          },
          options: Options(headers: {
            'Authorization': apiKey,
          }));

      if (response.statusCode == 200) {
        PhotoModel photoModel = PhotoModel.fromJson(response.data);
        return photoModel;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<PhotoModel?> searchPhotosModel(String query) async {
    try {
      var response = await _dio.get(searchPhotos,
          queryParameters: {
            'per_page': 80,
            'query': query,
          },
          options: Options(headers: {
            'Authorization': apiKey,
          }));

      if (response.statusCode == 200) {
        return PhotoModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> download(String src) async {
    try {
      var response = await _dio.get(src,
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "hello");
      print(result);
    } catch (e) {
      print(e);
      return null;
    }
  }

}
