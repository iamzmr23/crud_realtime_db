import 'package:crud_realtime_db/src/common/services/realtime_db.dart';
import 'package:crud_realtime_db/src/features/home/controller/home_controller.dart';
import 'package:flutter/material.dart';

class WFloatingActionButton extends StatelessWidget {
  const WFloatingActionButton({
    super.key,
    required this.con,
  });

  final HomeController con;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(controller: con.titleController, decoration: const InputDecoration()),
                    const SizedBox(height: 16),
                    TextField(controller: con.descriptionController, decoration: const InputDecoration()),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                        TextButton(
                            onPressed: () async {
                              await RTDService.createNotes(data: {
                                "title": con.titleController.text,
                                "description": con.descriptionController.text,
                                "time": DateTime.now().toString()
                              });
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              await con.GET();
                              con.titleController.clear();
                              con.descriptionController.clear();
                            },
                            child: const Text("Create a new note")),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add, size: 36));
  }
}
