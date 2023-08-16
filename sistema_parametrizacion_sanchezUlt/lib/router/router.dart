import 'package:admin_dashboard/router/dashboard_handlers.dart';
import 'package:admin_dashboard/router/no_page_found_handlers.dart';
import 'package:fluro/fluro.dart';
import 'package:admin_dashboard/router/admin_handlers.dart';

class Flurorouter {

  static final FluroRouter router = new FluroRouter();

  static String rootRoute     = '/';

  // Auth Router
  static String loginRoute    = '/auth/login';
  static String registerRoute = '/auth/ressetPassword';

  // Dashboard
  static String dashboardRoute  = '/dashboard';
  static String iconsRoute      = '/dashboard/icons';
  static String blankRoute      = '/dashboard/blank';
  static String categoriesRoute = '/dashboard/parametrizacion';
  static String reportesTipoRoute = '/dashboard/Reportes/Tipo';
  //seguridad modulo
  static String usersRoute = '/dashboard/users';
    static String inventarioRoute = '/dashboard/inventario';
     static String costosRoute = '/dashboard/costos';
      static String rentabilidadRoute = '/dashboard/rentabilidad';
  static String permisosRoute = '/dashboard/permisos';
  static String userRoute  = '/dashboard/users/:uid';
static String ressetView  = '/auth/ressetPasswordP/:token';



  static void configureRoutes() {
    // Auth Routes
    router.define( rootRoute, handler: AdminHandlers.login, transitionType: TransitionType.none );
    router.define( loginRoute, handler: AdminHandlers.login, transitionType: TransitionType.none );
    router.define( registerRoute, handler: AdminHandlers.register, transitionType: TransitionType.none );
        router.define( ressetView, handler: AdminHandlers.resset, transitionType: TransitionType.none );
    // Dashboard
   
     router.define( inventarioRoute, handler: DashboardHandlers.inventarioRoute, transitionType: TransitionType.fadeIn );
     router.define( costosRoute, handler: DashboardHandlers.costosRoute, transitionType: TransitionType.fadeIn );
     router.define( rentabilidadRoute, handler: DashboardHandlers.rentabilidadRoute, transitionType: TransitionType.fadeIn );
    router.define( blankRoute, handler: DashboardHandlers.blank, transitionType: TransitionType.fadeIn );
    router.define( categoriesRoute, handler: DashboardHandlers.categories, transitionType: TransitionType.fadeIn );
    router.define( iconsRoute, handler: DashboardHandlers.icons, transitionType: TransitionType.fadeIn );
    router.define( reportesTipoRoute, handler: DashboardHandlers.reportesTipo, transitionType: TransitionType.fadeIn );

    // users
        router.define( permisosRoute, handler: DashboardHandlers.permisosRoute, transitionType: TransitionType.fadeIn );
    router.define( usersRoute, handler: DashboardHandlers.users, transitionType: TransitionType.fadeIn );


    // 404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;

  }
  


}

