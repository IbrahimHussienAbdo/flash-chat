import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/chat_screen.dart';

class Button extends StatelessWidget {
  final Color color ;
  final String buttontext ;
  final Function onPressed ;

  const Button({super.key, required this.color, required this.buttontext, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color ,
        borderRadius: BorderRadius.circular(10.0),
        child: MaterialButton(

          // Navigator.pushNamed(context, LoginScreen.id); ,
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {  },
          child: Text(
            buttontext ,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),

        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({super.key, required this.messagetext, required this.messagesender, required this.IsCurrentUser, required this.time});

  final String messagetext;
  final String messagesender;
  final bool IsCurrentUser ;
  final Duration time ;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: IsCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          messagesender,
          style: const TextStyle(
            color: Colors.black45,
            fontSize: 12.0,
          ),
        ),
        Padding(
          padding:  const EdgeInsets.all(8.0),
          child: Material(
            borderRadius:  BorderRadius.only(
              topRight: IsCurrentUser ? const Radius.circular(0) : const Radius.circular(22) ,
              topLeft:  IsCurrentUser ? const Radius.circular(22) : const Radius.circular(0),
              bottomLeft: const Radius.circular(22),
              bottomRight: const Radius.circular(22),
            ),
            elevation: 5,
            color: IsCurrentUser? Colors.blueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20 ,horizontal: 10),
              child: Text(
                messagetext,
                style: TextStyle(
                  color: IsCurrentUser ? Colors.white : Colors.black,

                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
