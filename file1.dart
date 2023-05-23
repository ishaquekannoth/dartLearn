import 'dart:async';

void main() async {
  StreamController controller = new StreamController<String>();
  controller.sink.add("Helllo");
  controller.sink.add("World");

  await for (String word in controller.stream) {
    print(word);
  }
  controller.close();
}
