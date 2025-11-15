
import 'package:cliniq_core/models/History.dart';
import 'package:cliniq_core/models/equipement_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

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

  void addEquipement(Equipement equipe)async{
    await ref.child(equipe.id).set(equipe.toJson());
  }
  void moveEquipement(Equipement e,String id){
    //later
  }
  void sentToMaintenence(){
    //later
  }

}