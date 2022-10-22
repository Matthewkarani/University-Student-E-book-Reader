import 'package:cloud_firestore/cloud_firestore.dart';

class PersonaInfo{
  late String Course_Title;
  late String Persona_Description;
  late String Persona_Title;
  late String Persona_Key;
  late List my_personas;
  late Timestamp createdAt;

  PersonaInfo.fromMap(Map<String, dynamic>data){
    Course_Title = data['Course_Title'];
    Persona_Description= data['Persona_Description'];
    Persona_Title = data['Persona_Description'];
    Persona_Key = data['Persona_key'];
  }


}