import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

void main() async {
  log("From main isolate");
  final isolateFuture = runOnIsoloate();
  isolateFuture.whenComplete(() => log("Completed future"));
  isolateFuture.then((result) {
    log("Completed Spawn isolate with result: $result");
  });

  for (int i = 0; i < 10; i++) {
    await Future.delayed(Duration(milliseconds: 500));
    log("Main Isolate Printing  " + i.toString());
  }
}

Future<int> runOnIsoloate() async {
  Completer<int> completer = Completer();
  ReceivePort receivePort = ReceivePort();
  await Isolate.spawn(workerFunction, receivePort.sendPort);
  final rp = receivePort.asBroadcastStream(
    onCancel: (subscription) => subscription.cancel(),
  );

  StreamSubscription? subscription;
  subscription = rp.listen((message) {
    log("Spawn Isolate Printing  " + message.toString());
    if (message > 100) {
      completer.complete(message);
      subscription?.cancel();
    }
  });

  return completer.future;
}

void workerFunction(SendPort sendPort) async {
  int value = 0;
  for (int i = 0; i < 15; i++) {
    value = value + i;
    await Future.delayed(Duration(milliseconds: 200));
    sendPort.send(value);
  }
}
