import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final _auth = FirebaseAuth.instance ;

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async{
      if (event is LoginEvent)
          {
          emit(LoginLoading());

          try {
            final logInuser =   await _auth.signInWithEmailAndPassword(email: event.email, password: event.password) ;
            emit(LoginSuccess());
          }
          catch(error)
          {
            emit(LoginFailure( errorMsg: error.toString() ));
          }
        }
    });
  }
}
