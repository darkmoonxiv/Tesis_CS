import 'package:flutter/material.dart';



import 'package:admin_dashboard/models/usuario.dart';
import 'package:provider/provider.dart';

import '../models/roles.dart';
import '../providers/users_provider.dart';
import '../services/notifications_service.dart';

class UsersDataSource extends DataTableSource {
  final List<Usuario> users;
  final BuildContext context;
  final bool report;
  UsersDataSource(this.users, this.context, this.report);

  @override
  DataRow getRow(int index) {
    final Usuario user = users[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(user.id.toString())),
      DataCell(Text(user.firstName)),
      DataCell(Text(user.lastName)),
      DataCell(Text(user.email)),
      DataCell(Text(user.roles[0].roleName)),
      DataCell(
        user.state == "inactivo"
            ? Icon(Icons.clear, color: Colors.red) // Muestra una x roja
            : Icon(Icons.check, color: Colors.green), // Muestra un visto verde
      ),
      if(report!=true)
      DataCell(
        Row(
          children: [
            IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () async {
                  final usersProvider =
                      Provider.of<UsersProvider>(context, listen: false);
                  await usersProvider.getRoles();
                  if (usersProvider.roles.isEmpty) return;
                  final TextEditingController nameController =
                      TextEditingController();
                  final TextEditingController emailController =
                      TextEditingController();
                  final TextEditingController lastNameController =
                      TextEditingController();

                  String? selectedStatus;
                  int? selectedRoleId;
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          nameController.text = user.firstName;
                          lastNameController.text = user.lastName;
                          emailController.text = user.email;

                          // Asignar el estado y el rol seleccionados
                          selectedStatus = user.state;
                          selectedRoleId = user.roles[0].id;
                          late Roles rol;
                          for (Roles role in usersProvider.roles) {
                            if (user.roles[0].roleName == role.roleName) {
                              rol = role;
                              break; // Si se encuentra una coincidencia, se detiene el bucle
                            }
                          }

                          return AlertDialog(
                            title: Text('Editar usuario'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: nameController,
                                  decoration:
                                      InputDecoration(labelText: 'Nombre'),
                                ),
                                TextField(
                                  controller: lastNameController,
                                  decoration:
                                      InputDecoration(labelText: 'Apellido'),
                                ),
                                DropdownButtonFormField<String>(
                                  value: selectedStatus,
                                  decoration:
                                      InputDecoration(labelText: 'Estado'),
                                  items: ['activo', 'inactivo']
                                      .map<DropdownMenuItem<String>>(
                                        (String value) =>
                                            DropdownMenuItem<String>(
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
                                  value: rol,
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
                                onPressed: () async {
                                  // Lógica para guardar el usuario utilizando los datos ingresados
                                  final String name = nameController.text;
                                  final String lastName =
                                      lastNameController.text;

                                  final String email = emailController.text;

                                  // Validar que todos los campos estén completos
                                  if (email.isEmpty ||
                                      name.isEmpty ||
                                      lastName.isEmpty ||
                                      selectedStatus == null ||
                                      selectedRoleId == null) {
                                    return;
                                  }
                                  print(selectedRoleId);
                                  print(selectedStatus);
                                  await usersProvider.putUpdateUser(
                                      name,
                                      lastName,
                                      selectedStatus!,
                                      email,
                                      selectedRoleId!,
                                      user.id);
                                  NotificationsService.showSnackbar(
                                      'Usuario Actualizado');
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
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () async {
                  final usersProvider =
                      Provider.of<UsersProvider>(context, listen: false);
                  await usersProvider.deleteUser(user.id);
                   NotificationsService.showSnackbar('Usuario eliminado');
                })
          ],
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => this.users.length;

  @override
  int get selectedRowCount => 0;
}
