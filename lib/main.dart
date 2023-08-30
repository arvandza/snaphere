import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:snaphere/firebase_options.dart';
import 'package:snaphere/pages/homepage.dart';
import 'package:snaphere/pages/onboarding.dart';
import 'package:snaphere/services/image_api_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light
  ));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  ).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> user;

  @override
  void initState(){
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if(user == null){
        print('User is currently signed out!');
      }else{
        print('User is signed in!');
      }
    });
  }

  @override
  void dispose(){
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider(create: (_) => ImageApiServices()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SnapHere',
        theme: ThemeData(
          canvasColor: Colors.transparent,
          primaryColor: Colors.black,
          fontFamily: 'Poppins',
          textTheme: const TextTheme(
            headline1: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700, height: 1),
            headline2: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
            bodyText1: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            bodyText2: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            headline3: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
            headline4: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),
            headline5: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          brightness: Brightness.dark,
        ),
        home: FirebaseAuth.instance.currentUser == null ? const Onboarding() : const Homepage(),
      ),
    );
  }
}