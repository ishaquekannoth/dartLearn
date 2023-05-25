import 'dart:async';

void main() async {
  Future<void> nonBroadCastStreamExample() async {
    final controller = StreamController<String>();
    controller.sink.add("Ishaque");
    controller.sink.add("Bill Gates");
    controller.sink.add("Elon Musk");

    try {
      await for (var name in controller.stream) {
        print(name);
        await for (var name in controller.stream) {
          print(name);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> broadCastStreamExample() async {
    final StreamController<String> controller = StreamController<String>.broadcast();

    final sub1 = controller.stream.listen((event) {
      print("sub1: $event");
    });
    final sub2 = controller.stream.listen((event) {
      print("sub2: $event");
    });
    controller.sink.add("Ishaque");
    controller.sink.add("Bill Gates");
    //await Future.delayed(Duration(seconds: 2));
    //sub1.cancel();
    controller.sink.add("Elon Musk");
    controller.close();

    controller.onCancel = () {
      print("on cancel called");
      sub1.cancel();
      sub2.cancel();
    };
  }

  await broadCastStreamExample();
}
