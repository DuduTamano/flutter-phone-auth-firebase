import 'package:flutter/material.dart';
import 'package:zg_beauty_and_hair/screens/phone_auth.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  double element = 10;
  double spacingstart = 1;
  double spacingend = 1;

  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
