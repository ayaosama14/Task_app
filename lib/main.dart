import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_with_cubit/cubit/cubit.dart';

import 'package:sqflite_with_cubit/views/home_screen.dart';

void main() {
  runApp(
    BlocProvider(
        create: (context) => Cubita()..creatDatabase(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.dark,
    ));
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
