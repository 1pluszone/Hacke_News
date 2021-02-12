import 'package:flutter/material.dart';

class LoadingListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: greyBox(),
          subtitle: greyBox(),
        ),
      ],
    );
  }

  Container greyBox() {
    return Container(
      height: 24.0,
      width: double.infinity,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      color: Colors.grey[300],
    );
  }
}
