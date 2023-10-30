//creating abstract class and making multiple classes

abstract class MyEvent {
  //the parameter name must match the constructor argument
  //factory MyEvent.initialise({required String differentName}) = InitialiseEvent; doesnt work
  factory MyEvent.initialise({required String name}) = InitialiseEvent;
  factory MyEvent.fetchUserData({required String uid}) = FetchTheUserDetails;
//for this named constructor in the main class arguments need not to be matched since we are not assigning
//but we are calling the constructor
  factory MyEvent.initialiseUsingNamedConstructor(
          {required String differntName}) =>
      InitialiseEvent.startIntialising(name: differntName);
  void logTheData();
}

//make classess that impliments the abstract class with constructor

class InitialiseEvent implements MyEvent {
  final String name;
  InitialiseEvent({required this.name});
  String toString() {
    return '{My name is $name}';
  }

  factory InitialiseEvent.startIntialising({required String name}) =>
      InitialiseEvent(name: name);

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
  doSomething(InitialiseEvent(name: "Ishaque is the name "));
  doSomething(FetchTheUserDetails(uid: "UserID is ish-uid"));
  doSomething(InitialiseEvent.startIntialising(
      name: "Used Named Factory Constructor for abstract class"));
}
