import 'package:coodesh_store/models/interfaces/cloud_image_api_interface.dart';
import 'package:http/http.dart' show Client;

class CloudImageApiProvider implements ICloudImageApi {
  final Client client;

  CloudImageApiProvider(this.client);

  @override
  Future<bool> deleteOfCloud(String imageUrl) async {
    try {
      final response = await client.delete(
        Uri.parse(
            'https://jsonplaceholder.typicode.com/products/images/$imageUrl'),
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e);
    }

    return false;
  }

  @override
  Future<String?> saveOnCloud(String imageUrl, {String? fileName}) {
    throw UnimplementedError();
  }
}
