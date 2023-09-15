import 'package:flutter/material.dart';

class score_bord_in_custom extends StatelessWidget {
  const score_bord_in_custom({
    super.key,
    required this.totalrun,
    required this.wickets,
    required this.ballsInover,
    required this.overs,
  });

  final int totalrun;
  final int wickets;
  final int ballsInover;
  final int overs;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(30),
          topLeft: Radius.circular(30),
          topRight: Radius.circular(10),
        ),
      ),
      child: Container(
        width: 363,
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(30),
            topLeft: Radius.circular(30),
            topRight: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: AlignmentDirectional(-1.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                  child: Text(
                    'Bangladesh run       :             $totalrun/$wickets',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(
                      fontFamily: 'Readex Pro',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-1.00, 0.00),
                child: Padding(
                  padding:
                  const EdgeInsetsDirectional.fromSTEB(10, 2, 0, 0),
                  child: Text(
                    'Over                         :         $ballsInover.$overs',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(
                      fontFamily: 'Readex Pro',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}