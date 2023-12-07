import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_flutter/Authentication/signup.dart';
import 'package:fitness_app_flutter/bottom_nav.dart';
import 'package:fitness_app_flutter/Authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: 'AIzaSyDgdK8lVFMboYEL9YeTXJdUgFDpBdePqI4', appId: '1:369255134244:android:5f70a1ef56a6009d4254b1', 
    messagingSenderId: '', projectId: 'fitness-app-c3664')
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: LoginPage(),
      theme: ThemeData(primaryColor: Color.fromARGB(255, 130, 147, 239)),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (snapshot.hasData && snapshot.data != null) {
              return Bottom_nav();
            } else {
              return LoginPage();
            }
          }
        },
      ),
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => Bottom_nav(),
      },
    );
  }
}


































 
    