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

  final result = await getNames()
      .asyncMap((event) => extractCharactors(event))
      .fold("", (previous, element) {
    final elements = element.join("-");
    return "$previous  $elements";
  });
  print(result);
}
