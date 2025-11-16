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
      appBar: AppBar(
        title: Text("Rooms"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
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
          padding: EdgeInsets.all(10),
          itemCount: rooms.length,
          separatorBuilder: (_, __) => SizedBox(height: 8),
          itemBuilder: (context, index) {
            final room = rooms[index];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.meeting_room,
                        color: Colors.teal,
                        size: 36,
                      ),
                      title: Text(
                        "Room ${room.roomNumber}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                          room.roomType,
                          style: TextStyle(color: Colors.teal[800]),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Expand button
                          IconButton(
                            icon: Obx(
                                  () => AnimatedRotation(
                                turns: room.isExpanded.value ? 0.5 : 0.0,
                                duration: Duration(milliseconds: 300),
                                child: Icon(
                                  Icons.expand_more,
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                            onPressed: () {
                              room.isExpanded.value = !room.isExpanded.value;
                            },
                          ),
                          // Delete button
                          IconButton(
                            onPressed: () {
                              roomController.removeRoom(room);
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                          () => AnimatedSize(
                        duration: Duration(milliseconds: 300),
                        child: room.isExpanded.value
                            ? Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 8),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            room.notes.isEmpty
                                ? "No notes available"
                                : room.notes,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        )
                            : SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
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

