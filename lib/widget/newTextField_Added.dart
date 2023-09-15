import 'package:flutter/material.dart';

class newTextFieldAdded extends StatelessWidget {
  const newTextFieldAdded({
    super.key,
    required this.newController,
  });

  final TextEditingController newController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
      child: Material(
        color: Colors.transparent,
        elevation: 15,
        shape: const CircleBorder(),
        child: Container(
          height: 80,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.white54,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white54,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
            child: TextFormField(
              controller: newController,
              decoration:
              const InputDecoration(border: OutlineInputBorder()),
              // You can customize the height and width using InputDecoration
            ),
          ),
        ),
      ),
    );
  }
}