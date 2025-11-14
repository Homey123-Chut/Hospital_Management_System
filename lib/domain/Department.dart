import 'Staff.dart';

class Department {
  int departmentId;
  String departmentName;
  List<Staff> staffList;

  Department({
    required this.departmentId,
    required this.departmentName,
    List<Staff>? staffList,
  }) : staffList = staffList ?? [];

  void addStaff(Staff staff) {
    staffList.add(staff);
  }

  String listStaff() {
    final buffer = StringBuffer();
    buffer.writeln('\n=== Staff List for $departmentName Department ===');
    if (staffList.isEmpty) {
      buffer.writeln('No staff members in this department');
    } else {
      for (int i = 0; i < staffList.length; i++) {
        final s = staffList[i];
        buffer.writeln('\n${i + 1}. --- Staff Member ${i + 1} ---');
        buffer.writeln('   ID: ${s.id}');
        buffer.writeln('   Name: ${s.name}');
        buffer.writeln('   Age: ${s.age}');
        buffer.writeln('   Gender: ${s.gender}');
        buffer.writeln('   Email: ${s.email}');
        buffer.writeln('   Phone: ${s.phoneNumber}');
        buffer.writeln('   Address: ${s.address}');
        buffer.writeln('   Role: ${s.getRole()}');
        buffer.writeln('   Role Description: ${s.role.description}');
        buffer.writeln('   Salary: \$${s.salary.toStringAsFixed(2)}');
      }
    }
    buffer.writeln('\nTotal Staff in $departmentName: ${staffList.length}\n');
    return buffer.toString();
  }

  bool removeStaff(int staffId) {
    int initialLength = staffList.length;
    staffList.removeWhere((staff) => staff.id == staffId);
    return staffList.length < initialLength;
  }

  Staff? findStaffById(int staffId) {
    try {
      return staffList.firstWhere((staff) => staff.id == staffId);
    } catch (e) {
      return null;
    }
  }
}
