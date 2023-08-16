import 'package:admin_dashboard/datatables/parametrizacion_datasource.dart';

import 'package:admin_dashboard/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../../datatables/parametrizacion2_datasource.dart';
import '../../services/notifications_service.dart';

class SiembraView extends StatefulWidget {
  @override
  State<SiembraView> createState() => _SiembraViewState();
}

class _SiembraViewState extends State<SiembraView> {
  int c = 0;
  @override
  @override
  void didChangeDependencies() {
    if (c == 0) {
      super.didChangeDependencies();
      Provider.of<UsersProvider>(context).getSiembra();

      c++;
    }
  }

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);

    final usersDataSource = new ParametrizacionDataSource(
        usersProvider.parametrizacion, this.context, false);
    final usersDataSource2 = new Parametrizacion2DataSource(
        usersProvider.parametrizacion, this.context, false);

    final TextEditingController condicionController = TextEditingController();

    final TextEditingController cantidadSemillasController =
        TextEditingController();
    final TextEditingController cantidadpesticidaController =
        TextEditingController();
    final TextEditingController cantidadFertilizanteController =
        TextEditingController();
    final TextEditingController fumgationDateController =
        TextEditingController();

    final TextEditingController sowingDateController = TextEditingController();
    final TextEditingController sowingDateEndController =
        TextEditingController();
    final TextEditingController numberOfBunchesController =
        TextEditingController();
    final TextEditingController rejectedBunchesController =
        TextEditingController();
    final TextEditingController averageBunchWeightController =
        TextEditingController();
    List<String> sowingOptions = ["3", "6", "12"];
    String selectedSowingOption = "3";
    List<String> batchOptions = ["1", "2", "3", "4", "5", "6"];
    String selectedBatchOption = "1";
     List<String> variedadOptions = ["Cavendish","Williams"];
    String selectedvariedadOption = "Cavendish";

    List<String> irrigationOptions = ["Motores/Bombas", "Electrico/Diesel"];
    String selectedIrrigationOption = "Motores/Bombas";

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
                actions: [
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.blue),
                    onPressed: () async {
                      final usersProvider =
                          Provider.of<UsersProvider>(context, listen: false);
                      

                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return AlertDialog(
                                title: Text('Agregar parametrización'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: condicionController,
                                        decoration: InputDecoration(
                                            labelText: 'Condición climática'),
                                      ),
                                      DropdownButtonFormField<String>(
                                        value: selectedvariedadOption,
                                        decoration:
                                            InputDecoration(labelText: 'Variedad del banano'),
                                        items: variedadOptions.map((option) {
                                          return DropdownMenuItem<String>(
                                            value: option,
                                            child: Text(option),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedvariedadOption =
                                                newValue!;
                                          });
                                        },
                                      ),
                                      TextField(
                                        controller: cantidadSemillasController,
                                        decoration: InputDecoration(
                                            labelText: 'Cantidad de semilla/plantas'),
                                      ),
                                      TextField(
                                        controller:
                                            cantidadFertilizanteController,
                                        decoration: InputDecoration(
                                            labelText:
                                                'Cantidad de fertilizante'),
                                        keyboardType: TextInputType.number,
                                      ),
                                      TextField(
                                        controller: cantidadpesticidaController,
                                        decoration: InputDecoration(
                                            labelText: 'Cantidad de pesticida'),
                                        keyboardType: TextInputType.number,
                                      ),
                                      TextField(
                                        controller: fumgationDateController,
                                        decoration: InputDecoration(
                                            labelText: 'Fecha fumigación'),
                                        readOnly: true,
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2040),
                                          ).then((selectedDate) {
                                            if (selectedDate != null) {
                                              setState(() {
                                                fumgationDateController.text =
                                                    DateFormat.yMd()
                                                        .format(selectedDate);
                                              });
                                            }
                                          });
                                        },
                                      ),
                                      DropdownButtonFormField<String>(
                                        value: selectedIrrigationOption,
                                        decoration:
                                            InputDecoration(labelText: 'Riego'),
                                        items: irrigationOptions.map((option) {
                                          return DropdownMenuItem<String>(
                                            value: option,
                                            child: Text(option),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedIrrigationOption =
                                                newValue!;
                                          });
                                        },
                                      ),
                                      TextField(
                                        controller: sowingDateController,
                                        decoration: InputDecoration(
                                            labelText: 'Fecha de inicio'),
                                        readOnly: true,
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime.now(),
                                          ).then((selectedDate) {
                                            if (selectedDate != null) {
                                              setState(() {
                                                sowingDateController.text =
                                                    DateFormat.yMd()
                                                        .format(selectedDate);
                                              });
                                            }
                                          });
                                        },
                                      ),
                                      TextField(
                                        controller: sowingDateEndController,
                                        decoration: InputDecoration(
                                            labelText: 'Fecha de fin'),
                                        readOnly: true,
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2030),
                                          ).then((selectedDate) {
                                            if (selectedDate != null) {
                                              setState(() {
                                                sowingDateEndController.text =
                                                    DateFormat.yMd()
                                                        .format(selectedDate);
                                              });
                                            }
                                          });
                                        },
                                      ),
                                      DropdownButtonFormField<String>(
                                        value: selectedSowingOption,
                                        decoration: InputDecoration(
                                            labelText: 'Tiempo estimado'),
                                        items: sowingOptions.map((option) {
                                          return DropdownMenuItem<String>(
                                            value: option,
                                            child: Text(option),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedSowingOption = newValue!;
                                          });
                                        },
                                      ),
                                      TextField(
                                        controller: numberOfBunchesController,
                                        decoration: InputDecoration(
                                            labelText: 'Número de racimos'),
                                        keyboardType: TextInputType.number,
                                      ),
                                      TextField(
                                        controller: rejectedBunchesController,
                                        decoration: InputDecoration(
                                            labelText:
                                                'Número de racimos rechazados'),
                                        keyboardType: TextInputType.number,
                                      ),
                                      TextField(
                                        controller:
                                            averageBunchWeightController,
                                        decoration: InputDecoration(
                                            labelText: 'Peso estimado'),
                                        keyboardType: TextInputType.number,
                                      ),
                                      DropdownButtonFormField<String>(
                                        value: selectedBatchOption,
                                        decoration: InputDecoration(
                                            labelText: 'Número de lote'),
                                        items: batchOptions.map((option) {
                                          return DropdownMenuItem<String>(
                                            value: option,
                                            child: Text("Lote #" + option),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedBatchOption = newValue!;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
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

                                      // Validar cantidad y precio

                                      final cantidadSemilla =
                                          cantidadSemillasController.text;
                                      final cantidadF = double.tryParse(
                                          cantidadFertilizanteController.text);
                                      final cantidadP = double.tryParse(
                                          cantidadpesticidaController.text);
                                      final condicion =
                                          condicionController.text;
                                      final variedadBanano =
                                          selectedvariedadOption;
                                      final riego = selectedIrrigationOption;
                                      final fumationDate =
                                          fumgationDateController.text;

                                      final fechaI = sowingDateController.text;
                                      final fechaF =
                                          sowingDateEndController.text;
                                      final selectedSowingOpt =
                                          int.tryParse(selectedSowingOption);

                                      final numberB = int.tryParse(
                                          numberOfBunchesController.text);
                                      final rechazados = int.tryParse(
                                          rejectedBunchesController.text);
                                      final estimadoPeso = double.tryParse(
                                          averageBunchWeightController.text);
                                      final numberLote =
                                          int.tryParse(selectedBatchOption);

// Validar que los campos no estén vacíos
                                      if (condicion.isEmpty ||
                                          variedadBanano.isEmpty) {
                                        NotificationsService.showSnackbar(
                                            'Variedad o condición incorrectos');
                                        return;
                                      }

// Validar que las fechas sean válidas
                                      // ignore: unnecessary_null_comparison
                                      if (fechaI == null || fechaF == "") {
                                        NotificationsService.showSnackbar(
                                            'Fecha o Nombre incorrectos');
                                        return;
                                      }

// Validar la longitud máxima de los campos
                                      final maxCharacters = 10;

                                      if (numberB.toString().length >
                                          maxCharacters) {
                                        numberOfBunchesController.text = numberB
                                                .toString()
                                                .substring(0, maxCharacters) +
                                            '...';
                                      }

                                      if (estimadoPeso.toString().length >
                                          maxCharacters) {
                                        averageBunchWeightController.text =
                                            estimadoPeso.toString().substring(
                                                    0, maxCharacters) +
                                                '...';
                                      }

                                      //final fecha = fechaController.text;
                                      // ignore: unnecessary_null_comparison
                                      if (condicion == null ||
                                          condicion == "" ||
                                          variedadBanano == null ||
                                          variedadBanano == "") {
                                        NotificationsService.showSnackbar(
                                            'variedad o condición incorrectos');
                                        return;
                                      }

                                      // Actualizar el inventario
                                      //  inventario.product = productoController.text;
                                      // inventario.purchaseDate = DateFormat.yMd().parse(fechaController.text);
                                      //inventario.quantity = cantidad;
                                      //inventario.unitPrice = precio;

                                      // Guardar cambios
                                      await usersProvider
                                          .postCreateParametrizacion(
                                              condicion,
                                              cantidadSemilla,
                                              variedadBanano,
                                              cantidadF!,
                                              cantidadP!,
                                              fumationDate,
                                              riego,
                                              fechaI,
                                              fechaF,
                                              selectedSowingOpt!,
                                              estimadoPeso!,
                                              numberB!,
                                              rechazados!,
                                              numberLote!);

                                      NotificationsService.showSnackbar(
                                          'Parametrización creada');
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
                ],
                columnSpacing: 5,
                header: Center(
                    child: Text(
                  "Planificicación Siembra 1",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
                headingRowHeight: 100,
                columns: [
                  DataColumn(tooltip: "ID", label: Text('ID')),
                  DataColumn(
                      tooltip: "Condición climática",
                      label: Text('Cond. Climática')),
                  DataColumn(
                      tooltip: "Variedad del banano",
                      label: Text('Var. Banano')),
                  DataColumn(
                      tooltip: "Cantidad del pesticida",
                      label: Text('Cant. pesticida')),
                  DataColumn(
                      tooltip: "Cantidad del fertilizante",
                      label: Text('Cant. fertilizante')),
                  DataColumn(
                      tooltip: "Cantidad de la semilla",
                      label: Text('Cant. semillas/plantas')),
                  DataColumn(
                      tooltip: "Fecha de fumigación",
                      label: Text('Fecha fumigación')),
                  DataColumn(tooltip: "Riego", label: Text('Riego')),
                  DataColumn(label: Text('Acciones')),
                ],
                source: usersDataSource,
                onPageChanged: (page) {},
              ),
            ),

            //PLANIFICACION 2
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: PaginatedDataTable(
                columnSpacing: 5,
                header: Center(
                    child: Text(
                  "Planificiación Siembra 2",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
                headingRowHeight: 100,
                columns: [
                  DataColumn(
                      tooltip: "Fecha Siembra", label: Text('Fecha Inicio')),
                  DataColumn(
                      tooltip: "Fecha Siembra", label: Text('Fecha Fin')),
                  DataColumn(
                      tooltip: "Tiempo estimado",
                      label: Text('Tiempo estimado')),
                  DataColumn(
                      tooltip: "Número de racimos",
                      label: Text('Núm. racimos')),
                  DataColumn(
                      tooltip: "Número de racimos rechazados",
                      label: Text('Núm. rechazados')),
                  DataColumn(
                      tooltip: "Peso promedio", label: Text('Peso promedio')),
                  DataColumn(
                      tooltip: "Número de lote", label: Text('Núm. Lote')),
                  DataColumn(
                      tooltip: "ID parametrización 1",
                      label: Text('ID de param. 1')),
                ],
                source: usersDataSource2,
                onPageChanged: (page) {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
