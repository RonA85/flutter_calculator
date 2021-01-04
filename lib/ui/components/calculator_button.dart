

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget{

  final String text;
  final Function onTap;

  const CalculatorButton({Key key, this.text, this.onTap}) : super(key: key);


  @override
  Widget build(BuildContext context) =>Expanded(
    child: ButtonTheme(
      height: double.infinity,
      child: OutlineButton(
        onPressed:  onTap,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        splashColor: Theme.of(context).primaryColor.withOpacity(0.1),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
        ),
        highlightedBorderColor:
        Theme.of(context).primaryColor.withOpacity(0.1),
      ),
    ),
  );
}