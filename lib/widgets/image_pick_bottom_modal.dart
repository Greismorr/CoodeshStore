import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

Future<dynamic> buildBottomSheetSelectImage(
    BuildContext myContext, Function setStateFunction) {
  ImagePicker picker = ImagePicker();
  XFile? pickedFile;
  File? croppedImage;

  //Permite ao usuário recortar a imagem antes de salvá-la
  _cropImage() async {
    croppedImage = await ImageCropper.cropImage(
      sourcePath: pickedFile!.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    );
  }

  return showModalBottomSheet(
    context: myContext,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.collections_outlined),
            title: Text('Gallery'),
            onTap: () async {
              pickedFile = (await picker.pickImage(
                  source: ImageSource.gallery, imageQuality: 85));

              await _cropImage();

              setStateFunction(croppedImage!.path);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_camera_outlined),
            title: Text('Camera'),
            onTap: () async {
              pickedFile = (await picker.pickImage(
                  source: ImageSource.camera, imageQuality: 85));

              await _cropImage();

              setStateFunction(croppedImage!.path);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.delete_outlined),
            title: Text('Remove image'),
            onTap: () async {
              setStateFunction(null);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
