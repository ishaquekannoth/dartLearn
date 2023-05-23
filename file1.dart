void main() async {
  Stream<String> getCharactor(String name) async* {
    for (int i = 0; i < name.length; i++) {
      await Future.delayed(Duration(seconds: 2));
      yield name[i];
    }
  }

  Stream<String> getNames() async* {
    await Future.delayed(Duration(seconds: 1));
    yield "John";
    await Future.delayed(Duration(seconds: 1));
    yield "Jack";
    await Future.delayed(Duration(seconds: 1));
    yield "Ishaque";
  }

  await for (String charactors
      in getNames().asyncExpand((name) => getCharactor(name))) {
    print(charactors);
  }
  ;
}
