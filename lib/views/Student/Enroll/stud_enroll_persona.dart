import 'package:flutter/material.dart';

import '../../../app_styles.dart';

class EnrollPersona extends StatefulWidget {
  const EnrollPersona({Key? key}) : super(key: key);

  @override
  State<EnrollPersona> createState() => _EnrollPersonaState();
}

class _EnrollPersonaState extends State<EnrollPersona> {

  final _personaKeycontroller = TextEditingController();

  @override
  void dispose() {
    _personaKeycontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text('Enroll to Persona', style:
      TextStyle(
      fontWeight: FontWeight.bold,
      wordSpacing: 2,),),
    ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [

                SizedBox(height: 200,),


                Text('Enter Persona Key',
                      style: TextStyle(color: Colors.black,
                          fontSize: 22)),

                SizedBox(height: 20,),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                        controller: _personaKeycontroller,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Enter key here')),
                  ),
                ),
                
                SizedBox(height:30),

                Align(
                  alignment: Alignment.bottomRight,
                  child:Container(
                    padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: customBrown,
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Text(
                "Enroll",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
                ),




              ],
            ),
          ),
        ),
      ),
    );
  }
}
