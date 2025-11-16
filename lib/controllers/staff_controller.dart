import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/staff_model.dart';

class StaffController extends GetxController {
  final DatabaseReference ref = FirebaseDatabase.instance.ref("staff");
  RxList<Staff> staffList = <Staff>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchStaff();
  }

  void fetchStaff() {
    ref.onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      staffList.clear();
      if (data != null) {
        data.forEach((key, value) {
          staffList.add(Staff.fromJson(Map<String, dynamic>.from(value)));
        });
      }
    });
  }

  Future<void> addStaff(Staff staff) async {
    await ref.child(staff.id).set(staff.toJson());
    Get.snackbar("Success", "Staff added successfully");
  }

  Future<void> deleteStaff(String id) async {
    await ref.child(id).remove();
    Get.snackbar("Deleted", "Staff removed successfully");
  }

  /// Assign Room Duty
  Future<void> assignDuty(String staffId, String roomName) async {
    await ref.child(staffId).update({
      "assignedRoom": roomName,
      "isAvailable": false,
    });
    Get.snackbar("Duty Assigned", "Room duty successfully assigned");
  }

  /// Mark staff available again
  Future<void> markAvailable(String staffId) async {
    await ref.child(staffId).update({"isAvailable": true});
  }
}
