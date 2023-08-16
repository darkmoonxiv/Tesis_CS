import 'package:flutter/material.dart';


class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only( top: 0 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         
         
          Text(
            'SIEMBRA DE BANANO',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            
              color: Color.fromARGB(255, 11, 113, 16)
              
            ),
          )
        ],
      ),
    );
  }
}