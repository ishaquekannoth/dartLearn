import 'dart:isolate';

void main() async {
 
  
  void _getMessages(SendPort sendPort) async {
    await for (final now in Stream.periodic(
      Duration(milliseconds: 1000),
      (_) => DateTime.now().toIso8601String(),
    )) {
      sendPort.send(now);
    }
    ;
  }

  Stream<String> getMessages() {
    final ReceivePort receivePort = ReceivePort();
    return Isolate.spawn(_getMessages, receivePort.sendPort)
        .asStream()
        .asyncExpand((_) => receivePort)
        .takeWhile((element) => element is String)
        .cast();
  }

  await for (final msg in getMessages()) {
    print(msg);
  }
}
