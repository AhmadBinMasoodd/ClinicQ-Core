
import 'package:cliniq_core/models/History.dart';
import 'package:get/get.dart';

class Equipement {
  final String id;
  final String name;
  final String status;
  final String currentLocation;
  List<History> history;
  RxBool isExpand=false.obs;
  Equipement({
    required this.id,
    required this.name,
    required this.status,
    required this.currentLocation,
    this.history=const []
  });

  // Convert Equipement → JSON for Firebase
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "status": status,
      "currentLocation":currentLocation,
      "history":history.map((e)=>e.toJson()).toList()
    };
  }

  factory Equipement.fromJson(Map<String, dynamic> json) {
    return Equipement(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      status: json["status"] ?? "In Use",
      currentLocation: json["currentLocation"]??"",
      history: (json["history"] as List? ?? []).map((x)=>History.fromJson(Map<String,dynamic>.from(x))).toList()
    );
  }
}
