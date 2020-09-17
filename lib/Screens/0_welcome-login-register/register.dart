import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:studymanagement/Screens/0_welcome-login-register/login.dart';
import 'package:studymanagement/Screens/2_tasks_page/local_widgets/dropdownclasses.dart';

import '../../constants.dart';
import 'components/RoundButton.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

final firestoreInstance = FirebaseFirestore.instance;

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  String email;
  String password;
  void initState() {
    super.initState();
  }

  Subject selectedSubject;
  List<Subject> subjects = <Subject>[
    Subject('Mathematics'),
    Subject('Science'),
    Subject("Health"),
    Subject("Programming"),
    Subject("Thermodynamics")
  ];

  RegisterType registerType;
  List<RegisterType> registrationList = <RegisterType>[
    RegisterType(type: "Student"),
    RegisterType(type: "Teacher"),
  ];

  bool subjectsOptionShow = false;
  //function for changing the subjectsOptionShow
  changingTheSubjectOptions() {
    if (registerType == null) {
      subjectsOptionShow = false;
    } else {
      if (registerType.type == "Teacher") {
        subjectsOptionShow = true;
      } else {
        subjectsOptionShow = false;
      }
    }
    return subjectsOptionShow;
  }

  Future addingValuesToStudentDatabase() async {
    return firestoreInstance.collection("Student").add({
      "email": email,
      "password": password,
      "type": registerType.type,
    });
  }

  Future addingValuesToTeacherDatabase() async {
    return firestoreInstance.collection("Teacher").add({
      "email": email,
      "password": password,
      "type": registerType.type,
      "subjects": selectedSubject.subject,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 8.0,
              ),

              //1) for subject
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: Colors.lightBlueAccent)),
                child: Center(
                  child: DropdownButton<RegisterType>(
                    value: registerType,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    hint: Container(
                      // width: 200,
                      child: Text("You are ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 15)),
                    ),
                    underline: Container(
                      color: Colors.white,
                    ),
                    style: TextStyle(color: Colors.black),
                    onChanged: (RegisterType newValue) {
                      setState(() {
                        registerType = newValue;
                      });
                    },
                    items: registrationList.map<DropdownMenuItem<RegisterType>>(
                        (RegisterType value) {
                      return DropdownMenuItem<RegisterType>(
                        value: value,
                        child: Text(value.type),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Visibility(
                visible: changingTheSubjectOptions(),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.lightBlueAccent)),
                  child: Center(
                    child: DropdownButton<Subject>(
                      value: selectedSubject,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      hint: Container(
                        // width: 200,
                        child: Text("Choose the subject ",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: 15)),
                      ),
                      underline: Container(
                        color: Colors.white,
                      ),
                      style: TextStyle(color: Colors.black),
                      onChanged: (Subject newValue) {
                        setState(() {
                          selectedSubject = newValue;
                        });
                      },
                      items: subjects
                          .map<DropdownMenuItem<Subject>>((Subject value) {
                        return DropdownMenuItem<Subject>(
                          value: value,
                          child: Text(value.subject),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              RoundedButton(
                title: 'Register',
                colour: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  if (registerType.type == "Student") {
                    await addingValuesToStudentDatabase();
                  } else {
                    await addingValuesToTeacherDatabase();
                  }
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
