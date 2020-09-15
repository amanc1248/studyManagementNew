import 'package:flutter/material.dart';
import 'package:studymanagement/Screens/2_tasks_page/local_widgets/dropdownclasses.dart';
import 'package:studymanagement/provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final firestoreInstance = FirebaseFirestore.instance;
  Subject selectedSubject;
  List<Subject> subjects = <Subject>[
    Subject('Mathematics'),
    Subject('Science'),
    Subject("Health"),
    Subject("Programming"),
    Subject("Thermodynamics")
  ];

  MeetType selectedMeetType;
  List<MeetType> meetTypes = <MeetType>[
    MeetType(meetType: "Google meet", meetTypeIcon: Icons.video_call),
    MeetType(meetType: "Zoom", meetTypeIcon: Icons.zoom_in),
  ];

  var _chapterNameController = TextEditingController();
  var _chapterNumberController = TextEditingController();

  void dispose() {
    _chapterNameController.dispose();
    _chapterNumberController.dispose();
    super.dispose();
  }

  TheData theData;
  var theDataProvider;

  Future addingValuesToDatabase() async {
    return firestoreInstance.collection("eventDetails").add({
      "subject": selectedSubject.subject,
      "chapterName": _chapterNameController.text,
      "chapterNumber": _chapterNumberController.text,
      "meetType": selectedMeetType.meetType,
      "dateTime": theDataProvider.databaseSelectedDate
    });
  }

  Future afterAddingValues() async {
    theDataProvider.addEventSwitch();

    selectedSubject = null;
    _chapterNameController = null;
    _chapterNumberController = null;
    selectedMeetType = null;
    theDataProvider.databaseSelectedDate = null;
    return "successful";
  }

  @override
  Widget build(BuildContext context) {
    theDataProvider = Provider.of<TheData>(context, listen: false);
    return Consumer<TheData>(
      builder: (context, value, child) => Container(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: EdgeInsets.all(25),
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 4)),
                ],
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //1) for subject
                DropdownButton<Subject>(
                  value: selectedSubject,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  hint: Container(
                    width: 200,
                    child: Text("Choose your subject",
                        style: TextStyle(color: Colors.grey)),
                  ),
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (Subject newValue) {
                    setState(() {
                      selectedSubject = newValue;
                    });
                  },
                  items:
                      subjects.map<DropdownMenuItem<Subject>>((Subject value) {
                    return DropdownMenuItem<Subject>(
                      value: value,
                      child: Text(value.subject),
                    );
                  }).toList(),
                ),
                //3)for chapterName
                Padding(
                  padding: const EdgeInsets.only(left: 51, right: 51),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      width: 2,
                      color: Colors.deepPurpleAccent,
                      style: BorderStyle.solid,
                    ))),
                    child: TextField(
                      style: TextStyle(color: Colors.deepPurpleAccent),
                      controller: _chapterNameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Chapter Name",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
                //4)for chapterNumber
                Padding(
                  padding: const EdgeInsets.only(left: 51, right: 51),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      width: 2,
                      color: Colors.deepPurpleAccent,
                      style: BorderStyle.solid,
                    ))),
                    child: TextField(
                      style: TextStyle(color: Colors.deepPurpleAccent),
                      controller: _chapterNumberController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Chapter Number",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
                //4) for meetTypes
                DropdownButton<MeetType>(
                  value: selectedMeetType,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  hint: Container(
                    width: 200,
                    child: Text("Choose your meeting app",
                        style: TextStyle(color: Colors.grey)),
                  ),
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (MeetType newValue) {
                    setState(() {
                      selectedMeetType = newValue;
                    });
                  },
                  items: meetTypes
                      .map<DropdownMenuItem<MeetType>>((MeetType value) {
                    return DropdownMenuItem<MeetType>(
                      value: value,
                      child: Text(value.meetType),
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(
                        child: Text("Save"),
                        onPressed: () async {
                          //this creates the collection called "eventDetails" if it does not exist yet.
                          //And if it exits, it add the document to into the specified collection
                          await addingValuesToDatabase();
                          afterAddingValues().then((value) => print(value));
                          // showingTheSelectedDateEvents();
                        }),
                    FlatButton(
                        onPressed: () {
                          afterAddingValues();
                        },
                        child: Text("Cancel"))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
