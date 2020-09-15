import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studymanagement/Screens/1_home_page/local_widgets/heading_section.dart';
import 'package:studymanagement/Screens/1_home_page/local_widgets/running_subject.dart';
import 'package:studymanagement/Screens/1_home_page/local_widgets/section_title.dart';
import 'package:studymanagement/Widgets/widgets.dart';
import 'package:studymanagement/constants.dart';
import 'package:intl/intl.dart';

import '../../provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firestoreInstance = FirebaseFirestore.instance;
  upcomingScheduleFunction() {
    List<Widget> upcomingScheduleList = [];

    return StreamBuilder<QuerySnapshot>(
      stream: firestoreInstance.collection('eventDetails').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        String theDatabaseDate;
        final allDocuments = snapshot.data.docs;
        //here we get all the documents from the snapshot.
        theDataProvider.todaysTaskNumber = [];
        for (var i in allDocuments) {
          theDatabaseDate = i.data()['dateTime'];
          if (theDatabaseDate != DateFormat('y-MM-dd').format(DateTime.now())) {
            upcomingScheduleList.add(Widgets(
              i: i,
              upperPadding: const EdgeInsets.only(right: 10),
              containerWidth: 370,
              containerHeight: 250,
              thePaddingValue: kHomePageMainPadding,
              iconSize: 120,
              chapterName: i.data()['chapterName'],
              chapterNumber: i.data()['chapterNumber'],
              meetType: i.data()['meetType'],
              meetIcon: Icons.video_call,
              subject: i.data()['subject'],
              lectureTime: "09:30",
              teacherImage: AssetImage("assets/images/IMG-20200817-WA0000.jpg"),
              teacherName: "Alex Jesus",
            ));
          } else {
            theDataProvider.todaysTaskNumber.add(i.data()['subject']);
          }
        }
        return Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: upcomingScheduleList,
          ),
        );
      },
    );
  }

  var theDataProvider;
  @override
  Widget build(BuildContext context) {
    theDataProvider = Provider.of<TheData>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadingSection(),
            SectionTitle(
              mainHeading: 'Courses',
              subHeading: "Your running subjects",
            ),
            RunningSubjectBuilding(),
            SectionTitle(
              mainHeading: "Your Schedule",
              subHeading: "Upcoming classes and tasks",
            ),
            upcomingScheduleFunction()
          ],
        ),
      ),
    );
  }
}
