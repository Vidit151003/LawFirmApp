import 'package:app1/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserId;
  final String senderUserId;

  const ChatPage(
      {super.key, required this.receiverUserId, required this.senderUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messagecontroller = new TextEditingController();
  final ChatService _chatService = ChatService();

  void sendMessage() async {
    if (_messagecontroller.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.senderUserId, widget.receiverUserId, _messagecontroller.text);
      _messagecontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Messages"),
        ),
        body: Column(
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            _buildMessageInput(),
          ],
        ));
  }

  //build message list
  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _chatService.getMessage(widget.receiverUserId, widget.senderUserId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error" + snapshot.error.toString()),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

// alignement message
    var alignment = (data['senderId'] == widget.senderUserId)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    var color = (data['senderId'] == widget.senderUserId)
        ? Colors.blueAccent
        : Colors.white;

    return Container(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: (data['senderId'] == widget.senderUserId)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              mainAxisAlignment: (data['senderId'] == widget.senderUserId)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Text(
                  data['senderId'],
                  style: TextStyle(fontSize: 8),
                ),
                ChatBubble(message: data['message'], color: color),
              ]),
        ));
  }

//build message input
  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(9),
            padding:  EdgeInsets.only(left: 15, bottom: 6, top: 6, right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              border: Border.all(color: Colors.grey),
            ),
            child: TextField(
              controller: _messagecontroller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Type a message',
              ),
              obscureText: false,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.attachment_outlined),
          onPressed: () => print("button pressed"),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: sendMessage,
        ),
      ],
    );
  }
}
