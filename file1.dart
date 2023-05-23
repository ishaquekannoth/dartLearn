void main() async {
  Stream<String> maleNames() async* {
    yield "Ishaque";
    await Future.delayed(Duration(seconds: 1));
    yield "Irfan";
    await Future.delayed(Duration(seconds: 1));
    yield "Ihsan";
  }

  Stream<String> femaleNames() async* {
    yield "Imana";
    await Future.delayed(Duration(seconds: 1));
    yield "Inaya";
    await Future.delayed(Duration(seconds: 1));
    yield "Iqra";
  }

  Stream<String> allNames() async* {
    yield* maleNames();
    await Future.delayed(Duration(seconds: 3));
    yield* femaleNames();
  }

  await for (String name in allNames()) {
    print(name);
  }
}
