import 'package:flutter/material.dart';
class TTermsAndConditionCheckbox extends StatelessWidget {
  const TTermsAndConditionCheckbox({
    super.key,

  });


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(value: true, onChanged: (value) {})),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text.rich(TextSpan(children: [
            TextSpan(
                text: 'I understand the ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: 'terms ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: Color.fromARGB(255, 8, 23, 234),
                    decoration: TextDecoration.underline,
                    decorationColor:Colors.blue,
                    )),
          
            TextSpan(text:'and ',style:Theme.of(context).textTheme.bodySmall),
             TextSpan(
                text: 'policy ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                     color: Color.fromARGB(255, 8, 23, 234),
                    decoration: TextDecoration.underline,
                    decorationColor:Colors.blue,
                    )),
          ]),
          ),
        ),
      ],
    );
  }
}
