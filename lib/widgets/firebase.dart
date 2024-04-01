import 'package:app1/widgets/utils.dart';


import 'package:cloud_firestore/cloud_firestore.dart';



  postDetailsToFirestore2(String heading, String content, var user) async{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var u1 = user;
  CollectionReference ref = firebaseFirestore.collection('users');
  (ref.doc(u1!.uid).set({heading: content})).onError((error, stackTrace) {
    utils().toastMessage(error.toString());
  });
}
