import 'package:flutter/material.dart';

class studMaterials extends StatefulWidget {
  const studMaterials({Key? key}) : super(key: key);

  @override
  State<studMaterials> createState() => _studMaterialsState();
}

class _studMaterialsState extends State<studMaterials> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center
            (child: Text('Materials Page'))
      ),
    );
  }
}

