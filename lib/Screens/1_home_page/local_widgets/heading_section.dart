import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studymanagement/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymanagement/provider.dart';

class HeadingSection extends StatefulWidget {
  @override
  _HeadingSectionState createState() => _HeadingSectionState();
}

class _HeadingSectionState extends State<HeadingSection> {
  final _firestore = FirebaseFirestore.instance;
  //  final theUserValue =_firestore.collection('userDetails').snapshots();
  // void messageStream() async {
  //   //here we are fetching the data from the firebase console from the collection called, "messagaes" using snapshots methods.
  //   await for (var snapshot in _firestore.collection('userDetails').snapshots()) {
  //   }
  // }

  String userName;
  String theUserName() {
    _firestore.collection("userDetails").snapshots().listen((result) {
      result.docs.forEach((result) {
        userName = result.data()['name'];
      });
    });
    return userName;
  }

  var theDataProvider;
  @override
  Widget build(BuildContext context) {
    theDataProvider = Provider.of<TheData>(context, listen: false);

    return Consumer<TheData>(
      builder: (context, value, child) => Container(
        child: Padding(
          padding: kHomePageMainPadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('userDetails').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        final theUserValue = snapshot.data
                            .docs; //here we get all the documents from the snapshot.
                        String theName;
                        for (var i in theUserValue) {
                          theName = i.data()['name'];
                        }
                        return Text(
                          "Hello " + theName,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                  Text(
                    "You've got",
                    style: kHeadingTitleStyle,
                  ),
                  Text(
                    theDataProvider.todaysTaskNumber.length.toString() +
                        " tasks today",
                    style: TextStyle(
                        fontSize: 28,
                        color: Color(0xFF49B583),
                        fontWeight: FontWeight.w900),
                  )
                ],
              ),
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    // color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Image(
                    fit: BoxFit.cover,
                    frameBuilder: (context, child, frame,
                            wasSynchronouslyLoaded) =>
                        DecoratedBox(
                            position: DecorationPosition.background,
                            child: Image(
                                image: AssetImage(
                                    "assets/images/identityimage.jpg")),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                    image: AssetImage("assets/images/identityimage.jpg")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
