import 'package:flutter/material.dart';


class NoPageFoundView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          '404 - Página no encontrada',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}