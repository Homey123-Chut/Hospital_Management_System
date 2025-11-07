/// Class representing a role within a department
class Role {
  int roleId;
  String title;
  String description;
  dynamic department; // Associated department (using dynamic to avoid circular dependency)

  Role({
    required this.roleId,
    required this.title,
    required this.description,
    this.department,
  });

  /// Display role information
  void displayRoleInfo() {
    print('Role: $title');
    print('Description: $description');
    if (department != null) {
      print('Department: ${department.departmentName}');
    }
  }
}
