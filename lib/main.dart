import 'package:e_shopping_app/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_shopping_app/Provider/cartmodel_provider.dart';
//import 'package:flutter/rendering.dart';

void main() {
  //debugPaintSizeEnabled = true;
  runApp(
    MultiProvider(
      providers:[
      ChangeNotifierProvider(create: (context) => CartModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E Shopping App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
