import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';
import 'login_state.dart';




class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final _auth = FirebaseAuth.instance ;


Future<void> logInUser ({required email , required password}) async{

  emit(LoginLoading());

  try {

    final logInuser =   await _auth.signInWithEmailAndPassword(email: email, password: password) ;
    emit(LoginSuccess());
  }
  catch(error)
  {
    emit(LoginFailure( errorMsg: error.toString() ));
  }

}


}
