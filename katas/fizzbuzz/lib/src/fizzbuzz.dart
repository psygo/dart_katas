class FizzBuzz {
  static String calculate(int number) => _divisibleBy15(number)
      ? 'FizzBuzz'
      : _divisibleBy3(number)
          ? 'Fizz'
          : _divisibleBy5(number) ? 'Buzz' : number.toString();

  static bool _divisibleBy15(int number) => number % 15 == 0;

  static bool _divisibleBy3(int number) => number % 3 == 0;

  static bool _divisibleBy5(int number) => number % 5 == 0;
}
