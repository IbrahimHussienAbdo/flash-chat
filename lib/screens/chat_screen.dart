import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/cubits/chat_cubit/chat_cubit.dart';
import 'package:flash_chat/cubits/chat_cubit/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/utilities/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';





class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String messageText;
  final _auth = FirebaseAuth.instance;
  final Messagecontroller = TextEditingController();
  late String loggedinuserEmail ;

  Future getCurrentUser() async {
    try {
      loggedinuserEmail = (_auth.currentUser?.email)!;

    } catch (e) {
      print('problem  with get current user');
    }
  }
  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context).getMessages();
   getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();

                Navigator.pop(context);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: BlocConsumer<ChatCubit ,ChatState>(
              listener: (BuildContext context, Object? state) {
                if (state is ChatFailure)
                  {
                    showMySnackBar (context , state.errorMsg);
                  }
              },
              builder: (BuildContext context, state) {


                return  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[

                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListView(
                            reverse: false,
                            children: BlocProvider.of<ChatCubit>(context).messagebubbles,
                          ),
                        ),
                      ) ,
                      Container(
                        decoration: kMessageContainerDecoration,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: Messagecontroller,
                                onChanged: (value) {
                                  //Do something with the user input. messages
                                  messageText = value;
                                },
                                decoration: kMessageTextFieldDecoration,
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                //Implement send functionality.
                                Messagecontroller.clear();
                                BlocProvider.of<ChatCubit>(context).sendMessage(loggedinuserEmail, messageText);
                              },
                              child: const Text(
                                'Send',
                                style: kSendButtonTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ]
                ) ;
                },

            ),













      ),
    );
  }
}
