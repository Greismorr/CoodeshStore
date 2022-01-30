import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coodesh_store/constants/app_theme.dart';
import 'package:coodesh_store/models/product.dart';
import 'package:coodesh_store/widgets/image_pick_bottom_modal.dart';

class PictureEditWidget extends StatefulWidget {
  final Product product;
  final Function pictureHasChangedCallback;

  const PictureEditWidget({
    required this.product,
    required this.pictureHasChangedCallback,
  });

  @override
  _PictureEditWidgetState createState() => _PictureEditWidgetState();
}

class _PictureEditWidgetState extends State<PictureEditWidget> {
  bool _verifyLink(String? url) {
    return url!.substring(0, 4) == "http" ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await buildBottomSheetSelectImage(
          context,
          (value) {
            setState(
              () {
                widget.product.picture = value;
                widget.pictureHasChangedCallback();
              },
            );
          },
        );
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 154,
          minHeight: 154,
          maxWidth: 154,
          maxHeight: 154,
        ),
        child: widget.product.picture == null
            ? CachedNetworkImage(
                imageUrl: PLACEHOLDER_IMAGE,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(
                  value: downloadProgress.progress,
                  strokeWidth: 1.0,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              )
            : _verifyLink(widget.product.picture)
                ? CachedNetworkImage(
                    imageUrl: widget.product.picture ?? PLACEHOLDER_IMAGE,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                      value: downloadProgress.progress,
                      strokeWidth: 1.0,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  )
                : Image(
                    image: FileImage(
                      File(widget.product.picture as String),
                    ),
                    fit: BoxFit.cover,
                  ),
      ),
    );
  }
}
