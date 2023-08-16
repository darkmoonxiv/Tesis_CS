import 'package:admin_dashboard/models/roles.dart';
import 'package:admin_dashboard/providers/users_provider.dart';
import 'package:flutter/material.dart';



import 'package:provider/provider.dart';

import '../../datatables/permisos_datasource.dart';





class PermisosView extends StatefulWidget {
  @override
  State<PermisosView> createState() => _PermisosViewState();
}

class _PermisosViewState extends State<PermisosView> {
  int c=0;
  bool per=false;
  @override
@override
void didChangeDependencies() {
  if(c==0){
     super.didChangeDependencies();
  Provider.of<UsersProvider>(context).getRoles();
   Provider.of<UsersProvider>(context).getPermisos();
  
  c++;
  }
 
}

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
       final rolesP= usersProvider.roles;
       final permisosRol =usersProvider.permisosRol;
       final permisos = usersProvider.permisos;

    final usersDataSource = new PermisosDataSource(permisos,this.context,permisosRol,false);

    int? selectedRoleId;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 10,
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            SizedBox(height: 10),
            
                  Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  width: 200, // Ajusta el ancho del contenedor según tus necesidades
                  child: DropdownButtonFormField<Roles>(
                    value: null,
                    decoration: InputDecoration(labelText: 'Escoja un rol'),
                    items: rolesP
                        .map<DropdownMenuItem<Roles>>(
                          (Roles rol) => DropdownMenuItem<Roles>(
                            value: rol,
                            child: Text(rol.roleName),
                          ),
                        )
                        .toList(),
                    onChanged: (Roles? value) async {
                      selectedRoleId = value?.id;
                      await Provider.of<UsersProvider>(context, listen: false).getPermisosRol(selectedRoleId!);
                      per = true;
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
              if(per==true)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: PaginatedDataTable(
                sortAscending: usersProvider.ascending,
                sortColumnIndex: usersProvider.sortColumnIndex,
                header: Center(
                    child: Text(
                  "Permisos",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
                headingRowHeight: 100,
       
                  
                columns: [
                  DataColumn(label: Text('Id')),
                 
                  DataColumn(label: Text('Descripción')),
                
                  DataColumn(label: Text('Permission.Name')),
                  DataColumn(label: Text('Permiso')),
                 
                  DataColumn(label: Text('Dar/Quitar')),
                ],
                source: usersDataSource,
                onPageChanged: (page) {
               
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
