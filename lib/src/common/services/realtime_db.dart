import 'package:firebase_database/firebase_database.dart';

class RTDService {
  static final ref = FirebaseDatabase.instance.ref();

  static const String parentPath = "User";

  Future<List<DataSnapshot>> getAllData() async {
    List<DataSnapshot> list = [];
    DatabaseReference pP = ref.child(parentPath);
    DatabaseEvent data = await pP.once();
    final items = data.snapshot.children;
    for (var e in items) {
      list.add(e);
    }
    return list;
  }

  static Future<void> createNotes({required Map<String, String> data}) async {
    String? childPath = ref.child(parentPath).push().key;
    await ref.child(parentPath).child(childPath!).set(data);
  }

  static Future<void> updateNotes({required String id, required Map<String, dynamic> data}) async {
    await ref.child(parentPath).child(id).update(data);
  }

  static Future<void> deleteNotes({required String id}) async {
    await ref.child(parentPath).child(id).remove();
  }
}
