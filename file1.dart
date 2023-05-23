void main() async {
  bool isEven(int x) => x % 2 == 0;
  bool isOdd(int x) => x % 2 != 0;
  Stream<int> numberStream(
      {int start = 1, int end = 5, Function(int)? isIncluded}) async* {
    for (int i = start; i <= end; i++) {
      if (isIncluded == null || isIncluded(i)) {
        yield i;
      }
    }
  }

  await for (int value in numberStream(isIncluded: isEven)) {
    print(value);
  }
  await for (int value in numberStream(isIncluded: isOdd)) {
    print(value);
  }
  await for (int value in numberStream()) {
    print(value);
  }
}
