import 'dart:typed_data';

import 'package:flutter_application_1/view/Serach_image/state.dart';

import 'image_provider.dart';
// import '../models/state.dart';

class Repository {
  static final Repository _repository = Repository._private();
  Repository._private();
  factory Repository() => _repository;

  ImageProvider _imageProvider = ImageProvider();

  Future imageData(query) => _imageProvider.getImagesByName(query);

  Future<Uint8List> getImageToShare(String url) {
    return _imageProvider.getImageFromUrl(url);
  }
}
