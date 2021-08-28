import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zg_beauty_and_hair/colors/constants.dart';
import 'package:zg_beauty_and_hair/navigation_screen/drawer_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

  }

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Center(
            child: IconButton(
              icon: const Icon(Icons.drag_indicator_outlined, size: 33.0, color: Colors.black,),
              onPressed: () {
              },
            ),
          ),
          title: const Center(
            child: Image(
              height: 80,
              width: 80,
              image: AssetImage('assets/images/zglogo.png'),
            ),
          ),
          actions: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: IconButton(onPressed: (){},
                    iconSize: 30.0,
                    padding: const EdgeInsets.only(
                      right: 20,
                    ),
                    icon: SvgPicture.asset('assets/icons/shopping-cart.svg'),),
                ),
                Positioned(
                  left: -8,
                  top: 20,
                  child: Container(
                    width: 25.0,
                    height: 25.0,
                    decoration: BoxDecoration(
                      color: kOutlineInputColor,
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: const Center(
                      child: Text(
                        '0',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        drawer: const DrawerScreen(),
        body: SafeArea(
          child: Text(
            'User: ${FirebaseAuth.instance.currentUser!.phoneNumber}'
          ),
        ),
    );
  }
}
