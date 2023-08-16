
import 'package:flutter/material.dart';


import 'package:admin_dashboard/api/CafeApi.dart';
import 'package:admin_dashboard/models/http/auth_response.dart';

import 'package:admin_dashboard/router/router.dart';

import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated
}

class AuthProvider extends ChangeNotifier {

  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  User? user;

  AuthProvider() {
    this.isAuthenticated();
  }


   login(String email, String password) async {
    final url = Uri.parse('http://localhost:3000/v1/auth/signin');
    final data = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(url, body: data);
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromMap(jsonResponse);
        this.user = User(
          email: authResponse.data.user.email,
          firstName: authResponse.data.user.firstName,
          lastName: authResponse.data.user.lastName
          
        );

        _token = authResponse.data.token;
        authStatus = AuthStatus.authenticated;

        // Guardar el token en el almacenamiento local
        LocalStorage.prefs.setString('token', _token!);

        // Configurar la instancia Dio con el token
        CafeApi.configureDio();

        // Notificar a los oyentes que el estado de autenticación ha cambiado
        notifyListeners();

        // Navegar a la página de inicio o al dashboard después de iniciar sesión
        NavigationService.replaceTo(Flurorouter.usersRoute);
      } else {
        NotificationsService.showSnackbarError('Usuario / Password no válidos');
      }
    } catch (e) {
      print('error en: $e');
      NotificationsService.showSnackbarError('Ha ocurrido un error en el servidor');
    }
  }
     ressetPassword(String email) async {
    final url = Uri.parse('http://localhost:3000/v1/auth/reset-password');
    final data = {
      'email': email,
    };

    try {
      final response = await http.post(url, body: data);

      if (response.statusCode == 200) {
        NavigationService.replaceTo(Flurorouter.loginRoute);
         NotificationsService.showSnackbar('Correo enviado');
      } else {
        NotificationsService.showSnackbarError('Email no válidos');
      }
    } catch (e) {
      print('error en: $e');
      NotificationsService.showSnackbarError('Ha ocurrido un error en el servidor');
    }
  }
       changedPassword(String password,String token) async {
    final url = Uri.parse('http://localhost:3000/v1/auth/reset-password/$token');
    final data = {
      'password': password,
    };

    try {
      final response = await http.put(url, body: data);

      if (response.statusCode == 200) {
        NavigationService.replaceTo(Flurorouter.loginRoute);
         NotificationsService.showSnackbar('Contraseña cambiada con éxito');
      } else {
        NotificationsService.showSnackbarError('No se pudo cambiar la contraseña');
      }
    } catch (e) {
      print('error en: $e');
      NotificationsService.showSnackbarError('Ha ocurrido un error en el servidor');
    }
  }

 

  Future<bool> isAuthenticated() async {

    final token = LocalStorage.prefs.getString('token');

    if( token == null ) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
    
    try {
      final resp = await CafeApi.httpGet('/auth');
      final authReponse = AuthResponse.fromMap(resp);
      LocalStorage.prefs.setString('token', authReponse.data.token );
      
      this.user = authReponse.data.user;
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;

    } catch (e) {
      print(e);
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

  }


  logout() {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }

}
