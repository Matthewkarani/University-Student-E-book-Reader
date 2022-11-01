import 'package:flutter/material.dart';

class PersonaMaterial extends StatefulWidget {
  const PersonaMaterial({Key? key}) : super(key: key);

  @override
  State<PersonaMaterial> createState() => _PersonaMaterialState();
}

class _PersonaMaterialState extends State<PersonaMaterial> {
//Get persona title from firebase
  late final String _PersonaName;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : ListView( children: [
        Center(child: Text(" Persona Materials",
            style: TextStyle(fontSize: 22,
            fontWeight: FontWeight.bold))),

      ],

      )
    );
  }
}
