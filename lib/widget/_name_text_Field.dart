import 'package:flutter/material.dart';

class name_text_Feild extends StatelessWidget {
  name_text_Feild({
    super.key,
    required this.controller,
    required this.name,
  });
  final TextEditingController controller;
  final  String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        child: Container(
          width: 120,
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white54,
            boxShadow: const [
              BoxShadow(
                blurRadius: 1,
                color: Color(0x33000000),
                offset: Offset(0, 2),
              )
            ],
            shape: BoxShape.rectangle,
            border: Border.all(
              color: Colors.white54,
              width: 2,
            ),
          ),
          child: Padding(
            padding:
            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: Container(
              height: 50,
              width: 120,
              child: TextFormField(
                controller: controller,
                decoration:  InputDecoration(
                    hintText: name,
                    border:const OutlineInputBorder()),
              ),
            ),
          ),
        ));
  }
}