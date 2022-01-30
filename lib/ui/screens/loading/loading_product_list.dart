import 'package:flutter/material.dart';
import 'package:coodesh_store/ui/screens/loading/market_product_loading_widget.dart';

class LoadingProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int nItems = (MediaQuery.of(context).size.height / 150).round();

    return ListView.builder(
      itemCount: nItems,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: MarketProductLoadingWidget(),
          ),
        );
      },
    );
  }
}
