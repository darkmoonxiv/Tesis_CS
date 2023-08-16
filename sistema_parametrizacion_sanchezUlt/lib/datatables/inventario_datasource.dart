import 'package:admin_dashboard/models/inventario.dart';
import 'package:flutter/material.dart';



import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


import '../providers/users_provider.dart';
import '../services/notifications_service.dart';

class InventarioDataSource extends DataTableSource {
  final List<Inventario> inventarios;
  final BuildContext context;
  final bool report;
  InventarioDataSource(this.inventarios, this.context, this.report);

  @override
   DataRow getRow(int index) {
    final Inventario inventario = inventarios[index];

    final TextEditingController productoController = TextEditingController();
    final TextEditingController fechaController = TextEditingController();
    final TextEditingController cantidadController = TextEditingController();
    final TextEditingController precioController = TextEditingController();

    productoController.text = inventario.product;
    fechaController.text = DateFormat.yMd().format(inventario.purchaseDate);
    cantidadController.text = inventario.quantity.toString();
    precioController.text = inventario.unitPrice.toString();

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(inventario.id.toString())),
        DataCell(Text(inventario.product)),
       DataCell(Text(DateFormat('MMM d, y').format(inventario.purchaseDate))),
        DataCell(Text(inventario.quantity.toString())),
        DataCell(Text(inventario.unitPrice.toString())),
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

                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return AlertDialog(
                            title: Text('Modificar producto'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: productoController,
                                  decoration:
                                      InputDecoration(labelText: 'Nombre'),
                                ),
                                TextField(
                                  controller: fechaController,
                                  decoration:
                                      InputDecoration(labelText: 'Fecha'),
                                  readOnly: true,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: inventario.purchaseDate,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    ).then((selectedDate) {
                                      if (selectedDate != null) {
                                        setState(() {
                                          fechaController.text = DateFormat.yMd().format(selectedDate);
                                        });
                                      }
                                    });
                                  },
                                ),
                                TextField(
                                  controller: cantidadController,
                                  decoration:
                                      InputDecoration(labelText: 'Cantidad'),
                                  keyboardType: TextInputType.number,
                                ),
                                TextField(
                                  controller: precioController,
                                  decoration:
                                      InputDecoration(labelText: 'Precio'),
                                  keyboardType: TextInputType.number,
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
                                  // Validar cantidad y precio
                                  final cantidad = int.tryParse(cantidadController.text);
                                  final precio = double.tryParse(precioController.text);
                                  final productoname= productoController.text;
                                  final fecha = fechaController.text;
                                   // ignore: unnecessary_null_comparison
                                   if (productoname == null || productoname =="" || fecha == null || fecha =="" ) {
                                    NotificationsService.showSnackbar('Fecha o Nombre incorrectos');
                                    return;
                                  }
                                  if (cantidad == null || cantidad <= 0 || precio == null || precio <= 0) {
                                    NotificationsService.showSnackbar('Cantidad y precio inválidos');
                                    return;
                                  }

                                  // Actualizar el inventario
                                //  inventario.product = productoController.text;
                                 // inventario.purchaseDate = DateFormat.yMd().parse(fechaController.text);
                                  //inventario.quantity = cantidad;
                                  //inventario.unitPrice = precio;

                                  // Guardar cambios
                                   await usersProvider.putUpdateInventario(productoname, fecha, precio, cantidad, inventario.id);
                                
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
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  final usersProvider =
                      Provider.of<UsersProvider>(context, listen: false);
                  await usersProvider.deleteInventario(inventario.id);
                  
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => this.inventarios.length;

  @override
  int get selectedRowCount => 0;
}
