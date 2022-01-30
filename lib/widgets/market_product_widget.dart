import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:coodesh_store/constants/app_theme.dart';
import 'package:coodesh_store/models/product.dart';
import "package:coodesh_store/extensions/string_extension.dart";
import 'package:coodesh_store/widgets/circular_progress_widget.dart';
import 'package:coodesh_store/widgets/product_bottom_modal.dart';
import 'package:coodesh_store/widgets/rating_widget.dart';

class MarketProductWidget extends StatefulWidget {
  final Product product;

  MarketProductWidget({required this.product});

  @override
  _MarketProductWidgetState createState() => _MarketProductWidgetState();
}

class _MarketProductWidgetState extends State<MarketProductWidget> {
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Container(
        width: width * 0.95,
        decoration: BoxDecoration(
            border: Border.all(color: BORDER_COLOR), color: Colors.white),
        child: Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            isThreeLine: true,
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 84,
                minHeight: 56,
                maxWidth: 84,
                maxHeight: 56,
              ),
              child: CachedNetworkImage(
                imageUrl: widget.product.picture ?? PLACEHOLDER_IMAGE,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressWidget(
                  progress: downloadProgress.progress,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            title: Align(
              alignment: Alignment.topLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.title,
                        style: TextStyle(
                          color: PRIMARY_COLOR,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.product.getTimeDate(widget.product.createdAt),
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: SECONDARY_COLOR,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 5,
                    ),
                    child: Text(
                      widget.product.type.capitalize(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                widget.product.description.isNotEmpty
                    ? SizedBox(
                        height: isCollapsed ? null : 50,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: Row(
                            children: [
                              isCollapsed
                                  ? Expanded(
                                      child: Text(
                                        widget.product.description,
                                        style: TextStyle(
                                          color: PRIMARY_COLOR,
                                          fontSize: 16,
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: Text(
                                        widget.product.description,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: PRIMARY_COLOR,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: SizedBox(),
                      ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingWidget(
                      rating: widget.product.rating,
                      size: 18,
                    ),
                    Spacer(),
                    Text(
                      "\$ ${widget.product.price.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: PRIMARY_COLOR,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.more_horiz),
              color: PRIMARY_COLOR,
              onPressed: () async {
                await buildBottomSheetDeleteOrEdit(context, widget.product);
              },
            ),
          ),
        ),
      ),
      onTap: () {
        setState(
          () {
            isCollapsed = !isCollapsed;
          },
        );
      },
    );
  }
}
