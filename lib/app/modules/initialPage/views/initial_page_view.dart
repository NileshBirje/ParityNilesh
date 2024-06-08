import 'package:flutter/material.dart';
import 'package:flutter_application_nilesh/app/modules/home/views/home_view.dart';

import 'package:get/get.dart';

import '../controllers/initial_page_controller.dart';

class InitialPageView extends GetView<InitialPageController> {
  const InitialPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InitialPageView'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => Get.to(()=>const HomeView()),),
      body: const Center(
        child: Text(
          'InitialPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
