import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_app/moduloPedido.dart';
import 'package:proyecto_app/pantalla3.dart';
import 'package:proyecto_app/registroClientes.dart';

import 'package:url_launcher/url_launcher.dart';

import 'main.dart';

class pantalla4 extends StatelessWidget {

  final datosNegocio negocios;
  const pantalla4({required this.negocios});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar:  AppBar(
        backgroundColor: Colors.cyan[900],
        title: Text("Acerca de: "+negocios.nombre),
      ),

      drawer: menu(),


      body: ListView(
        children: [
          miCardImage(url: negocios.foto, texto:" Nombre: "+ negocios.nombre+"\n Categoria: "+negocios.categoria+"\n Direccion: "+negocios.direccion
          +"\n Celular: "+negocios.celular+"\n Telefono: "+negocios.telefono+"\n Productos: "+negocios.producto1+", "+negocios.producto2+
              ", "+negocios.producto3+", "+negocios.producto4+"\n Localizacion: "+negocios.geolocalizacion),
          ElevatedButton(
              onPressed: (){
                launch(negocios.pagina.toString());
              },
              child: Text("Pagina oficial",style: TextStyle(fontSize: 20),)
          ),
          ElevatedButton(
            onPressed: (){
              print(negocios.id);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>moduloPedido(id: negocios.id,)));
            },
            child:RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Realizar Pedido",style: TextStyle(fontSize: 20)
                  ),
                  WidgetSpan(
                    child: Icon(Icons.add, size: 25),
                  ),

                ],
              ),
            )

          )
        ],
      ),

    );
  }
}

