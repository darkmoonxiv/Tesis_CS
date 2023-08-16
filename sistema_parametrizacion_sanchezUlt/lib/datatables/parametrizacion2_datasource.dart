import 'package:admin_dashboard/models/parametrizacion.dart';
import 'package:flutter/material.dart';



import 'package:intl/intl.dart';


class Parametrizacion2DataSource extends DataTableSource {
  final List<Parametrizacion> parametrizaciones;
  final BuildContext context;
  final bool reporte;
  Parametrizacion2DataSource(this.parametrizaciones, this.context, this.reporte);

  @override
  DataRow getRow(int index) {
    final Parametrizacion parametrizacion = parametrizaciones[index];

    return DataRow.byIndex(index: index, cells: [
DataCell(
  Tooltip(
    message: DateFormat('MMM d, y').format(parametrizacion.sowingDate), // Mensaje del tooltip sin _trimString
    child: Text(_trimString(DateFormat('MMM d, y').format(parametrizacion.sowingDate), 5)),
  ),
),
DataCell(
  Tooltip(
    message: DateFormat('MMM d, y').format(parametrizacion.sowingDateEnd), // Mensaje del tooltip sin _trimString
    child: Text(_trimString(DateFormat('MMM d, y').format(parametrizacion.sowingDateEnd), 5)),
  ),
),
DataCell(
  Tooltip(
    message: parametrizacion.estimatedSowingTime.toString(), // Mensaje del tooltip sin _trimString
    child: Text(_trimString(parametrizacion.estimatedSowingTime.toString(), 5)),
  ),
),
DataCell(
  Tooltip(
    message: parametrizacion.numberOfBunches.toString(), // Mensaje del tooltip sin _trimString
    child: Text(_trimString(parametrizacion.numberOfBunches.toString(), 5)),
  ),
),
DataCell(
  Tooltip(
    message: parametrizacion.rejectedBunches.toString(), // Mensaje del tooltip sin _trimString
    child: Text(_trimString(parametrizacion.rejectedBunches.toString(), 5)),
  ),
),
DataCell(
  Tooltip(
    message: parametrizacion.averageBunchWeight.toString(), // Mensaje del tooltip sin _trimString
    child: Text(_trimString(parametrizacion.averageBunchWeight.toString(), 5)),
  ),
),



DataCell(
  Tooltip(
    message: parametrizacion.batchNumber.toString(), // Mensaje del tooltip sin _trimString
    child: Text(_trimString(parametrizacion.batchNumber.toString(), 5)),
  ),
),
DataCell(
  Tooltip(
    message: parametrizacion.planningSowing1Id.toString(), // Mensaje del tooltip sin _trimString
    child: Text(_trimString(parametrizacion.planningSowing1Id.toString(), 5)),
  ),
),


 
      
     
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => this.parametrizaciones.length;

  @override
  int get selectedRowCount => 0;
}
String _trimString(String value, int maxLength) {
  if (value.length > maxLength) {
    return value.substring(0, maxLength) + "...";
  }
  return value;
}
