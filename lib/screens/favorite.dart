import 'package:flutter/material.dart';

class Favorite extends StatelessWidget {
  late String pageTitle;
  Favorite({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10),
            child: Text(
              pageTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
