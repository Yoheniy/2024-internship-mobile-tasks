import 'package:flutter/material.dart';
import '../../widgets/common/style.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  // ignore: non_constant_identifier_names
  List<int> shoe_sizes = List.generate(21, (index) => 30 + index);

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(

          child: Column(
            children: [



                 //top image and back button

                  Stack(
                    children: [
                      SizedBox(
            
                        height: 240,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          'assets/shoes.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 5,
                        left: 5,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios_new_outlined),
                          ),
                        ),
                      )
                    ],
                  ),





                  //for center elements


                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [


                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      tex2(
                                        'Men’s shoe',
                                        FontWeight.w400,
                                        16,
                                        Colors.grey,
                                      ),
                                      const Spacer(),

                                      const Icon(Icons.star, color: Colors.yellow, size: 20),

                                      tex2('(4.0)', FontWeight.w400, 16, Colors.grey),
                                    ],
                                  ),


                                Padding(
                                  padding: const EdgeInsets.only(top: 18, bottom: 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      tex2(
                                        'Derby Leather',
                                        FontWeight.w600,
                                        24,
                                      ),
                                      tex2('\$120', FontWeight.w500, 16),
                                    ],
                                  ),
                                ),


                                tex2('Size:', FontWeight.w500, 20),




                                SizedBox(
                                  height: 60,
                                  child: ListView.builder(
                                    itemCount: 15,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        
                                        onTap: () {
                                          setState(() {
                                            selected = index;
                                          });
                                        },
                                        child: Card(

                                          color: selected == index
                                              ? const Color.fromARGB(255, 1, 26, 250)
                                              : Colors.white,
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: Center(
                                              child: tex2(
                                                '${shoe_sizes[index]}',
                                                FontWeight.w500,
                                                20,
                                                selected == index
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                  
                                      );
                                    },
                                  ),
                                ),



                                const Padding(
                                  padding: EdgeInsets.only(top: 20.0, bottom: 45),
                                  child: Text(
                                    'A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.',
                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                                  ),
                                ),


              //the bottom two buttons---------------------------

                                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [



                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 35,
                                  ),
                                  child: Center(
                                    child: tex2(
                                      "DELETE",
                                      FontWeight.w400,
                                      15,
                                      Colors.red,
                                    ),
                                  ),
                                ),
                              ),



                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 32, 52, 233),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 35,
                                ),
                                child: Center(
                                  child: tex2(
                                    "UPDATE",
                                    FontWeight.w600,
                                    14,
                                    Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          
                      ],
                    ),
                    
                   const SizedBox(
                    height: 30,
                   )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


