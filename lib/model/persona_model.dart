import 'package:cloud_firestore/cloud_firestore.dart';

class Persona {
  late final String? Persona_title;
  late final String? Course_Title;
  late final String? Persona_Description;
  late final String? Persona_key;
  late final bool? IsPersona;

  Persona({
    this.Persona_title,
    this.Course_Title,
    this.Persona_Description,
    this.Persona_key,
    this.IsPersona

  });
  factory Persona.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Persona(
      Persona_title: data?['Persona_title'],
      Course_Title: data?['Course_Title'],
      Persona_Description: data?['Persona_Description'],
      IsPersona: data?['IsPersona'],
      Persona_key: data?['Persona_key'],

    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (Persona_title != null) "Persona_title": Persona_title,
      if (Course_Title != null) "Course_Title": Course_Title,
      if (Persona_Description != null) "Persona_Description": Persona_Description,
      if (IsPersona != null) "IsPersona": IsPersona,
      if (Persona_key != null) "Persona_key": Persona_key,

    };
  }

}