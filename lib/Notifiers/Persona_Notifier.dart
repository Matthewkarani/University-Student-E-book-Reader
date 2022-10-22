import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../model/rertrieve_persona_data.dart';

class PersonaNotifier with ChangeNotifier{
  //create state for list of personas
 List<PersonaInfo>_personaList = [];
  late PersonaInfo _currentPersona;

  //lb returns the unmodifiableListView and passes in _personaList
  //It gets us the persona List and makes sure we can't change it.
  UnmodifiableListView<PersonaInfo> get personaList =>
      UnmodifiableListView(_personaList);

  PersonaInfo get currentPersona => _currentPersona;
//Whenever you get the persona for the first time you call the setter below
  set personaList(List<PersonaInfo> personaList) {
    _personaList = personaList;
    notifyListeners();
  }

  //Whenever you change the current persona you call this and notify the app.
  set currentPersona(PersonaInfo personaInfo) {
    _currentPersona = personaInfo;
    notifyListeners();
  }

}