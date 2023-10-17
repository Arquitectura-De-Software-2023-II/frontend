import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mypetcare/connections/request_options.dart';
import 'package:mypetcare/connections/request_to_api.dart';
import 'package:mypetcare/connections/response_api.dart';
import 'package:mypetcare/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}
Future <bool> saveLogin(String jwt, String email, String pass) async {
  final prefs = await SharedPreferences.getInstance();
  var works = true;
  // set values
  if(! await prefs.setString('jwt', jwt)){
    works = false;
  }
  if(! await prefs.setBool('logged', true)){
    works = false;
  }
  if(! await prefs.setString('email', email)){
    works = false;
  }
  if(! await prefs.setString('pass', pass)){
    works = false;
  }
  return works;
}

Future<ApiResponse> loginToApi(String email, String password) {
  ///*
  final Map<String, dynamic>  reqBody = {
    'email': email,
    'password': password
  };
  //*/
  /*
  final Map<String, dynamic>  reqBody = {
    'email': 'chandlerhammond@geekola.com',
    'password': '6511c32d7e664f067586a8676511c32dd28e8db8e880b73b'
  };
  */
  return fetchFromApi(RequestOptions(method: HttpMethods.post, path: '/api/users/login', 
  body: jsonEncode(reqBody)
  ));
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  
  late Future<ApiResponse> futureResponse;
  
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        leading: Image.asset('lib/assets/mypetcare.png'),
        backgroundColor: Color.fromARGB(128, 0, 213, 255),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/animals.png'),
            repeat: ImageRepeat.repeat,
            fit: BoxFit.fitHeight,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: 
        Form(
          key: _formKey,
          child:
          Padding(
            padding: EdgeInsets.all(20),
            child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                    height: 20,
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
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        
                        // Procesar los datos del formulario
                        final pass = passwordController.text;
                        final email = emailController.text;
                        futureResponse = loginToApi(email, pass);
                        showDialog(context: context, 
                          builder: ((context) {
                            return Dialog(
                              child: SizedBox(
                                height: 350,
                                width: 250,
                                child:Center(
                                  child:FutureBuilder<ApiResponse>(
                                    future: futureResponse,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData){
                                        final ApiResponse apiResponse = snapshot.data!;
                                        if (apiResponse.statusCode == 200){
                                          Map<dynamic,dynamic> json = jsonDecode(apiResponse.body);
                                          String token = json['token'];
                                          Future<bool> saved = saveLogin(token, email, pass);
                                          print(token);
                                          return FutureBuilder<bool>(future: saved, builder: ((context, snapshot) {
                                            if (snapshot.hasData){
                                              final bool saved = snapshot.data!;
                                              if (saved){
                                                return Center(
                                                  child:Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                        height: 20,
                                                        ),
                                                      Text('Bienvenido $email',textAlign: TextAlign.center,),
                                                      Padding(
                                                        padding: EdgeInsets.all(10),
                                                        child:ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pushReplacementNamed(context, Routes.principal);
                                                          },
                                                          child: const Text('Principal'),
                                                        )
                                                      ),
                                                    ],
                                                  )
                                                );
                                              }
                                              else{
                                                return Center(
                                                  child:Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                        height: 20,
                                                        ),
                                                      Text('Error al iniciar seción'),
                                                      Padding(
                                                        padding: EdgeInsets.all(10),
                                                        child:ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pushReplacementNamed(context, Routes.principal);
                                                          },
                                                          child: const Text('Principal'),
                                                        )
                                                      ),
                                                    ],
                                                  )
                                                );
                                              }
                                            }
                                            else if (snapshot.hasError){
                                              print(snapshot.error);
                                                return Center(
                                                  child:Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                        height: 20,
                                                        ),
                                                      Text('Error al iniciar seción'),
                                                      Padding(
                                                        padding: EdgeInsets.all(10),
                                                        child:ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child: const Text('cerrar'),
                                                        )
                                                      ),
                                                    ],
                                                  )
                                                );
                                            }
                                            return 
                                            CircularProgressIndicator();
                                            
                                          }
                                          ));

                                        }
                                        else{
                                          return Center(
                                                  child:Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                        height: 20,
                                                        ),
                                                      Text('Usuario o contraseña invalidos',textAlign: TextAlign.center,),
                                                      Padding(
                                                        padding: EdgeInsets.all(10),
                                                        child:ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child: const Text('cerrar'),
                                                        )
                                                      ),
                                                    ],
                                                  )
                                                );
                                        }

                                      }
                                      else if (snapshot.hasError){
                                        return Text('${snapshot.error}');
                                      }
                                      return Center(child:CircularProgressIndicator());
                                    },
                                    ) 
                                
                                )
                              )
                              );
                          })
                        );
                      
                      }
                      else{
                        print('no validate');
                        }
                    },
                    child: const Text('Ingresar'),
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
        ),
        
      )
    );
  }
}