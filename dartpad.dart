import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

void main() async {
  do {
    stdout.write("Say Something :");
    final line = stdin.readLineSync(encoding: utf8);
    switch (line?.trim().toLowerCase()) {
      case null:
        print("object");
        continue;
      case 'exit':
        exit(0);
      default:
        final message = await getMessage(line!);
        print(message);
    }
  } while (true);
}

Future<String> getMessage(String messageToSend) async {
  //Making a Recieve port to recieve the reply..Recieve Port has SendPort built in it
  //RecievePort is implimenting Stream<dynamic>
  ReceivePort receivePortToRecieveReply = ReceivePort();
  //1)Awaiting a new spawn by sending the  RecievePort's SendPort
  //2)This is done since the response from the _communicator will be recieved in the
  //sendPort which is the 2nd arguement of the spawn method (which is also inside the RecievePort)
  //3)isolate.spawn must have 2 postitional argument..Can have any type of return value
  // function(T) and message which is also of same type as T which is the function Parameter type
  //and the same type must be passed in the message parameter
  Isolate.spawn(_communicator, receivePortToRecieveReply.sendPort);
  final broadCastRp = receivePortToRecieveReply.asBroadcastStream();
  final SendPort sendPortCommunicator = await broadCastRp.first;
  sendPortCommunicator.send(messageToSend);

  return broadCastRp
      .takeWhile((element) => element is String)
      .cast<String>()
      .take(1)
      .first;
}

void _communicator(SendPort sendPortToSendReply) async {
  //here we are making a RP since we need to recieve the message from the caller
  ReceivePort receivePortTogetMessage = ReceivePort();
  // we are sending my recievePort's send port for them through my SendPort(recieved as argument and i can send the messages out through this port only)
  //the purpose is to tell them that,here is my my port,send me the message to this port which i can access from my RP
  sendPortToSendReply.send(receivePortTogetMessage.sendPort);
//since RP is implimenting Streams,we can use any stream function on RP
  final messages = await receivePortTogetMessage
      .takeWhile((element) => element is String)
      .cast<String>();
  await for (final msg in messages) {
    for (final entry in messagesAndResponse.entries) {
      if (entry.key.trim().toLowerCase() == msg.trim().toLowerCase()) {
        sendPortToSendReply.send(entry.value);
        continue;
      }
    }
    sendPortToSendReply.send("OOPS...I couldnt understand");
  }
}

const Map<String, String> messagesAndResponse = {
  "": "Ask me a question like How are you",
  "hello": "hi",
  "how are you": "fine",
  "what are you doing": "I am a computer",
  "Are you enjoying life": "Yes,definitely"
};


/*
consider like this..

GetMessage Method:
I will give U my send port..Here is it..send your message to this SP...
I will recieve it in my Recieve port
I will be listening
_communicator:
Ok..I will also make a recievePort and send you my sendPort...
U will get it in first message..save it and keep it with you or
Send message to this port..I will keep listening..

*/

