import 'package:coodesh_store/constants/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:coodesh_store/constants/app_theme.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String title = "Coodesh Store";
  final bool hasPreviousScreen;

  AppBarWidget({required this.hasPreviousScreen});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0.0,
      title: Row(
        mainAxisAlignment: hasPreviousScreen
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.local_grocery_store_rounded,
              size: 22,
              color: SECONDARY_COLOR,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 22.0,
              color: SECONDARY_COLOR,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      leading: hasPreviousScreen
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: SECONDARY_COLOR),
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, HOME_PAGE, (route) => false),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
