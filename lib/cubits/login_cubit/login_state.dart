
import 'package:flutter/cupertino.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginLoading extends LoginState {}
class LoginFailure extends LoginState {

  late final String errorMsg ;

  LoginFailure ({required this.errorMsg});

  }
