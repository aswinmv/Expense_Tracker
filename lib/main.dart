import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/screens/intro.dart';

import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async{
  await Hive.initFlutter();

 await Hive.openBox("expense_database");


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => ExpenseData(),
    builder: (context, child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Intro(),
    ));
  }
}

