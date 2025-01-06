// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ProgressUpdateScreen extends StatefulWidget {
//   final String petitionId;
//   final Map<String, dynamic> petitionData;

//   ProgressUpdateScreen({required this.petitionId, required this.petitionData});

//   @override
//   _ProgressUpdateScreenState createState() => _ProgressUpdateScreenState();
// }

// class _ProgressUpdateScreenState extends State<ProgressUpdateScreen> {
//   late String _selectedStatus;

//   @override
//   void initState() {
//     super.initState();
//     _selectedStatus = widget.petitionData['status'] ?? 'Pending';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Update Progress'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Petition ID: ${widget.petitionId}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             DropdownButtonFormField<String>(
//               value: _selectedStatus,
//               items: [
//                 'Pending',
//                 'Receive the Legal Request',
//                 'Review the Submitted Query',
//                 'Allocate Legal Resources',
//                 'Review the Request in Detail',
//                 'Communicate and Collaborate',
//               ].map((status) {
//                 return DropdownMenuItem(
//                   value: status,
//                   child: Text(status),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedStatus = value!;
//                 });
//               },
//               decoration: InputDecoration(labelText: 'Select Status'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async { // Add async
//                 try {
//                   await FirebaseFirestore.instance
//                       .collection('clients')
//                       .doc(widget.petitionData['client_id'])
//                       .collection('requests')
//                       .doc(widget.petitionId)
//                       .set({'status': _selectedStatus}); // Use 'update'

//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                     content: Text('Status updated successfully'),
//                   ));
//                 } catch (error) {
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                     content: Text('Failed to update status: $error'),
//                   ));
//                 }
//               },
//               child: Text('Update Status'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:app1/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class ProgressUpdateScreen extends StatefulWidget {
//   final String petitionId;
//   final Map<String, dynamic> petitionData;

//   ProgressUpdateScreen({required this.petitionId, required this.petitionData});

//   @override
//   _ProgressUpdateScreenState createState() => _ProgressUpdateScreenState();
// }

// class _ProgressUpdateScreenState extends State<ProgressUpdateScreen> {
//   late String _selectedStatus;

//   @override
//   void initState() {
//     super.initState();
//     _selectedStatus = widget.petitionData['status'] ?? 'Pending';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Update Progress'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Petition ID: ${widget.petitionId}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             DropdownButtonFormField<String>(
//               value: _selectedStatus,
//               items: [
//                 'Pending',
//                 'Receive the Legal Request',
//                 'Review the Submitted Query',
//                 'Allocate Legal Resources',
//                 'Review the Request in Detail',
//                 'Communicate and Collaborate',
//               ].map((status) {
//                 return DropdownMenuItem(
//                   value: status,
//                   child: Text(status),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedStatus = value!;
//                 });
//               },
//               decoration: InputDecoration(labelText: 'Select Status'),
//             ),
//             SizedBox(height: 20),
// ElevatedButton(
//   onPressed: () async {
//     try {
//       print('Updating status for document ID: ${widget.petitionId}');
//       print('Client ID: ${widget.petitionData['client_id']}');

//       await FirebaseFirestore.instance
//           .collection('clients')
//           .doc(widget.petitionData['client_id'])
//           .collection('requests')
//           .doc(widget.petitionId)
//           .set({'status': _selectedStatus});

//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Status updated successfully'),
//       ));
//     } catch (error) {
//       print('Error updating status: $error');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Failed to update status: $error'),
//       ));
//     }
//   },
//   child: Text('Update Status'),
// ),

//           ],
//         ),
//       ),
//     );
//   }
// }

class ProgressUpdateScreen extends StatefulWidget {
  final String petitionId;
  final Map<String, dynamic> petitionData;
  final String clientId; // Add clientId to the constructor

  ProgressUpdateScreen({
    required this.petitionId,
    required this.petitionData,
    required this.clientId, // Accept clientId as a parameter
  });

  @override
  _ProgressUpdateScreenState createState() => _ProgressUpdateScreenState();
}

class _ProgressUpdateScreenState extends State<ProgressUpdateScreen> {
  late String _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.petitionData['status'] ?? 'Pending';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Progress'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Petition ID: ${widget.petitionId}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35)
              ),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  colorScheme: ColorScheme.light(),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                  alignedDropdown: true,
                  child: DropdownButtonFormField<String>(
                    value: _selectedStatus,
                    items: [
                      'Pending',
                      'Receive the Legal Request',
                      'Review the Submitted Query',
                      'Allocate Legal Resources',
                      'Review the Request in Detail',
                      'Communicate and Collaborate',
                    ].map((status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32)
                          ),
                          child: Text(status,
                              style:
                                  TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedStatus = value!;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Select Status',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 45,
              width: 180,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(0, 65, 120, 1),
                ),
                onPressed: () async {
                  try {
                    print(
                        'Updating status for document ID: ${widget.petitionId}');
                    print('Client ID: ${widget.petitionData['client_id']}');

                    await FirebaseFirestore.instance
                        .collection('clients')
                        .doc(widget.clientId) // Use widget.clientId
                        .collection('requests')
                        .doc(widget.petitionId)
                        .update({'status': _selectedStatus});

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Status updated successfully'),
                    ));
                  } catch (error) {
                    print('Error updating status: $error');
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Failed to update status: $error'),
                    ));
                  }
                },
                child: Text('Update Status',style: TextStyle(color: Colors.white, fontSize: 14),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
