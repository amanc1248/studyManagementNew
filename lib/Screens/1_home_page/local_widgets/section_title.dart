import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String mainHeading;
  final String subHeading;

  SectionTitle({this.mainHeading, this.subHeading});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mainHeading,
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
          ),
          Text(
            subHeading,
            style: TextStyle(
                fontSize: 17, color: Colors.grey, fontWeight: FontWeight.w400),
          )
        ],
      )),
    );
  }
}
