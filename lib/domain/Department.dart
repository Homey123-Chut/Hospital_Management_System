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
    print('Staff ${staff.name} added to $departmentName department');
  }

  void listStaff() {
    print('\n=== Staff List for $departmentName Department ===');
    if (staffList.isEmpty) {
      print('No staff members in this department');
    } else {
      for (int i = 0; i < staffList.length; i++) {
        print('\n${i + 1}. --- Staff Member ${i + 1} ---');
        print('   ID: ${staffList[i].id}');
        print('   Name: ${staffList[i].name}');
        print('   Age: ${staffList[i].age}');
        print('   Gender: ${staffList[i].gender}');
        print('   Email: ${staffList[i].email}');
        print('   Phone: ${staffList[i].phoneNumber}');
        print('   Address: ${staffList[i].address}');
        print('   Role: ${staffList[i].getRole()}');
        print('   Role Description: ${staffList[i].role.description}');
        print('   Salary: \$${staffList[i].salary.toStringAsFixed(2)}');
      }
    }
    print('\nTotal Staff in $departmentName: ${staffList.length}\n');
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
