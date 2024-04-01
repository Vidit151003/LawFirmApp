import 'package:flutter/material.dart';



class ChatManagementScreen extends StatelessWidget {
  const ChatManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Chat"),
      ),
      body: const Center(
        child: Text("Chat Management Screen"),
      ),
    );
  }
}
