import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class AdminHomescreen extends StatefulWidget {
  const AdminHomescreen({super.key});

  @override
  State<AdminHomescreen> createState() => _AdminHomescreenState();
}

class _AdminHomescreenState extends State<AdminHomescreen> {
  List<Map<String, dynamic>> items = [
    {"title": "Rooms", "icon": Icons.meeting_room},
    {"title": "Equipment", "icon": Icons.medical_services},
    {"title": "Staff", "icon": Icons.groups},
    {"title": "Admins", "icon": Icons.admin_panel_settings},
    {"title": "History", "icon": Icons.history},
    {"title": "Settings", "icon": Icons.settings},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item['icon'],
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(height: 10),
                  Text(
                    item['title'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
