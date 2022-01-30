import 'package:flutter/material.dart';
import 'package:coodesh_store/ui/screens/loading/category_loading_widget.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int nItems = (MediaQuery.of(context).size.height / 120).round();

    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!,
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Container(
          height: 30,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: nItems,
            itemBuilder: (context, index) {
              return CategoryLoadingWidget();
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 5,
              );
            },
          ),
        ),
      ),
    );
  }
}
