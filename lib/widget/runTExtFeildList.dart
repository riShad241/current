import 'package:flutter/material.dart';
class TextFieldList extends StatelessWidget {
  final List<TextEditingController> controllers;

  const TextFieldList({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < controllers.length; i++)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(4, 5, 3, 5),
            child: Material(
              color: Colors.transparent,
              elevation: 5,
              shape: const CircleBorder(),
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                  child: TextFormField(
                    controller: controllers[i],
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontFamily: 'Readex Pro',
                        color: Colors.blueAccent,
                      ),
                      hintStyle: Theme.of(context).textTheme.labelMedium,
                      enabledBorder: UnderlineInputBorder(
                        borderSide:const BorderSide(
                          color: Colors.white70,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blueAccent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide:const  BorderSide(
                          color: Colors.redAccent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide:const  BorderSide(
                          color: Colors.redAccent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontFamily: 'Readex Pro',
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
