import 'package:app1/chat/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/*class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String senderId, String receiverId, String message) async {
    final Timestamp timestamp = Timestamp.now();


    Message newMessage = Message(
        senderId: senderId,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

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
}
*/

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String senderId, String receiverId, String message) async {
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
        .map((snapshot) => snapshot.docs.map((doc) => {
      'chatRoomId': doc.id,
      'participants': doc['participants']
    }).toList());
  }
}

class ChatBubble extends StatelessWidget {
  final Color color;
  final String message;
  const ChatBubble({super.key, required this.message, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 5), // Shadow position
          ),
        ],
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      ),
    );
  }
}

