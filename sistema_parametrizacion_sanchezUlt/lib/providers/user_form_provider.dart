
import 'package:admin_dashboard/models/usuario.dart';
import 'package:flutter/material.dart';

class UserFormProvider extends ChangeNotifier {

  Usuario? user;
  late GlobalKey<FormState> formKey;

  // void updateListener() {
  //   notifyListeners();
  // }




  bool _validForm() {
    return formKey.currentState!.validate();
  }

  Future updateUser() async {

    if ( !this._validForm() ) return false;

    // ignore: unused_local_variable
    final data = {
      'nombre': user!.firstName,
      'correo': user!.email,
      
    };

    try {
      


      return true;

    } catch (e) {
      print('error en updateUser: $e');
      return false;
    }


  }




}
