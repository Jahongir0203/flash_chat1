import 'package:flutter/material.dart';

class ReusablePadding extends StatelessWidget {

  ReusablePadding({@required this.colour,@required this.onTap,@required this.text});

  final Color colour;
  final Function onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color:colour ,//
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed:
          onTap
          //Navigator.pushNamed(context, LoginScreen.id)
          ,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text  ,
            style: TextStyle(color: Colors.white),//'Log In'
          ),
        ),
      ),
    );
  }
}
