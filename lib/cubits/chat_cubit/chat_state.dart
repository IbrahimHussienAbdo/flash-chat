
import 'package:flutter/cupertino.dart';


abstract class ChatState {}

class ChatInitial extends ChatState {}
class ChatSuccess extends ChatState {}
class ChatFailure extends ChatState {

String errorMsg ;

ChatFailure ({required this.errorMsg});


}
