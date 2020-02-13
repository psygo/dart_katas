# Dart Katas

These are coding exercises meant to sharpen your programming abilities, analogous to martial arts'.

## Featured Katas

1. [Prime Factors](http://butunclebob.com/ArticleS.UncleBob.ThePrimeFactorsKata)
    - By Object Mentor (probably Robert C. Martin, aka Uncle Bob).
1. [Bowling Game](http://butunclebob.com/ArticleS.UncleBob.TheBowlingGameKata)
    - By Object Mentor (probably Robert C. Martin, aka Uncle Bob).
1. [Game of Life](http://codingdojo.org/kata/GameOfLife/)
    - By me, without any prior knowledge, except for the rules themselves.
    - Since I struggle a bit when learning some of the more advanced Dart features &mdash; and because I created considerable overhead with the `GridParser` class &mdash;, this particular kata took me about 2 days to complete.
    - The tests only test for high-level behavior &mdash; we should not couple the tests with the production code by testing implementation &mdash;; there should have been more tests, strictly speaking.
    - The `GridParser` class was not necessary. I created it so string grids could be converted into objects in the background and, so, we had truly OOP software &mdash; but is it really?
    - When going through the grid, on the borders, I avoided the typical `null` error of having invalid indices by shielding the logic with a *try-catch*. A more ideal OOP solution would be to create an outer buffer layer of *Null Cells* (Null-Object Pattern), which would represent nothingness in terms of the rules.

For more info about them, go to the `docs` or `docs/presentations` folder.