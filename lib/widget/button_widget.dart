import 'package:flutter/material.dart';
class button extends StatelessWidget {
  const button({
  required this.name,
    required this.onTap,
    required this.color



  }) ;
  final VoidCallback onTap;
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
          height: 30,
          width: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: MaterialButton(
            onPressed: onTap,
            color: color,
            child:  Text(name),
          )),
    );
  }
}
