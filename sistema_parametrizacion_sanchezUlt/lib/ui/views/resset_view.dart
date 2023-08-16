import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/register_form_provider.dart';



import 'package:admin_dashboard/router/router.dart';

import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';

class RessetView extends StatefulWidget {
  final String token;

  const RessetView({Key? key, required this.token}) : super(key: key);
  @override
  State<RessetView> createState() => _RessetViewState(token);
}

class _RessetViewState extends State<RessetView> {
  final String token;
   String password = '';
  _RessetViewState(this.token);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ( _ ) => RegisterFormProvider(),
      child: Builder(builder: (context) {

        final registerFormProvider = Provider.of<RegisterFormProvider>(context, listen: false);

        return Container(
          margin: EdgeInsets.only(top: 0),
          padding: EdgeInsets.symmetric( horizontal: 20 ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints( maxWidth: 370 ),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: registerFormProvider.formKey,
                child: Column(
                  children: [

                     
                       TextFormField(
        
                     onChanged: (value) => setState(() => password = value),
                    validator: ( value ) {
                      if ( value == null || value.isEmpty ) return 'Ingrese su contraseña';
                      if ( value.length < 3 ) return 'La contraseña debe de ser de 3 caracteres';

                      return null; // Válido
                    },
                    obscureText: true,
                    style: TextStyle( color: Colors.black ),
                    decoration: CustomInputs.loginInputDecoration(
                      hint: '*********',
                      label: 'Contraseña',
                      icon: Icons.lock_outline_rounded
                    ),
                  ),

                    SizedBox( height: 5 ),

             
                    
               
                    CustomOutlinedButton(
  onPressed: ()async {
    
     showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Contraseña Ingresada'),
          content: Text('La contraseña ingresada es: $password'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
    if(password!=""){
         final authProvider = Provider.of<AuthProvider>(context, listen: false);
    

    await authProvider.changedPassword(password, token);
    }



  }, 
  text: 'Cambiar Contraseña',
),

SizedBox( height: 5 ),
LinkText(
  text: 'Ir al login',
  onPressed: () {
    Navigator.pushReplacementNamed(context, Flurorouter.loginRoute );
  },
)

],
)
),
),
));
}),
);

}
}
