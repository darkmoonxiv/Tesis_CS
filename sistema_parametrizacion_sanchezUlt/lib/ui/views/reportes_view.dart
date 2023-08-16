import 'dart:async';

import 'package:admin_dashboard/datatables/inventario_datasource.dart';
import 'package:admin_dashboard/models/costos.dart';
import 'package:admin_dashboard/models/inventario.dart';
import 'package:admin_dashboard/models/parametrizacion.dart';
import 'package:admin_dashboard/models/rentabilidad.dart';
import 'package:admin_dashboard/models/tipoReporte.dart';

import 'package:admin_dashboard/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';


// ignore: unused_import
import 'dart:convert';
// ignore: unnecessary_import
import 'dart:typed_data';
import 'package:provider/provider.dart';

import '../../datatables/costos_datasource.dart';
import '../../datatables/parametrizacion2_datasource.dart';
import '../../datatables/parametrizacion_datasource.dart';
import '../../datatables/permisos_datasource.dart';
import '../../datatables/rentabilidad_datasource.dart';
import '../../datatables/users_datasource.dart';


import 'package:pdf/widgets.dart' as pw;
import 'dart:html' as html;

import 'package:universal_html/html.dart' as html;


import 'package:flutter/services.dart';

import '../../models/permisos.dart';
import '../../models/usuario.dart';


void generateAndDownloadPdfSiembra(List<Parametrizacion> parametrizacion, List<Costos> costos ) async {
  final pdf = pw.Document();
  final ByteData imageLeftData = await rootBundle.load('assets/logo_pdfFruty.jpeg');
  final ByteData imageCenterData = await rootBundle.load('/seguimientoS.jpeg');
  final ByteData imageRightData = await rootBundle.load('/logo_pdfImagen.jpeg');

  final Uint8List imageLeftBytes = imageLeftData.buffer.asUint8List();
  final Uint8List imageCenterBytes = imageCenterData.buffer.asUint8List();
  final Uint8List imageRightBytes = imageRightData.buffer.asUint8List();

  // Crear las imágenes
  final pdfImageLeft = pw.MemoryImage(imageLeftBytes);
  final pdfImageCenter = pw.MemoryImage(imageCenterBytes);
  final pdfImageRight = pw.MemoryImage(imageRightBytes);

  // Crear la tabla de permisos
  final permisosTable = pw.Table(
     border: pw.TableBorder.all(),

    children: [
      pw.TableRow(
        children: [
          pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child:pw.Text('ID', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child:pw.Text('Condición climatica', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child:pw.Text('Variación del Banano', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child:pw.Text('Cantidad de semillas', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child:pw.Text('Cantidad de pesticida', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child:pw.Text('Cantidad de fertilizante', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child:pw.Text('Fecha fumigación', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child:pw.Text('Riego', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
        ],
      ),
      ...parametrizacion.map((parametrizaci) {
        return pw.TableRow(
          children: [
              pw.Container(
              color: PdfColors.green100,  
              alignment: pw.Alignment.center,
              child:pw.Text(parametrizaci.id.toString(),style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
              color: PdfColors.green100,  
              alignment: pw.Alignment.center,
              child:pw.Text(parametrizaci.climaticCondition,style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
              color: PdfColors.green100,  
              alignment: pw.Alignment.center,
              child:pw.Text(parametrizaci.bananaVariety,style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
              color: PdfColors.green100,  
              alignment: pw.Alignment.center,
              child:pw.Text(parametrizaci.seedName.toString(),style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
              color: PdfColors.green100,  
              alignment: pw.Alignment.center,
              child:pw.Text(parametrizaci.pesticideQuantityKG.toString(),style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
              color: PdfColors.green100,  
              alignment: pw.Alignment.center,
              child:pw.Text(parametrizaci.fertilizerQuantityKG.toString(),style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
              color: PdfColors.green100,               
              alignment: pw.Alignment.center,
              child:pw.Text(parametrizaci.fumigationDate.toString(),style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
              color: PdfColors.green100,  
              alignment: pw.Alignment.center,
              child:pw.Text(parametrizaci.irrigation.toString(),style: pw.TextStyle(fontSize: 10)),
              ),

          ],
        );
      }),
    ],
  );

  // Crear la tabla de usuarios
  final usuariosTable = pw.Table(
    border: pw.TableBorder.all(),
    children: [
      pw.TableRow(
        children: [
          pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child: pw.Text('Fecha Inicio', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,    
          alignment: pw.Alignment.center,
          child:pw.Text('Fecha fin', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,    
          alignment: pw.Alignment.center,
          child:pw.Text('Tiempo estimado', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,    
          alignment: pw.Alignment.center,
          child:pw.Text('Núm. Racimos ', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,    
          alignment: pw.Alignment.center,
          child: pw.Text('Núm. Rechazados', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,    
          alignment: pw.Alignment.center,
          child:pw.Text('Peso promedio', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,    
          alignment: pw.Alignment.center,
          child:pw.Text('Núm de lote', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,    
          alignment: pw.Alignment.center,
          child:pw.Text('Id parametrización I', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
        ],
      ),
      ...parametrizacion.map((parametrizaci) {
        return pw.TableRow(
          children: [
              pw.Container(
              color: PdfColors.green100,  
              alignment: pw.Alignment.center,
              child:pw.Text(parametrizaci.sowingDate.toString(),style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
              color: PdfColors.green100,  
              alignment: pw.Alignment.center,
              child:pw.Text(parametrizaci.sowingDateEnd.toString(),style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
              color: PdfColors.green100,    
              alignment: pw.Alignment.center,
              child:pw.Text(parametrizaci.estimatedSowingTime.toString(),style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
              color: PdfColors.green100,    
              alignment: pw.Alignment.center,
              child:pw.Text(parametrizaci.numberOfBunches.toString(),style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
              color: PdfColors.green100,    
              alignment: pw.Alignment.center,
              child:pw.Text(parametrizaci.rejectedBunches.toString(),style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
              color: PdfColors.green100,    
              alignment: pw.Alignment.center,
              child:pw.Text(parametrizaci.averageBunchWeight.toString(),style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
              color: PdfColors.green100,  
              alignment: pw.Alignment.center,
              child:pw.Text(parametrizaci.batchNumber.toString(),style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
              color: PdfColors.green100,    
              alignment: pw.Alignment.center,
              child:pw.Text(parametrizaci.id.toString(),style: pw.TextStyle(fontSize: 10)),
              ),
          ],
        );
      }),
    ],
  );

  // Agregar las tablas al documento PDF
  pdf.addPage(
 pw.MultiPage(
      header: (pw.Context context) {
        return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Image(pdfImageLeft, width: 100, height: 100),
            pw.Image(pdfImageCenter, width: 200, height: 150),
            pw.Image(pdfImageRight, width: 100, height: 100),
          ],
        );
      },
   
      footer: (pw.Context context) {
        return pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text('Página ${context.pageNumber} de ${context.pagesCount}', style: pw.TextStyle(fontSize: 12)),
        );
      },
      build: (pw.Context context) {
        return [
         // Reemplaza "yourLeftImageProvider" con la imagen de la esquina izquierda


          pw.Text('Informe de Siembra', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.Text('Tabla de Parametrización 1', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          permisosTable,
          pw.SizedBox(height: 20),
          pw.Text('Tabla de Parametrización 2', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          usuariosTable,
        ];
      },
    ),
  );

  final Uint8List bytes = await pdf.save();

  // Descargar el archivo PDF
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = 'InformeSiembra.pdf';

  html.document.body?.children.add(anchor);
  anchor.click();

  html.document.body?.children.remove(anchor);
  html.Url.revokeObjectUrl(url);
}

void generateAndDownloadPdfInventario(List<Inventario> inventario, List<Costos> costos ) async {
  final pdf = pw.Document();

  final ByteData imageLeftData = await rootBundle.load('assets/logo_pdfFruty.jpeg');
  final ByteData imageCenterData = await rootBundle.load('/seguimientoS.jpeg');
  final ByteData imageRightData = await rootBundle.load('/logo_pdfImagen.jpeg');

  final Uint8List imageLeftBytes = imageLeftData.buffer.asUint8List();
  final Uint8List imageCenterBytes = imageCenterData.buffer.asUint8List();
  final Uint8List imageRightBytes = imageRightData.buffer.asUint8List();

  // Crear las imágenes
  final pdfImageLeft = pw.MemoryImage(imageLeftBytes);
  final pdfImageCenter = pw.MemoryImage(imageCenterBytes);
  final pdfImageRight = pw.MemoryImage(imageRightBytes);

  // Crear la tabla de permisos
  final permisosTable = pw.Table(
    border: pw.TableBorder.all(),
    children: [
      pw.TableRow(
        children: [
          pw.Container(
          color: PdfColors.green300,    
          alignment: pw.Alignment.center,
          child: pw.Text('ID', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,    
          alignment: pw.Alignment.center,
          child: pw.Text('Producto', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,    
          alignment: pw.Alignment.center,
          child: pw.Text('Cantidad', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,    
          alignment: pw.Alignment.center,
          child:  pw.Text('Precio', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,    
          alignment: pw.Alignment.center,
          child: pw.Text('Fecha', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
       
        ],
      ),
      ...inventario.map((inventario) {
        return pw.TableRow(
          children: [
            pw.Container(color: PdfColors.green100,  alignment: pw.Alignment.center,
            child: pw.Text(inventario.id.toString(), style: pw.TextStyle(fontSize: 10),
            ), ),
            pw.Container(color: PdfColors.green100,  alignment: pw.Alignment.center,
            child: pw.Text(inventario.product,style: pw.TextStyle(fontSize: 10),
            ), ),
            pw.Container(color: PdfColors.green100,  alignment: pw.Alignment.center,
            child: pw.Text(inventario.unitPrice.toString(),style: pw.TextStyle(fontSize: 10),
            ), ),
           pw.Container(color: PdfColors.green100,  alignment: pw.Alignment.center,
            child:  pw.Text(inventario.quantity.toString(), style: pw.TextStyle(fontSize: 10),
            ), ),
            pw.Container(color: PdfColors.green100,  alignment: pw.Alignment.center,
            child: pw.Text(inventario.purchaseDate.toString(), style: pw.TextStyle(fontSize: 10),
            ), ),
     
          ],
        );
      }),
    ],
  );

  // Crear la tabla de usuarios
  final usuariosTable = pw.Table(
    border: pw.TableBorder.all(),
    children: [
      pw.TableRow(
        children: [
         pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child: pw.Text('ID', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
         ),
          pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child:pw.Text('Descripción', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
         pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child: pw.Text('Mano de obra', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
         pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child: pw.Text('Inventario id', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
         pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child:pw.Text('Combustible', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
         pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child: pw.Text('Insumos', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
         pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child:pw.Text('total', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
        
        ],
      ),
      ...costos.map((costo) {
        return pw.TableRow(
          children: [
          pw.Container(
          color: PdfColors.green100,    
          alignment: pw.Alignment.center,
          child:pw.Text(costo.id.toString(),style: pw.TextStyle(fontSize: 10),
          ), ),
          pw.Container(
          color: PdfColors.green100,    
          alignment: pw.Alignment.center,
          child:pw.Text(costo.description,style: pw.TextStyle(fontSize: 10),
          ),),
          pw.Container(
          color: PdfColors.green100,  
          alignment: pw.Alignment.center,
          child:pw.Text(costo.labor.toString(),style: pw.TextStyle(fontSize: 10),
          ), ),
          pw.Container(
          color: PdfColors.green100,    
          alignment: pw.Alignment.center,
          child:pw.Text(costo.inventoryId.toString(), style: pw.TextStyle(fontSize: 10),
          ), ),
          pw.Container(
          color: PdfColors.green100,  
          alignment: pw.Alignment.center,
          child:pw.Text(costo.fuel.toString(),style: pw.TextStyle(fontSize: 10),
          ), ),
          pw.Container(
          color: PdfColors.green100,  
          alignment: pw.Alignment.center,
          child:pw.Text(costo.input.toString(),style: pw.TextStyle(fontSize: 10),
          ), ),
          pw.Container(
          color: PdfColors.green100,  
          alignment: pw.Alignment.center,
          child:pw.Text(costo.totalCosts.toString(),style: pw.TextStyle(fontSize: 10),
            ), ),
          ],
        );
      }),
    ],
  );

  // Agregar las tablas al documento PDF
  pdf.addPage(
     pw.MultiPage(
      header: (pw.Context context) {
        return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Image(pdfImageLeft, width: 100, height: 100),
            pw.Image(pdfImageCenter, width: 200, height: 150),
            pw.Image(pdfImageRight, width: 100, height: 100),
          ],
        );
      },
      footer: (pw.Context context) {
        return pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text('Página ${context.pageNumber} de ${context.pagesCount}', style: pw.TextStyle(fontSize: 12)),
        );
      },
      build: (pw.Context context) {
        return [
          pw.Text('Tabla de Inventario', style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          permisosTable,
          pw.SizedBox(height: 20),
          pw.Text('Tabla de Costos', style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          usuariosTable,
        ];
      },
    ),
  );

  final Uint8List bytes = await pdf.save();

  // Descargar el archivo PDF
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = 'InformeInventario.pdf';

  html.document.body?.children.add(anchor);
  anchor.click();

  html.document.body?.children.remove(anchor);
  html.Url.revokeObjectUrl(url);
}

void generateAndDownloadPdfRentCosto(List<Rentabilidad> rentabilidad, List<Costos> costos ) async {
  final pdf = pw.Document();

  final ByteData imageLeftData = await rootBundle.load('assets/logo_pdfFruty.jpeg');
  final ByteData imageCenterData = await rootBundle.load('/seguimientoS.jpeg');
  final ByteData imageRightData = await rootBundle.load('/logo_pdfImagen.jpeg');

  final Uint8List imageLeftBytes = imageLeftData.buffer.asUint8List();
  final Uint8List imageCenterBytes = imageCenterData.buffer.asUint8List();
  final Uint8List imageRightBytes = imageRightData.buffer.asUint8List();

  // Crear las imágenes
  final pdfImageLeft = pw.MemoryImage(imageLeftBytes);
  final pdfImageCenter = pw.MemoryImage(imageCenterBytes);
  final pdfImageRight = pw.MemoryImage(imageRightBytes);

  // Crear la tabla de permisos
  final permisosTable = pw.Table(
  border: pw.TableBorder.all(),
  children: [
    pw.TableRow(
      children: [
        pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child: pw.Text('ID', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
        ),
        pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child: pw.Text('Número de lote', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
        ),
        pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child: pw.Text('Número de racimos aceptados', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
        ),
        pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child: pw.Text('Peso estimado por racimo', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
        ),
        pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child: pw.Text('Conversión', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
        ),
        pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child: pw.Text('Rentabilidad', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
        ),
      ],
    ),
    // ... aquí puedes agregar las filas de datos de manera similar a lo que tenías antes ...
        ...rentabilidad.map((renta) {
        return pw.TableRow(
          children: [
            pw.Container(
            color: PdfColors.green100,  
            alignment: pw.Alignment.center,
            child:pw.Text(renta.id.toString(),
            style: pw.TextStyle(fontSize: 10),
            ),
            ),
            pw.Container(
            color: PdfColors.green100,  
            alignment: pw.Alignment.center,
            child:pw.Text(renta.planningSowing2.batchNumber.toString(),
            style: pw.TextStyle(fontSize: 10),
            ),
            ),
            pw.Container(
            color: PdfColors.green100,    
            alignment: pw.Alignment.center,
            child:pw.Text((renta.planningSowing2.numberOfBunches-renta.planningSowing2.rejectedBunches).toString(),
            style: pw.TextStyle(fontSize: 10),
            ),
            ),
            pw.Container(
            color: PdfColors.green100,    
            alignment: pw.Alignment.center,
            child: pw.Text(((renta.planningSowing2.averageBunchWeight*(renta.planningSowing2.numberOfBunches-renta.planningSowing2.rejectedBunches)/1000)).toStringAsFixed(2)+"KG",
            style: pw.TextStyle(fontSize: 10),
            ),
            ),
            pw.Container(
            color: PdfColors.green100,    
            alignment: pw.Alignment.center,
            child:pw.Text((((renta.planningSowing2.averageBunchWeight*(renta.planningSowing2.numberOfBunches-renta.planningSowing2.rejectedBunches))*2.20/1000)).toStringAsFixed(2)+"LB",
            style: pw.TextStyle(fontSize: 10),
            ),        
            ),
            pw.Container(
            color: PdfColors.green100,  
            alignment: pw.Alignment.center,
            child: pw.Text(
                ((renta.planningSowing2.averageBunchWeight * (renta.planningSowing2.numberOfBunches - renta.planningSowing2.rejectedBunches) * 2.20) >= 45)
                    ? "RENTABLE"
                    : "NO RENTABLE",
                  style: pw.TextStyle(fontSize:10,
                  color: (renta.planningSowing2.averageBunchWeight * (renta.planningSowing2.numberOfBunches - renta.planningSowing2.rejectedBunches) * 2.20) >= 45
                      ? PdfColors.green600
                      : PdfColors.red,
                ),
              ),
),


     

     
          ],
        );
      }),
    ],
  );

  // Crear la tabla de usuarios
  final usuariosTable = pw.Table(
    border: pw.TableBorder.all(),
    children: [
      pw.TableRow(
        children: [
          pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child: pw.Text('ID', style: pw.TextStyle(fontSize: 10,fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child: pw.Text('Descripción', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child: pw.Text('Mano de obra', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child: pw.Text('Inventario id', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child: pw.Text('Combustible', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),      
          pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child: pw.Text('Insumos', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child: pw.Text('Planeación ID', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child: pw.Text('total', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
         ),
      ],
    ),
      ...costos.map((costo) {
        return pw.TableRow(
          children: [
            pw.Container(
            color: PdfColors.green100,  
            alignment: pw.Alignment.center,
            child: pw.Text(costo.id.toString(), style: pw.TextStyle(fontSize: 10),
            ),
            ),
            pw.Container(
            color: PdfColors.green100,  
            alignment: pw.Alignment.center,
            child:pw.Text(costo.description,style: pw.TextStyle(fontSize: 10),
            ),
            ),
            pw.Container(
            color: PdfColors.green100,    
            alignment: pw.Alignment.center,
            child:pw.Text(costo.labor.toString(),style: pw.TextStyle(fontSize: 10),
            ),
            ),
            pw.Container(
            color: PdfColors.green100,    
            alignment: pw.Alignment.center,
            child:pw.Text(costo.inventoryId.toString(),style: pw.TextStyle(fontSize: 10),
            ),
            ),
            pw.Container(
            color: PdfColors.green100,    
            alignment: pw.Alignment.center,
            child:pw.Text(costo.fuel.toString(),style: pw.TextStyle(fontSize: 10),
            ),
            ),
            pw.Container(
            color: PdfColors.green100,  
            alignment: pw.Alignment.center,
            child: pw.Text(costo.input.toString(),style: pw.TextStyle(fontSize: 10),
            ),
            ),
            pw.Container(
            color: PdfColors.green100,  
            alignment: pw.Alignment.center,
            child:pw.Text(costo.id.toString(),style: pw.TextStyle(fontSize: 10),
            ),
            ),
            pw.Container(
            color: PdfColors.green100,  
            alignment: pw.Alignment.center,
            child: pw.Text(costo.totalCosts.toString(),style: pw.TextStyle(fontSize: 10),
            ),
            ),
             
          ],
        );
      }),
    ],
  );

  // Agregar las tablas al documento PDF
  pdf.addPage(
   pw.MultiPage(
      header: (pw.Context context) {
        return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Image(pdfImageLeft, width: 100, height: 100),
            pw.Image(pdfImageCenter, width: 200, height: 150),
            pw.Image(pdfImageRight, width: 100, height: 100),
          ],
        );
      },
      footer: (pw.Context context) {
        return pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text('Página ${context.pageNumber} de ${context.pagesCount}', style: pw.TextStyle(fontSize: 12)),
        );
      },
      build: (pw.Context context) {
        return [
          pw.Text('Tabla de Rentabilidad', style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          permisosTable,
          pw.SizedBox(height: 20),
          pw.Text('Tabla de costos', style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          usuariosTable,
        ];
      },
    ),
  );

  final Uint8List bytes = await pdf.save();

  // Descargar el archivo PDF
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = 'InformeRentabilidadyCosto.pdf';

  html.document.body?.children.add(anchor);
  anchor.click();

  html.document.body?.children.remove(anchor);
  html.Url.revokeObjectUrl(url);
}
void generateAndDownloadPdfAdministracion(List<Permisos> permisos, List<Usuario> usuarios ) async {
  final pdf = pw.Document();

  final ByteData imageLeftData = await rootBundle.load('assets/logo_pdfFruty.jpeg');
  final ByteData imageCenterData = await rootBundle.load('/seguimientoS.jpeg');
  final ByteData imageRightData = await rootBundle.load('/logo_pdfImagen.jpeg');

  final Uint8List imageLeftBytes = imageLeftData.buffer.asUint8List();
  final Uint8List imageCenterBytes = imageCenterData.buffer.asUint8List();
  final Uint8List imageRightBytes = imageRightData.buffer.asUint8List();

  // Crear las imágenes
  final pdfImageLeft = pw.MemoryImage(imageLeftBytes);
  final pdfImageCenter = pw.MemoryImage(imageCenterBytes);
  final pdfImageRight = pw.MemoryImage(imageRightBytes);

  // Crear la tabla de permisos
  final permisosTable = pw.Table(
    border: pw.TableBorder.all(),
    children: [
      pw.TableRow(
        children: [
          pw.Text('ID', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          pw.Text('Descripción', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
        ],
      ),
      ...permisos.map((permiso) {
        return pw.TableRow(
          children: [
            pw.Text(permiso.id.toString()),
            pw.Text(permiso.description),
          ],
        );
      }),
    ],
  );

  // Crear la tabla de usuarios
  final usuariosTable = pw.Table(
    border: pw.TableBorder.all(),
    
    children: [
      pw.TableRow(
        children: [
          pw.Container(
          color: PdfColors.green300, // Color de fondo para el título 'ID'
          alignment: pw.Alignment.center,
          child:pw.Text('ID', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,
          alignment: pw.Alignment.center,
          child:pw.Text('Nombre', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,
          alignment: pw.Alignment.center,
          child:pw.Text('Apellido', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,
          alignment: pw.Alignment.center,
          child:pw.Text('Correo Electrónico', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child:pw.Text('Estado', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
          color: PdfColors.green300,  
          alignment: pw.Alignment.center,
          child:pw.Text('Rol', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          ),
        ],
      ),
      ...usuarios.map((usuario) {
        return pw.TableRow(
          children: [
            pw.Container(
            color: PdfColors.green100,
            alignment: pw.Alignment.center,
            child:pw.Text(usuario.id.toString(),style: pw.TextStyle(fontSize: 10),
            ), ),
            pw.Container(
            color: PdfColors.green100,
            alignment: pw.Alignment.center,
            child:pw.Text(usuario.firstName,style: pw.TextStyle(fontSize: 10),
            ), ),
            pw.Container(
            color: PdfColors.green100,
            alignment: pw.Alignment.center,
            child:pw.Text(usuario.lastName,style: pw.TextStyle(fontSize: 10),
            ),),
            pw.Container(
            color: PdfColors.green100, 
            alignment: pw.Alignment.center,
            child:pw.Text(usuario.email,style: pw.TextStyle(fontSize: 10),
            ), ),
            pw.Container(
            color: PdfColors.green100,
            alignment: pw.Alignment.center,
            child:pw.Text(usuario.state,style: pw.TextStyle(fontSize: 10),
            ), ),
            pw.Container(
            color: PdfColors.green100,  
            alignment: pw.Alignment.center,
            child:pw.Text(usuario.roles[0].roleName,style: pw.TextStyle(fontSize: 10),
            ), ),
          ],
        );
      }),
    ],
  );

  // Agregar las tablas al documento PDF
  pdf.addPage(
     pw.MultiPage(
      header: (pw.Context context) {
        return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Image(pdfImageLeft, width: 100, height: 100),
            pw.Image(pdfImageCenter, width: 200, height: 150),
            pw.Image(pdfImageRight, width: 100, height: 100),
          ],
        );
      },
      footer: (pw.Context context) {
        return pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text('Página ${context.pageNumber} de ${context.pagesCount}', style: pw.TextStyle(fontSize: 12)),
        );
      },
      build: (pw.Context context) {
        return [
          pw.Text('Tabla de Permisos', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          permisosTable,
          pw.SizedBox(height: 20),
          pw.Text('Tabla de Usuarios', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          usuariosTable,
        ];
      },
    ),
  );

  final Uint8List bytes = await pdf.save();

  // Descargar el archivo PDF
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = 'InformeAdministracion.pdf';

  html.document.body?.children.add(anchor);
  anchor.click();

  html.document.body?.children.remove(anchor);
  html.Url.revokeObjectUrl(url);
}



class ReportesView extends StatefulWidget {
  @override
  State<ReportesView> createState() => _ReportesViewState();
}

class _ReportesViewState extends State<ReportesView> {
  int c=0;
  String nombreReporte="";
   int? selectedTipoReporteId;
  @override
@override
void didChangeDependencies() {
  if(c==0){
     super.didChangeDependencies();
  Provider.of<UsersProvider>(context).getInventario();
  Provider.of<UsersProvider>(context).getTipoReporte();
    Provider.of<UsersProvider>(context).getPaginatedUsers();
       Provider.of<UsersProvider>(context).getPermisos();
       Provider.of<UsersProvider>(context).getSiembra();
         Provider.of<UsersProvider>(context).getRentabilidad();
         Provider.of<UsersProvider>(context).getCostos();
  c++;
  }
 
}

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    final inventario = usersProvider.inventario;
      final costos = usersProvider.costos;
          final costosDataSource = new CostosDataSource(costos,this.context,inventario,usersProvider.parametrizacion,true);
     final usersDataSource = new UsersDataSource(usersProvider.users,this.context,true);
    final inventarioDataSource = new InventarioDataSource(inventario,this.context,true);
    final tipoRepo = usersProvider.reporteTipos;
           final permisosRol =usersProvider.permisosRol;
       final permisos = usersProvider.permisos;
        final parametrizacionDataSource = new ParametrizacionDataSource(
        usersProvider.parametrizacion, this.context,true);
           final parametrizacion2DataSource = new Parametrizacion2DataSource(
        usersProvider.parametrizacion, this.context,true);
        final rentabilidad = usersProvider.rentabilidad;
    final permisoDataSource = new PermisosDataSource(permisos,this.context,permisosRol,true);
      final rentabilidadDataSource = new RentabilidadDataSource(rentabilidad,this.context,costos,usersProvider.parametrizacion,true);
     
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
                  width: MediaQuery.of(context).size.width * 0.4, // Ajusta el ancho del contenedor según tus necesidades
                  child: DropdownButtonFormField<ReporteTipo>(
                    value: null,
                    isDense: true, // Reduce el espacio vertical entre los elementos del menú desplegable
                    decoration: InputDecoration(labelText: 'Escoja tipo de Reporte'),
                    items: tipoRepo
                        .map<DropdownMenuItem<ReporteTipo>>(
                          (ReporteTipo reportT) => DropdownMenuItem<ReporteTipo>(
                            value: reportT,
                            child: Text(reportT.reportName),
                          ),
                        )
                        .toList(),
                    onChanged: (ReporteTipo? value) async {
                      selectedTipoReporteId = value?.id;
                      nombreReporte = value?.reportName ?? "";
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
            if(selectedTipoReporteId!=null)
               Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4, // Ajusta el ancho del contenedor según tus necesidades
                  child:  IconButton(onPressed: (){
                      if(selectedTipoReporteId==1)generateAndDownloadPdfAdministracion(permisos,usersProvider.users);
                      if(selectedTipoReporteId==2)generateAndDownloadPdfSiembra(usersProvider.parametrizacion, costos);
                      if(selectedTipoReporteId==3)generateAndDownloadPdfInventario(inventario, costos);
                      if(selectedTipoReporteId==4)generateAndDownloadPdfRentCosto(rentabilidad, costos);
                  }, icon: Icon(Icons.picture_as_pdf,color: Colors.red,size: 35,))
                ),
              ),
            ),
           
            if(selectedTipoReporteId==4 && rentabilidad.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: PaginatedDataTable(
                 

                
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
         

             
                ],
                source: rentabilidadDataSource,
                onPageChanged: (page) {
               
                },
              ),
            ),
            if(selectedTipoReporteId==3)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: PaginatedDataTable(
                
                sortAscending: usersProvider.ascending,
                sortColumnIndex: usersProvider.sortColumnIndex,
       
                header: Center(
                    child: Text(
                  "$nombreReporte",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
                headingRowHeight: 100,
               
                  
                columns: [
                  DataColumn(label: Text('Id')),
                 
                  DataColumn(label: Text('Producto')),
                
                  DataColumn(label: Text('Fecha de compra')),
                  DataColumn(label: Text('Cantidad')),
                 
                  DataColumn(label: Text('Precio')),
                  
                ],
                source: inventarioDataSource,
                onPageChanged: (page) {
               
                },
              ),
            ),
            if(selectedTipoReporteId==1&&usersProvider.users.isNotEmpty)
            Padding(

              padding: const EdgeInsets.all(15.0),
              child: PaginatedDataTable(
                
                sortAscending: usersProvider.ascending,
                sortColumnIndex: usersProvider.sortColumnIndex,
                header: Center(
                    child: Text(
                  "$nombreReporte",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
                headingRowHeight: 100,
                
                columns: [
                  DataColumn(label: Text('Id'),numeric: true),
                  DataColumn(
                      label: Text('Nombre'),
                      onSort: (colIndex, _) {
                        usersProvider.sortColumnIndex = colIndex;
                        usersProvider.sort<String>((user) => user.firstName);
                      }),
                  DataColumn(label: Text('Apellido'),
                  onSort: (colIndex, _) {
                        usersProvider.sortColumnIndex = colIndex;
                        usersProvider.sort<String>((user) => user.lastName);
                      }),
                  DataColumn(
                      label: Text('Email'),
                      onSort: (colIndex, _) {
                        usersProvider.sortColumnIndex = colIndex;
                        usersProvider.sort<String>((user) => user.email);
                      }),
                  DataColumn(label: Text('Rol')),
                  DataColumn(label: Text('Estado')),
        
                ],
                source: usersDataSource,
                onPageChanged: (page) {
                  print('page: $page');
                },
              ),
            ),
            if(selectedTipoReporteId==1 &&permisos.isNotEmpty)
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
   
                ],
                source: permisoDataSource,
                onPageChanged: (page) {
               
                },
              ),
            ),
            if(selectedTipoReporteId==2)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: PaginatedDataTable(
             
                columnSpacing: 10,
                sortAscending: usersProvider.ascending,
                sortColumnIndex: usersProvider.sortColumnIndex,
                header: Center(
                    child: Text(
                  "Parametrización",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
                headingRowHeight: 130,
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
                      tooltip: "Nombre de la semilla",
                      label: Text('N. semillas')),
                  DataColumn(
                      tooltip: "Fecha de fumigación",
                      label: Text('Fecha fumigación')),
                  DataColumn(
                      tooltip: "Riego", 
                      label: Text('Riego')),
                
                ],
                source: parametrizacionDataSource,
                onPageChanged: (page) {},
              ),
            ),
                   if(selectedTipoReporteId==2)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: PaginatedDataTable(
             
                columnSpacing: 8,
                sortAscending: usersProvider.ascending,
                sortColumnIndex: usersProvider.sortColumnIndex,
                header: Center(
                    child: Text(
                  "Parametrización 2",
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
                source: parametrizacion2DataSource,
                onPageChanged: (page) {},
              ),
            ),


            if(selectedTipoReporteId==2&&costos.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: PaginatedDataTable(
                 
                sortAscending: usersProvider.ascending,
                sortColumnIndex: usersProvider.sortColumnIndex,
                
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

               
                ],
                source: costosDataSource,
                onPageChanged: (page) {
               
                },
              ),
            ),
             if(selectedTipoReporteId==4&&costos.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: PaginatedDataTable(
                 
                sortAscending: usersProvider.ascending,
                sortColumnIndex: usersProvider.sortColumnIndex,
                
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

               
                ],
                source: costosDataSource,
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
