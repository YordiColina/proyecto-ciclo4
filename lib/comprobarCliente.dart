import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'actualizarCliente.dart';
import 'main.dart';


class comprobarCliente extends StatefulWidget {
  const comprobarCliente({Key? key}) : super(key: key);

  @override
  _comprobarClienteState createState() => _comprobarClienteState();
}

class _comprobarClienteState extends State<comprobarCliente> {
  final correo = TextEditingController();
  final password = TextEditingController();
  CollectionReference cliente =
  FirebaseFirestore.instance.collection("Clientes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan[50],
        appBar: AppBar(
          backgroundColor: Colors.cyan[700],
          title: Text("Iniciar Sesión"),
          centerTitle: true,
        ),

        drawer: menu(),


        body: ListView(children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 105.0, right: 15.0, bottom: 10.0,top:10.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/equipo1proyecto-98cd8.appspot.com/o/imagenes%20proyecto%20veci%20app%2Flogin.JPG?alt=media&token=e1ca7a78-72db-4f6f-9265-fd153ecd26c0'),
                  radius: 70,
                ),
              )
            ],
          ),
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: correo,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    fillColor: Colors.cyan[700],
                    filled: true,
                    icon: Icon(Icons.email,
                        size: 25, color: Colors.cyan[700]),
                    hintText: "Digite su Correo Electronico ",
                    hintStyle: TextStyle(color: Colors.black45)),
              )),
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: password,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    fillColor: Colors.cyan[700],
                    filled: true,
                    icon: Icon(Icons.lock,
                        size: 25, color: Colors.cyan[700]),
                    hintText: "Digite su Contraseña",
                    hintStyle: TextStyle(color: Colors.black45)),
              )),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),

            alignment: Alignment.center,
            child:ElevatedButton(

              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical:10.0,horizontal: 20.0)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),


              ),

                  onPressed: () async {
                List listaCliente = [];


                QuerySnapshot ingreso = await cliente
                    .where("correo", isEqualTo: correo.text)
                    .where("password", isEqualTo: password.text)
                    .get();


                if (ingreso.docs.length > 0) {
                  for (var cli in ingreso.docs) {
                    listaCliente.add(cli.data());
                  }


                  datosCliente dCli = datosCliente(
                      listaCliente[0]['id'], listaCliente[0]['nombre'],
                      listaCliente[0]['apellidos'], listaCliente[0]['correo'],
                      listaCliente[0]['celular'],listaCliente[0]['password']);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => actualizarCliente(cliente: dCli)));
                  Fluttertoast.showToast(msg: "Cargando Datos",
                      fontSize: 20,
                      backgroundColor: Colors.red,
                      textColor: Colors.lightGreen,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER);
                } else {
                  Fluttertoast.showToast(msg: "Datos Incorrectos",
                      fontSize: 20,
                      backgroundColor: Colors.red,
                      textColor: Colors.lightGreen,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER);
                }
              },
              child: Text("Iniciar Sesion",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
        ])
    );
    }
  }


class datosCliente {

  String cedula = "";
  String nombre = "";
  String apellido = "";
  String correo = "";
  String celular = "";
  String password = "";


  datosCliente(cedula, nombre, apellido, correo, celular,password) {
    this.nombre = nombre;
    this.apellido = apellido;
    this.correo = correo;
    this.cedula = cedula;
    this.celular = celular;
    this.password=password;

  }


}
