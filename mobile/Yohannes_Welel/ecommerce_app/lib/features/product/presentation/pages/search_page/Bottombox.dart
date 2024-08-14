import 'package:flutter/material.dart';

import '../../widgets/common/inputfield.dart';
import 'rangeslider.dart';
import 'search.dart';

class BottmSheet extends StatefulWidget {
  const BottmSheet({super.key});

  @override
  State<BottmSheet> createState() => _BottmSheetState();
}

class _BottmSheetState extends State<BottmSheet> {
  get type => null;
  
  get hint => null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        
        children: [
          const SizedBox(
                height: 10,
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
           
              Padding(
                padding: const EdgeInsets.only(top:10.0,bottom: 5,left: 10),
                child: SizedBox(
                   child:text2('Catagory', FontWeight.w500, 14),
                ),
              ),
            ],
          ),
          
          
      const InputTake(),

      Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
           
              Padding(
                padding: const EdgeInsets.only(top:10.0,bottom: 5,left: 10),
                child: SizedBox(
                   child:text2('Price', FontWeight.w500, 14),
                ),
              ),
            ],
          ),

          const rangeslider(),

       const Spacer(flex: 1),
   ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue, // Set the background color to blue
    minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50), // Set the width to 80% of the screen width and a fixed height
  ),
  child: const Text(
    'APPLY',
    style: TextStyle(color: Color.fromARGB(255, 246, 247, 247)), // Text color
  ),
  onPressed: () {
    Navigator.pop(context);
  },
   
),

    const Spacer(flex: 1)


        ],
      ),

    );
  }
}










































// GestureDetector(
//                     onTap: () {
//                       showModalBottomSheet(
//                           context: context,
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.vertical(
//                               top: Radius.circular(20.0),
//                             ),
//                           ),
//                           builder: (context) {
//                             return StatefulBuilder(
//                                 builder: (context, setState) {
//                               return Container(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.35,
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.vertical(
//                                         top: Radius.circular(20))),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 20),

//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: 18.0),
//                                         child: text2(
//                                             "Category", FontWeight.w400, 16),
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         width: MediaQuery.sizeOf(context).width,
//                                         margin: const EdgeInsets.symmetric(
//                                             vertical: 10),
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 4),
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                             border: Border.all(
//                                                 width: 1, color: Colors.black)),
//                                         child: const TextField(
//                                           decoration: InputDecoration(
//                                             fillColor: Colors.black,
//                                             // hintText: "Leather ",
//                                             hintStyle: TextStyle(
//                                                 color: Color(0xffC1C1C1)),
//                                             border: InputBorder.none,
//                                             contentPadding:
//                                                 EdgeInsets.symmetric(
//                                               vertical: 12,
//                                               horizontal: 16,
//                                             ),
//                                             isDense: true,
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 22,
//                                       ),
//                                       text2(
//                                           "Price", FontWeight.w400, 16),
//                                       RangeSlider(
//                                         activeColor: const Color(0xff3F51F3),
//                                         values: _currentRangeValues,
//                                         max: 100,
//                                         divisions: 5,
//                                         labels: RangeLabels(
//                                           _currentRangeValues.start
//                                               .round()
//                                               .toString(),
//                                           _currentRangeValues.end
//                                               .round()
//                                               .toString(),
//                                         ),
//                                         onChanged: (RangeValues values) {
//                                           setState(() {
//                                             _currentRangeValues = values;
//                                           });
//                                         },
//                                       ),
//                                       const SizedBox(
//                                         height: 18,
//                                       ),
//                                       DecoratedBox(
//                                         decoration: BoxDecoration(
//                                             color: const Color(0xff3F51F3),
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 16, horizontal: 34),
//                                           child: Center(
//                                               child: text2(
//                                                   "APPLY",
//                                                   FontWeight.w600,
//                                                   14,
//                                                   Colors.white)),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             });
//                           });
//                     },
//                     child: DecoratedBox(
//                       decoration: BoxDecoration(
//                           color: const Color(0xff3F51F3),
//                           borderRadius: BorderRadius.circular(8)),
//                       child: const Padding(
//                         padding: EdgeInsets.all(6.0),
//                         child: Icon(
//                           CupertinoIcons.slider_horizontal_3,
//                           color: Colors.white,
//                           size: 28,
//                         ),
//                       ),
//                     ),
//                   );