import 'package:flutter/material.dart';

class name_widget extends StatelessWidget {
  const name_widget({
    super.key,
    required this.name
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
      child: Text(
        '$name :',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontFamily: 'Readex Pro',
          fontSize: 25,
        ),
      ),
    );
  }
}