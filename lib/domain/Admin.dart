import 'dart:io';
import 'Staff.dart';
import 'Hospital.dart';
import 'Department.dart';
import 'Role.dart';

class Admin extends Staff {
  Hospital? currentHospital;
  
  Admin({
    required super.id,
    required super.name,
    required super.age,
    required super.gender,
    required super.email,
    required super.phoneNumber,
    required super.address,
    required super.salary,
    required super.role,
    this.currentHospital,
  });

  Hospital createHospital() {
    print('\n--- Create New Hospital ---');
    stdout.write('Enter hospital name: ');
    String? name = stdin.readLineSync();
    stdout.write('Enter hospital address: ');
    String? address = stdin.readLineSync();

    if (name != null && name.isNotEmpty && address != null && address.isNotEmpty) {
      Hospital hospital = Hospital(
        hospitalName: name,
        hospitalAddress: address,
      );
      currentHospital = hospital;
      print('\nHospital "$name" created successfully!');
      return hospital;
    } else {
      print('Error: Invalid input');
      return createHospital();
    }
  }

  void createDepartment() {
    if (currentHospital == null) {
      print('Error: No hospital selected. Create or select a hospital first.');
      return;
    }

    print('\n--- Create New Department ---');
    stdout.write('Enter department ID: ');
    int? id = int.tryParse(stdin.readLineSync() ?? '');
    stdout.write('Enter department name: ');
    String? name = stdin.readLineSync();

    if (id != null && name != null && name.isNotEmpty) {
      Department dept = Department(
        departmentId: id,
        departmentName: name,
      );
      currentHospital!.addDepartment(dept);
      print('Department "$name" created successfully!');
    } else {
      print('Error: Invalid input');
    }
  }

  void addStaff() {
    if (currentHospital == null) {
      print('Error: No hospital selected.');
      return;
    }

    if (currentHospital!.departments.isEmpty) {
      print('Error: No departments available. Create a department first.');
      return;
    }

    print('\n--- Add New Staff ---');

    print('Available Departments:');
    for (int i = 0; i < currentHospital!.departments.length; i++) {
      print('${i + 1}. ${currentHospital!.departments[i].departmentName}');
    }
    
    stdout.write('Select department (number): ');
    int? deptIndex = int.tryParse(stdin.readLineSync() ?? '');
    
    if (deptIndex == null || deptIndex < 1 || deptIndex > currentHospital!.departments.length) {
      print('Error: Invalid department selection');
      return;
    }

    Department selectedDept = currentHospital!.departments[deptIndex - 1];

    stdout.write('Enter staff ID: ');
    int? id = int.tryParse(stdin.readLineSync() ?? '');
    stdout.write('Enter name: ');
    String? name = stdin.readLineSync();
    stdout.write('Enter age: ');
    int? age = int.tryParse(stdin.readLineSync() ?? '');
    stdout.write('Enter gender: ');
    String? gender = stdin.readLineSync();
    stdout.write('Enter email: ');
    String? email = stdin.readLineSync();
    stdout.write('Enter phone number: ');
    String? phone = stdin.readLineSync();
    stdout.write('Enter address: ');
    String? address = stdin.readLineSync();
    stdout.write('Enter salary: ');
    double? salary = double.tryParse(stdin.readLineSync() ?? '');
    stdout.write('Enter role title: ');
    String? roleTitle = stdin.readLineSync();
    stdout.write('Enter role description: ');
    String? roleDesc = stdin.readLineSync();

    if (id != null && name != null && age != null && gender != null && 
        email != null && phone != null && address != null && 
        salary != null && roleTitle != null && roleDesc != null) {
      
      Role role = Role(
        roleId: id,
        title: roleTitle,
        description: roleDesc,
        department: selectedDept,
      );

      Staff staff = Staff(
        id: id,
        name: name,
        age: age,
        gender: gender,
        email: email,
        phoneNumber: phone,
        address: address,
        salary: salary,
        role: role,
      );

      selectedDept.addStaff(staff);
      print('Staff member added successfully!');
    } else {
      print('Error: Invalid input');
    }
  }

  void viewStaff() {
    if (currentHospital == null) {
      print('Error: No hospital selected.');
      return;
    }

    currentHospital!.listAllStaff();
  }

  void updateStaff() {
    if (currentHospital == null) {
      print('Error: No hospital selected.');
      return;
    }

    print('\n--- Update Staff ---');
    stdout.write('Enter staff ID to update: ');
    int? staffId = int.tryParse(stdin.readLineSync() ?? '');

    if (staffId == null) {
      print('Error: Invalid staff ID');
      return;
    }

    Staff? staffToUpdate;
    
    for (var dept in currentHospital!.departments) {
      staffToUpdate = dept.findStaffById(staffId);
      if (staffToUpdate != null) {
        break;
      }
    }

    if (staffToUpdate == null) {
      print('Error: Staff member not found');
      return;
    }

    print('\nCurrent Information:');
    staffToUpdate.displayInfo();

    print('\nWhat would you want to update?');
    print('1. Name');
    print('2. Salary');
    print('3. Phone Number');
    print('4. Email');
    print('5. Address');
    stdout.write('Select option: ');
    
    int? option = int.tryParse(stdin.readLineSync() ?? '');

    switch (option) {
      case 1:
        stdout.write('Enter new name: ');
        String? newName = stdin.readLineSync();
        if (newName != null && newName.isNotEmpty) {
          staffToUpdate.name = newName;
          print('Name updated successfully!');
        }
        break;
      case 2:
        stdout.write('Enter new salary: ');
        double? newSalary = double.tryParse(stdin.readLineSync() ?? '');
        if (newSalary != null) {
          staffToUpdate.setSalary(newSalary);
        }
        break;
      case 3:
        stdout.write('Enter new phone number: ');
        String? newPhone = stdin.readLineSync();
        if (newPhone != null && newPhone.isNotEmpty) {
          staffToUpdate.phoneNumber = newPhone;
          print('Phone number updated successfully!');
        }
        break;
      case 4:
        stdout.write('Enter new email: ');
        String? newEmail = stdin.readLineSync();
        if (newEmail != null && newEmail.isNotEmpty) {
          staffToUpdate.email = newEmail;
          print('Email updated successfully!');
        }
        break;
      case 5:
        stdout.write('Enter new address: ');
        String? newAddress = stdin.readLineSync();
        if (newAddress != null && newAddress.isNotEmpty) {
          staffToUpdate.address = newAddress;
          print('Address updated successfully!');
        }
        break;
      default:
        print('Invalid option');
    }
  }

  void removeStaff() {
    if (currentHospital == null) {
      print('Error: No hospital selected.');
      return;
    }

    print('\n--- Remove Staff ---');
    stdout.write('Enter staff ID to remove: ');
    int? staffId = int.tryParse(stdin.readLineSync() ?? '');

    if (staffId == null) {
      print('Error: Invalid staff ID');
      return;
    }

    for (var dept in currentHospital!.departments) {
      if (dept.removeStaff(staffId)) {
        print('Staff member removed successfully!');
        return;
      }
    }

    print('Error: Staff member not found');
  }

  void deleteDepartment() {
    if (currentHospital == null) {
      print('Error: No hospital selected.');
      return;
    }

    if (currentHospital!.departments.isEmpty) {
      print('Error: No departments available.');
      return;
    }

    print('\n--- Delete Department ---');
    currentHospital!.listDepartments();
    
    stdout.write('Enter department ID to delete: ');
    int? deptId = int.tryParse(stdin.readLineSync() ?? '');

    if (deptId == null) {
      print('Error: Invalid department ID');
      return;
    }

    Department? dept = currentHospital!.findDepartmentById(deptId);
    if (dept == null) {
      print('Error: Department not found');
      return;
    }

    if (dept.staffList.isNotEmpty) {
      print('Warning: This department has ${dept.staffList.length} staff member(s).');
      stdout.write('Are you sure you want to delete? (yes/no): ');
      String? confirmation = stdin.readLineSync()?.toLowerCase();
      
      if (confirmation != 'yes') {
        print('Deletion cancelled');
        return;
      }
    }

    if (currentHospital!.removeDepartment(deptId)) {
      print('Department deleted successfully!');
    } else {
      print('Error: Failed to delete department');
    }
  }

  @override
  String displayInfo() {
    String baseInfo = super.displayInfo();
    String extra = 'Role: Administrator';
    if (currentHospital != null) {
      extra += '\nManaging Hospital: ${currentHospital!.hospitalName}';
    }
    
    print(extra);
    return '$baseInfo\n$extra';
  }
}
