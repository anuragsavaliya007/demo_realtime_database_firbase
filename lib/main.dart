import 'package:demo_realtime_database_firbase/Firstpage.dart';
import 'package:demo_realtime_database_firbase/Viewpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: Viewpage(),));
}