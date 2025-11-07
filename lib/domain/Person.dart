
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

  void displayInfo() {
    print('--- Person Information ---');
    print('ID: $id');
    print('Name: $name');
    print('Age: $age');
    print('Gender: $gender');
    print('Email: $email');
    print('Phone: $phoneNumber');
    print('Address: $address');
  }
}
