//creating abstract class and making multiple classes

abstract class MyEvent {
  //the parameter name must match the constructor argument
  //factory MyEvent.initialise({required String differentName}) = InitialiseEvent; doesnt work
  factory MyEvent.initialise({required String name}) = InitialiseEvent;
  factory MyEvent.fetchUserData({required String uid}) = FetchTheUserDetails;
  void logTheData();
}

//make classess that impliments the abstract class with constructor

class InitialiseEvent implements MyEvent {
  final String name;
  InitialiseEvent({required this.name});
  String toString() {
    return '{My name is $name}';
  }

  @override
  void logTheData() {
    print('$name');
  }
}

class FetchTheUserDetails implements MyEvent {
  final String uid;
  FetchTheUserDetails({required this.uid});
  @override
  String toString() {
    return '{My userId is $uid}';
  }

  @override
  void logTheData() {
    print('$uid');
  }
}

void doSomething(MyEvent event) {
  event.logTheData();
}

void main() {
  doSomething(InitialiseEvent(name: "Raju"));
  doSomething(FetchTheUserDetails(uid: "UserID"));
}
