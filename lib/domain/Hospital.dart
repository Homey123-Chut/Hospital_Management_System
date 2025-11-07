import 'Department.dart';

/// Class representing a hospital
class Hospital {
  String hospitalName;
  String hospitalAddress;
  List<Department> departments;

  Hospital({
    required this.hospitalName,
    required this.hospitalAddress,
    List<Department>? departments,
  }) : departments = departments ?? [];

  /// Add a department to the hospital
  void addDepartment(Department dept) {
    departments.add(dept);
    print('Department "${dept.departmentName}" added to $hospitalName');
  }

  /// List all departments in the hospital
  void listDepartments() {
    print('\n========== Departments at $hospitalName ==========');
    if (departments.isEmpty) {
      print('No departments available');
    } else {
      for (int i = 0; i < departments.length; i++) {
        print('${i + 1}. ${departments[i].departmentName} (ID: ${departments[i].departmentId})');
        print('   Staff Count: ${departments[i].staffList.length}');
      }
    }
    print('Total Departments: ${departments.length}\n');
  }

  /// List all staff across all departments
  void listAllStaff() {
    print('\n========== All Staff at $hospitalName ==========');
    int totalStaff = 0;
    
    if (departments.isEmpty) {
      print('No departments available');
      return;
    }

    for (var dept in departments) {
      if (dept.staffList.isNotEmpty) {
        print('\n--- ${dept.departmentName} Department ---');
        for (var staff in dept.staffList) {
          print('• ${staff.name} - ${staff.getRole()} (ID: ${staff.id})');
          totalStaff++;
        }
      }
    }
    
    if (totalStaff == 0) {
      print('No staff members in the hospital');
    }
    print('\nTotal Staff: $totalStaff\n');
  }

  /// Find a department by ID
  Department? findDepartmentById(int deptId) {
    try {
      return departments.firstWhere((dept) => dept.departmentId == deptId);
    } catch (e) {
      return null;
    }
  }

  /// Remove a department from the hospital
  bool removeDepartment(int deptId) {
    int initialLength = departments.length;
    departments.removeWhere((dept) => dept.departmentId == deptId);
    return departments.length < initialLength;
  }
}
