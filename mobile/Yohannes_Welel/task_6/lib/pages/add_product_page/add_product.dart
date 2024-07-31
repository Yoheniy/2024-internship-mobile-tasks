import 'package:flutter/material.dart';
import 'package:task6/pages/add_product_page/input_take.dart';
import 'package:task6/pages/search_page/search.dart';


class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.blue,
                  size: 20,
                ),
              );
            },
          ),
          flexibleSpace: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 48.0,top: 25),
              child:Center( child:text2("Add Product", FontWeight.w500, 16),),
            ),
          ),
        ),


      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             



            //the about image upload 
                  SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 222, 221, 221)),
                
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.image,
                            size: 36,
                          ),
                          text2("upload image", FontWeight.w500, 14)
                        ],
                      ),
                    ),
                  ),

                  
                const SizedBox(
                  height: 20,
                ),


                text2("name", FontWeight.w500, 14),
                const InputField(),


                const SizedBox(
                  height: 20,
                ),

                
                text2("category", FontWeight.w500, 14),
                const InputField(),
                const SizedBox(
                  height: 20,
                ),
                text2("price", FontWeight.w500, 14),
                const InputField(),
                const SizedBox(
                  height: 20,
                ),


                text2("description", FontWeight.w500, 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 243, 237, 237),
                      borderRadius: BorderRadius.circular(7),
                      border:
                          Border.all(width: 1, color: const Color.fromARGB(255, 255, 255, 255))),
                  child: const Center(
                    child: TextField(
                      minLines: 5,
                      maxLines: 15,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsetsDirectional.only(start: 4),
                        hintStyle: TextStyle(color: Color.fromARGB(255, 230, 230, 230)),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ),



                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, top: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xff3F51F3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 35),
                      child: Center(
                          child: text2(
                              "ADD", FontWeight.w600, 14, Colors.white)),
                    ),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 34),
                    child: Center(
                        child: text2(
                            "DELETE", FontWeight.w600, 14, Colors.red)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}










































