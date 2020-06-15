class FizzBuzz {
  static String calculate(int number) =>
      _divisibleBy3(number) ? 'Fizz' : number.toString();

  static bool _divisibleBy3(int number) => number % 3 == 0;
}
