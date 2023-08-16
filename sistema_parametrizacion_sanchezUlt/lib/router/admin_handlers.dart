import 'package:admin_dashboard/providers/auth_provider.dart';

import 'package:admin_dashboard/ui/views/users_view.dart';
import 'package:fluro/fluro.dart';

import 'package:admin_dashboard/ui/views/login_view.dart';
import 'package:admin_dashboard/ui/views/ressetemail_view.dart';
import 'package:provider/provider.dart';

import '../ui/views/resset_view.dart';

class AdminHandlers {

  static Handler login = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);

      if ( authProvider.authStatus == AuthStatus.notAuthenticated )
        return LoginView();
      else 
        return UsersView();

    }
  );

  static Handler register = Handler(
    handlerFunc: ( context, params ) {
      
      final authProvider = Provider.of<AuthProvider>(context!);
      
      if ( authProvider.authStatus == AuthStatus.notAuthenticated )
        return RegisterView();
      else 
        return UsersView();
    }
  );
      static Handler resset = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
     


      if ( authProvider.authStatus == AuthStatus.notAuthenticated ){
        print( params );
        if ( params['token']?.first != null ) {
            return RessetView(token: params['token']!.first);
        } else {
            return UsersView();
        }


      } else {
        return LoginView();
      }
    }
  );


}

