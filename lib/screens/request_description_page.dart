import 'package:app1/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RequestDescriptionPage extends StatefulWidget {
  const RequestDescriptionPage({super.key, required this.clientEmail, required this.subject, required this.clientId});

  final String clientEmail;
  final String subject;
  final String clientId;

  @override
  State<RequestDescriptionPage> createState() => _RequestDescriptionPageState();
}

class _RequestDescriptionPageState extends State<RequestDescriptionPage> {
  Map<String, dynamic>? requestData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRequestDetails();
  }

  Future<void> _fetchRequestDetails() async {
    try {
      String requestId = "${widget.clientEmail.toString()}_${widget.subject.toString()}"; // Format of request ID
      DocumentSnapshot requestSnapshot = await FirebaseFirestore.instance
          .collection('requests')
          .doc(requestId)
          .get();

      if (requestSnapshot.exists) {
        setState(() {
          requestData = requestSnapshot.data() as Map<String, dynamic>;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching request details: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Description')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : requestData == null
          ? const Center(child: Text("Request details not found"))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("Email", requestData!['email'] ?? "N/A"),
            _buildDetailRow("Subject", requestData!['subject'] ?? "N/A"),
            _buildDetailRow("Description", requestData!['description'] ?? "N/A"),
            _buildDetailRow("Assigned Lawyer", requestData!['assignedLawyer'] ?? "Not assigned"),
            _buildDetailRow("Field", requestData!['field'] ?? "N/A"),
            _buildDetailRow("Timestamp", _formatTimestamp(requestData!['timestamp'])),
            const SizedBox(height: 20),
            LawyerDropDown(clientId: widget.clientId, clientemail: requestData!['email'], subject: requestData!['subject'],),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black),
          children: [
            TextSpan(text: "$title: ", style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate().toString();
    }
    return "N/A";
  }
}
