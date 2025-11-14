import 'Person.dart';
import 'Role.dart';

class Staff extends Person {
  double salary;
  Role role;

  Staff({
    required super.id,
    required super.name,
    required super.age,
    required super.gender,
    required super.email,
    required super.phoneNumber,
    required super.address,
    required this.salary,
    required this.role,
  });

  double getSalary() {
    return salary;
  }

  void setSalary(double newSalary) {
    if (newSalary >= 0) {
      salary = newSalary;
    } else {
      throw ArgumentError('Salary cannot be negative');
    }
  }

  String getRole() {
    return role.title;
  }

  void performTask() {
    print('$name is performing task as ${role.title}');
  }

  @override
  String displayInfo() {
    final buffer = StringBuffer();
    buffer.writeln(super.displayInfo());
    buffer.writeln('Salary: \$${salary.toStringAsFixed(2)}');
    buffer.writeln('Role: ${role.title}');
    buffer.writeln('Role Description: ${role.description}');
    return buffer.toString();
  }

  @override
  String toString() => displayInfo();
}
