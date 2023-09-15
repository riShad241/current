import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddRemoveButtons extends StatelessWidget {
  final VoidCallback onAddPressed;
  final VoidCallback onRemovePressed;

  AddRemoveButtons({
    required this.onAddPressed,
    required this.onRemovePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: GestureDetector(
            onTap: onRemovePressed,
            child: Container(
              height: 20,
              width: 30,
              child: Icon(Icons.remove,size: 20,),
              color: Colors.green,
            ),
          ),
        ),
        const SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: GestureDetector(
            onTap: onAddPressed,
            child: Container(
              height: 20,
              width: 30,
              child: Icon(Icons.add,size: 20,),
                color: Colors.blue,
              ),
          ),
        ),
      ],
    );
  }
}