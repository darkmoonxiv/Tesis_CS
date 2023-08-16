import 'package:flutter/material.dart';

class CustomInputs {
  static InputDecoration loginInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      filled: true, // Agregar fondo lleno
      fillColor: Colors.white, // Color de fondo blanco
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.brown.withOpacity(0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.brown.withOpacity(0.3)),
      ),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.brown),
      labelStyle: TextStyle(color: Colors.brown),
      hintStyle: TextStyle(color: Colors.brown),
    );
  }

  static InputDecoration searchInputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      filled: true, // Agregar fondo lleno
      fillColor: Colors.white, // Color de fondo blanco
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.brown),
      labelStyle: TextStyle(color: Colors.brown),
      hintStyle: TextStyle(color: Colors.brown),
    );
  }

  static InputDecoration formInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      filled: true, // Agregar fondo lleno
      fillColor: Colors.white, // Color de fondo blanco
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.brown.shade400.withOpacity(0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.brown.shade400.withOpacity(0.3)),
      ),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.brown),
      labelStyle: TextStyle(color: Colors.brown),
      hintStyle: TextStyle(color: Colors.brown),
    );
  }
}
