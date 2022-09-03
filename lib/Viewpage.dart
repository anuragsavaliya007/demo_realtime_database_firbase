import 'package:demo_realtime_database_firbase/Firstpage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Viewpage extends StatefulWidget {
  const Viewpage({Key? key}) : super(key: key);

  @override
  State<Viewpage> createState() => _ViewpageState();
}

class _ViewpageState extends State<Viewpage> {
  List l = [];
  bool status = false;

  @override
  void initState() {
    super.initState();

    lodalldata();
  }

  lodalldata() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("contectbook");

    DatabaseEvent databaseEvent = await ref.once();

    DataSnapshot snapshot = databaseEvent.snapshot;

    print(snapshot.value);

    Map map = snapshot.value as Map;

    map.forEach((key, value) {
      l.add(value);
    });

    setState(() {
      status = true;
    });

    print(l);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ViewPgae")),
      floatingActionButton: FloatingActionButton(onPressed: () {

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return Firstpage();
        },));

      },child: Icon(Icons.add),),
      body: status
          ? ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
                Map m = l[index];

                User user = User.fromJson(m);

                return ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context1) {
                        return SimpleDialog(
                          title: Text("Select Choice"),
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.pop(context1);
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                  return Firstpage(map: m);
                                },));
                              },
                              title: Text("Update"),
                            ),
                            ListTile(onTap: () async {
                              Navigator.pop(context1);
                              print("Hello Anurag");

                              DatabaseReference ref = FirebaseDatabase.instance.ref("contectbook").child(user.userid!);
                             await ref.remove();
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                               return Viewpage();
                             },));

                            },title: Text("Delete")),
                          ],
                        );
                      },
                    );
                  },
                  title: Text("${user.name}"),
                  subtitle: Text("${user.contect}"),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class User {
  String? userid;
  String? name;
  String? contect;

  User({this.userid, this.name, this.contect});             

  User.fromJson(Map json) {
    userid = json['userid'];
    name = json['name'];
    contect = json['contect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['name'] = this.name;
    data['contect'] = this.contect;
    return data;
  }
}
