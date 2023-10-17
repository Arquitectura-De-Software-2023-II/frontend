import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mypetcare/connections/request_options.dart';
import 'package:mypetcare/connections/request_to_api.dart';
import 'package:mypetcare/connections/response_api.dart';
import 'package:mypetcare/main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => RegisterPageState();
}
Future<ApiResponse> registerToApi(String email, String password, String name) {
  ///*
  final Map<String, dynamic>  reqBody = {
    'name': name,
    'email': email,
    'password': password,
    'role': 'usuario'
  };
  //*/
  /*
  final Map<String, dynamic>  reqBody = {
    'email': 'chandlerhammond@geekola.com',
    'password': '6511c32d7e664f067586a8676511c32dd28e8db8e880b73b'
  };
  */
  return fetchFromApi(RequestOptions(method: HttpMethods.post, path: '/api/users/register', 
  body: jsonEncode(reqBody)
  ));
}
class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  
  late Future<ApiResponse> futureResponse;
  
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirnpasswordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirnpasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        leading: Image.asset('lib/assets/mypetcare.png'),
        backgroundColor: Color.fromARGB(128, 0, 213, 255),
      ),
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/animals.png'),
            repeat: ImageRepeat.repeat,
            fit: BoxFit.fitHeight,
          ),
        ),
        
        constraints: BoxConstraints.expand(),
        child:Form(
          key: _formKey,
          child:
          Padding(
            padding: EdgeInsets.all(20),
            child:SingleChildScrollView(
              child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LayoutBuilder(builder: ((context, constraints) {
                    if (constraints.maxWidth > 500){
                      return SizedBox( height: 0,);
                    }
                    else{
                      return SizedBox(height: 185,);
                    }
                  })),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingrese su nombre';
                      }
                      if (value.length < 6) {
                        return 'el nombre debe tener al menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Correo electrónico',
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingrese su correo electrónico';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingrese su contraseña';
                      }
                      if (value.length < 6) {
                        return 'La contraseña debe tener al menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: confirnpasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirmación Contraseña',
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingrese su contraseña';
                      }
                      if (value.length < 6) {
                        return 'La contraseña debe tener al menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        
                        final pass = passwordController.text;
                        final email = emailController.text;
                        final validPass = confirnpasswordController.text;
                        final name = nameController.text;
                        if (pass != validPass){
                          print('no valid pass');
                          showDialog(context: context, builder: (context){
                            return
                              AlertDialog(
                                title: const Text('Error'),
                                content: const Text('Las contraseñas no coinciden'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cerrar'),
                                  ),
                                ],
                              );
                          });
                          return;
                        }
                        futureResponse = registerToApi(email, pass, name);
                        showDialog(context: context, 
                          builder: ((context) {
                            return FutureBuilder<ApiResponse>(
                              future: futureResponse,
                              builder: (context, snapshot) {
                                if (snapshot.hasData){
                                  final ApiResponse apiResponse = snapshot.data!;
                                  if (apiResponse.statusCode == 200){
                                    return AlertDialog(
                                      title: const Text('Usuario Creado!'),
                                      content: const Text('ahora puedes iniciar sesión'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacementNamed(context, Routes.login);
                                          },
                                          child: const Text('login'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cerrar'),
                                        ),
                                      ],
                                    );
                                  }
                                  else if (apiResponse.statusCode == 400){
                                    Map<dynamic,dynamic> json = jsonDecode(apiResponse.body);
                                    String error = json['error'];
                                    if (error == "Email ya registrado"){
                                      return AlertDialog(
                                        title: const Text('Error!'),
                                        content: const Text('El email ya aparece registrado, puedes iniciar sesión o intentar con otro correo',overflow: TextOverflow.clip,maxLines: 5),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pushReplacementNamed(context, Routes.login);
                                            },
                                            child: const Text('login'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cerrar'),
                                          ),
                                        ],
                                      );
                                    }
                                    else{
                                        print("dist error");
                                      return AlertDialog(
                                        title: const Text('Error!'),
                                        content: const Text('Error procesando tu solicitud, intenta mas tarde',overflow: TextOverflow.clip,maxLines: 3),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cerrar'),
                                          ),
                                        ],
                                      );
                                    }
                                    
                                  }
                                  else{
                                    print("dist a 400");
                                    return AlertDialog(
                                      title: const Text('Error!'),
                                      content: const Text('Error procesando tu solicitud, intenta mas tarde',overflow: TextOverflow.clip,maxLines: 3),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cerrar'),
                                        ),
                                      ],
                                    );
                                  }

                                }
                                else if (snapshot.hasError){
                                  print("snapshot err");
                                  return AlertDialog(
                                      title: const Text('Error!'),
                                      content: const Text('Error procesando tu solicitud, intenta mas tarde',overflow: TextOverflow.clip,maxLines: 3),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cerrar'),
                                        ),
                                      ],
                                    );
                                }
                                return Dialog(
                                  child:SizedBox(
                                    height: 200,
                                    width: 200,
                                    child:Center(child:CircularProgressIndicator())
                                  )
                                );
                              },
                            );
                          })
                        );
                       
                        // Procesar los datos del formulario
                      }else{
                        print('no valid');
                      }
                    },
                    child: const Text('Registrarse'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.principal);
                    },
                    child: const Text('Principal'),
                  )
                ],
              ),
            )    
          )
        ),
      )
    );
  }
}
