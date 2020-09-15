import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studymanagement/Screens/2_tasks_page/local_widgets/addEvent.dart';
import 'package:studymanagement/Screens/2_tasks_page/local_widgets/heading.dart';
import 'package:provider/provider.dart';
import 'package:studymanagement/Widgets/widgets.dart';
import 'package:studymanagement/provider.dart';

final firestoreInstance = FirebaseFirestore.instance;

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

var theDataProvider;

class _TasksPageState extends State<TasksPage> {
  showingTheSelectedDateEvents() {
    List<Widget> listViewContainer = [];

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
        for (var i in allDocuments) {
          // if(i.data()["subject"] == "Mathemtics")

          theDatabaseDate = i.data()['dateTime'];
          if (theDatabaseDate == theDataProvider.databaseSelectedDate) {
            print(theDatabaseDate +
                " is same as " +
                theDataProvider.databaseSelectedDate);
            listViewContainer.add(Dismissible(
                key: ObjectKey(snapshot.data.docs.elementAt(0)),
                onDismissed: (direction) async {
                  firestoreInstance
                      .collection("eventDetails")
                      .doc(i.id)
                      .delete();

                  // allDocuments.removeAt(0);
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Text(
                      "Slide To Remove",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Poppins",
                          color: Colors.black),
                    ),
                  ),
                  decoration: BoxDecoration(color: Color(0xFFF4F5F6)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "09:30",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          Text(
                            "10:20",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                border: Border.all(
                                    color: Colors.blueAccent, width: 2)),
                            child: Container(
                              height: 7,
                              width: 7,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.lightBlueAccent),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 150,
                            width: 2,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.lightBlueAccent)),
                          )
                        ],
                      ),
                    ),
                    Widgets(
                      upperPadding: const EdgeInsets.only(
                          right: 0, top: 0, bottom: 20, left: 10),
                      containerHeight: 180,
                      containerWidth: 270,
                      thePaddingValue: EdgeInsets.only(
                          left: 8, right: 20, top: 0, bottom: 20),
                      iconSize: 60,
                      chapterName: i.data()['chapterName'],
                      chapterNumber: i.data()['chapterNumber'],
                      meetType: i.data()['meetType'],
                      meetIcon: Icons.video_call,
                      subject: i.data()['subject'],
                      lectureTime: "09:30",
                      teacherImage:
                          AssetImage("assets/images/IMG-20200817-WA0000.jpg"),
                      teacherName: "Alex Jesus",
                    ),
                  ],
                )));
            print(listViewContainer.length);
          } else {
            print("no any events for today");
          }
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: listViewContainer,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    theDataProvider = Provider.of<TheData>(context, listen: false);

    return Consumer<TheData>(
      builder: (context, value, child) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Column(
              children: [
                //1) Heading
                Heading(),
                Visibility(
                  visible: theDataProvider.addEvent,
                  child: AddEvent(),
                ),
                showingTheSelectedDateEvents()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
