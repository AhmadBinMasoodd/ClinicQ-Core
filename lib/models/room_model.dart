import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

import 'equipement_model.dart';

class Room{
  final String roomId;
  final int roomNumber;
  final String roomType;
  final String notes;
  List<Equipement> equipement;
  RxBool isExpanded=false.obs;
  Room({required this.roomId,required this.roomNumber,required this.roomType,this.notes="",this.equipement=const []});
  Map<String,dynamic> toJson(){
    return{
      "roomid": roomId,
      "roomNumber": roomNumber,
      "roomType": roomType,
      "notes": notes,
      "equipement": equipement.map((e) => e.toJson()).toList(),
    };
  }
  factory Room.fromSnapshot(DataSnapshot snapshot) {
    final data = Map<String, dynamic>.from(snapshot.value as Map);
    final equipList = (data['equipement'] as List?)
        ?.map((e) => Equipement.fromJson(Map<String, dynamic>.from(e)))
        .toList() ?? [];
    return Room(
      roomId: data['roomid'],
      roomNumber: data['roomNumber'],
      roomType: data['roomType'],
      notes: data['notes'] ?? "",
      equipement: equipList,
    );
  }

}
