import 'dart:math';

class RankCause {
  double popularity;
  double time; //hours
  double gravity;

  double causeScore() {
    return (popularity - 1) / (time + 2) * exp(gravity);
  }
}
