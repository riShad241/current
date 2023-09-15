import 'package:flutter/material.dart';

import '../model/batsman.dart';
import '../model/blower.dart';

class Scoreboard extends StatefulWidget {
  @override
  _ScoreboardState createState() => _ScoreboardState();
}

class _ScoreboardState extends State<Scoreboard> {
  final List<PlayerStats> batsmen = [
    PlayerStats(name: 'Player 1'),
    PlayerStats(name: 'Player 2'),
    PlayerStats(name: 'Player 3'),
    // Add more batsmen as needed
  ];

  final List<BowlerStats> bowlers = [
    BowlerStats(name: 'Bowler 1'),
    BowlerStats(name: 'Bowler 2'),
    BowlerStats(name: 'Bowler 3'),
    // Add more bowlers as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cricbuzz Scoreboard'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Batting Statistics',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            DataTable(
              columns: [
                DataColumn(label: Text('Player')),
                DataColumn(label: Text('Runs')),
                DataColumn(label: Text('Balls')),
                DataColumn(label: Text('4s')),
                DataColumn(label: Text('6s')),
                DataColumn(label: Text('Strike Rate')),
              ],
              rows: batsmen.map((player) {
                double strikeRate = (player.runs / player.ballsFaced) * 100;

                return DataRow(
                  cells: [
                    DataCell(Text(player.name)),
                    DataCell(Text(player.runs.toString())),
                    DataCell(Text(player.ballsFaced.toString())),
                    DataCell(Text(player.fours.toString())),
                    DataCell(Text(player.sixes.toString())),
                    DataCell(Text(strikeRate.toStringAsFixed(2))),
                  ],
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Bowling Statistics',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            DataTable(
              columns: const [
                DataColumn(label: Expanded(child: Text('Bowler'))),
                DataColumn(label: Expanded(child: Text('Runs Given'))),
                DataColumn(label: Expanded(child: Text('Wickets Taken'))),
                DataColumn(label: Expanded(child: Text('Economy Rate'))),
              ],
              rows: bowlers.map((bowler) {
                return DataRow(
                  cells: [
                    DataCell(Text(bowler.name)),
                    DataCell(Text(bowler.runsGiven.toString())),
                    DataCell(Text(bowler.wicketsTaken.toString())),
                    DataCell(Text(bowler.economyRate.toStringAsFixed(2))),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}