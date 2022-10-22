import 'package:flutter/material.dart';
//This Page Should return a list of all enrolled personas, then upon
//clicking on a certain persona , it should take you to a materials page
class LecsMaterials extends StatefulWidget {
  const LecsMaterials({Key? key}) : super(key: key);

  @override
  State<LecsMaterials> createState() => _LecsMaterialsState();
}

class _LecsMaterialsState extends State<LecsMaterials> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center
            (child: Text('Persona Material')
          )),
    );
  }
}
