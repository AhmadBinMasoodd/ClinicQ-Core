import 'package:cliniq_core/controllers/room_controller.dart';
import 'package:cliniq_core/views/rooms/add_room_screen.dart';
import 'package:cliniq_core/views/widgets/bottom_action_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cliniq_core/models/room_model.dart';

class RoomsScreen extends StatelessWidget {
  final RoomController roomController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rooms"), centerTitle: true),
      body: Obx(() {
        final rooms = roomController.rooms;
        if (rooms.isEmpty) {
          return Center(
            child: Text(
              "No rooms added yet",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.separated(
          itemCount: rooms.length,
          separatorBuilder: (_, __) => Divider(height: 1),
          itemBuilder: (context, index) {
            final room = rooms[index];

            return Card(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Column(
                children: [
                  ListTile(
                    title: Text("Room ${room.roomNumber} - ${room.roomType}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // delete room
                            roomController.removeRoom(room);
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                        IconButton(
                          icon: Obx(
                                () => AnimatedRotation(
                              turns: room.isExpanded.value ? 0.5 : 0.0,
                              duration: Duration(milliseconds: 300),
                              child: Icon(
                                Icons.expand_more,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          onPressed: () {
                            room.isExpanded.value = !room.isExpanded.value;
                          },
                        ),
                      ],
                    ),
                  ),
                  Obx(
                        () => AnimatedSize(
                      duration: Duration(milliseconds: 300),
                      child: room.isExpanded.value
                          ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          room.notes.isEmpty
                              ? "No notes available"
                              : room.notes,
                          style: TextStyle(color: Colors.grey[700]),
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
        buttonText: "Add Room",
        onPressed: () {
          Get.to(() => AddRoomScreen());
        },
      ),
    );
  }
}
