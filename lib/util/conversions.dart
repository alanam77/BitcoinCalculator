class Conversions {
  static double dollarsToBit(double amt, double rate) {
    if (amt < 0) {
      throw ArgumentError();
    }
    return amt / rate;
  }

  static double bitToDollars(double amt, double rate) {
    if (amt < 0) {
      throw ArgumentError();
    }
    return amt * rate;
  }
}
