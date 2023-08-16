
import 'package:admin_dashboard/datatables/rentabilidad_datasource.dart';

import 'package:admin_dashboard/providers/users_provider.dart';
import 'package:flutter/material.dart';




import 'package:provider/provider.dart';


import '../../services/notifications_service.dart';





class RentabilidadView extends StatefulWidget {
  @override
  State<RentabilidadView> createState() => _RentabilidadViewState();
}

class _RentabilidadViewState extends State<RentabilidadView> {
  int c=0;
      int? selectedCostosId;
int? selectedPlaneacionId;

int? selectedCostosID;
  @override
@override
void didChangeDependencies() {
  if(c==0){
     super.didChangeDependencies();
  Provider.of<UsersProvider>(context).getRentabilidad();
   Provider.of<UsersProvider>(context).getInventario();
   Provider.of<UsersProvider>(context).getSiembra();
   Provider.of<UsersProvider>(context).getCostos();
  c++;
  }
 
}



  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    //final costos = usersProvider.costos;
    final rentabilidad = usersProvider.rentabilidad;
   
    final planeacion = usersProvider.parametrizacion;
    final costos = usersProvider.costos;
    final usersDataSource = new RentabilidadDataSource(rentabilidad,this.context,costos,planeacion,false);











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
                            builder: (BuildContext context, StateSetter setState) {
                              return AlertDialog(
                                title: Text('Crear Rentabilidad'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                  
                                        

                                   
                                      DropdownButton<int>(
                                        value: selectedPlaneacionId,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedPlaneacionId = newValue;
                                          });
                                        },
                                        items: planeacion.map((item) {
                                          return DropdownMenuItem<int>(
                                            value: item.id,
                                            child: Text(item.planningSowing1Id.toString()), // Assuming there's a property "planningSowingCol" in the planeacion object
                                          );
                                        }).toList(),
                                        hint: Text('Select Planeacion'), // Shown when no item is selected
                                      ),
                                       DropdownButton<int>(
                                        value: selectedCostosID,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedCostosID = newValue;
                                          });
                                        },
                                        items: costos.map((item) {
                                          return DropdownMenuItem<int>(
                                            value: item.id,
                                            child: Text(item.description.toString()), // Assuming there's a property "planningSowingCol" in the planeacion object
                                          );
                                        }).toList(),
                                        hint: Text('Select Costo'), // Shown when no item is selected
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
                                  
                                    
                                          // ignore: unnecessary_null_comparison
                               
                                         if (selectedPlaneacionId == null || selectedPlaneacionId! <= 0  ) {
                                        NotificationsService.showSnackbar('planeación id incorrecto.');
                                        return;
                                      }
                                      
                                         if (selectedCostosID == null || selectedCostosID! <= 0  ) {
                                        NotificationsService.showSnackbar('Costos no seleccionado.');
                                        return;
                                      }
                  
                                      // Actualizar el inventario
                                    //  inventario.product = productoController.text;
                                     // inventario.purchaseDate = DateFormat.yMd().parse(fechaController.text);
                                      //inventario.quantity = cantidad;
                                      //inventario.unitPrice = precio;
                  
                                      // Guardar cambios
                                      
                                      await usersProvider.postCreateRentabilidad(selectedCostosID!,selectedPlaneacionId!);
                                     // NotificationsService.showSnackbar('Producto agregado al inventario');
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
                header: Center(
                    child: Text(
                  "Rentabilidad",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
                headingRowHeight: 100,
                columnSpacing: 5,
                  
                columns: [
                  //DataColumn(label: Text('Id')),
                 
                  DataColumn(tooltip: "Id",
                    label: Text('Id')),
                   DataColumn(tooltip: "Número de lote",
                    label: Text('Núm. lote')),
                      DataColumn(tooltip: "Número Racimos aceptados",
                    label: Text('Núm. Racimos aceptados')),
                       DataColumn(tooltip: "Peso estimado por Racimo",
                    label: Text('Peso estimado')),
                         DataColumn(tooltip: "Conversión de KG a LB",
                    label: Text('Conversión')),
           
                     DataColumn(tooltip: "Rentabilidad",
                    label: Text('Rentabilidad')),
         

                  DataColumn(label: Text('Acciones')),
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
