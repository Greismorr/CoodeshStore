import 'package:coodesh_store/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:coodesh_store/widgets/rating_widget.dart';
import 'package:shimmer/shimmer.dart';

class MarketProductLoadingWidget extends StatelessWidget {
  MarketProductLoadingWidget();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.95,
      decoration: BoxDecoration(
          border: Border.all(color: BORDER_COLOR), color: Colors.white),
      child: Card(
        margin: EdgeInsets.zero,
        child: ListTile(
          leading: Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              width: 94,
              height: 94,
              decoration: boxDecoration,
            ),
          ),
          title: Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[300]!,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    width: 80,
                    height: 20,
                    decoration: boxDecoration,
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[300]!,
                child: Container(
                  width: 80,
                  height: 20,
                  decoration: boxDecoration,
                ),
              ),
            ],
          ),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[300]!,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    decoration: boxDecoration,
                    child: Container(
                      width: 80,
                      height: 20,
                      decoration: boxDecoration,
                    ),
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[300]!,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(height: 40, decoration: boxDecoration),
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[300]!,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingWidget(
                        rating: 0,
                        size: 18,
                      ),
                      Spacer(),
                      Container(
                        width: 40,
                        height: 20,
                        decoration: boxDecoration,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          trailing: Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Icon(
              Icons.more_horiz,
              color: PRIMARY_COLOR,
            ),
          ),
        ),
      ),
    );
  }
}
