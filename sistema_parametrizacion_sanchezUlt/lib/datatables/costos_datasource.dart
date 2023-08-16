import 'package:admin_dashboard/models/costos.dart';
import 'package:admin_dashboard/models/inventario.dart';
import 'package:admin_dashboard/models/parametrizacion.dart';

import 'package:flutter/material.dart';



import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


import '../providers/users_provider.dart';
import '../services/notifications_service.dart';

class CostosDataSource extends DataTableSource {
  final List<Costos> costos;
  final List<Inventario> inventario;
  final List<Parametrizacion> planeacion;
  final BuildContext context;
  final bool reporte;
  CostosDataSource(this.costos, this.context, this.inventario, this.planeacion, this.reporte);

  @override
   DataRow getRow(int index) {
    final Costos costo = costos[index];
          int? selectedInventarioId=costo.inventoryId;

       final TextEditingController descriptionController = TextEditingController();
 
   
    final TextEditingController manoObraController = TextEditingController();
    final TextEditingController combustibleController = TextEditingController();

    descriptionController.text = costo.description;
    combustibleController.text =costo.fuel.toString();

    manoObraController.text = costo.labor.toString();

    return DataRow.byIndex(
      index: index,
      cells: [
      
        DataCell(Text(costo.description)),
         DataCell(Text(costo.labor.toString())),
          DataCell(Text(costo.input.toString())),
           DataCell(Text(costo.fuel.toString())),
             
              DataCell(Text(costo.inventoryId.toString())),



       DataCell(Text(DateFormat('MMM d, y').format(costo.registerDate))),
       DataCell(Text(costo.totalCosts.toString())),
        if(reporte!=true)
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
                                        controller: descriptionController,
                                        decoration:
                                            InputDecoration(labelText: 'Descripción'),
                                      ),
                                     
                                   
                                      TextField(
                                        controller: manoObraController,
                                        decoration:
                                            InputDecoration(labelText: 'Costo mano de obra'),
                                        keyboardType: TextInputType.number,
                                      ),
                                        TextField(
                                        controller: combustibleController,
                                        decoration:
                                            InputDecoration(labelText: 'Costo Combustible'),
                                        keyboardType: TextInputType.number,
                                      ),
                                     DropdownButton<int>(
                                        value: selectedInventarioId,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedInventarioId = newValue;
                                          });
                                        },
                                        items: inventario.map((item) {
                                          return DropdownMenuItem<int>(
                                            value: item.id,
                                            child: Text(item.product), // Assuming there's a property "product" in the inventario object
                                          );
                                        }).toList(),
                                        hint: Text('Select Inventario'), // Shown when no item is selected
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
                                  
                                      final manoO = double.tryParse(manoObraController.text);
                                      final combustible = double.tryParse(combustibleController.text);
                                      final description= descriptionController.text;
                                   
                                       // ignore: unnecessary_null_comparison
                                       if (description == null || description ==""  ) {
                                        NotificationsService.showSnackbar('campos incorrectos');
                                        return;
                                      }
                                      if ( manoO == null || manoO <= 0|| combustible == null || combustible <= 0) {
                                        NotificationsService.showSnackbar('Cantidades inválidos');
                                        return;
                                      }
                                    
                  
                                      // Actualizar el inventario
                                    //  inventario.product = productoController.text;
                                     // inventario.purchaseDate = DateFormat.yMd().parse(fechaController.text);
                                      //inventario.quantity = cantidad;
                                      //inventario.unitPrice = precio;
                  
                                      // Guardar cambios
                                         final total = manoO+combustible;
                                  await usersProvider.putUpdateCostos(description, manoO, combustible,selectedInventarioId!,total, costo.id);
                                  NotificationsService.showSnackbar('Inventario Actualizado');
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
                  await usersProvider.deleteCostos(costo.id);
                   NotificationsService.showSnackbar('Costo Eliminado');
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
  int get rowCount => this.costos.length;

  @override
  int get selectedRowCount => 0;
}

