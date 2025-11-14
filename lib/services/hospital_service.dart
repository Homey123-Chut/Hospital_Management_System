import '../domain/Department.dart';
import '../domain/Hospital.dart';
import '../domain/Role.dart';
import '../domain/Staff.dart';

class HospitalService {

  Hospital createDemoHospital() {
    Hospital centralHospital = Hospital(
      hospitalName: 'Central City Hospital',
      hospitalAddress: '123 Medical Avenue, City Center',
    );

    Department administrativeDept = Department(
      departmentId: 1,
      departmentName: 'Administrative',
    );

    Department pharmacyDept = Department(
      departmentId: 2,
      departmentName: 'Pharmacy',
    );

    Department surgeryDept = Department(
      departmentId: 3,
      departmentName: 'Surgery',
    );

    Department maternityDept = Department(
      departmentId: 4,
      departmentName: 'Maternity',
    );

    Department emergencyDept = Department(
      departmentId: 5,
      departmentName: 'Emergency',
    );

    centralHospital.addDepartment(administrativeDept);
    centralHospital.addDepartment(pharmacyDept);
    centralHospital.addDepartment(surgeryDept);
    centralHospital.addDepartment(maternityDept);
    centralHospital.addDepartment(emergencyDept);

    // Roles
    Role adminRole = Role(
      roleId: 1,
      title: 'Administrator',
      description: 'Manage hospital operations',
      department: administrativeDept,
    );

    Role pharmacistRole = Role(
      roleId: 2,
      title: 'Pharmacist',
      description: 'Dispense medications and provide pharmaceutical care',
      department: pharmacyDept,
    );

    Role surgeonRole = Role(
      roleId: 3,
      title: 'Surgeon',
      description: 'Perform surgical procedures',
      department: surgeryDept,
    );

    Role obstetricsRole = Role(
      roleId: 4,
      title: 'Obstetrician',
      description: 'Provide maternity and childbirth care',
      department: maternityDept,
    );

    Role emergencyDoctorRole = Role(
      roleId: 5,
      title: 'Emergency Doctor',
      description: 'Provide emergency medical care',
      department: emergencyDept,
    );

    // Staff
    Staff admin1 = Staff(
      id: 101,
      name: 'Sarah Johnson',
      age: 38,
      gender: 'Female',
      email: 'sarah.johnson@hospital.com',
      phoneNumber: '+1-555-0101',
      address: '456 Oak Street',
      salary: 85000.0,
      role: adminRole,
    );

    Staff pharmacist1 = Staff(
      id: 201,
      name: 'Dr. Michael Chen',
      age: 42,
      gender: 'Male',
      email: 'michael.chen@hospital.com',
      phoneNumber: '+1-555-0102',
      address: '789 Pine Avenue',
      salary: 95000.0,
      role: pharmacistRole,
    );

    Staff surgeon1 = Staff(
      id: 301,
      name: 'Dr. Emily Rodriguez',
      age: 45,
      gender: 'Female',
      email: 'emily.rodriguez@hospital.com',
      phoneNumber: '+1-555-0201',
      address: '321 Elm Street',
      salary: 150000.0,
      role: surgeonRole,
    );

    Staff obstetrician1 = Staff(
      id: 401,
      name: 'Dr. Jessica Williams',
      age: 39,
      gender: 'Female',
      email: 'jessica.williams@hospital.com',
      phoneNumber: '+1-555-0301',
      address: '654 Maple Drive',
      salary: 140000.0,
      role: obstetricsRole,
    );

    Staff emergencyDoc1 = Staff(
      id: 501,
      name: 'Dr. David Brown',
      age: 37,
      gender: 'Male',
      email: 'david.brown@hospital.com',
      phoneNumber: '+1-555-0302',
      address: '987 Cedar Lane',
      salary: 130000.0,
      role: emergencyDoctorRole,
    );

    administrativeDept.addStaff(admin1);
    pharmacyDept.addStaff(pharmacist1);
    surgeryDept.addStaff(surgeon1);
    maternityDept.addStaff(obstetrician1);
    emergencyDept.addStaff(emergencyDoc1);

    return centralHospital;
  }

  Map<String, dynamic>? findStaffById(Hospital hospital, int id) {
    for (var dept in hospital.departments) {
      var s = dept.findStaffById(id);
      if (s != null) {
        return {'staff': s, 'department': dept.departmentName};
      }
    }
    return null;
  }

  List<Map<String, dynamic>> findStaffByName(Hospital hospital, String nameSubstr) {
    List<Map<String, dynamic>> results = [];
    final q = nameSubstr.toLowerCase();
    for (var dept in hospital.departments) {
      for (var s in dept.staffList) {
        if (s.name.toLowerCase().contains(q)) {
          results.add({'staff': s, 'department': dept.departmentName});
        }
      }
    }
    return results;
  }

  List<Map<String, dynamic>> findStaffByRole(Hospital hospital, String roleSubstr) {
    List<Map<String, dynamic>> results = [];
    final q = roleSubstr.toLowerCase();
    for (var dept in hospital.departments) {
      for (var s in dept.staffList) {
        if (s.role.title.toLowerCase().contains(q)) {
          results.add({'staff': s, 'department': dept.departmentName});
        }
      }
    }
    return results;
  }
}
