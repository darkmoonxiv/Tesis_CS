import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/sidemenu_provider.dart';

import 'package:admin_dashboard/router/router.dart';

import 'package:admin_dashboard/services/navigation_service.dart';

import 'package:admin_dashboard/ui/shared/widgets/menu_item.dart';

import 'package:admin_dashboard/ui/shared/widgets/text_separator.dart';


class Sidebar extends StatelessWidget {
 

  void navigateTo( String routeName ) {
    NavigationService.replaceTo( routeName );
    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);

    return Container(
      width: 100,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          SizedBox(height: 50),
                

          SizedBox( height: 50 ),

          TextSeparator( text: 'Seguridad' ),
           MenuItem( 
            text: 'Usuarios', 
            icon: Icons.people_alt_outlined, 
            onPressed: () =>navigateTo( Flurorouter.usersRoute ),
            isActive: sideMenuProvider.currentPage == Flurorouter.usersRoute,
          ),
          MenuItem( 
            text: 'Permisos', 
            icon: Icons.admin_panel_settings, 
            onPressed: () =>navigateTo( Flurorouter.permisosRoute ),
            isActive: sideMenuProvider.currentPage == Flurorouter.permisosRoute,
           
          ),

           TextSeparator( text: 'Parametrización' ),
             MenuItem(
            text: 'siembras', 
            icon: Icons.content_paste_go_sharp, 
            onPressed: () => navigateTo( Flurorouter.categoriesRoute ),
            isActive: sideMenuProvider.currentPage == Flurorouter.categoriesRoute,
          ),
          
   
           TextSeparator( text: 'Operativo' ),

          MenuItem(
            text: 'Inventario',
            icon: Icons.bed,
            onPressed: () => navigateTo( Flurorouter.inventarioRoute ),
            isActive: sideMenuProvider.currentPage == Flurorouter.inventarioRoute,
          ),
             MenuItem(
            text: 'Costos',
            icon: Icons.monetization_on,
            onPressed: () => navigateTo( Flurorouter.costosRoute ),
            isActive: sideMenuProvider.currentPage == Flurorouter.costosRoute,
          ),
          MenuItem(
            text: 'Rentabilidad',
            icon: Icons.format_align_left_sharp,
            onPressed: () => navigateTo( Flurorouter.rentabilidadRoute ),
            isActive: sideMenuProvider.currentPage == Flurorouter.rentabilidadRoute,
          ),
         

 
          
        


       

          TextSeparator( text: 'Reportes' ),
          MenuItem( 
            text: 'Reportes', 
            icon: Icons.picture_as_pdf, 
            onPressed: () => navigateTo( Flurorouter.reportesTipoRoute ),
            isActive: sideMenuProvider.currentPage == Flurorouter.reportesTipoRoute,
          ),

          SizedBox( height: 50 ),
          TextSeparator( text: 'Exit' ),
          MenuItem( 
            text: 'Logout', 
            icon: Icons.exit_to_app_outlined, 
            onPressed: (){
              Provider.of<AuthProvider>(context, listen: false)
                .logout();
            }),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.green.shade400,
        Colors.green.shade300,
      ]
    ),
    borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
    boxShadow: [
    BoxShadow(
      color: Colors.white.withOpacity(1), // Color de la sombra, puedes ajustar la opacidad según tus preferencias
      offset: Offset(0, 8), // Ajusta el desplazamiento en la dirección x e y para el efecto de elevación
      blurRadius: 20, // Ajusta el radio de desenfoque para suavizar o enfocar la sombra
      spreadRadius: 5, // Ajusta la expansión de la sombra
    ),
  ],
  );
}