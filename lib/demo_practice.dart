/// abstract Class example
abstract class Vehicle {
  void start();

  void stop();
}

class Bike extends Vehicle {
  @override
  void start() {
    print("bike Start");
  }

  @override
  void stop() {
    print("bike Stop");
  }
}

class Car extends Vehicle {
  @override
  void start() {
    print("car Start");
  }

  @override
  void stop() {
    print("car Stop");
  }
}

/// contructor
class User {
  String? name;
  int? id;

  User({this.name, this.id});
}

/// mixin
mixin Musical {
  void play() {
    print('Playing music');
  }
}

class Instrument {
  void playing() {
    print('Playing music');
  }
// Class definition
}

class Guitar extends Instrument with Musical {
  // Now Guitar has the play method
}

class A {
  void showA() {
    print("A");
  }
}

class B {
  void showB() {
    print("B");
  }
}

// Class C implements interfaces A and B
class C implements A, B {
  @override
  void showA() {
    print("A from C");
  }

  @override
  void showB() {
    print("B from C");
  }
}

void main() {
  C c = C();
  c.showA();
  c.showB();

  Guitar guitar = Guitar();
  guitar.play();

  User user = User(name: 'dharmik', id: 22);
  print("name: ${user.name}");
  print("id: ${user.id}");

  Car car = Car();
  car.start();
  car.stop();

  Bike bike = Bike();
  bike.start();
  bike.stop();
}
