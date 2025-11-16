import 'package:cliniq_core/models/equipement_model.dart';
import 'package:cliniq_core/models/room_model.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
class RoomController extends GetxController{
  var rooms=<Room>[].obs;
  final DatabaseReference ref=FirebaseDatabase.instance.ref('rooms');
  @override
  void onInit(){
    super.onInit();
    fetchRooms();
  }
  void fetchRooms(){
    ref.onValue.listen((event){
      final data=event.snapshot.value as Map<dynamic,dynamic>?;
      if(data!=null){
        rooms.value = data.entries.map((e) {
          final roomMap = Map<String, dynamic>.from(e.value);
          final equipList = (roomMap['equipement'] as List?)
              ?.map((x) => Equipement.fromJson(Map<String, dynamic>.from(x)))
              .toList() ?? [];
          return Room(
            roomId: roomMap['roomid'],
            roomNumber: roomMap['roomNumber'],
            roomType: roomMap['roomType'],
            notes: roomMap['notes'] ?? "",
            equipement: equipList,
          );
        }).toList();
      }
    });
  }
  void addRoom(Room room)async{
    await ref.child(room.roomId).set(room.toJson());
  }
  void updateRoom(int index,Room room){
    if(index>=0&& index<rooms.length){
      rooms[index]=room;
    }

  }

  void removeRoom(Room room) async {
    final index = rooms.indexWhere((r) => r.roomId == room.roomId);
    if (index != -1) {
       deleteRoom(index);
    }
  }

  void deleteRoom(int index)async{

    if(index>=0&& index<rooms.length){
      if(rooms[index].equipement.isEmpty){
        await ref.child(rooms[index].roomId).remove();
        rooms.removeAt(index);
        Get.snackbar("Deleted", "Room deleted successfully");
      }else{
        Get.snackbar(
            "Cannot delete",
            "Room has equipment assigned",
            snackPosition: SnackPosition.BOTTOM
        );
      }
    }
  }
  Room? getRoomById(String id){
    return rooms.firstWhereOrNull((room)=>room.roomId==id);
  }
}