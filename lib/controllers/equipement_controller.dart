
import 'package:cliniq_core/models/History.dart';
import 'package:cliniq_core/models/equipement_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class EquipementController extends GetxController{
  var equipements=<Equipement>[].obs;
  final DatabaseReference ref=FirebaseDatabase.instance.ref("equipement");
  @override
  void onInit(){
    super.onInit();
    fetchEquipement();
  }
  void fetchEquipement() {
    ref.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        equipements.value = data.entries.map((e) {
          final equipementMap = Map<String, dynamic>.from(e.value);

          // Convert history list from Map → EquipmentHistory object
          final historyList = (equipementMap["history"] as List? ?? [])
              .map((x) => History.fromJson(
            Map<String, dynamic>.from(x),
          ))
              .toList();

          return Equipement(
            id: equipementMap["id"],
            name: equipementMap["name"],
            status: equipementMap["status"] ?? "available",
            currentLocation: equipementMap["currentLocation"] ?? "",
            history: historyList,
          );
        }).toList();
      }
    });
  }
  void addEquipement({
    required String name,
    required String status,
    required String roomNumber,
    required String roomtype
  }) async {
    final id = Uuid().v4(); // generate unique id for equipment
    final Equipement equipe = Equipement(
      id: id,
      name: name,
      status: status,
      currentLocation: roomNumber+roomtype,
    );

    await ref.child(equipe.id).set(equipe.toJson());
    Get.snackbar("Success", "Equipment added successfully",
        snackPosition: SnackPosition.BOTTOM);
  }

  void removeEquipment(Equipement equip) async {
    final index = equipements.indexWhere((r) => r.id == equip.id);
    if (index != -1) {
      // Check if equipment can be deleted
      if (equip.currentLocation.isNotEmpty) {
        // Equipment is assigned somewhere
        Get.snackbar(
          "Cannot delete",
          "Equipment is currently assigned to a room",
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      await deleteEquipment(index);
    }
  }

  Future<void> deleteEquipment(int index) async {
    final equipment = equipements[index];
    try {
      await ref.child(equipment.id).remove();
      equipements.removeAt(index);
      Get.snackbar("Deleted", "Equipment deleted successfully",
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", "Failed to delete equipment: $e",
          snackPosition: SnackPosition.BOTTOM);
    }
  }


  void moveEquipement(Equipement e,String id){
    //later
  }
  void sentToMaintenence(){
    //later
  }

}