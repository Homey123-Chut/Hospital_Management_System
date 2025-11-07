import '../domain/Role.dart';
import '../domain/Staff.dart';
import '../domain/Department.dart';
import '../domain/Hospital.dart';

void main() {
  print('========================================');
  print('   Hospital Management System Demo');
  print('========================================\n');

  // ============================================
  // 1. Create Hospital (with 5 departments)
  // ============================================
  print('--- Option 1: Create Hospital (with 5 departments) ---\n');
  
  Hospital centralHospital = Hospital(
    hospitalName: 'Central City Hospital',
    hospitalAddress: '123 Medical Avenue, City Center',
  );
  print('✓ Hospital created: ${centralHospital.hospitalName}\n');

  // Create 5 departments
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

  // Add departments to hospital
  centralHospital.addDepartment(administrativeDept);
  centralHospital.addDepartment(pharmacyDept);
  centralHospital.addDepartment(surgeryDept);
  centralHospital.addDepartment(maternityDept);
  centralHospital.addDepartment(emergencyDept);
  
  print('✓ 5 departments created successfully!\n');

  // ============================================
  // 2. Add Staff
  // ============================================
  print('--- Option 2: Add Staff ---\n');

  // Create roles
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

  // Create staff members
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

  // Add staff to departments
  administrativeDept.addStaff(admin1);
  pharmacyDept.addStaff(pharmacist1);
  surgeryDept.addStaff(surgeon1);
  maternityDept.addStaff(obstetrician1);
  emergencyDept.addStaff(emergencyDoc1);
  
  print('✓ 5 staff members added successfully!\n');

  // ============================================
  // 3. View All Staff
  // ============================================
  print('--- Option 3: View All Staff ---\n');
  centralHospital.listAllStaff();

  // ============================================
  // 4. View Staff by Department
  // ============================================
  print('\n--- Option 4: View Staff by Department ---\n');
  
  print('Department 1: Administrative');
  administrativeDept.listStaff();

  print('\nDepartment 2: Pharmacy');
  pharmacyDept.listStaff();

  print('\nDepartment 3: Surgery');
  surgeryDept.listStaff();

  print('\nDepartment 4: Maternity');
  maternityDept.listStaff();

  print('\nDepartment 5: Emergency');
  emergencyDept.listStaff();

  // ============================================
  // 5. Search Staff (by ID or Name)
  // ============================================
  print('\n--- Option 5: Search Staff (by ID or Name) ---\n');
  
  // Search by ID
  print('Search Example 1: Search by ID "301"');
  Staff? foundById = null;
  for (var dept in centralHospital.departments) {
    foundById = dept.findStaffById(301);
    if (foundById != null) {
      print('✓ Staff found:');
      foundById.displayInfo();
      break;
    }
  }

  // Search by Name
  print('\nSearch Example 2: Search by Name "Sarah"');
  for (var dept in centralHospital.departments) {
    for (var staff in dept.staffList) {
      if (staff.name.toLowerCase().contains('sarah')) {
        print('✓ Staff found:');
        staff.displayInfo();
      }
    }
  }

  // Search by Role
  print('\nSearch Example 3: Search by Role "Doctor"');
  print('All staff with "Doctor" in their role:');
  int count = 1;
  for (var dept in centralHospital.departments) {
    for (var staff in dept.staffList) {
      if (staff.role.title.toLowerCase().contains('doctor')) {
        print('${count}. ${staff.name} - ${staff.role.title} (Department: ${dept.departmentName})');
        count++;
      }
    }
  }

  print('\n========================================');
  print('   Demo Completed Successfully!');
  print('   All 5 menu options demonstrated');
  print('========================================');
}
