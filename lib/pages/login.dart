import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mypetcare/connections/request_options.dart';
import 'package:mypetcare/connections/request_to_api.dart';
import 'package:mypetcare/connections/response_api.dart';
import 'package:mypetcare/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

Future<ApiResponse> loginToApi(String email, String password) {
  /*
  final Map<String, dynamic>  reqBody = {
    'email': email,
    'password': password
  };
  */
  final Map<String, dynamic>  reqBody = {
    'email': 'chandlerhammond@geekola.com',
    'password': '6511c32d7e664f067586a8676511c32dd28e8db8e880b73b'
  };
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
      body: Form(
        key: _formKey,
        child: Column(
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
                fillColor: Colors.blue.shade200,
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
                fillColor: Colors.blue.shade200,
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
                          height: 300,
                          width: 300,
                          child:Center(
                            child:FutureBuilder<ApiResponse>(
                              future: futureResponse,
                              builder: (context, snapshot) {
                                if (snapshot.hasData){
                                  final ApiResponse apiResponse = snapshot.data!;
                                  if (apiResponse.statusCode == 200){
                                    Map<dynamic,dynamic> json = jsonDecode(apiResponse.body);
                                    String token = json['token'];
                                    print(token);
                                    return Column(
                                      children: [
                                        Text('Bienvenido $email'),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context, Routes.principal);
                                          },
                                          child: const Text('Principal'),
                                        )
                                      ],
                                    );
                                  }
                                  else{
                                    return Text('Usuario o contraseña incorrectos');
                                  }

                                }
                                else if (snapshot.hasError){
                                  return Text('${snapshot.error}');
                                }
                                return CircularProgressIndicator();
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
                Navigator.pushNamed(context, Routes.principal);
              },
              child: const Text('Principal'),
            )
          ],
        ),
      ),
    );
  }
}