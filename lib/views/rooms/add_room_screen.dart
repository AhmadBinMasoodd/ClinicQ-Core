
import 'package:cliniq_core/controllers/room_controller.dart';
import 'package:cliniq_core/models/room_model.dart';
import 'package:cliniq_core/views/widgets/custom_field.dart';
import 'package:cliniq_core/views/widgets/rounded_button.dart';
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
        roomTypeController.clear();
        roomNumberController.clear();
        notesController.clear();
        Get.back(); // close dialoge// go back to RoomsScreen
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
      appBar: AppBar(title: Text("Add Room"),centerTitle: true,),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Register New Room",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Fill the details below to add room.",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [

                  CustomTextField(
                    controller: roomNumberController,
                    label: "Room Number",
                  ),

                  const SizedBox(height: 12),

                  CustomTextField(
                    controller: roomTypeController,
                    label: "Type (ICU / Emergency)",
                  ),

                  const SizedBox(height: 12),

                  CustomTextField(
                    controller: notesController,
                    label: "Notes",
                  ),

                ],
              ),
            ),

            const SizedBox(height: 25),

            RoundedButton(
              text: "Save Room",
              ontap: () {
                saveRoom();
              },
            )
          ],
        ),
      ),
    );
  }
}
