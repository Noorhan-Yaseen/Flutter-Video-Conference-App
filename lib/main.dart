import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/resources/auth_methods.dart';
import 'package:flutter_project/screens/history_meeting_screen.dart';
import 'package:flutter_project/screens/home_screen.dart';
import 'package:flutter_project/screens/MainScreen.dart';
import 'package:flutter_project/screens/meeting_screen.dart';
import 'package:flutter_project/screens/video_call_screen.dart';
import 'package:flutter_project/utils/colors.dart';
import 'package:flutter_project/screens/signin.dart';
import 'package:flutter_project/screens/splash_screen.dart';
import 'package:flutter_project/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Conferencce App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      routes: {
        '/splash-screen': (context) => ZoomSplashScreen(),
        '/login': (context) => Loginscreen(),
        '/signIn': (context) => SignInScreen(),
        '/home': (context) => HomeScreen(),
        '/main': (context) => MainScreen(),
        '/video-call': (context) => VideoCallScreen(),
        '/history-meeting-screen': (context) => HistoryMeetingScreen(),
        '/meeting-screen': (context) =>MeetingScreen(),
      },
      initialRoute: '/splash-screen',
      home: StreamBuilder(
          stream: AuthMethods().authChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return const HomeScreen();
            }
            return const MainScreen();
          }),
    );
  }
}
