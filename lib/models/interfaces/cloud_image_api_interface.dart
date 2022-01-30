abstract class ICloudImageApi {
  Future<String?> saveOnCloud(String imageUrl, {String? fileName});

  Future<bool> deleteOfCloud(String imageUrl);
}
