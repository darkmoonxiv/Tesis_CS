import 'package:admin_dashboard/models/roles.dart';
import 'package:admin_dashboard/providers/users_provider.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/datatables/users_datasource.dart';

import 'package:provider/provider.dart';

import '../../services/notifications_service.dart';



class UsersView extends StatefulWidget {
  @override
  State<UsersView> createState() => _UsersViewState();
  
}

class _UsersViewState extends State<UsersView> {
    int c=0;
  @override
@override
void didChangeDependencies() {
  if(c==0){
     super.didChangeDependencies();
  Provider.of<UsersProvider>(context).getPaginatedUsers();

  
  c++;
  }
}
  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);

    final usersDataSource = new UsersDataSource(usersProvider.users,this.context,false);
    bool _showPassword = false;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 10,
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            SizedBox(height: 10),
            Padding(

              padding: const EdgeInsets.all(15.0),
              child: PaginatedDataTable(
                
                sortAscending: usersProvider.ascending,
                sortColumnIndex: usersProvider.sortColumnIndex,
                header: Center(
                    child: Text(
                  "Usuarios",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
                headingRowHeight: 100,
                actions: [
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.blue),
                    onPressed: () async {
                   
                      final TextEditingController nameController =
                          TextEditingController();
                            final TextEditingController emailController =
                          TextEditingController();
                      final TextEditingController lastNameController =
                          TextEditingController();
                      final TextEditingController passwordController =
                          TextEditingController();
                      String? selectedStatus;
                      int? selectedRoleId;
                      showDialog(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        return StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                  
                  
                                        return AlertDialog(
                            title: Text('Crear usuario'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                 TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(labelText: 'email'),
                                ),
                                TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(labelText: 'Nombre'),
                                ),
                                TextField(
                                  controller: lastNameController,
                                  decoration:
                                      InputDecoration(labelText: 'Apellido'),
                                ),
                                DropdownButtonFormField<String>(
                                  value: selectedStatus,
                                  decoration: InputDecoration(labelText: 'Estado'),
                                  items: ['activo', 'inactivo']
                                      .map<DropdownMenuItem<String>>(
                                        (String value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (String? value) {
                                    selectedStatus = value;
                                  },
                                ),
                                DropdownButtonFormField<Roles>(
                                  value: null,
                                  decoration: InputDecoration(labelText: 'Rol'),
                                  items: usersProvider.roles
                                      .map<DropdownMenuItem<Roles>>(
                                        (Roles rol) => DropdownMenuItem<Roles>(
                                          value: rol,
                                          child: Text(rol.roleName),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (Roles? value) {
                                    selectedRoleId = value?.id;
                                  },
                                ),
                                TextField(
                                  controller: passwordController,
                                  obscureText:
                                      !_showPassword, // Oculta la contraseña si _showPassword es false
                                  decoration: InputDecoration(
                                    labelText: 'Contraseña',
                                    suffixIcon: IconButton(
                                      icon: Icon(_showPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _showPassword =
                                              !_showPassword; // Cambia el estado de visibilidad de la contraseña
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancelar'),
                              ),
                              ElevatedButton(
                                onPressed: ()async {
                                  // Lógica para guardar el usuario utilizando los datos ingresados
                                  final String name = nameController.text;
                                  final String lastName = lastNameController.text;
                                  final String password = passwordController.text;
                                  final String email = emailController.text;
                  
                                  // Validar que todos los campos estén completos
                                  if (email.isEmpty || name.isEmpty ||
                                      lastName.isEmpty ||
                                      selectedStatus == null ||
                                      selectedRoleId == null ||
                                      password.isEmpty) {
                                    return;
                                  }
                                  print(selectedRoleId);
                                  print(selectedStatus);
                                  await usersProvider.postCreateUser(name,lastName,selectedStatus!,email,password,selectedRoleId!);
                                   NotificationsService
                                                                              .showSnackbar(
                                                                                  'Usuario creado');
                                  Navigator.pop(context);
                                },
                                child: Text('Guardar'),
                              ),
                            ],
                          );
                                     
                                          },
                                        );
                                      },
                                    );
                      
                    }),
                  SizedBox(
                    width: 20,
                  )
                ],
                columns: [
                  DataColumn(label: Text('Id'),numeric: true),
                  DataColumn(
                      label: Text('Nombre'),
                      onSort: (colIndex, _) {
                        usersProvider.sortColumnIndex = colIndex;
                        usersProvider.sort<String>((user) => user.firstName);
                      }),
                  DataColumn(label: Text('Apellido')),
                  DataColumn(
                      label: Text('Email'),
                      onSort: (colIndex, _) {
                        usersProvider.sortColumnIndex = colIndex;
                        usersProvider.sort<String>((user) => user.email);
                      }),
                  DataColumn(label: Text('Rol')),
                  DataColumn(label: Text('Estado')),
                  DataColumn(label: Text('Acciones')),
                ],
                source: usersDataSource,
                onPageChanged: (page) {
                  print('page: $page');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
