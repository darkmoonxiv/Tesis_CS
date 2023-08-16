import 'package:admin_dashboard/datatables/costos_datasource.dart';


import 'package:admin_dashboard/providers/users_provider.dart';
import 'package:flutter/material.dart';




import 'package:provider/provider.dart';


import '../../services/notifications_service.dart';





class CostosView extends StatefulWidget {
  @override
  State<CostosView> createState() => _CostosViewState();
}

class _CostosViewState extends State<CostosView> {
  int c=0;
      int? selectedInventarioId;

  @override
@override
void didChangeDependencies() {
  if(c==0){
     super.didChangeDependencies();
  Provider.of<UsersProvider>(context).getCostos();
   Provider.of<UsersProvider>(context).getInventario();
   Provider.of<UsersProvider>(context).getSiembra();
  c++;
  }
 
}



  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    final costos = usersProvider.costos;
    final inventario = usersProvider.inventario;
    final planeacion = usersProvider.parametrizacion;
    final usersDataSource = new CostosDataSource(costos,this.context,inventario,planeacion,false);
    final TextEditingController descriptionController = TextEditingController();
 
   
    final TextEditingController manoObraController = TextEditingController();
    final TextEditingController combustibleController = TextEditingController();



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
                 
                sortAscending: usersProvider.ascending,
                sortColumnIndex: usersProvider.sortColumnIndex,
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
                                title: Text('Agregar Costo'),
                                content: SingleChildScrollView(
                                  child: Column(
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
                                      await usersProvider.postCreateCosto(description, manoO, combustible,selectedInventarioId!,total);
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
                  "Costos",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
                headingRowHeight: 100,
                columnSpacing: 5,
                  
                columns: [
                  //DataColumn(label: Text('Id')),
                 
                  DataColumn(tooltip: "Descripción",
                    label: Text('Descripción')),
                   DataColumn(tooltip: "Mano de obra",
                    label: Text('Mano de obra')),
                   DataColumn(tooltip: "Insumo",
                    label: Text('Insumo')),
                     DataColumn(tooltip: "Combustible",
                    label: Text('Combustible')),
                     DataColumn(tooltip: "Inventario",
                    label: Text('Inventario')),
                      DataColumn(tooltip: "Fecha",
                    label: Text('Fecha')),
                       DataColumn(tooltip: "Total",
                    label: Text('Total')),

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