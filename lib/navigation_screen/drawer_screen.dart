import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 40, bottom: 70),
        child: Column(
        children: <Widget>[
          Row(
            children: const <Widget>[
              CircleAvatar(
                backgroundColor: Colors.black,
                child: ClipRect(
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/zglogo.png'),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'dudu tamano',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }
}
