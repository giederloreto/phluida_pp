import 'package:dio/dio.dart';
import 'package:phluid_app/models/image_model.dart';

class ImageNetwork {
  final dio = Dio();

  Future<List<ImageModel>> getImages() async {
    var response =
        await dio.get('https://picsum.photos/v2/list?page=1&limit=100');
    var jsonList = response.data as List<dynamic>;
    var imageList = jsonList.map((json) => ImageModel.fromJson(json)).toList();
    return imageList;
  }
}
