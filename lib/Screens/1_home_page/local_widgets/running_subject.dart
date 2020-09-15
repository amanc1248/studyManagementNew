import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studymanagement/Screens/1_home_page/local_widgets/modalclass.dart';
import 'package:provider/provider.dart';
import '../../../provider.dart';

class RunningSubjectBuilding extends StatefulWidget {
  @override
  _RunningSubjectBuildingState createState() => _RunningSubjectBuildingState();
}

class _RunningSubjectBuildingState extends State<RunningSubjectBuilding> {
  var theDataProvider;
  final firestoreInstance = FirebaseFirestore.instance;
  final List<RunningSubject> runningSubjects = [
    RunningSubject(
        subjectIcon: Icons.format_list_numbered,
        subjectTitle: "Mathematics",
        color: Colors.redAccent),
    RunningSubject(
        subjectIcon: Icons.border_horizontal,
        subjectTitle: "Science",
        color: Color(0xFFFFBD69)),
    RunningSubject(
        subjectIcon: Icons.ac_unit,
        subjectTitle: "Health",
        color: Color(0xFFFF4171)),
    RunningSubject(
        subjectIcon: Icons.computer,
        subjectTitle: "Programming",
        color: Colors.lightBlueAccent),
    RunningSubject(
        subjectIcon: Icons.add_to_home_screen,
        subjectTitle: "Thermodynamics",
        color: Colors.blueGrey)
  ];
  @override
  Widget build(BuildContext context) {
    theDataProvider = Provider.of<TheData>(context, listen: false);

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
        final allDocuments = snapshot.data.docs;
        List<String> theRunningList = [];
        List<Widget> theRunningWidgets = [];
        //here we get all the documents from the snapshot.
        for (var i in allDocuments) {
          theRunningList.add(i.data()['subject']);
        }
        var uniqueValues = new Set.from(theRunningList);
        var theConvertedList = uniqueValues.toList();

        for (int i = 0; i < theConvertedList.length; i++) {
          for (int j = 0; j < runningSubjects.length; j++) {
            if (theConvertedList[i] == runningSubjects[j].subjectTitle) {
              theRunningWidgets.add(
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, right: 12, left: 12),
                  child: Container(
                      height: 120,
                      width: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: runningSubjects[j].color),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            runningSubjects[j].subjectIcon,
                            size: 60,
                            color: Colors.grey[400],
                          ),
                          Text(
                            runningSubjects[j].subjectTitle,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          )
                        ],
                      )),
                ),
              );
            } else {
              print(runningSubjects[j].subjectTitle + " is not running");
            }
          }
        }

        // for()

        return Expanded(
          flex: 1,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: theRunningWidgets,
          ),
        );
      },
    );
  }
}
