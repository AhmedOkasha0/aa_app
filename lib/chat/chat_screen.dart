import 'package:chat_app/chat/chat_screen_navigator.dart';
import 'package:chat_app/chat/chat_screen_view_model.dart';
import 'package:chat_app/chat/message_widget.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/utils.dart' as Utils;

class ChatScreen extends StatefulWidget {
  static const String routName = 'chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    implements ChatScreenNavigator {
  String messageContent = '';
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  ChatScreenViewModel viewModel = ChatScreenViewModel();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var args = ModalRoute.of(context)?.settings.arguments as Room;
    var provider = Provider.of<UserProvider>(context);
    viewModel.room = args;
    viewModel.currentUser = provider.user!;
    viewModel.listenForUpdateMessage();

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(children: [
        Container(
          color: Colors.white,
        ),
        Image.asset(
          'assets/images/main_background.png',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              args.roomTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(20),
                height: size.height / 1.3,
                width: size.width / 1.1,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Expanded(
                        child: StreamBuilder<QuerySnapshot<Message>>(
                      stream: viewModel.streamMessage,
                      builder: (context, asyncSnapShot) {
                        if (asyncSnapShot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (asyncSnapShot.hasError) {
                          return Text(asyncSnapShot.error.toString());
                        } else {
                          var messageList = asyncSnapShot.data?.docs
                                  .map((doc) => doc.data())
                                  .toList() ??
                              [];
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              return MessageWidget(message: messageList[index]);
                            },
                            itemCount: messageList.length,
                          );
                        }
                      },
                    )),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12)),
                              ),
                              hintText: 'type message',
                            ),
                            controller: controller,
                            onChanged: (text) {
                              messageContent = text;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              viewModel.sendMessage(messageContent);
                            },
                            child: Row(
                              children: [
                                Text('Send'),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.send_outlined),
                              ],
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(context, message, 'ok', (context) {
      Navigator.pop(context);
    });
  }
  //show message

  @override
  void clearMessage() {
    controller.clear();
  }
}
