import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Anket"),
        ),
        body: SurveyList(),
      ),
    );
  }
}

class SurveyList extends StatefulWidget {
  const SurveyList({super.key});

  @override
  State<StatefulWidget> createState() {
    return SurveyListState();
  }
}

class SurveyListState extends State {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("dilanketi").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          } else {
            return buildBody(context, snapshot.data!.docs);
          }
        });
  }

  Widget buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: EdgeInsets.only(top: 20.0),
      children:
          snapshot.map<Widget>((data) => buildListItem(context, data)).toList(),
    );
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot data) {
    final row = Anket.fromSnapshot(data);
    return Padding(
      key: ValueKey(row.isim),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0)),
        child: ListTile(
          title: Text(row.isim! + " | " + row.oy.toString()),
          trailing: TextButton.icon(
            onPressed: () => {
              FirebaseFirestore.instance.runTransaction((transaction) async {
                final freshSnapshot = await transaction.get(row.reference!);
                await transaction.delete(freshSnapshot.reference);
              })
            },
            icon: Icon(Icons.delete),
            label: Text('Delete'),
          ),
          onTap: () =>
              FirebaseFirestore.instance.runTransaction((transaction) async {
            final freshSnapshot = await transaction
                .get(row.reference!); // snapshot'ın, datanın, orijinal hali
            final fresh = Anket.fromSnapshot(freshSnapshot); // Anket

            await transaction.update((row.reference!), {'oy': fresh.oy! + 1});
          }),
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> sahteSnapshot = [
  {"isim": "C#", "oy": 3},
  {"isim": "Java", "oy": 4},
  {"isim": "C", "oy": 1},
  {"isim": "JavaScript", "oy": 6},
  {"isim": "HTML", "oy": 9},
  {"isim": "Dart", "oy": 5},
];

class Anket {
  String? isim;
  int? oy;
  DocumentReference? reference;

  Anket.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map["isim"] != null),
        assert(map["oy"] != null),
        isim = map["isim"],
        oy = map["oy"];

  Anket.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);
}
