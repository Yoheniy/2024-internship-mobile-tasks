import 'package:flutter/material.dart';

class rangeslider extends StatefulWidget {
  const rangeslider({super.key});

  @override
  State<rangeslider> createState() => _rangesliderState();
}

class _rangesliderState extends State<rangeslider> {
  double start=10.0;
  double end=80.0;
  @override
  Widget build(BuildContext context) {
    return Column( 
		mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
		children: [ 
		RangeSlider( 
			values: RangeValues(start, end), 
			labels: RangeLabels(start.toString(), end.toString()), 
			onChanged: (value) { 
			setState(() { 
				start = value.start; 
				end = value.end; 
			}); 
			}, 
			min: 10.0, 
			max: 90.0, 
		), 
	
		], 
	); 
  }
}