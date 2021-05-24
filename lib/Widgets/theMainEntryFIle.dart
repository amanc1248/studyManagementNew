import 'package:flutter/material.dart';

import 'package:studymanagement/Screens/3_chat_screen/chat_screen.dart';

class MainEntryFile extends StatefulWidget {
  static const String id = 'entryPoint';

  @override
  _MainEntryFile createState() => _MainEntryFile();
}

class _MainEntryFile extends State<MainEntryFile> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    ChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: _children.elementAt(_selectedIndex)),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
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
    );
  }
}
