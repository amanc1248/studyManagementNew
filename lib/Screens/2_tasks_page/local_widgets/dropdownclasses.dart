import 'package:flutter/cupertino.dart';

class Subject {
  String subject;
  Subject(this.subject);
}

class Chapter {
  String chapter;
  Chapter(this.chapter);
}

class ChapterName {
  String chapterName;
  ChapterName(this.chapterName);
}

class MeetType {
  String meetType;
  IconData meetTypeIcon;
  MeetType({this.meetType, this.meetTypeIcon});
}

//for registering as a student or teacher
class RegisterType {
  String type;
  RegisterType({this.type});
}
