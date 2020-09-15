import 'package:flutter/material.dart';
import 'package:studymanagement/Screens/1_home_page/home_page.dart';
import 'package:studymanagement/Screens/2_tasks_page/tasks_page.dart';
import 'package:studymanagement/Screens/3_chat_screen/chat_screen.dart';
import 'package:provider/provider.dart';
import 'package:studymanagement/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    HomePage(),
    TasksPage(),
    ChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TheData>(create: (context) => TheData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(child: _children.elementAt(_selectedIndex)),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: BottomNavigationBar(
                backgroundColor: Colors.black,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), title: Text("Home")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.event), title: Text("Tasks")),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.chat,
                      ),
                      title: Text("Chat")),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.greenAccent,
                unselectedItemColor: Colors.grey,
                onTap: _onItemTapped,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
