import 'package:demo_realtime_database_firbase/Viewpage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Firstpage extends StatefulWidget {

  Map? map;

  Firstpage({this.map});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  TextEditingController tname = TextEditingController();
  TextEditingController tcontect = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.map != null)
      {
        tname.text = widget.map!['name'];
        tcontect.text = widget.map!['contect'];

      }


  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(
          leading: IconButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return Viewpage();
            },));

          }, icon: Icon(Icons.arrow_back_ios_new)),
          title: Text("Database")),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(controller: tname),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(controller: tcontect),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {


                FirebaseDatabase database = FirebaseDatabase.instance;

                String name = tname.text;
                String contect = tcontect.text;

                if(widget.map == null){

                  DatabaseReference ref = database.ref("contectbook").push();

                  String? userid = ref.key;

                  Map m = {"userid": userid, "name": name, "contect": contect};
                  ref.set(m);
                }else
                {

                  String userid = widget.map!['userid'];
                  DatabaseReference ref = database.ref("contectbook").child(userid);

                  Map m = {"userid": userid, "name": name, "contect": contect};
                  ref.set(m);

                }

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return Viewpage();
                },));


              },
              child: Text(widget.map == null ? "Insert" : "Update")),
        ),
      ]),
    ), onWillPop: goback);
  }

 Future<bool> goback(){


    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Viewpage();
    },));

    return Future.value();

  }

}
