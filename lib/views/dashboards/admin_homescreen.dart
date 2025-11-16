import 'package:cliniq_core/views/admin/admin_list_screen.dart';
import 'package:cliniq_core/views/equipment/equipement_screen.dart';
import 'package:cliniq_core/views/history/history_screen.dart';
import 'package:cliniq_core/views/rooms/rooms_screen.dart';
import 'package:cliniq_core/views/staff/staff_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomescreen extends StatefulWidget {
  const AdminHomescreen({super.key});

  @override
  State<AdminHomescreen> createState() => _AdminHomescreenState();
}

class _AdminHomescreenState extends State<AdminHomescreen> {
  final List<Map<String, dynamic>> items = [
    {"title": "Rooms", "icon": Icons.meeting_room, "color": Colors.teal},
    {"title": "Equipments", "icon": Icons.medical_services, "color": Colors.teal},
    {"title": "Staff", "icon": Icons.groups, "color": Colors.teal},
    {"title": "Admins", "icon": Icons.admin_panel_settings, "color": Colors.teal},
    {"title": "History", "icon": Icons.history, "color": Colors.teal},
    {"title": "Settings", "icon": Icons.settings, "color": Colors.orange},
  ];

  void navigate(String title) {
    switch (title) {
      case "Rooms":
        Get.to(() => RoomsScreen());
        break;
      case "Equipments":
        Get.to(() => EquipementScreen());
        break;
      case "Staff":
        Get.to(() => StaffScreen());
        break;
      case "Admins":
        Get.to(() => AdminListScreen());
        break;
      case "History":
        Get.to(() => HistoryScreen());
        break;
      case "Settings":
      // You can navigate to Settings screen here
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.1,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final Color color = item['color'] as Color? ?? Colors.teal;

            return InkWell(
              onTap: () => navigate(item['title']),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      color.withOpacity(0.1),
                      Colors.white,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item['icon'],
                      size: 50,
                      color: color,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item['title'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
