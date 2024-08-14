import 'package:flutter/material.dart';

import 'features/product/presentation/pages/add_product_page/add_product.dart';
import 'features/product/presentation/pages/detail_page/detail.dart';
import 'features/product/presentation/pages/home_page/home.dart';
import 'features/product/presentation/pages/search_page/search.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(), 
      routes: {
        '/search_page': (context) => const SearchPage(),
        '/create_product': (context) => const CreateProduct(),
        '/detail_page': (context) => const DetailPage(), // Define the route here
      },
    );
  }
}
