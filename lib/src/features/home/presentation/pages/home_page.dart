import 'package:crud_realtime_db/src/features/home/controller/home_controller.dart';
import 'package:crud_realtime_db/src/features/home/presentation/widgets/wfloatingactionbutton.dart';
import 'package:crud_realtime_db/src/features/home/presentation/widgets/wgridviewbulder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(homeController);
    final con = ref.read(homeController);
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Crud RTD & Crashlytics & RMC'), backgroundColor: con.colors[con.backgroundColor]),
      body: WGridViewBulder(con: con),
      floatingActionButton: WFloatingActionButton(con: con),
    );
  }
}
