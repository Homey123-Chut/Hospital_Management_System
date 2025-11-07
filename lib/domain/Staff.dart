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
      print('Salary updated to: \$${newSalary.toStringAsFixed(2)}');
    } else {
      print('Error: Salary cannot be negative');
    }
  }

  /// Get the staff member's role title
  String getRole() {
    return role.title;
  }

  /// Perform a task based on the staff member's role
  void performTask() {
    print('$name is performing task as ${role.title}');
  }

  @override
  void displayInfo() {
    super.displayInfo();
    print('Salary: \$${salary.toStringAsFixed(2)}');
    print('Role: ${role.title}');
    print('Role Description: ${role.description}');
  }
}
