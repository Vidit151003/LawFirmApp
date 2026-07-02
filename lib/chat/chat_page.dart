import 'package:app1/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserId;
  final String senderUserId;
  final String receiverName;

  const ChatPage({
    super.key, 
    required this.receiverUserId, 
    required this.senderUserId,
    this.receiverName = 'Chat',
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messagecontroller = TextEditingController();
  final ChatService _chatService = ChatService();
  final ScrollController _scrollController = ScrollController();

  void sendMessage() async {
    if (_messagecontroller.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.senderUserId, widget.receiverUserId, _messagecontroller.text);
      _messagecontroller.clear();
      // Scroll to bottom after sending
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.receiverName),
          backgroundColor: const Color.fromRGBO(0, 65, 120, 1),
          foregroundColor: Colors.white,
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

  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _chatService.getMessage(widget.receiverUserId, widget.senderUserId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        // Auto scroll on new messages
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          }
        });

        return ListView(
          controller: _scrollController,
          padding: const EdgeInsets.all(10),
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>? ?? {};
    bool isMe = data['senderId'] == widget.senderUserId;

    var alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;
    var chatColor = isMe ? const Color.fromRGBO(0, 65, 120, 1) : Colors.grey[300];
    var textColor = isMe ? Colors.white : Colors.black87;

    return Container(
        alignment: alignment,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: chatColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15),
              topRight: const Radius.circular(15),
              bottomLeft: isMe ? const Radius.circular(15) : const Radius.circular(0),
              bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(15),
            ),
          ),
          child: Text(
            data['message'] ?? '',
            style: TextStyle(color: textColor, fontSize: 16),
          ),
        ));
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messagecontroller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              obscureText: false,
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: const Color.fromRGBO(0, 65, 120, 1),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: sendMessage,
            ),
          )
        ],
      ),
    );
  }
}

