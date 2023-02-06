import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/ReusablePadding.dart';


class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 1,
      ),
      upperBound: 1.0,
    );

    animation =
        ColorTween(begin: Colors.red, end: Colors.blue).animate(controller);

    // animation=CurvedAnimation(parent: controller, curve:Curves.easeIn);
      controller.forward();
    // animation.addStatusListener((status) {
    //   print(status);
    //   if(status==AnimationStatus.completed){
    //     controller.reverse(from: 1.0);
    //   }else if(status==AnimationStatus.dismissed){
    //     controller.forward();
    //   }
    // });


    controller.addListener(() {
      setState(() {print(animation.value);
      }
      );
    }
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height:60.0,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                  'Flash Chat',
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                    )],

                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            ReusablePadding(colour:Colors.lightBlueAccent ,onTap:(){Navigator.pushNamed(context, LoginScreen.id);} ,text:'Log in' ,),
            ReusablePadding(colour:Colors.blueAccent , onTap: (){Navigator.pushNamed(context, RegistrationScreen.id);}, text:'Register'),

          ],
        ),
      ),
    );
  }
}
