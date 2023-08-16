import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/api/CafeApi.dart';

import 'package:admin_dashboard/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:admin_dashboard/ui/layouts/splash/splash_layout.dart';

import 'package:admin_dashboard/router/router.dart';


import 'package:admin_dashboard/providers/providers.dart';


import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';

import 'package:admin_dashboard/ui/layouts/auth/auth_layout.dart';
 
void main() async {

  await LocalStorage.configurePrefs();
  CafeApi.configureDio();
  
  Flurorouter.configureRoutes();
  runApp(AppState());
}
 
class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: ( _ ) => AuthProvider() ),
        ChangeNotifierProvider(lazy: false, create: ( _ ) => SideMenuProvider() ),
        ChangeNotifierProvider(create: ( _ ) => CategoriesProvider() ),
        ChangeNotifierProvider(create: ( _ ) => UsersProvider() ),
        ChangeNotifierProvider(create: ( _ ) => UserFormProvider() ),

      ],
      child: MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BananoProject',
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      builder: (_, child) {
        final authProvider = Provider.of<AuthProvider>(context);

        if (authProvider.authStatus == AuthStatus.checking)
          return SplashLayout();

        if (authProvider.authStatus == AuthStatus.authenticated) {
          return DashboardLayout(child: child!);
        } else {
          return AuthLayout(child: child!);
        }
      },
      theme: ThemeData.light().copyWith(
        scrollbarTheme: ScrollbarThemeData().copyWith(
          thumbColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
        ),
        dropdownMenuTheme:DropdownMenuThemeData(
  textStyle: TextStyle(color: Colors.black, fontSize: 16),
  inputDecorationTheme: InputDecorationTheme(
    // Personaliza la apariencia del cuadro de búsqueda en el menú desplegable
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    // Estilo del texto dentro del cuadro de búsqueda
    hintStyle: TextStyle(color: Colors.grey),
    // Personaliza el ícono que aparece en el cuadro de búsqueda
   // prefixIcon: Icon(Icons.search, color: Colors.black),
  ),

),
        cardTheme: CardTheme(
          
          // Aquí puedes personalizar el CardTheme según tus preferencias
          surfaceTintColor: Colors.black,
          clipBehavior: Clip.antiAlias,
        
          color: Colors.white60, // Cambiar el color de fondo del Card
          elevation: 10,
           // Cambiar la elevación del Card
        ),
        dialogTheme: DialogTheme(
           shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25), // Bordes redondeados para el AlertDialog
          ),
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Estilo del texto del título
          contentTextStyle: TextStyle(fontSize: 16, color: Colors.black), // Estilo del texto del contenido
          backgroundColor: Colors.grey.shade100, // Color de fondo del AlertDialog
          elevation: 40, // Elevación del AlertDialog
          // Más configuraciones según tus preferencias...
        ),
  

        dataTableTheme: DataTableThemeData(
          decoration: BoxDecoration(
      color: Colors.yellow, // Color de fondo amarillo para toda la tabla
    ),
            //headingRowColor: MaterialStateColor.resolveWith((states) => Colors.green.shade400), // Color amarillo para el encabezado
    //dataRowColor: MaterialStateColor.resolveWith((states) => Colors.yellow), // Color amarillo para las celdas de datos
    headingTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), // Estilo de texto en el encabezado
    dataTextStyle: TextStyle(color: Colors.black), // Estilo de texto en las celdas de datos
    horizontalMargin: 16, // Margen horizontal de 16
    columnSpacing: 8, // Espacio entre columnas de 8
            dividerThickness: 6,
           // headingRowColor: MaterialStateColor.resolveWith((states) => Colors.green.shade400), // 
        )
      ),
    );
  }
}