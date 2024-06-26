import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../utilities/widgets.dart';

class WelcomeScreen extends StatefulWidget {
 static const String id = 'welcome_screen';

  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>  with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this ,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();

    controller.addListener(() {
      setState(() {});

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            // logo & name
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: animation.value *100 ,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                 AnimatedTextKit(
                 animatedTexts: [
                   TypewriterAnimatedText(
                             ' Chat',
                           textStyle: const TextStyle(
                           fontSize: 45.0,
                           color: Colors.black54,
                           fontWeight: FontWeight.w900,
                   ),
                   speed: const Duration(milliseconds: 120),)
                 ],
                ),
              ],
            ),

            const SizedBox(
              height: 170.0,
            ),

            // log in button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent ,
                borderRadius: BorderRadius.circular(10.0),
                child: MaterialButton(


                  minWidth: 200.0,
                  height: 42.0,
                  onPressed: () {   Navigator.pushNamed(context, LoginScreen.id) ; },
                  child: const Text(
                    'Log In' ,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),

                ),
              ),
            ),

            // sign up button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.blue ,
                borderRadius: BorderRadius.circular(10.0),
                child: MaterialButton(


                  minWidth: 200.0,
                  height: 42.0,
                  onPressed: () {   Navigator.pushNamed(context, RegistrationScreen.id) ; },
                  child: const Text(
                    'Sign Up' ,
                    style: TextStyle(
                      color: Colors.white,
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



// Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16.0),
//               child: Material(
//                 elevation: 5.0,
//                 color: Colors.blue ,
//                 borderRadius: BorderRadius.circular(10.0),
//                 child: MaterialButton(
//
//
//                   minWidth: 200.0,
//                   height: 42.0,
//                   onPressed: () {   Navigator.pushNamed(context, RegistrationScreen.id) ; },
//                   child: const Text(
//                     'Log In' ,
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//
//                 ),
//               ),
//             ),