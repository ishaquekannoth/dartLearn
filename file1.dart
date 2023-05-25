import 'dart:async';

void main() async {
  Stream<String> getNames() async* {
    yield "A";
    await Future.delayed(Duration(seconds: 1));
    yield "B";
    await Future.delayed(Duration(seconds: 2));
    yield "C";
    await Future.delayed(Duration(seconds: 1));
    yield "D";
    await Future.delayed(Duration(seconds: 4));
    yield "E";
    await Future.delayed(Duration(seconds: 7));
    yield "F";
  }

  try {
    await for (var name in getNames().streamTimeWait(Duration(seconds: 3))) {
      print(name);
    }
  } on TimerRanoutException catch (e) {
    print(e.message.toString());
  }
}

class TimeOutBeetweenEvents<T> extends StreamTransformerBase<T, T> {
  Duration duration;
  StreamController<T>? controller;
  StreamSubscription<T>? subscription;
  Timer? timer;
  TimeOutBeetweenEvents(this.duration);
  @override
  Stream<T> bind(Stream<T> stream) {
    controller = StreamController<T>(
      onListen: () {
        subscription = stream.listen((data) {
          timer?.cancel();
          timer = Timer.periodic(duration, (timer) {
            controller?.addError(TimerRanoutException(
              "Timer ran out",
            ));
          });
          controller?.add(data);
        }, onError: controller?.addError, onDone: controller?.close);
      },
      onCancel: () {
        subscription?.cancel();
        timer?.cancel();
      },
    );
    return controller!.stream;
  }
}

extension TimerBetweeenEvents<T> on Stream<T> {
  Stream<T> streamTimeWait(Duration duration) =>
      transform(TimeOutBeetweenEvents(duration));
}

class TimerRanoutException implements Exception {
  String message;
  TimerRanoutException(this.message);
}


