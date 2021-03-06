import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

mixin HaveImageOnAssets {
  //Acessa o diretório temporário do app para retornar
  //uma imagem asset como um arquivo.
  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/images/$path');

    final File file = File('${(await getTemporaryDirectory()).path}/$path');

    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
}
