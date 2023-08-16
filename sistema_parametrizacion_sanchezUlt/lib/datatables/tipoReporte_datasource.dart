
import 'package:admin_dashboard/models/tipoReporte.dart';
import 'package:flutter/material.dart';



import 'package:provider/provider.dart';


import '../providers/users_provider.dart';


class TipoReporteDataSource extends DataTableSource {
  final List<ReporteTipo> reporteTipo;
  final BuildContext context;
  TipoReporteDataSource(this.reporteTipo, this.context);

  @override
   DataRow getRow(int index) {
    final ReporteTipo reporteTip = reporteTipo[index];


    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(reporteTip.id.toString())),
        DataCell(Text(reporteTip.reportName)),

        DataCell(
          Row(
            children: [
             
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  final usersProvider =
                      Provider.of<UsersProvider>(context, listen: false);
                  await usersProvider.deleteTipoReporte(reporteTip.id);
                  
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
  int get rowCount => this.reporteTipo.length;

  @override
  int get selectedRowCount => 0;
}
