void runTest() {
  t2();
}

void test1() {
  var items = ['Salad', 'Popcorn', 'T'];

  if (items.any((element) => element.contains('a'))) {
    print('At least one element contains "a"');
  }
  if (items.any((element) => element.contains('T'))) {
    print('at lease one el contains T');
  }

  if (items.every((element) => element.length >= 5)) {
    print('All elements have length >= 5');
  }
}

t2() {
  var numbers = [1, 3, -2, 0, 4, 5];

  var numbersUntilZero = numbers.takeWhile((number) => number != 0);
  print('Numbers until 0: $numbersUntilZero');

  var numbersAfterZero = numbers.skipWhile((number) => number != 0);
  print('Numbers after 0: $numbersAfterZero');

  Iterable iterable = numbers.map((e) {
    return e + 1;
  });
  print(iterable.toString());
}
