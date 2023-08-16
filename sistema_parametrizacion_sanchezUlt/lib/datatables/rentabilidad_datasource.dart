
import 'package:admin_dashboard/models/costos.dart';
import 'package:admin_dashboard/models/inventario.dart';
import 'package:admin_dashboard/models/parametrizacion.dart';
import 'package:admin_dashboard/models/rentabilidad.dart';

import 'package:flutter/material.dart';




import 'package:provider/provider.dart';


import '../providers/users_provider.dart';


class RentabilidadDataSource extends DataTableSource {
  final List<Rentabilidad> rentabilidades;
  final List<Costos> costos;
  final List<Parametrizacion> planeacion;
  final BuildContext context;
  final bool reporte;
  RentabilidadDataSource(this.rentabilidades, this.context, this.costos, this.planeacion, this.reporte);

  @override
   DataRow getRow(int index) {
    final Rentabilidad rentabilidad = rentabilidades[index];
          //int? selectedInventarioId=rentabilidad.inventoryId;
// ignore: unused_local_variable




    return DataRow.byIndex(
      index: index,
      cells: [
         DataCell(Text(rentabilidad.id.toString())),

         DataCell(Text("Lote #"+rentabilidad.planningSowing2.batchNumber.toString())),
             DataCell(Text((rentabilidad.planningSowing2.numberOfBunches-rentabilidad.planningSowing2.rejectedBunches).toString())),
                DataCell(Text(((rentabilidad.planningSowing2.averageBunchWeight*(rentabilidad.planningSowing2.numberOfBunches-rentabilidad.planningSowing2.rejectedBunches)/1000)).toStringAsFixed(2)+"KG")),
                      DataCell(Text((((rentabilidad.planningSowing2.averageBunchWeight*(rentabilidad.planningSowing2.numberOfBunches-rentabilidad.planningSowing2.rejectedBunches))/1000)).toStringAsFixed(2)+"LB")),

     
   DataCell(
  Text(
    ((rentabilidad.planningSowing2.averageBunchWeight * (rentabilidad.planningSowing2.numberOfBunches - rentabilidad.planningSowing2.rejectedBunches) * 2.20) >= 45)
        ? "RENTABLE"
        : "NO RENTABLE",
    style: TextStyle(
      color: (rentabilidad.planningSowing2.averageBunchWeight * (rentabilidad.planningSowing2.numberOfBunches - rentabilidad.planningSowing2.rejectedBunches) * 2.20) >= 45
          ? Colors.green
          : Colors.red,
    ),
  ),
),



        if(reporte!=true)
        DataCell(
          Row(
            children: [
              
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  final usersProvider =
                      Provider.of<UsersProvider>(context, listen: false);
                  await usersProvider.deleteCostos(rentabilidad.id);
                  
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
  int get rowCount => this.rentabilidades.length;

  @override
  int get selectedRowCount => 0;
}
