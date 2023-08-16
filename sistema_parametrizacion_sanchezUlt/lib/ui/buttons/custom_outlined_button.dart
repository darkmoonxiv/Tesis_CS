import 'package:flutter/material.dart';
class CustomOutlinedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final bool isTextWhite;

  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color = Colors.white, // Cambio en el color
    this.isFilled = false,
    this.isTextWhite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ocupar todo el ancho disponible
      child: OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          side: MaterialStateProperty.all(
            BorderSide(color: color),
          ),
          backgroundColor: MaterialStateProperty.all(
            isFilled ? color : Colors.brown.shade300,
          ),
        ),
        onPressed: () => onPressed(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            text,
            style: TextStyle(fontSize: 16, color: isTextWhite ? Colors.white : color),
          ),
        ),
      ),
    );
  }
}

