import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studymanagement/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../provider.dart';

class Widgets extends StatefulWidget {
  final String subject;
  final String chapterNumber;
  final String chapterName;
  final String lectureTime;
  final ImageProvider teacherImage;
  final String teacherName;
  final IconData meetIcon;
  final String meetType;
  final EdgeInsetsGeometry thePaddingValue;
  final int containerHeight;
  final int iconSize;
  final QueryDocumentSnapshot i;
  final int containerWidth;
  final EdgeInsetsGeometry upperPadding;
  Widgets(
      {this.chapterName,
      this.upperPadding,
      this.chapterNumber,
      this.lectureTime,
      this.subject,
      this.meetIcon,
      this.meetType,
      this.teacherImage,
      this.teacherName,
      this.thePaddingValue,
      this.iconSize,
      this.containerHeight,
      this.i,
      this.containerWidth});
  @override
  _WidgetsState createState() => _WidgetsState();
}

class _WidgetsState extends State<Widgets> {
  final firestoreInstance = FirebaseFirestore.instance;
  var theDataProvider;
  @override
  Widget build(BuildContext context) {
    theDataProvider = Provider.of<TheData>(context, listen: false);

    return Padding(
      padding: widget.upperPadding,
      child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          height: widget.containerHeight.toDouble(),
          width: widget.containerWidth.toDouble(),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color(0xFF7F86FF)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.subject,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800)),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Chapter " +
                                  widget.chapterNumber +
                                  ": " +
                                  widget.chapterName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.5
                                  // font
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 25,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.alarm,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: kWidgetColumnPadding,
                                  child: Text(widget.lectureTime,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                    radius: 10,
                                    backgroundImage: widget.teacherImage),
                                Padding(
                                  padding: kWidgetColumnPadding,
                                  child: Text(
                                    widget.teacherName,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                  child: Icon(
                                    widget.meetIcon,
                                    size: 15,
                                  ),
                                ),
                                Padding(
                                  padding: kWidgetColumnPadding,
                                  child: Text(
                                    widget.meetType,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  child: Icon(
                Icons.ac_unit,
                size: widget.iconSize.toDouble(),
                color: Colors.lightBlueAccent,
              )),
              Container(
                  child: Icon(FontAwesomeIcons.diceTwo,
                      size: 10, color: Colors.white))
            ],
          )),
    );
  }
}
