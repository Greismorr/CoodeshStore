import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:coodesh_store/constants/env_constants.dart';
import 'package:coodesh_store/models/interfaces/cloud_image_api_interface.dart';

class CloudinaryApi implements ICloudImageApi {
  final cloudinary =
      Cloudinary(CLOUD_IMAGE_API_KEY, CLOUD_IMAGE_API_SECRET, CLOUD_NAME);

  @override
  Future<String?> saveOnCloud(String imageUrl, {String? fileName}) async {
    final response = await cloudinary.uploadResource(
      CloudinaryUploadResource(
        filePath: imageUrl,
        resourceType: CloudinaryResourceType.image,
        fileName: fileName,
        optParams: {
          "public_id": fileName,
        },
      ),
    );

    return response.url;
  }

  @override
  Future<bool> deleteOfCloud(String imageUrl) async {
    //Comentado para evitar ter que reupar imagens sempre que um delete fosse feito.
    /*     
      final response = await cloudinary.deleteFile(
        url: imageUrl,
        resourceType: CloudinaryResourceType.image,
        invalidate: true,
      );

      return response.isSuccessful;
    */

    return true;
  }
}
