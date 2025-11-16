import 'package:cliniq_core/controllers/equipement_controller.dart';
import 'package:cliniq_core/controllers/room_controller.dart';
import 'package:cliniq_core/models/room_model.dart';
import 'package:cliniq_core/views/widgets/custom_field.dart';
import 'package:cliniq_core/views/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEquipmentScreen extends StatefulWidget {
  const AddEquipmentScreen({super.key});

  @override
  State<AddEquipmentScreen> createState() => _AddEquipmentScreenState();
}

class _AddEquipmentScreenState extends State<AddEquipmentScreen> {
  final EquipementController equipController = Get.find();
  final RoomController roomController = Get.find();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  Room? selectedRoom;

  void addEquipment() {
    if (nameController.text.isEmpty ||
        statusController.text.isEmpty ||
        selectedRoom == null) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    equipController.addEquipement(
      name: nameController.text.trim(),
      status: statusController.text.trim(),
      roomNumber: "${selectedRoom!.roomNumber}",
      roomtype:selectedRoom!.roomType,
    );

    Get.defaultDialog(
      title: "Success",
      middleText: "Equipment added successfully!",
      textConfirm: "OK",
      onConfirm: () {
        nameController.clear();
        statusController.clear();
        setState(() {
          selectedRoom = null;
        });
        Get.back(); // close dialog
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Equipment"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
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
            CustomTextField(
              controller: nameController,
              label: "Equipment Name",
            ),

            const SizedBox(height: 10),

            CustomTextField(
              controller: statusController,
              label: "Status",
            ),

            const SizedBox(height: 10),

            Obx(() {
              return DropdownButtonFormField<Room>(
                value: selectedRoom,
                decoration: InputDecoration(
                  labelText: "Select Room",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                items: roomController.rooms.map((room) {
                  return DropdownMenuItem<Room>(
                    value: room,
                    child: Text("${room.roomNumber} - ${room.roomType}"),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRoom = value;
                  });
                },
              );
            }),


            const SizedBox(height: 20),

            RoundedButton(
              text: "Save Equipment",
              ontap: addEquipment,
            ),
          ],
        ),
      ),
    );
  }
}
