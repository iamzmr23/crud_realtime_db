// ignore_for_file: use_build_context_synchronously
import 'package:crud_realtime_db/src/common/services/realtime_db.dart';
import 'package:crud_realtime_db/src/features/home/controller/home_controller.dart';
import 'package:flutter/material.dart';

class WGridViewBulder extends StatelessWidget {
  final HomeController con;
  const WGridViewBulder({super.key, required this.con});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: con.list.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
        ),
        itemBuilder: (_, index) {
          var item = con.list[index].value as Map;
          return SizedBox(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("${item["title"]}"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text("${item["description"]}"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Text("${item["time"]}"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await RTDService.deleteNotes(id: con.list[index].key.toString());
                            await con.GET();
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            var item = con.list[index].value as Map;
                            final upDateTitle = TextEditingController(text: item["title"].toString());
                            final upDateDescription = TextEditingController(text: item["description"].toString());
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: upDateTitle,
                                        decoration: const InputDecoration(),
                                      ),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: upDateDescription,
                                        decoration: const InputDecoration(),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await RTDService.updateNotes(
                                          id: con.list[index].key.toString(),
                                          data: {
                                            "title": upDateTitle.text,
                                            "description": upDateDescription.text,
                                            "time": DateTime.now().toString(),
                                          },
                                        );
                                        await con.GET();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Update"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
