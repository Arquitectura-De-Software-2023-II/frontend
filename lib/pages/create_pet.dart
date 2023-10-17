import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mypetcare/connections/request_options.dart';
import 'package:mypetcare/connections/request_to_api.dart';
import 'package:mypetcare/connections/response_api.dart';
import 'package:mypetcare/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePetPage extends StatefulWidget {
  const CreatePetPage({Key? key}) : super(key: key);

  @override
  State<CreatePetPage> createState() => CreatePetPageState();
}
Future<ApiResponse> createPetToApi(String name, int age, String color, String animal, String breed, String jwt) {
  // jwt = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiU2FudGlhZ28iLCJpZCI6IjY1MWY3MGE3NTk5YTY4YTNiOWI4NTk2ZCIsImlhdCI6MTY5NzUyMjQ0NH0.28S0EhahE2hhMIpu2uqukjd_s_3e9ANkZ_H5Xuw_Mro';
  ///*
  final Map<String, dynamic>  reqBody = {
    'name': name,
    'age': age,
    'color': color,
    'animal': animal,
    'breed': breed
  };
  //*/
  /*
  final Map<String, dynamic>  reqBody = {
    'email': 'chandlerhammond@geekola.com',
    'password': '6511c32d7e664f067586a8676511c32dd28e8db8e880b73b'
  };
  */
  return fetchFromApi(RequestOptions(
    method: HttpMethods.post, 
    path: '/api/users/postpet', 
    bearier: jwt,
    body: jsonEncode(reqBody)
  ));
}
class CreatePetPageState extends State<CreatePetPage> {
  final _formKey = GlobalKey<FormState>();
  
  late Future<ApiResponse> futureResponse;
  late Future<SharedPreferences> prefs;
  String jwt = '';
  
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController colorController;
  late TextEditingController breedController;
  late TextEditingController animalController;

  @override
  void initState() {
    super.initState();
    prefs = SharedPreferences.getInstance();

    nameController = TextEditingController();
    ageController = TextEditingController();
    colorController = TextEditingController();
    breedController = TextEditingController();
    animalController = TextEditingController();
    
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
        child:
        FutureBuilder<SharedPreferences>(future: prefs, builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              return Center(child:Text('No hay datos'));
            }
            try{
              jwt = snapshot.data!.getString('jwt') ?? '';

              
              return Form(
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
                            return SizedBox(height: 180,);
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
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: ageController,
                          decoration: InputDecoration(
                            labelText: 'Edad',
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
                              return 'Por favor, ingrese la edad';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: colorController,
                          decoration: InputDecoration(
                            labelText: 'color',
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
                              return 'Por favor, ingrese un color';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: animalController,
                          decoration: InputDecoration(
                            labelText: 'animal',
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
                              return 'Por favor, ingrese el animal';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: breedController,
                          decoration: InputDecoration(
                            labelText: 'raza',
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
                              return 'Por favor, ingrese la raza';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  
                                  final name = nameController.text;
                                  final age = ageController.text;
                                  final color = colorController.text;
                                  final animal = animalController.text;
                                  final breed = breedController.text;

                                  futureResponse = createPetToApi(name, int.parse(age), color, animal, breed, jwt);
                                  showDialog(context: context, 
                                    builder: ((context) {
                                      return FutureBuilder<ApiResponse>(
                                        future: futureResponse,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData){
                                            final ApiResponse apiResponse = snapshot.data!;
                                            if (apiResponse.statusCode == 200){
                                              return AlertDialog(
                                                title: const Text('Mascota Creada!'),
                                                content: const Text('ahora puedes seguir creando o volver'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pushReplacementNamed(context, Routes.lookPets);
                                                    },
                                                    child: const Text('volver'),
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
                                              return AlertDialog(
                                                title: const Text('Error!'),
                                                content: const Text('Error procesando tu solicitud, intenta mas tarde',overflow: TextOverflow.clip,maxLines: 3),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pushReplacementNamed(context, Routes.lookPets);
                                                    },
                                                    child: const Text('volver'),
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
                                          }
                                          else if (snapshot.hasError){
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
                              child: const Text('Crear'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, Routes.principal);
                              },
                              child: const Text('Principal'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, Routes.lookPets);
                              },
                              child: const Text('volver'),
                            )
                          

                          ],
                        )

                      ],
                    ),
                  )    
                )
              );
            

            }catch (e){
              print(e);
              snapshot.data?.clear();

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Error al obtener datos'),

                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routes.principal);
                        },
                        child: const Text('Principal'),
                      ),

                  ],
                )
              );
            }

              
          }
          else if (snapshot.hasError){
            print(snapshot.error);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Error al obtener datos'),

                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Routes.principal);
                      },
                      child: const Text('Principal'),
                    ),

                ],
              )
            );
            
          }
          else{
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Routes.principal);
                      },
                      child: const Text('Principal'),
                    ),

                ],
              )
            );
          }

        },)
      )
    );
  }
}
