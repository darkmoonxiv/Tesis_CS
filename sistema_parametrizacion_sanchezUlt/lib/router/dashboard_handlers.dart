
import 'package:admin_dashboard/ui/views/costos_view.dart';
import 'package:admin_dashboard/ui/views/inventario_view.dart';
import 'package:admin_dashboard/ui/views/permisos_view.dart';
import 'package:admin_dashboard/ui/views/rentabilidad_view.dart';

import 'package:admin_dashboard/ui/views/reportes_view.dart';

import 'package:admin_dashboard/ui/views/siembra_view.dart';

import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';


import 'package:admin_dashboard/router/router.dart';

import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/providers/auth_provider.dart';


import 'package:admin_dashboard/ui/views/blank_view.dart';

import 'package:admin_dashboard/ui/views/icons_view.dart';
import 'package:admin_dashboard/ui/views/login_view.dart';
import 'package:admin_dashboard/ui/views/users_view.dart';


class DashboardHandlers {


    static Handler inventarioRoute = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.inventarioRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated )
        return InventarioView();
      else 
        return LoginView();
    }
  );
      static Handler costosRoute = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.costosRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated )
        return CostosView();
      else 
        return LoginView();
    }
  );
     static Handler rentabilidadRoute = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.rentabilidadRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated )
        return RentabilidadView();
      else 
        return LoginView();
    }
  );



  static Handler icons = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.iconsRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated )
        return IconsView();
      else 
        return LoginView();
    }
  );
    static Handler reportesTipo = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.reportesTipoRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated )
        return ReportesView();
      else 
        return LoginView();
    }
  );


  static Handler blank = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.blankRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated )
        return BlankView();
      else 
        return LoginView();
    }
  );


  static Handler categories = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.categoriesRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated )
        return SiembraView();
      else 
        return LoginView();
    }
  );

  // users
  static Handler users = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.usersRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated )
        return UsersView();
      else 
        return LoginView();
    }
  );
    static Handler permisosRoute = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.permisosRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated )
        return PermisosView();
      else 
        return LoginView();
    }
  );

  // user



}

