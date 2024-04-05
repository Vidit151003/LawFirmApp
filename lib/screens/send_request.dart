import 'package:flutter/material.dart';

class Send_Request extends StatelessWidget {
  const Send_Request({super.key});

  TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Send a Request")),
        body: Center(
          child: Form(
              key: _formKey,
              child: child),
        ));
  }
}
