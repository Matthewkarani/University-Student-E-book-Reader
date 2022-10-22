import 'package:cloud_firestore/cloud_firestore.dart';

class UserX {
  late final String? Fname;
  late final String? Lname;
  late final int? age;
  late final String? email;
  late final String? role;

  //add male & female

  UserX({
    this.Fname,
    this.Lname,
    this.age,
    this.email,
    this.role

});
  factory UserX.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return UserX(
      Fname: data?['Fname'],
      Lname: data?['Lname'],
      age: data?['age'],
      email: data?['email'],
      role: data?['role'],

    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (Fname != null) "Fname": Fname,
      if (Lname != null) "Lname": Lname,
      if (age != null) "age": age,
      if (email != null) "email": email,
      if (role != null) "role": role,

    };
  }

}