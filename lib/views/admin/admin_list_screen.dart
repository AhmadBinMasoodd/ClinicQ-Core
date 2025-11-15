import 'package:flutter/material.dart';
class AdminListScreen extends StatefulWidget {
  const AdminListScreen({super.key});

  @override
  State<AdminListScreen> createState() => _AdminListScreenState();
}

class _AdminListScreenState extends State<AdminListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin List'),
      ),
      body:Center(
        child: Text('Coming Soon',style: TextStyle(fontSize:18 ),),
      ),
    );
  }
}
