import 'package:crud_realtime_db/src/common/services/realtime_db.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeController = ChangeNotifierProvider.autoDispose((ref) => HomeController());

class HomeController with ChangeNotifier {
  HomeController() {
    onInit();
    GET();
  }
  FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<DataSnapshot> list = [];

  // ignore: non_constant_identifier_names
  Future<void> GET() async {
    list = await RTDService().getAllData();
    notifyListeners();
  }

  String backgroundColor = "red";

  final Map<String, Color> colors = {
    "green": Colors.green,
    "yellow": Colors.yellow,
    "pink": Colors.pink,
    "teal": Colors.teal,
  };
  Future<void> onInit() async {
    remoteConfig.setDefaults({
      "backgroundColor": backgroundColor,
    });
    await fetchActive();
    remoteConfig.onConfigUpdated.listen((event) async {
      await fetchActive();
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> fetchActive() async {
    await remoteConfig.fetchAndActivate().then((value) {
      backgroundColor = remoteConfig.getString("backgroundColor");
      notifyListeners();
    });
  }
}
