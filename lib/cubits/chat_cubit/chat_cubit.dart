import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../utilities/widgets.dart';
import 'chat_state.dart';


class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());


  final firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance ;
  var loggedinuser ;
  List<MessageBubble> messagebubbles =[];




  void sendMessage ( String email ,  String messageText) async{
    
    try{
      await firestore.collection('messages').add({
        'sender':email ,
        'text': messageText ,
        'time':DateTime.now(),
      });
    }
    catch (error)
    {
      emit(ChatFailure(errorMsg: 'Proplem with Sending message '));
    }
   
  }

  void getMessages (){

    firestore.collection('messages').orderBy('time').snapshots().listen((event) {

      for (var oneMessage in event.docs)
      {

        final messagetext = oneMessage['text'];
        final messagesender = oneMessage['sender'];

        int time = DateTime.now().millisecond;

        messagebubbles.add(MessageBubble(
          messagetext: messagetext,
          messagesender: messagesender,
          IsCurrentUser: (messagesender == _auth.currentUser?.email),
          time: DateTime.now().timeZoneOffset,));
      }
      emit (ChatSuccess());
      messagebubbles.clear();
    });
  }


}
