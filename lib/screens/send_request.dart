import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Send_Request extends StatefulWidget {
  const Send_Request({super.key});

  @override
  State<Send_Request> createState() => _SendRequestState();
}

class _SendRequestState extends State<Send_Request> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Send a Request")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(labelText: 'Subject'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              _isLoading 
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() { _isLoading = true; });
                          try {
                            final auth = FirebaseAuth.instance;
                            final firestore = FirebaseFirestore.instance;
                            final user = auth.currentUser;
                            if (user == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Error: Not logged in.')),
                              );
                              setState(() { _isLoading = false; });
                              return;
                            }

                            // Fetch client name from Firestore
                            var clientDoc = await firestore.collection('clients').doc(user.email).get();
                            String name = clientDoc.data()?['name'] ?? 'Unknown Client';

                            await firestore.collection('requests').add({
                              'uid': user.uid,
                              'email': user.email, 
                              'name': name,
                              'subject': _subjectController.text,
                              'description': _descriptionController.text,
                              'assignedLawyerUid': '',
                              'status': 'pending',
                              'timestamp': FieldValue.serverTimestamp(),
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Request submitted successfully!')),
                            );
                            Navigator.pop(context);
                          } catch (e) {
                            setState(() { _isLoading = false; });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        }
                      },
                      child: const Text('Submit Request'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
