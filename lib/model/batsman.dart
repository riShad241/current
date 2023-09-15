class PlayerStats {
  String name;
  int runs;
  int ballsFaced;
  int fours;
  int sixes;
  double SR;

  PlayerStats({
    required this.name,
    this.runs = 0,
    this.ballsFaced = 0,
    this.fours = 0,
    this.sixes = 0,
    this.SR = 0.0,
  });
}
