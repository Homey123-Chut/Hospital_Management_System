import 'Department.dart';

class Hospital {
  String hospitalName;
  String hospitalAddress;
  List<Department> departments;

  Hospital({
    required this.hospitalName,
    required this.hospitalAddress,
    List<Department>? departments,
  }) : departments = departments ?? [];

  void addDepartment(Department dept) {
    departments.add(dept);
  }

  String listDepartments() {
    final buffer = StringBuffer();
    buffer.writeln('\n========== Departments at $hospitalName ==========');
    if (departments.isEmpty) {
      buffer.writeln('No departments available');
    } else {
      for (int i = 0; i < departments.length; i++) {
        buffer.writeln('${i + 1}. ${departments[i].departmentName} (ID: ${departments[i].departmentId})');
        buffer.writeln('   Staff Count: ${departments[i].staffList.length}');
      }
    }
    buffer.writeln('Total Departments: ${departments.length}\n');
    return buffer.toString();
  }

  String listAllStaff() {
    final buffer = StringBuffer();
    buffer.writeln('\n========== All Staff at $hospitalName ==========');
    int totalStaff = 0;
    
    if (departments.isEmpty) {
      buffer.writeln('No departments available');
      return buffer.toString();
    }

    for (var dept in departments) {
      if (dept.staffList.isNotEmpty) {
        buffer.writeln('\n--- ${dept.departmentName} Department ---');
        for (var staff in dept.staffList) {
          buffer.writeln('• ${staff.name} - ${staff.getRole()} (ID: ${staff.id})');
          totalStaff++;
        }
      }
    }
    
    if (totalStaff == 0) {
      buffer.writeln('No staff members in the hospital');
    }
    buffer.writeln('\nTotal Staff: $totalStaff\n');
    return buffer.toString();
  }

  Department? findDepartmentById(int deptId) {
    try {
      return departments.firstWhere((dept) => dept.departmentId == deptId);
    } catch (e) {
      return null;
    }
  }

  bool removeDepartment(int deptId) {
    int initialLength = departments.length;
    departments.removeWhere((dept) => dept.departmentId == deptId);
    return departments.length < initialLength;
  }
}
