import 'package:cliniq_core/controllers/equipement_controller.dart';
import 'package:cliniq_core/controllers/room_controller.dart';
import 'package:cliniq_core/models/equipement_model.dart';
import 'package:cliniq_core/views/rooms/add_room_screen.dart';
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
      builder: (context) {
        return Obx(() {
          final rooms = roomController.rooms;
          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              return ListTile(
                title: Text("Room ${room.roomNumber} - ${room.roomType}"),
                onTap: () {
                  equipController.moveEquipement(equip, room.roomId);
                  Navigator.pop(context);
                },
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
      appBar: AppBar(title: Text('Equipement Screen')),
      body: Obx(() {
        final equipements = equipController.equipements;
        return ListView.builder(
          itemCount: equipements.length,
          itemBuilder: (context, index) {
            final equipement=equipements[index];
            return Card(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  ListTile(
                    title: Text(equipement.name,style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                    ),
                    subtitle: Text("Location: ${equipement.currentLocation}"),
                    trailing: IconButton(
                      icon: Obx(
                            () => AnimatedRotation(
                          turns: equipement.isExpand.value ? 0.5 : 0.0,
                          duration: Duration(milliseconds: 300),
                          child: Icon(
                            Icons.expand_more,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      onPressed: () {
                        equipement.isExpand.value = !equipement.isExpand.value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {

                            showRoomSelector(context, equipement);

                          },
                          child: Text("Move"),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Send to maintenance
                          },
                          child: Text("Maintenance"),
                        ),
                      ],
                    ),
                  ),
                  Obx(() => equipement.isExpand.value
                      ? Container(
                    padding: EdgeInsets.all(16),
                    color: Colors.grey[100],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: equipement.history.map((h) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: Icon(Icons.history),
                              title: Text("Moved from: ${h.oldLocation}"),
                              subtitle: Text("To: ${h.newLocation}"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16, bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                      : SizedBox.shrink()),

                ],
              ),
            );
          },
        );
      }),
      bottomNavigationBar: BottomActionBar(
        buttonText: "Add Equipment",
        onPressed: (){
          Get.to(AddRoomScreen());
        },
      ),
    );
  }
}
