import 'package:admin_dashboard/models/http/lotes_response.dart';
import 'package:admin_dashboard/models/lotes.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/api/CafeApi.dart';

import 'package:admin_dashboard/models/category.dart';
import 'package:admin_dashboard/models/http/categories_response.dart';

class CategoriesProvider extends ChangeNotifier {

  List<Categoria> categorias = [];
  List<Lotes> lotes = [];

  getCategories() async {
    final resp = await CafeApi.httpGet('/categorias');
    final categoriesResp = CategoriesResponse.fromMap(resp);

    this.categorias = [...categoriesResp.categorias];

    print( this.categorias );

    notifyListeners();
  }
  getLotes() async {
    final resp2 = await CafeApi.httpGet('/lotes');
    final lotesResp = LotesResponse.fromMap(resp2);

    this.lotes = [...lotesResp.lotes];
    
    print( this.lotes );

    notifyListeners();
  }

  Future newCategory( String name ) async {

    final data = {
      'nombre': name
    };

    try {

      final json = await CafeApi.post('/categorias', data );
      print("$json");
      final newCategory = Categoria.fromMap(json);

      categorias.add( newCategory );
      notifyListeners();
      
    } catch (e) {
      throw 'Error al crear lotes';
    }

  }
    Future newLote( String name,String codigo,String modelo,bool estado,int stock ) async {

    final data = {
      'nombre': name,
      "codigo": codigo,
      "modelo": modelo,
      "stock":stock,
    };

    try {

      final json = await CafeApi.post('/lotes', data );
      print(json);
      final newLote = Lotes.fromMap(json);

      print(newLote);
      lotes.add( newLote );
      notifyListeners();
      
    } catch (e) {
      throw 'Error al crear lotes';
    }

  }
Future updateLotes( String id,  String name,String codigo,String modelo,bool estado,int stock ) async {

     final data = {
      'nombre': name,
      "codigo": codigo,
      "modelo": modelo,
      "stock":stock,
      "estadoRevision":estado,
    };

    try {

      await CafeApi.put('/lotes/$id', data );
    
      this.lotes = this.lotes.map(
        (lotes) {
          if ( lotes.id != id ) return lotes;
          lotes.nombre = name;
          lotes.codigo = codigo;
          lotes.modelo = modelo;
          lotes.stock = stock;
          lotes.estadoRevision = estado;
          return lotes;
        }
      ).toList();
      
      notifyListeners();
      
    } catch (e) {
      throw 'Error al crear categoria';
    }

  }

  Future updateCategory( String id, String name ) async {

    final data = {
      'nombre': name
    };

    try {

      await CafeApi.put('/categorias/$id', data );
    
      this.categorias = this.categorias.map(
        (category) {
          if ( category.id != id ) return category;
          category.nombre = name;
          return category;
        }
      ).toList();
      
      notifyListeners();
      
    } catch (e) {
      throw 'Error al crear categoria';
    }

  }

  Future deleteCategory( String id ) async {

    try {

      await CafeApi.delete('/categorias/$id', {} );
    
      categorias.removeWhere((categoria) => categoria.id == id );
     
      notifyListeners();
      
      
    } catch (e) {
      print(e);
      print('Error al crear categoria');
    }

  }
    Future deleteLote( String id ) async {

    try {

      await CafeApi.delete('/lotes/$id', {} );
    
      lotes.removeWhere((lotes) => lotes.id == id );
     
      notifyListeners();
      
      
    } catch (e) {
      print(e);
      print('Error al eliminar lote');
    }

  }

}