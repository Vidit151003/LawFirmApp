import 'package:app1/chat/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../chat/chat_service.dart';

class ChatRoomsScreen extends StatefulWidget {
  final String userId;

  ChatRoomsScreen({required this.userId});

  @override
  _ChatRoomsScreenState createState() => _ChatRoomsScreenState();
}

class _ChatRoomsScreenState extends State<ChatRoomsScreen> {
  final ChatService _chatService = ChatService();
  late Stream<List<Map<String, dynamic>>> _chatRoomsStream;

  @override
  void initState() {
    super.initState();
    _chatRoomsStream = _chatService.getUserChatRooms(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _chatRoomsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final chatRooms = snapshot.data ?? [];

          if (chatRooms.isEmpty) {
            return Center(child: Text('No chat rooms found.'));
          }

          return ListView.builder(
            itemCount: chatRooms.length,
            itemBuilder: (context, index) {
              final chatRoom = chatRooms[index];
              final chatRoomId = chatRoom['chatRoomId'];
              final participants = chatRoom['participants'] as List<dynamic>;
              final otherUserId = participants.firstWhere((id) => id != widget.userId);
              final role = FirebaseFirestore.instance.collection('users').doc('role');

              return ListTile(
                title: Text('Chat with $role'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        senderUserId: widget.userId,
                        receiverUserId: otherUserId,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
