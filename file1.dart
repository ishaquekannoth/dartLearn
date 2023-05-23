void main() async {
  Stream<double> getAllAges() async* {
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(Duration(microseconds: 1));
      yield i * 10;
    }
  }

  double add(double a, double b) => a + b;

  Stream<String> getNames() async* {
    await Future.delayed(Duration(seconds: 1));
    yield "John";
    await Future.delayed(Duration(seconds: 1));
    yield "Jack";
    await Future.delayed(Duration(seconds: 1));
    yield "Ishaque";
  }

  final result = await getAllAges().reduce((pre, curr) {
    print("Previous is $pre");
    print("Current is $curr");
    print("Iteration done");
    return add(pre / 10, curr / 10);
  });
  print(result);
}
