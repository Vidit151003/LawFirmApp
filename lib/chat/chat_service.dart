import 'package:app1/chat/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(
      String senderId, String receiverId, String message) async {
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderId: senderId,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    // Create or update the chatroom with the participants array
    await _firestore.collection('chat_rooms').doc(chatRoomId).set({
      'participants': ids,
      'lastUpdated': timestamp,
    }, SetOptions(merge: true));

    // Add the message to the messages sub-collection
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessage(String userId, String otheruserId) {
    List<String> ids = [userId, otheruserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Stream<List<Map<String, dynamic>>> getUserChatRooms(String userId) {
    return _firestore
        .collection('chat_rooms')
        .where('participants', arrayContains: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                {'chatRoomId': doc.id, 'participants': doc['participants']})
            .toList());
  }
}


class ChatBubble extends StatelessWidget {
  final Color color;
  final String message;
  final bool sender;

  const ChatBubble({
    super.key,
    required this.message,
    required this.color,
    required this.sender,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 350),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3), // Shift the shadow downward (dy > 0)
            blurRadius: 4, // Controls the softness of the shadow
            spreadRadius: 0, // Ensures no extra spread
            color: Colors.grey.withOpacity(0.6), // Adjust the shadow color and opacity
          )
        ],
        color: color,
        borderRadius: sender
            ? const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(2),
        )
            : const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(2),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: sender ? Colors.white : Colors.black, // Corrected condition
          fontSize: 16.0,
        ),
      ),
    );
  }
}