import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zg_beauty_and_hair/state/state_management.dart';
import 'package:zg_beauty_and_hair/utils/utils.dart';

import 'colors/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Z&G Beauty and Hair',

      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: ScaffoldColor,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),//at top left
              bottomRight: Radius.circular(10.0), // at top right
            ),
            gapPadding: 0,
          ),

        ),

      ),
      home: SplashScreen(),);
  }
}

class SplashScreen extends ConsumerWidget {
  GlobalKey<ScaffoldState> scaffoldState = new GlobalKey();

  @override
  Widget build(BuildContext context, watch) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldState,
       // backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/zg_splash_screen.png'),
                fit: BoxFit.cover,
            ),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                  future: checkLoginState(context),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator(),);
                    else {
                      var userState = snapshot.data as LOGIN_STATE;
                      if(userState == LOGIN_STATE.LOGGED)
                      {
                        return Container();
                      }
                      else { //If user not login before then return button
                        return ElevatedButton.icon(
                          onPressed: ()=> (context),
                          icon: Icon(Icons.phone, color: Colors.white),
                          label: Text('כניסה', style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
                        );
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<LOGIN_STATE> checkLoginState(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3)).then((value) =>
    {
      FirebaseAuth.instance.currentUser!
          .getIdToken()
          .then((token) {
        print('$token');
        context
            .read(userToken)
            .state = token;
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      })
    });
    return FirebaseAuth.instance.currentUser != null
        ? LOGIN_STATE.LOGGED
        : LOGIN_STATE.NOT_LOGIN;
  }
}

