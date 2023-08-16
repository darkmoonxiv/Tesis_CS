import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/ui/shared/widgets/logo.dart';
import 'package:flutter/material.dart';



class Navbar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 160),
      child: Container(
        width: double.infinity,    
        height: 50,
        decoration: buildBoxDecoration(),
        child: Row(
          children: [
            
            if ( size.width <= 700 )
              IconButton(
                icon: Icon( Icons.menu_outlined ), 
                onPressed: () => SideMenuProvider.openMenu()
              ),
            
            SizedBox( width: 5 ),
    
      
        
              
            Spacer(),
    
         
            SizedBox( width: 10 ),
            Logo(),
            SizedBox( width: 10 )
    
          ],
        ),
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
    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)),
    boxShadow: [
      BoxShadow(
        color: Colors.white,
        blurRadius: 5
      )
    ]
  );
}