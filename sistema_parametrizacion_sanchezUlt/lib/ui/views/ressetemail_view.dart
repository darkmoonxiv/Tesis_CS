import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/register_form_provider.dart';

import 'package:email_validator/email_validator.dart';

import 'package:admin_dashboard/router/router.dart';

import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';

class RegisterView extends StatelessWidget {
  
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

                    // Email
                   
                    
                    // Email
                    TextFormField(
                      onChanged: ( value ) => registerFormProvider.email = value,
                      validator: ( value ) {
                        if( !EmailValidator.validate(value ?? '') ) return 'Email no valido';
                        return null;
                      },
                      style: TextStyle( color: Colors.black ),
                      decoration: CustomInputs.loginInputDecoration(
                        hint: 'Ingrese su correo',
                        label: 'Email',
                        icon: Icons.email
                      ),
                    ),

                    SizedBox( height: 5 ),

             
                    
               
                    CustomOutlinedButton(
  onPressed: () {


   

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
       authProvider.ressetPassword(registerFormProvider.email);

  }, 
  text: 'Recuperar cuenta',
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
