import 'dart:async';

void main() async {
  List<String> name = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N"
  ];

  // await for (String name in Stream<String>.fromIterable(name)) {
  //   print(name.toLowerCase());
  // }

  // await for (String name in Stream<String>.fromIterable(name)
  //     .map((event) => event.toUpperCase())) {
  //   print(name);
  // }

  await for (String name in Stream<String>.fromIterable(name).capitalised) {
    print(name);
  }
  await for (String name
      in Stream<String>.fromIterable(name).smallCasedUsingMap) {
    print(name);
  }
}

class ToUpperCase extends StreamTransformerBase<String, String> {
  @override
  Stream<String> bind(Stream stream) {
    return stream.map((event) => event.toUpperCase());
  }
}

extension Capitalize on Stream<String> {
  Stream<String> get capitalised {
    return this.transform(ToUpperCase());
  }

  Stream<String> get smallCasedUsingMap {
    return this.map((event) => event.toLowerCase());
  }
}
