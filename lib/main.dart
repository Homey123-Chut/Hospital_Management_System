import 'dart:io';
import 'domain/Role.dart';
import 'domain/Staff.dart';
import 'domain/Department.dart';
import 'domain/Hospital.dart';
import 'domain/Admin.dart';

// Pre-defined roles for each department
Map<String, List<String>> departmentRoles = {
  'Administrative': ['Administrator', 'Receptionist', 'HR Manager', 'Accountant'],
  'Pharmacy': ['Pharmacist', 'Pharmacy Technician', 'Pharmacy Assistant'],
  'Surgery': ['Surgeon', 'Surgical Nurse', 'Anesthesiologist', 'Surgical Technician'],
  'Maternity': ['Obstetrician', 'Midwife', 'Maternity Nurse', 'Gynecologist'],
  'Emergency': ['Emergency Doctor', 'ER Nurse', 'Paramedic', 'Emergency Technician'],
};

void main() async {
  print('========================================');
  print('   Hospital Management System');
  print('========================================\n');

  // Create admin role
  Role adminRole = Role(
    roleId: 001,
    title: 'System Administrator',
    description: 'Manages hospital operations and staff',
  );

  // Create an admin user
  Admin admin = Admin(
    id: 1,
    name: 'Homey',
    age: 38,
    gender: 'Male',
    email: 'tharoeun@gmail.com',
    phoneNumber: '089 85 20 86',
    address: 'ChhoukVa2',
    salary: 80000.0,
    role: adminRole,
  );

  print('Welcome, ${admin.name}!\n');

  // Main menu loop
  bool running = true;
  while (running) {
    print('\n========== Main Menu ==========');
    print('1. Create Hospital');
    print('2. Add Staff');
    print('3. View All Staffs');
    print('4. Update Staff');
    print('5. Remove Staff');
    print('6. List Departments');
    print('7. List Staff by Department');
    print('8. Search Staff');
    print('0. Exit');
    print('================================');
    stdout.write('Select an option: ');

    String? input = stdin.readLineSync();
    int? choice = int.tryParse(input ?? '');

    print(''); // Add blank line for readability

    switch (choice) {
      case 1:
        createHospitalWithDepartments(admin);
        break;
      case 2:
        addStaffWithRoleChoice(admin);
        break;
      case 3:
        admin.viewStaff();
        break;
      case 4:
        admin.updateStaff();
        break;
      case 5:
        admin.removeStaff();
        break;
      case 6:
        if (admin.currentHospital != null) {
          admin.currentHospital!.listDepartments();
        } else {
          print('Error: No hospital available. Create a hospital first.');
        }
        break;
      case 7:
        if (admin.currentHospital != null) {
          if (admin.currentHospital!.departments.isEmpty) {
            print('No departments available.');
          } else {
            print('Select a department:');
            for (int i = 0; i < admin.currentHospital!.departments.length; i++) {
              print('${i + 1}. ${admin.currentHospital!.departments[i].departmentName}');
            }
            stdout.write('Enter department number: ');
            int? deptNum = int.tryParse(stdin.readLineSync() ?? '');
            if (deptNum != null && deptNum > 0 && deptNum <= admin.currentHospital!.departments.length) {
              admin.currentHospital!.departments[deptNum - 1].listStaff();
            } else {
              print('Invalid department number');
            }
          }
        } else {
          print('Error: No hospital available.');
        }
        break;
      case 8:
        searchStaffByRole(admin);
        break;
      case 0:
        print('Thank you for using the Hospital Management System!');
        print('Goodbye!');
        running = false;
        break;
      default:
        print('Invalid option. Please try again.');
    }
  }
}

// Search staff by ID, name, or role
void searchStaffByRole(Admin admin) {
  if (admin.currentHospital == null) {
    print('Error: No hospital available. Create a hospital first.');
    return;
  }

  if (admin.currentHospital!.departments.isEmpty) {
    print('Error: No departments available.');
    return;
  }

  print('\n========== Search Staff ==========');
  print('Select search type:');
  print('1. Search by Staff ID');
  print('2. Search by Staff Name');
  print('3. Search by Role');
  print('0. Cancel');
  stdout.write('Enter your choice: ');
  
  String? choiceInput = stdin.readLineSync();
  int? searchType = int.tryParse(choiceInput ?? '');
  
  if (searchType == null || searchType < 0 || searchType > 3) {
    print('Error: Invalid choice.');
    return;
  }
  
  if (searchType == 0) {
    print('Search cancelled.');
    return;
  }
  
  // Get search term based on type
  String searchPrompt = '';
  switch (searchType) {
    case 1:
      searchPrompt = 'Enter Staff ID: ';
      break;
    case 2:
      searchPrompt = 'Enter Staff Name: ';
      break;
    case 3:
      searchPrompt = 'Enter Role ';
      break;
  }
  
  stdout.write(searchPrompt);
  String? searchInput = stdin.readLineSync();
  
  if (searchInput == null || searchInput.trim().isEmpty) {
    print('Error: Search term cannot be empty.');
    return;
  }

  String searchTerm = searchInput.trim().toLowerCase();
  int? searchId = int.tryParse(searchInput.trim());
  
  // Search for staff based on selected type
  List<Map<String, dynamic>> matchingStaff = [];
  
  for (var dept in admin.currentHospital!.departments) {
    for (var staff in dept.staffList) {
      bool matches = false;
      
      switch (searchType) {
        case 1: // Search by ID
          if (searchId != null && staff.id == searchId) {
            matches = true;
          }
          break;
        case 2: // Search by Name
          if (staff.name.toLowerCase().contains(searchTerm)) {
            matches = true;
          }
          break;
        case 3: // Search by Role
          if (staff.role.title.toLowerCase().contains(searchTerm)) {
            matches = true;
          }
          break;
      }
      
      if (matches) {
        matchingStaff.add({
          'staff': staff,
          'department': dept.departmentName,
        });
      }
    }
  }
  
  // Display results
  if (matchingStaff.isEmpty) {
    print('\n❌ No staff found matching "$searchInput"');
  } else {
    print('\n========== Search Results: "$searchInput" ==========');
    print('Found ${matchingStaff.length} staff member(s):\n');
    
    int count = 1;
    for (var entry in matchingStaff) {
      Staff staff = entry['staff'];
      String department = entry['department'];
      
      print('${count}. --- Staff Member ${count} ---');
      print('   ID: ${staff.id}');
      print('   Name: ${staff.name}');
      print('   Age: ${staff.age}');
      print('   Gender: ${staff.gender}');
      print('   Email: ${staff.email}');
      print('   Phone: ${staff.phoneNumber}');
      print('   Address: ${staff.address}');
      print('   Role: ${staff.role.title}');
      print('   Role Description: ${staff.role.description}');
      print('   Department: $department');
      print('   Salary: \$${staff.getSalary().toStringAsFixed(2)}');
      print('');
      count++;
    }
    
    print('Total matching staff: ${matchingStaff.length}');
  }
}

// Create hospital with 5 pre-defined departments
void createHospitalWithDepartments(Admin admin) {
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
    admin.currentHospital = hospital;
    print('\nHospital "$name" created successfully!');
    
    // Create 5 pre-defined departments
    print('\nCreating 5 departments...');
    
    Department administrative = Department(
      departmentId: 1,
      departmentName: 'Administrative',
    );
    
    Department pharmacy = Department(
      departmentId: 2,
      departmentName: 'Pharmacy',
    );
    
    Department surgery = Department(
      departmentId: 3,
      departmentName: 'Surgery',
    );
    
    Department maternity = Department(
      departmentId: 4,
      departmentName: 'Maternity',
    );
    
    Department emergency = Department(
      departmentId: 5,
      departmentName: 'Emergency',
    );
    
    hospital.addDepartment(administrative);
    hospital.addDepartment(pharmacy);
    hospital.addDepartment(surgery);
    hospital.addDepartment(maternity);
    hospital.addDepartment(emergency);
    
    print('\nAll departments created successfully!');
  } else {
    print('Error: Invalid input');
  }
}

// Add staff with simplified process (no role selection)
void addStaffWithRoleChoice(Admin admin) {
  if (admin.currentHospital == null) {
    print('Error: No hospital selected. Create a hospital first.');
    return;
  }

  if (admin.currentHospital!.departments.isEmpty) {
    print('Error: No departments available. Create a hospital first.');
    return;
  }

  print('\n--- Add New Staff ---');
  
  // Display available departments
  print('Available Departments:');
  for (int i = 0; i < admin.currentHospital!.departments.length; i++) {
    print('${i + 1}. ${admin.currentHospital!.departments[i].departmentName}');
  }
  
  stdout.write('Select department (number): ');
  int? deptIndex = int.tryParse(stdin.readLineSync() ?? '');
  
  if (deptIndex == null || deptIndex < 1 || deptIndex > admin.currentHospital!.departments.length) {
    print('Error: Invalid department selection');
    return;
  }

  Department selectedDept = admin.currentHospital!.departments[deptIndex - 1];
  String deptName = selectedDept.departmentName;

  print('\nAdding staff to $deptName department...\n');

  // Get staff details
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
  stdout.write('Enter role/position: ');
  String? roleTitle = stdin.readLineSync();
  stdout.write('Enter salary: ');
  double? salary = double.tryParse(stdin.readLineSync() ?? '');

  if (id != null && name != null && age != null && gender != null && 
      email != null && phone != null && address != null && 
      roleTitle != null && roleTitle.isNotEmpty && salary != null) {
    
    Role role = Role(
      roleId: id,
      title: roleTitle,
      description: 'Works in $deptName department',
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
    print('\n✓ Staff member "$name" added successfully to $deptName department!');
  } else {
    print('Error: Invalid input. Please provide all required information.');
  }
}
