import 'package:flash_chat/Blocks/auth_bloc.dart';

import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utilities/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login_screen';

late String email ;
late String password ;
bool showSpinner = false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess)
            {
              Navigator.pushNamed(context, ChatScreen.id);
              showSpinner =  false ;
            }
          else if (state is LoginFailure)
            {
              // Show SnackBar
              showSpinner = false ;
              showMySnackBar(context , state.errorMsg);
            }
          else if (state is LoginLoading)
            {
              showSpinner = true ;
            }

        },
        builder: (BuildContext context, state) {
          return ModalProgressHUD(
            inAsyncCall: showSpinner ,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  // logo
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),


                  const SizedBox(
                    height: 48.0,
                  ),


                  // enter email field
                  TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value ;
                    },
                    decoration: KTextFieldInputDecoration.copyWith(hintText: 'Enter your E-mail') ,
                  ),




                  const SizedBox(
                    height: 20.0,
                  ),



                  // enter password  field
                  TextField(
                    keyboardType: TextInputType.visiblePassword,
                    textAlign: TextAlign.center,
                    obscureText: true,
                    onChanged: (value) {
                      password =value ;
                    },
                    decoration: KTextFieldInputDecoration.copyWith(hintText: 'Enter your Password') ,
                  ),



                  const SizedBox(
                    height: 24.0,
                  ),


                  //log in button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      elevation: 5.0,
                      color: Colors.lightBlueAccent ,
                      borderRadius: BorderRadius.circular(10.0),
                      child: MaterialButton(


                        minWidth: 200.0,
                        height: 42.0,
                        onPressed: () {

                          BlocProvider.of<AuthBloc>(context).add(LoginEvent(email: email, password: password))  ;
                        },
                        child: const Text(
                          'Log In' ,
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
        },

      ),
    );
  }
}


