import 'package:app1/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserId;
  final String senderUserId;

  const ChatPage(
      {super.key, required this.receiverUserId, required this.senderUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messagecontroller = TextEditingController();
  final ChatService _chatService = ChatService();
  final ScrollController _scrollController = ScrollController(); // ScrollController
  bool _initialScrollDone = false; // To track if the initial scroll is already done

  void sendMessage() async {
    if (_messagecontroller.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.senderUserId,
        widget.receiverUserId,
        _messagecontroller.text,
      );
      _messagecontroller.clear();
      _scrollToBottomAnimated(); // Smooth scroll after sending a message
    }
  }

  void _scrollToBottomInstant() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent); // Instant scroll
    }
  }

  void _scrollToBottomAnimated() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 50), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), // Smooth scroll duration
          curve: Curves.easeOut, // Animation curve
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Messages"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  // Build message list
  Widget _buildMessageList() {
    return Container(
      color: Colors.white,
      child: StreamBuilder<QuerySnapshot>(
        stream: _chatService.getMessage(widget.receiverUserId, widget.senderUserId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: " + snapshot.error.toString()),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Scroll to the bottom on the first load
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!_initialScrollDone) {
              _scrollToBottomInstant(); // Instant scroll only for the first load
              _initialScrollDone = true; // Mark initial scroll as done
            } else {
              _scrollToBottomAnimated(); // Smooth scroll for subsequent updates
            }
          });

          return ListView(
            controller: _scrollController, // Attach the ScrollController
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        },
      ),
    );
  }

  // Build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == widget.senderUserId)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    var color = (data['senderId'] == widget.senderUserId)
        ? Colors.blue.shade700
        : Colors.grey.shade200;
    bool sender = (data['senderId'] == widget.senderUserId);

    return Container(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: (data['senderId'] == widget.senderUserId)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            ChatBubble(
              message: data['message'],
              color: color,
              sender: sender,
            ),
          ],
        ),
      ),
    );
  }

  // Build message input
  Widget _buildMessageInput() {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 49,
              margin: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 5),
              padding: const EdgeInsets.only(left: 15, bottom: 6, top: 6, right: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(35),
                border: Border.all(color: Colors.transparent),
              ),
              child: Center(
                child: TextField(
                  controller: _messagecontroller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type a message',
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black12,
            ),
            child: IconButton(
              iconSize: 25,
              icon: const Icon(Icons.attachment_outlined),
              onPressed: () => print("Attachment pressed"),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.shade700,
            ),
            child: IconButton(
              color: Colors.white,
              iconSize: 25,
              icon: const Icon(Icons.send),
              onPressed: sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
