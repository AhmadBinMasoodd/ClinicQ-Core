import 'package:cliniq_core/controllers/equipement_controller.dart';
import 'package:cliniq_core/controllers/room_controller.dart';
import 'package:cliniq_core/models/equipement_model.dart';
import 'package:cliniq_core/views/equipment/add_equipment_screen.dart';
import 'package:cliniq_core/views/widgets/bottom_action_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EquipementScreen extends StatefulWidget {
  const EquipementScreen({super.key});

  @override
  State<EquipementScreen> createState() => _EquipementScreenState();
}

class _EquipementScreenState extends State<EquipementScreen> {
  final EquipementController equipController = Get.find();
  final RoomController roomController = Get.find();

  void showRoomSelector(BuildContext context, Equipement equip) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Obx(() {
          final rooms = roomController.rooms;
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              final newLocation = "Room ${room.roomNumber} - ${room.roomType}";
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: Icon(Icons.meeting_room, color: Colors.teal),
                  title: Text(newLocation),
                  onTap: () {
                    // Check if already in the room
                    if (equip.currentLocation == newLocation) {
                      Get.snackbar(
                        "Info",
                        "Equipment is already in this room",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }

                    //move

                    Navigator.pop(context); // close bottom sheet
                  },
                ),
              );
            },
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipment'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Obx(() {
        final equipements = equipController.equipements;
        if (equipements.isEmpty) {
          return Center(
            child: Text(
              "No equipment added yet",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: equipements.length,
          itemBuilder: (context, index) {
            final equipement = equipements[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.devices, color: Colors.teal, size: 36),
                    title: Text(
                      equipement.name,
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Container(
                      margin: EdgeInsets.only(top: 4),
                      padding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        equipement.currentLocation,
                        style: TextStyle(color: Colors.teal[800]),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Obx(
                                () => AnimatedRotation(
                              turns: equipement.isExpand.value ? 0.5 : 0.0,
                              duration: Duration(milliseconds: 300),
                              child: Icon(Icons.expand_more, color: Colors.teal),
                            ),
                          ),
                          onPressed: () {
                            equipement.isExpand.value = !equipement.isExpand.value;
                          },
                        ),

                      ],
                    ),

                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => showRoomSelector(context, equipement),
                          icon: Icon(Icons.room, color: Colors.white),
                          label: Text("Move"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            // maintenance logic
                          },
                          icon: Icon(Icons.build, color: Colors.white),
                          label: Text("Maintenance"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                       //  IconButton(
                        //  onPressed: () {
                         //   Get.defaultDialog(
                         //     title: "Delete Equipment",
                         //     middleText: "Are you sure you want to delete ${equipement.name}?",
                         //     textConfirm: "Yes",
                         //     textCancel: "No",
                         //     confirmTextColor: Colors.white,
                         //     onConfirm: () {
                         //       equipController.removeEquipment(equipement);
                          //      Get.back();
                           //   },
                            //);
                          //},
                          //icon: Icon(Icons.delete, color: Colors.red),
                          //tooltip: "Delete Equipment",
                        //),
                      ],
                    ),

                  ),
                  Obx(
                        () => AnimatedSize(
                      duration: Duration(milliseconds: 300),
                      child: equipement.isExpand.value
                          ? Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: equipement.history.map((h) {
                            return Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: Icon(Icons.history,
                                      color: Colors.teal),
                                  title:
                                  Text("Moved from: ${h.oldLocation}"),
                                  subtitle:
                                  Text("To: ${h.newLocation}"),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 16, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text("Date & Time: ${h.dateTime}"),
                                      Text("Moved By: ${h.movedBy}"),
                                    ],
                                  ),
                                ),
                                Divider(),
                              ],
                            );
                          }).toList(),
                        ),
                      )
                          : SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
      bottomNavigationBar: BottomActionBar(
        buttonText: "Add Equipment",
        onPressed: () {
          Get.to(() => AddEquipmentScreen());
        },
      ),
    );
  }
}
