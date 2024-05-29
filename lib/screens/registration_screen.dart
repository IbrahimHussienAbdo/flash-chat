import 'package:flash_chat/cubits/registration_cubit/registration_cubit.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/utilities/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../utilities/constants.dart';

class RegistrationScreen extends StatelessWidget {

  static const String id = 'registration_screen';

  RegistrationScreen({super.key});

  late String email ;
  late String password;
  bool showSpinner = false ;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationCubit,RegistrationState>(
      listener: (context , state) {
        if (state is RegistrationSuccess)
          {
            Navigator.pushNamed(context, ChatScreen.id);
            showSpinner = false ;
          }
        else if (state is RegistrationLoading)
          {
            showSpinner = true ;
          }
        else if (state is RegistrationFailure){
          showSpinner = false ;
          showMySnackBar(context, state.errorMsg);
        }
      },
      builder: ( context, state) { return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
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
                  height: 8.0,
                ),

                // enter password
                TextField(

                  keyboardType: TextInputType.visiblePassword,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    password = value ;
                  },
                  decoration: KTextFieldInputDecoration.copyWith(hintText: 'Enter your Password'),
                ),


                const SizedBox(
                  height: 24.0,
                ),


                // signup button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    elevation: 5.0,
                    color:  Colors.blueAccent ,
                    borderRadius: BorderRadius.circular(10.0),
                    child: MaterialButton(


                      minWidth: 200.0,
                      height: 42.0,
                      onPressed: () {

                        BlocProvider.of<RegistrationCubit>(context).signUp(email, password)  ;
                      },
                      child: const Text(
                        'Register' ,
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
        ),
      ) ;  },

    );
  }
}
