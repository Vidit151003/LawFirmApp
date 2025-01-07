import 'package:app1/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceRequestPage extends StatefulWidget {
  final String userEmail;

  ServiceRequestPage({required this.userEmail});

  @override
  _ServiceRequestPageState createState() => _ServiceRequestPageState();
}

class _ServiceRequestPageState extends State<ServiceRequestPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedField;
  List<String> _fields = ['Money Matters', 'Criminal', 'Consultation'];

  String _selectedStatus = 'Pending'; // Default status is set to 'Pending'
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  String? email = FirebaseAuth.instance.currentUser!.email;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance
          .collection('requests').doc(email)
          .set({
            'email': email,
            'uid': uid,
            'name': _nameController.text,
            'subject': _subjectController.text,
            'description': _descriptionController.text,
            'field': _selectedField,
            'status': _selectedStatus,
            'timestamp': Timestamp.now(),
          })
          .then((value) => _showSuccessSnackBar())
          .catchError((error) => _showFailureSnackBar(error));
    }
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Request submitted successfully'),
    ));
    _resetForm();
  }

  void _showFailureSnackBar(error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Failed to submit request: $error'),
    ));
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _subjectController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedField = null;
      _selectedStatus = 'Pending'; // Reset status
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Request'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    hintText: 'Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name' : null,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    hintText: 'Subject'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter subject' : null,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    hintText: 'Description'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter description' : null,
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField<String>(
                value: _selectedField,
                items: _fields.map((field) {
                  return DropdownMenuItem(
                    value: field,
                    child: Text(field),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedField = value),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    hintText: 'Select Field'),
              ),
              SizedBox(height: 20.0),
              SizedBox(
                height: 20,
              ),
              OvalButtonSmall(
                onPressed: _submitForm,
                name: 'Submit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
