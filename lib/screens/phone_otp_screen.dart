import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:zg_beauty_and_hair/colors/constants.dart';
import 'package:zg_beauty_and_hair/colors/custom_buttons.dart';
import 'package:zg_beauty_and_hair/screens/home_screen.dart';
import 'package:zg_beauty_and_hair/screens/phone_auth.dart';

class OPTScreen extends StatefulWidget {
  OPTScreen({Key? key, required this.phoneNumber}) : super(key: key);

  final String phoneNumber;

  @override
  _OPTScreenState createState() => _OPTScreenState();

}

class _OPTScreenState extends State<OPTScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Colors.black45,
    ),
  );

  bool isLoggedIn = false;
  bool otpSent = false;
  late String uid;
  late String _verificationCode;

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }

  void next({String? value, FocusNode? focusNode}){
    if(value!.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneAuth()));
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.black,),
        ),
      ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 20.0 / 3,
              top: 20.0 / 3,
              left: 20.0 / 3,
              right: 20.0 / 3,
            ),
            child: Column(
              children: [
                const SizedBox(height: 130.0,
                ),
                RichText(
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                    text: 'אנא הקשי הזיני את הקוד \n שנשלח אליך לנייד  ',
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Colors.black26,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  wordSpacing: 1.0,
                    ),
                    children: [
                      TextSpan(
                        text: widget.phoneNumber,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0,),
                Form(
                  key: _formKey,
                  child: PinPut(
                      fieldsCount: 6,
                      textStyle: const TextStyle(fontSize: 23.0, color: Colors.black),
                      eachFieldWidth: 45.0,
                      eachFieldHeight: 50.0,
                      focusNode: _pinPutFocusNode,
                      controller: _pinPutController,
                      submittedFieldDecoration: pinPutDecoration,
                      selectedFieldDecoration: pinPutDecoration,
                      followingFieldDecoration: pinPutDecoration,
                      pinAnimationType: PinAnimationType.fade,
                      onSubmit: (pin) async {
                        try {
                          await FirebaseAuth.instance
                              .signInWithCredential(PhoneAuthProvider.credential(
                              verificationId: _verificationCode, smsCode: pin))
                              .then((value) async {
                            if (value.user != null) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomePage()),
                                      (route) => false);
                            }
                          });
                        } catch (e) {
                          FocusScope.of(context).unfocus();
                          _formKey.currentState;
                            SnackBar(content: Text('invalid OTP')
                          );
                        }
                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Code expires in:  ',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontWeight: FontWeight.normal,
                          color: kTextColorLight,
                        ),
                      ),
                      TweenAnimationBuilder(
                          tween: IntTween(
                              begin: 60, end: 0),
                          duration: const Duration(seconds: 60),
                          builder: (context, int value, child) =>
                              Text('${value.toInt()}',
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontWeight: FontWeight.normal,
                            color: Colors.black
                          ),)),
                    ],
                  ),
                ),
                TextButton(onPressed: () {}, child:
                Text(
                  'שלח שוב',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ),
                const Spacer(),
                CustomButton(title: 'Verify Me', onTap: (){
                  if(_formKey.currentState!.validate()){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
    );
  }
  
  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+972${widget.phoneNumber}',
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    await FirebaseAuth.instance.signInWithCredential(credential);
    if(FirebaseAuth.instance.currentUser != null) {
      setState(() {
        isLoggedIn = true;
        uid = FirebaseAuth.instance.currentUser!.uid;
      });
    } else {
      print("Filed to sign in");
    }
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    setState(() {
      _verificationCode = verificationId;
      otpSent = true;
    });
  }

  void codeSent(String verificationId, [int? a]) {
    setState(() {
      _verificationCode = verificationId;
      otpSent = true;
    });
  }

  void verificationFailed(FirebaseAuthException exception) {
    print(exception.message);
    setState(() {
      isLoggedIn = false;
      otpSent = false;
    });
  }
}
