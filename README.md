# Dart Katas

These are coding exercises meant to sharpen your programming abilities, analogous to martial arts'.

All of the katas were done using TDD, meaning they are not only tested by were tailored for (*driven by*) them.

## Featured Katas

1. [Prime Factors](http://butunclebob.com/ArticleS.UncleBob.ThePrimeFactorsKata)
    - By Object Mentor (probably, hopefully Robert C. Martin, aka Uncle Bob).
1. [Bowling Game](http://butunclebob.com/ArticleS.UncleBob.TheBowlingGameKata)
    - By Object Mentor (probably, hopefully Robert C. Martin, aka Uncle Bob).
1. [Conway's Game of Life](http://codingdojo.org/kata/GameOfLife/)
    - By me, without any prior knowledge, except for the rules themselves.
    - Since I struggle a bit when learning some of the more advanced Dart features &mdash; and because I created considerable overhead with the `GridParser` class &mdash;, this particular kata took me about 2 days to complete.
    - The tests only test for high-level behavior &mdash; we should not couple the tests with the production code by testing implementation &mdash;; there should have been more tests, strictly speaking.
    - The `GridParser` class was not necessary. I created it so string grids could be converted into objects in the background and, so, we had truly OOP software &mdash; but is it really?
    - When going through the grid, on the borders, I avoided the typical `null` error of having invalid indices by shielding the logic with a *try-catch*. A more ideal OOP solution would be to create an outer buffer layer of *Null Cells* (Null-Object Pattern), which would represent nothingness in terms of the rules.
1. [Sieve of Eratosthenes (Prime Generator)](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)
    - By me, with some prior knowledge. [I had already created a simple version](http://fanaro.com.br/python-basics-eratosthenes-and-problem-51/) of the algorithm when I was learning Python 1.5 years ago.
    - This is only one version of the sieve, there are many others much more optimized. This version features two optimizations:
        - Only using bases up to `sqrt(N)`.
        - Starting the sieve on the base from `base^2`.
1. [Tic-Tac-Toe](https://en.wikipedia.org/wiki/Tic-tac-toe)
    - The overall program is a bit (*cough*) overengineered. But it is good for practice, and, in the end, it even works for other board sizes than the typical 3x3 (there's already a test in place proving that it works for 4x4 boards).
        - Using asymmetrical boards will need some adaptation and refactoring, which I'm not interested in at the moment. The optional `boardSize` parameter for the game would have to be modified.
    - I completely dismissed the fact that this game is played by two people. What I mean is that I didn't create a player class to interact with the game itself. All of the plays are inserted directly into the game class. But fixing this to make things friendlier shouldn't be that hard. 
        - It would be best if changes to the board were notified to the players' instances, with the game board being an observable.
        - The player class could be some sort of façade between the game class and the end-user.
1. [Design Patterns](https://en.wikipedia.org/wiki/Software_design_pattern)
    - This is only at its beginning stages right now.
    1. Observer
        - So far, only the Observer pattern is featured. To achieve it I could have implemented the vanilla interfaces in the GoF book (I still intend on doing it). However, I was interested in knowing how to do it in a way that's more in tune with Dart. So, naturally, I chose to try doing it `Stream`s. It isn't very trivial, native support isn't very straightforward at all and I needed Rémi Rousselet's help in order to make it work. You can find out more about it in [this answer](https://stackoverflow.com/a/60341534/4756173).

> I've taken the liberty (good practice?) of refactoring the repetitive tests into for's with organized maps of input-outputs inside the `mocks` folder. If you want to check out how they looked like before this refactoring, look for the tag `refactored_generalized_tests`.

For more info about them, go to the `docs` or `docs/presentations` folder.

## How do I run these tests?

There are two options:

- `pub run test <path_to_file>`
- `dart <path_to_file>`