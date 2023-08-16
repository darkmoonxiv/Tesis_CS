import 'package:admin_dashboard/models/permisos.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


import '../providers/users_provider.dart';
import '../services/notifications_service.dart';


class PermisosDataSource extends DataTableSource {
  final List<Permisos> permisos;
  final List<Permisos> permisosRol;
  final BuildContext context;
  final bool report;
  PermisosDataSource(this.permisos, this.context, this.permisosRol, this.report);

  @override
  DataRow getRow(int index) {
    final Permisos permiso = permisos[index];
    bool hasPermisoRol = permisosRol.any((permisoRol) => permisoRol.id == permiso.id);
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(permiso.id.toString())),
      DataCell(Text(permiso.description)),
      DataCell(Text(permiso.permissionName)),
      if(report!=true)
       DataCell(
        hasPermisoRol
      
            ? Icon(Icons.check, color: Colors.green) // Ícono de visto verde
            : Icon(Icons.close, color: Colors.red), // X roja
      ),
      if(report!=true)
      DataCell(
        Row(
          children: [
            IconButton(
                icon: Icon(
                  Icons.edit_attributes,
                  color: Colors.blue,
                ),
                onPressed: () async {
                  final usersProvider =
                      Provider.of<UsersProvider>(context, listen: false);
                  await usersProvider.putUpdatePermisos(permisosRol,hasPermisoRol,permiso.id);
                   NotificationsService.showSnackbar('Permiso Actualizado');
                })
          ],
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => this.permisos.length;

  @override
  int get selectedRowCount => 0;
}
