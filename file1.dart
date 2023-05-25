import 'dart:async';

void main() async {
  Stream<String> getNames() async* {
    yield "Ishaque";
    yield "Bill Gates";
    yield "Elon Musk";
    throw "All out of names";
  }

  await for (String name in getNames().absorbErrUsingHandleError()) {
    print(name);
  }
  await for (String name in getNames().absorbUsingHandlers()) {
    print(name);
  }
  await for (String name in getNames().absorbUsingTransformer()) {
    print(name);
  }
}

extension AbsorbErrors<T> on Stream<T> {
  Stream<T> absorbErrUsingHandleError() => handleError((error, stackTrace) {
        print("Error occured");
      });
  Stream<T> absorbUsingHandlers() => transform(StreamTransformer.fromHandlers(
        handleError: (error, stackTrace, sink) => sink.close(),
      ));
  Stream<T> absorbUsingTransformer() => transform(StreamErrAbsorber());
}

class StreamErrAbsorber<T> extends StreamTransformerBase<T, T> {
  @override
  Stream<T> bind(Stream<T> stream) {
    final controller = StreamController<T>();

    stream.listen(
      (event) {
        controller.sink.add(event);
      },
      onError: (_) {},
      onDone: () => controller.close(),
    );
    return controller.stream;
  }
}
