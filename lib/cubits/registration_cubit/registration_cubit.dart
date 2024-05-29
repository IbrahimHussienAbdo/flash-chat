import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());
  final _auth = FirebaseAuth.instance ;

  Future<void> signUp (String email , String password) async{

    emit(RegistrationLoading());
    try {
      final newuser =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
        emit(RegistrationSuccess());
    }
    catch (error)
    {

     emit(RegistrationFailure(errorMsg: error.toString()));

    }
  }
}
