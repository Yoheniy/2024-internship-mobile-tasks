import 'package:flutter/material.dart';

import 'Bottombox.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  

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
              child:Center( child:text2('Search Product', FontWeight.w500, 16),),
            ),
          ),
        ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [



       // Leather search -------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width * 0.68,
             
                    padding: const EdgeInsets.symmetric(horizontal: 4),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(width: 1, color: const Color.fromARGB(255, 175, 173, 173))),

                    child: const TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.black,
                        hintText: 'Leather ',
                        hintStyle: TextStyle(color: Color.fromARGB(255, 180, 175, 175)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 14,
                        ),
                        isDense: true,
                        suffixIcon: Icon(
                          //
                          Icons.arrow_forward,
                          color: Color.fromARGB(255, 80, 52, 220),
                        ),
                      ),
                    ),
                  ),
                
                  ElevatedButton(
                    onPressed: (){
                      showModalBottomSheet(
                        context: context, 
                        builder: (BuildContext context){
                          return const BottmSheet();
                        },
                        );
                    }, 
                  child: const Padding(
                              padding: EdgeInsets.all(1.0),
                              child: Icon(Icons.filter_list),
                            ),
                  ),
                             
                                 
                    
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/detail_page');
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/shoes.png',
                              fit: BoxFit.cover,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                text2(
                                    'Derby Leather Shoes', FontWeight.w500, 20),
                                text2('\$120', FontWeight.w500, 14),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  text2(
                                      'Men’s shoe', FontWeight.w400, 12),
                                  const Spacer(),
                                  const Icon(Icons.star,
                                      color: Colors.yellow, size: 15),
                                  text2('(4.0)', FontWeight.w400, 12),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Container text2Field(String hint, TextEditingController controller,
    {TextInputType? type}) {
  return Container(
    height: 48,
    padding: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: const Color(0xffD9D9D9))),
    child: Center(
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsetsDirectional.only(start: 4),
          hintStyle: const TextStyle(color: Color(0xffC1C1C1)),
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    ),
  );
}

Text text2(String text, FontWeight wight, double size,
    [Color color = Colors.black]) {
  return Text(
    text,
    overflow: TextOverflow.clip,
    style: TextStyle(fontWeight: wight, fontSize: size, color: color),
  );
}