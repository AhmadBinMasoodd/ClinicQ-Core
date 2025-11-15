
import 'package:cliniq_core/controllers/room_controller.dart';
import 'package:cliniq_core/models/room_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AddRoomScreen extends StatefulWidget {
  const AddRoomScreen({super.key});

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  final RoomController roomController = Get.find();

  final TextEditingController roomNumberController = TextEditingController();
  final TextEditingController roomTypeController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  void saveRoom() {
    final String roomId = Uuid().v4();
    final int? roomNumber = int.tryParse(roomNumberController.text);
    final String roomType = roomTypeController.text.trim();
    final String notes = notesController.text.trim();

    if (roomNumber == null || roomType.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter valid room details",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final Room room = Room(
      roomId: roomId,
      roomNumber: roomNumber,
      roomType: roomType,
      notes: notes,
      equipement: [],
    );

    roomController.addRoom(room);

    // Show dialog
    Get.defaultDialog(
      title: "Success",
      middleText: "Room has been added!",
      textConfirm: "OK",
      onConfirm: () {
        Get.back(); // close dialog
        Get.back(); // go back to RoomsScreen
        Get.snackbar(
          "Success",
          "Room added successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Room")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: roomNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Room Number"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: roomTypeController,
              decoration: InputDecoration(labelText: "Room Type"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: notesController,
              decoration: InputDecoration(labelText: "Notes (Optional)"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveRoom,
              child: Text("Add Room"),
            ),
          ],
        ),
      ),
    );
  }
}
