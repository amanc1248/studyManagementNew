import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studymanagement/Screens/3_chat_screen/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:studymanagement/Widgets/theMainEntryFIle.dart';
import 'package:studymanagement/provider.dart';

import 'Screens/0_welcome-login-register/login.dart';
import 'Screens/0_welcome-login-register/register.dart';
import 'Screens/0_welcome-login-register/welcomscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TheData>(create: (context) => TheData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          ChatScreen.id: (context) => ChatScreen(),
          MainEntryFile.id: (context) => MainEntryFile(),
        },
      ),
    );
  }
}
