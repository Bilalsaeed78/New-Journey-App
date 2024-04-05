import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_journey_app/controllers/auth_controller.dart';

class GuestDashbaord extends StatelessWidget {
  GuestDashbaord({super.key});

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => controller.logout(),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(child: Text("GUEST DASHBOARD")),
    );
  }
}
