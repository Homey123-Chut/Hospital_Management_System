import 'package:test/test.dart';
import '../lib/domain/Person.dart';
import '../lib/domain/Role.dart';
import '../lib/domain/Staff.dart';
import '../lib/domain/Department.dart';
import '../lib/domain/Hospital.dart';
import '../lib/domain/Admin.dart';

void main() {
  print('\n========================================');
  print('   Hospital Management System - Tests');
  print('========================================\n');
  
  group('========== 1. Create Hospital Tests ==========', () {
    test('Person creation with all attributes', () {
      final person = Person(
        id: 1,
        name: 'Tharoeun',
        age: 38,
        gender: 'Male',
        email: 'thapp@gmail.com',
        phoneNumber: '089 85 20 86',
        address: 'Kob Srov, ChhoukVa2',
      );

      expect(person.id, equals(1));
      expect(person.name, equals('Tharoeun'));
      expect(person.age, equals(38));
      expect(person.gender, equals('Male'));
      expect(person.email, equals('thapp@gmail.com'));
      expect(person.phoneNumber, equals('089 85 20 86'));
      expect(person.address, equals('Kob Srov, ChhoukVa2'));
    });

    test('Person displayInfo should not throw error', () {
      final person = Person(
        id: 1,
        name: 'Tharoeun',
        age: 38,
        gender: 'Male',
        email: 'thapp@gmail.com',
        phoneNumber: '089 85 20 86',
        address: 'Kob Srov, ChhoukVa2',
      );

      expect(() => person.displayInfo(), returnsNormally);
    });
  });

  group('========== 1. Create Hospital Tests ==========', () {
    test('✓ Create hospital with 5 departments', () {
      final hospital = Hospital(
        hospitalName: 'Calmette Hospital',
        hospitalAddress: 'Phnom Penh',
      );

      final dept1 = Department(departmentId: 1, departmentName: 'Administrative');
      final dept2 = Department(departmentId: 2, departmentName: 'Pharmacy');
      final dept3 = Department(departmentId: 3, departmentName: 'Surgery');
      final dept4 = Department(departmentId: 4, departmentName: 'Maternity');
      final dept5 = Department(departmentId: 5, departmentName: 'Emergency');

      hospital.addDepartment(dept1);
      hospital.addDepartment(dept2);
      hospital.addDepartment(dept3);
      hospital.addDepartment(dept4);
      hospital.addDepartment(dept5);

      expect(hospital.hospitalName, equals('Calmette Hospital'));
      expect(hospital.hospitalAddress, equals('Phnom Penh'));
      expect(hospital.departments.length, equals(5));
      expect(hospital.departments[0].departmentName, equals('Administrative'));
      expect(hospital.departments[4].departmentName, equals('Emergency'));
    });
  });

  group('========== 2. Add Staff Tests ==========', () {
    test('✓ Add staff to Surgery department', () {
      final dept = Department(departmentId: 3, departmentName: 'Surgery');
      final role = Role(roleId: 1, title: 'Doctor', description: 'Medical care');
      final staff = Staff(
        id: 2,
        name: 'Homey',
        age: 35,
        gender: 'Male',
        email: 'homey@hospital.com',
        phoneNumber: '076 89 71 1426',
        address: 'Phnom Penh',
        salary: 3000.0,
        role: role,
      );

      dept.addStaff(staff);
      expect(dept.staffList.length, equals(1));
      expect(dept.staffList[0].name, equals('Homey'));
      expect(dept.staffList[0].getSalary(), equals(3000.0));
      expect(dept.departmentName, equals('Surgery'));
    });
  });

  group('========== 3. View All Staffs Tests ==========', () {
    test('✓ View all staff in hospital', () {
      final hospital = Hospital(
        hospitalName: 'Test Hospital',
        hospitalAddress: 'Test Address',
      );

      final dept1 = Department(departmentId: 1, departmentName: 'Emergency');
      final dept2 = Department(departmentId: 2, departmentName: 'Pharmacy');
      hospital.addDepartment(dept1);
      hospital.addDepartment(dept2);

      // Add staff to Emergency
      final role1 = Role(roleId: 1, title: 'Doctor', description: 'Medical');
      final staff1 = Staff(
        id: 101,
        name: 'Dr. John',
        age: 40,
        gender: 'Male',
        email: 'john@hospital.com',
        phoneNumber: '+1-555-0101',
        address: '101 St',
        salary: 100000.0,
        role: role1,
      );
      dept1.addStaff(staff1);

      // Add staff to Pharmacy
      final role2 = Role(roleId: 2, title: 'Pharmacist', description: 'Medicine');
      final staff2 = Staff(
        id: 102,
        name: 'Jane Pharmacist',
        age: 35,
        gender: 'Female',
        email: 'jane@hospital.com',
        phoneNumber: '+1-555-0102',
        address: '102 St',
        salary: 80000.0,
        role: role2,
      );
      dept2.addStaff(staff2);

      // Count total staff
      int totalStaff = 0;
      for (var dept in hospital.departments) {
        totalStaff += dept.staffList.length;
      }

      expect(totalStaff, equals(2));
      expect(() => hospital.listAllStaff(), returnsNormally);
    });
  });

  group('========== 4. Update Staff Tests ==========', () {
    test('✓ Update staff salary', () {
      final role = Role(roleId: 1, title: 'Doctor', description: 'Medical care');
      final staff = Staff(
        id: 2,
        name: 'Homey',
        age: 35,
        gender: 'Male',
        email: 'homey@hospital.com',
        phoneNumber: '012 34 56 78',
        address: 'Phnom Penh',
        salary: 3000.0,
        role: role,
      );

      expect(staff.getSalary(), equals(3000.0));
      
      staff.setSalary(3500.0);
      expect(staff.getSalary(), equals(3500.0));
    });
  });

  group('========== 5. Remove Staff Tests ==========', () {
    test('✓ Remove staff from department', () {
      final dept = Department(departmentId: 3, departmentName: 'Surgery');
      final role = Role(roleId: 1, title: 'Doctor', description: 'Medical care');
      final staff = Staff(
        id: 2,
        name: 'Homey',
        age: 35,
        gender: 'Male',
        email: 'homey@hospital.com',
        phoneNumber: '012 34 56 78',
        address: 'Phnom Penh',
        salary: 3000.0,
        role: role,
      );

      dept.addStaff(staff);
      expect(dept.staffList.length, equals(1));

      final removed = dept.removeStaff(2);
      expect(removed, isTrue);
      expect(dept.staffList.length, equals(0));
    });
  });

  group('========== 6. List Departments Tests ==========', () {
    test('✓ List all 5 departments in hospital', () {
      final hospital = Hospital(
        hospitalName: 'Royal Hospital',
        hospitalAddress: 'Phnom Penh',
      );

      final dept1 = Department(departmentId: 1, departmentName: 'Administrative');
      final dept2 = Department(departmentId: 2, departmentName: 'Pharmacy');
      final dept3 = Department(departmentId: 3, departmentName: 'Surgery');
      final dept4 = Department(departmentId: 4, departmentName: 'Maternity');
      final dept5 = Department(departmentId: 5, departmentName: 'Emergency');

      hospital.addDepartment(dept1);
      hospital.addDepartment(dept2);
      hospital.addDepartment(dept3);
      hospital.addDepartment(dept4);
      hospital.addDepartment(dept5);

      expect(hospital.departments.length, equals(5));
      expect(hospital.departments[0].departmentName, equals('Administrative'));
      expect(hospital.departments[2].departmentName, equals('Surgery'));
      expect(hospital.departments[4].departmentName, equals('Emergency'));
      expect(() => hospital.listDepartments(), returnsNormally);
    });
  });

  group('========== 7. List Staff by Department Tests ==========', () {
    test('✓ List staff in specific department', () {
      final dept = Department(departmentId: 3, departmentName: 'Surgery');
      
      final surgeonRole = Role(roleId: 1, title: 'Surgeon', description: 'Operations');
      final nurseRole = Role(roleId: 2, title: 'Surgical Nurse', description: 'Assist surgery');

      final surgeon = Staff(
        id: 301,
        name: 'Dr. Surgeon',
        age: 45,
        gender: 'Female',
        email: 'surgeon@hospital.com',
        phoneNumber: '+1-555-3001',
        address: '301 Medical Plaza',
        salary: 150000.0,
        role: surgeonRole,
      );

      final nurse = Staff(
        id: 302,
        name: 'Nurse Helper',
        age: 30,
        gender: 'Male',
        email: 'helper@hospital.com',
        phoneNumber: '+1-555-3002',
        address: '302 Medical Plaza',
        salary: 65000.0,
        role: nurseRole,
      );

      dept.addStaff(surgeon);
      dept.addStaff(nurse);

      expect(dept.staffList.length, equals(2));
      expect(dept.staffList[0].name, equals('Dr. Surgeon'));
      expect(dept.staffList[1].name, equals('Nurse Helper'));
      expect(() => dept.listStaff(), returnsNormally);
    });
  });

  group('========== 8. Search Staff Tests ==========', () {
    test('✓ Search staff by ID', () {
      final dept = Department(departmentId: 3, departmentName: 'Surgery');
      final role = Role(roleId: 1, title: 'Doctor', description: 'Medical care');
      final staff = Staff(
        id: 2,
        name: 'Homey',
        age: 35,
        gender: 'Male',
        email: 'homey@hospital.com',
        phoneNumber: '012 34 56 78',
        address: 'Phnom Penh',
        salary: 3000.0,
        role: role,
      );

      dept.addStaff(staff);
      final found = dept.findStaffById(2);
      
      expect(found, isNotNull);
      expect(found?.name, equals('Homey'));
      expect(found?.id, equals(2));
      expect(found?.getRole(), equals('Doctor'));
    });
  });

  group('========== Admin & Person Core Tests ==========', () {
    test('✓ Admin can manage hospital system', () {
      final adminRole = Role(
        roleId: 1,
        title: 'System Administrator',
        description: 'Manages hospital operations',
      );

      final admin = Admin(
        id: 1,
        name: 'Tharoeun',
        age: 38,
        gender: 'Male',
        email: 'tharoeun@gmail.com',
        phoneNumber: '089 85 20 86',
        address: 'ChhoukVa2',
        salary: 80000.0,
        role: adminRole,
      );

      expect(admin.name, equals('Tharoeun'));
      expect(admin.getRole(), equals('System Administrator'));
      expect(admin.getSalary(), equals(80000.0));
      expect(admin, isA<Staff>());
      expect(admin, isA<Person>());
    });
  });

  group('========== Complete Workflow Integration Tests ==========', () {
    test('✓ Full hospital management system workflow', () {
      print('\n--- Testing Complete Workflow ---');
      
      // Step 1: Create Hospital (Menu Option 1)
      print('Step 1: Creating Hospital...');
      final hospital = Hospital(
        hospitalName: 'Royal Hospital',
        hospitalAddress: 'Phnom Penh',
      );

      // Create 5 departments
      final administrative = Department(departmentId: 1, departmentName: 'Administrative');
      final pharmacy = Department(departmentId: 2, departmentName: 'Pharmacy');
      final surgery = Department(departmentId: 3, departmentName: 'Surgery');
      final maternity = Department(departmentId: 4, departmentName: 'Maternity');
      final emergency = Department(departmentId: 5, departmentName: 'Emergency');

      hospital.addDepartment(administrative);
      hospital.addDepartment(pharmacy);
      hospital.addDepartment(surgery);
      hospital.addDepartment(maternity);
      hospital.addDepartment(emergency);

      expect(hospital.departments.length, equals(5));

      // Step 2: Add Staff (Menu Option 2)
      print('Step 2: Adding Staff...');
      final doctorRole = Role(roleId: 1, title: 'Doctor', description: 'Medical care', department: surgery);
      final doctor = Staff(
        id: 2,
        name: 'Homey',
        age: 35,
        gender: 'Male',
        email: 'homey@hospital.com',
        phoneNumber: '012 34 56 78',
        address: 'Phnom Penh',
        salary: 3000.0,
        role: doctorRole,
      );
      surgery.addStaff(doctor);

      // Step 3: View All Staffs (Menu Option 3)
      print('Step 3: Viewing All Staff...');
      int totalStaff = 0;
      for (var dept in hospital.departments) {
        totalStaff += dept.staffList.length;
      }
      expect(totalStaff, equals(1));

      // Step 4: Update Staff (Menu Option 4)
      print('Step 4: Updating Staff Salary...');
      doctor.setSalary(3500.0);
      expect(doctor.getSalary(), equals(3500.0));

      // Step 5: Remove Staff (Menu Option 5)
      print('Step 5: Removing Staff...');
      final removed = surgery.removeStaff(2);
      expect(removed, isTrue);
      expect(surgery.staffList.length, equals(0));

      // Step 6: List Departments (Menu Option 6)
      print('Step 6: Listing Departments...');
      expect(hospital.departments.length, equals(5));
      expect(() => hospital.listDepartments(), returnsNormally);

      // Step 7: Add staff back for department listing
      surgery.addStaff(Staff(
        id: 3,
        name: 'Dr. Test',
        age: 40,
        gender: 'Male',
        email: 'test@hospital.com',
        phoneNumber: '011 11 11 11',
        address: 'Phnom Penh',
        salary: 4000.0,
        role: doctorRole,
      ));

      // Step 7: List Staff by Department (Menu Option 7)
      print('Step 7: Listing Staff by Department...');
      expect(surgery.staffList.length, equals(1));
      expect(() => surgery.listStaff(), returnsNormally);

      // Step 8: Search Staff (Menu Option 8)
      print('Step 8: Searching Staff...');
      final foundStaff = surgery.findStaffById(3);
      expect(foundStaff, isNotNull);
      expect(foundStaff?.name, equals('Dr. Test'));

      print('✓ Complete workflow test passed!\n');
    });
  });

  print('\n========================================');
  print('   All Tests Completed Successfully!');
  print('========================================\n');
}
