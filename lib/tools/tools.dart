import 'dart:math';
Random random = new Random();

int randInt(int min, int max) { // [min; max[
  return min + random.nextInt(max - min);
}
