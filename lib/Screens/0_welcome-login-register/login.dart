import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studymanagement/Screens/2_tasks_page/local_widgets/dropdownclasses.dart';
import 'package:studymanagement/Widgets/theMainEntryFIle.dart';
import 'package:studymanagement/provider.dart';
import '../../constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'components/RoundButton.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String email;
  String password;
  RegisterType registerType;
  List<RegisterType> registrationList = <RegisterType>[
    RegisterType(type: "Student"),
    RegisterType(type: "Teacher"),
  ];

  final firestoreInstance = FirebaseFirestore.instance;

  // Future authenticatingStudentOrTeacher() async {
  //   print("Hello man first in");
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: firestoreInstance.collection("Student").snapshots(),
  //     builder: (context, snapshot) {
  //       print("you are definitely in");
  //       print(password);
  //       if (!snapshot.hasData) {
  //         return Center(
  //           child: CircularProgressIndicator(
  //             backgroundColor: Colors.lightBlueAccent,
  //           ),
  //         );
  //       }
  //       final allDocuments = snapshot.data.docs;
  //       for (var i in allDocuments) {
  //         if ((email == i.data()['email']) &&
  //             (password == i.data()['password'])) {
  //           print("email and password verified");
  //           Navigator.pushNamed(context, MainEntryFile.id);
  //           break;
  //         } else {
  //           continue;
  //         }
  //       }
  //       return SizedBox();
  //     },
  //   );
  // }

  var theData;
  @override
  Widget build(BuildContext context) {
    theData = Provider.of<TheData>(context, listen: false);

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
                height: 24,
              ),
              RoundedButton(
                title: 'Log In',
                colour: Colors.lightBlueAccent,
                onPressed: () {
                  setState(() {
                    showSpinner = true;
                  });
                  firestoreInstance
                      .collection(registerType.type)
                      .get()
                      .then((querySnapshot) {
                    querySnapshot.docs.forEach(
                      (i) {
                        if ((email == i.data()['email']) &&
                            (password == i.data()['password'])) {
                          print("email and password verified");
                          theData.userEmail = email;
                          theData.userPassword = password;
                          theData.type = registerType.type;
                          Navigator.pushNamed(context, MainEntryFile.id);
                        } else {}
                      },
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
