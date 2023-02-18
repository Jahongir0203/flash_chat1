import 'package:flash_chat/components/ReusablePadding.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class RegistrationScreen extends StatefulWidget {

  static const String id='registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  final _auth=FirebaseAuth.instance;

  String email;
  String password;
  bool showSpinner=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email=value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText:'Enter your email' ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                style: TextStyle(color: Colors.black),
                textAlign:TextAlign.center ,
                onChanged: (value) {
                  password=value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText:'Enter your password' ),
              ),
              SizedBox(
                height: 24.0,
              ),
              ReusablePadding(colour: Colors.blueAccent, onTap:() async{
               setState(() {
                 showSpinner=true;
               });
              try {
                final newUser = await _auth.createUserWithEmailAndPassword(
                    email: email, password: password);
                if(newUser != null){
                  Navigator.pushNamed(context,ChatScreen.id);
                }
                setState(() {
                  showSpinner=false;
                });
              }catch(e){
                print(e);
              }
              }, text:'Registration')
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableTextField extends StatelessWidget {
  ReusableTextField({@required this.onPressed,@required this.title});
  final Function onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        onPressed;
        //Do something with the user input.
      },
      decoration: InputDecoration(
        hintText: title, //'Enter your password'
        contentPadding:
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}
