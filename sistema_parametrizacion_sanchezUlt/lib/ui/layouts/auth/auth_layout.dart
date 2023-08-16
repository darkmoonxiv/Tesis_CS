import 'package:flutter/material.dart';




class AuthLayout extends StatelessWidget {

  final Widget child;

  const AuthLayout({
    Key? key, 
    required this.child
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Scrollbar(
        // isAlwaysShown: true,
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [

            ( size.width > 1000 )
              ? _DesktopBody( child: child)
              : _MobileBody( child: child ),
            
            // LinksBar
            //LinksBar()
          ],
        ),
      )
    );
  }
}


class _MobileBody extends StatelessWidget {

  final Widget child;

  const _MobileBody({
    Key? key, 
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 800,
      color: Color.fromRGBO(91, 60, 6, 0.498),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox( height: 20 ),
          BackgroundLogin(),
          Container(
            width: double.infinity,
            height: 420,
            child: child,
          ),

          /*Container(
            width: double.infinity,
            height: 400,
            child: BackgroundTwitter(),
          )*/
        ],
      ),
    );
  }
 
}


class _DesktopBody extends StatelessWidget {

  final Widget child;

  const _DesktopBody({
    Key? key, 
    required this.child
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {



    return Container(
      height: 800,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('banano-background4.jpg'), // Ruta de la imagen
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox( height: 20 ),
         Card(
  elevation: 20, // Controla la intensidad de la sombra
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8), // Controla el radio de los bordes
  ),
  child: FractionallySizedBox(
    widthFactor: 0.45, // Porcentaje del ancho de la pantalla
    child: Container(
      height: 550,
      decoration: BoxDecoration(
        color: Color(0xFFFFE3B3),
        borderRadius: BorderRadius.circular(8), // Igual al radio de los bordes del Card
      ),
      child: Column(
        children: [
          BackgroundLogin(), // Widget BackgroundLogin
          Expanded(
            child: child, // Widget child
          ),
        ],
      ),
    ),
  ),
)
        
        ],
      ),
    );
  }
}

class BackgroundLogin extends StatelessWidget {
  const BackgroundLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
	              height: 200,
	              decoration: BoxDecoration(
	                image: DecorationImage(
	                  image: AssetImage('background1.png'),
	                  fit: BoxFit.contain
	                )
	              ),
	              child: Stack(
	                children: <Widget>[],
	              ),
	            );
  }
}

