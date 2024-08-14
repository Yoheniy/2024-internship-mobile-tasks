import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';
import '../../bloc/product_bloc.dart';
import '../../widgets/common/style.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.pushNamed(context, '/create_product');
        },
        tooltip: 'Add',
        heroTag: 'contact',
        backgroundColor: const Color.fromARGB(255, 29, 49, 228),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: BlocProvider(
        create: (_) => sl<ProductBloc>(),
        child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      children: [
                              const SizedBox(
                                height: 10,
                              ),
      
                              //the fist header-----------------------------------------------
      
                                  Row(
                                    children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(10)),
                                      child: const SizedBox(
                                        height: 50,
                                        width: 50,
                                      ),
                                      
                                   
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start, 
                                      children: [
                                      tex2("July 14, 2023", FontWeight.w400, 11),
                                      tex2("Hello, Yohannes", FontWeight.w600, 16)
                                    ]),
                                    const Spacer(),
      
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(8)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Icon(CupertinoIcons.bell),
                                        )),
                                  ]),
                                  
                      //available product ---------------------------------  
                                
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0, bottom: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    tex2("Available Products", FontWeight.w600, 24),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/search_page');
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(color: const Color.fromARGB(255, 147, 145, 145)),
                                              borderRadius: BorderRadius.circular(7)),
                                          child: const Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Icon(CupertinoIcons.search),
                                          )),
                                    )
                                  ],
                                ),
                              ),
      
      
                  //the products -------------------------------------------------
      
      
      
      
      
                  Expanded(
                    child: ListView.builder(
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/detail_page');
                          },
                          child: Card(
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/shoes.png",
                                  fit: BoxFit.cover,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    tex2(
                                        "Derby Leather Shoes", FontWeight.w500, 20),
                                    tex2("\$120", FontWeight.w500, 14),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0, vertical: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      tex2("Men’s shoe", FontWeight.w400, 11),
                                      const Spacer(),
                                      const Icon(Icons.star,
                                          color: Colors.yellow, size: 15),
                                      tex2("(4.0)", FontWeight.w400, 12),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
      
      
      
                ]),
              ),
            ),
      ),
    );
  }
}
