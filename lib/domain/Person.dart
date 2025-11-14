
class Person {
  int id;
  String name;
  int age;
  String gender;
  String email;
  String phoneNumber;
  String address;

  Person({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  String displayInfo() {
    final buffer = StringBuffer();
    buffer.writeln('--- Person Information ---');
    buffer.writeln('ID: $id');
    buffer.writeln('Name: $name');
    buffer.writeln('Age: $age');
    buffer.writeln('Gender: $gender');
    buffer.writeln('Email: $email');
    buffer.writeln('Phone: $phoneNumber');
    buffer.writeln('Address: $address');
    return buffer.toString();
  }

  @override
  String toString() => displayInfo();
}
