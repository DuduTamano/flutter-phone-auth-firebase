import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zg_beauty_and_hair/colors/constants.dart';
import 'package:zg_beauty_and_hair/screens/phone_auth.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin{

  late final AnimationController _controler = AnimationController(vsync: this,
      duration: const Duration(seconds: 2))..repeat(reverse: true);

  late final Animation<double> _animation =
  CurvedAnimation(parent: _controler, curve: Curves.elasticOut);

  double element = 10;
  double spacingstart = 1;
  double spacingend = 1;

  bool isPressed = false;

  @override
  void dispose() {
    _controler.dispose();
    super.dispose();
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(left: 0.0, top: 150.0, right: 0.0, bottom: 0.0)),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Z',
                  style: TextStyle(
                      fontSize: 60.0,
                      fontFamily: 'elephant',
                      letterSpacing: 2.0,
                      color: Colors.black,
                      shadows: [
                        BoxShadow(
                            color: kTextColorDark,
                            blurRadius: 5
                        ),
                      ]
                  ),
                ),
                RotationTransition(turns: _animation,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 0.0, top: 15.0, right: 0.0, bottom: 0.0),
                    child: Text(
                      '&',
                      style: TextStyle(
                          fontSize: 35.0,
                          fontFamily: 'elephant',
                          letterSpacing: 2.0,
                          color: Colors.black,
                          shadows: [
                            BoxShadow(
                                color: kTextColorDark,
                                blurRadius: 2
                            ),
                          ]
                      ),
                    ),
                  ),
                ),
                const Text(
                  'G',
                  style: TextStyle(
                      fontSize: 60.0,
                      fontFamily: 'elephant',
                      letterSpacing: 2.0,
                      color: Colors.black,
                      shadows: [
                        BoxShadow(
                            color: kTextColorDark,
                            blurRadius: 5
                        ),
                      ]
                  ),
                ),
              ],
            ),
            const Padding(
                padding: EdgeInsets.all(0.0)
            ),
            const Text(
              'Beauty and Hair',
              style: TextStyle(
                  fontSize: 17.0,
                  fontFamily: 'elephant',
                  color: Colors.black,
                  shadows: [
                    BoxShadow(
                        color: kTextColorDark,
                        blurRadius: 1
                    ),
                  ]
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 0.0, top: 230.0, right: 0.0, bottom: 0.0),
                ),
              ],
            ),
            Center(
              child: GestureDetector(
                onTapDown: (d) {
                  setState(() {
                    element = 0;
                    spacingstart = 1;
                    spacingend = 20;

                    isPressed = true;
                  });
                },
                onTapUp: (d) {
                  setState(() {
                    element = 0;
                    spacingstart = 20;
                    spacingend = 1;

                    isPressed = false;
                  });
                },
                child: AnimatedContainer(
                  height: 50,
                  width: 150,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: isPressed ? Colors.grey.shade200 : Colors.black,
                    boxShadow: [
                      BoxShadow(
                        color: isPressed ? Colors.grey : Colors.black45,
                        offset: const Offset(1, 10),
                        blurRadius: 25,
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.phone, color: Colors.white,),
                    label: Text(
                      "לכניסה",
                      style: TextStyle(
                        color: isPressed ? Colors.black : Colors.white,
                        fontSize: 15,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w500,
                      ),
                    ), onPressed: () {
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => PhoneAuth(),),);
                  },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black)
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
