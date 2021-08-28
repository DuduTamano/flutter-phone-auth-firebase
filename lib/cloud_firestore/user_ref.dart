

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zg_beauty_and_hair/model/user_model.dart';

Future<UserModel> getUserProfiles(String phone) async {
  CollectionReference userRef = FirebaseFirestore.instance.collection("Users");
  DocumentSnapshot snapshot = await userRef.doc(phone).get();
  if(snapshot.exists) {
    var userModel = UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return userModel;
  } else
    return UserModel(name: '', address: ''); //empty object
}