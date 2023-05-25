import 'dart:async';

void main() async {
  Future<List<String>> extractCharactors(String word) async {
    final charactors = <String>[];

    for (String char in word.split("")) {
      await Future.delayed(
          Duration(microseconds: 100), () => charactors.add(char));
    }
    return charactors;
  }

  Stream<String> getNames() async* {
    yield "Ishaque";
    yield "Bill Gates";
    yield "Elon Musk";
  }

  Stream<String> repeatThrice(String value) {
    return Stream.fromIterable(Iterable.generate(3, (_) => value));
  }

  await for(String name in getNames().asyncExpand((event) => repeatThrice(event))) {
    print(name);
  }
}
