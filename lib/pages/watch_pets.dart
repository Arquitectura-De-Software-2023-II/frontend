import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mypetcare/components/pet_card_item.dart';
import 'package:mypetcare/connections/request_options.dart';
import 'package:mypetcare/connections/request_to_api.dart';
import 'package:mypetcare/connections/response_api.dart';
import 'package:mypetcare/main.dart';
import 'package:mypetcare/models/pet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WatchUserPets extends StatefulWidget {
  const WatchUserPets({Key? key}) : super(key: key);

  @override
  State<WatchUserPets> createState() => WatchUserPetsState();
}

class WatchUserPetsState extends State<WatchUserPets> {
  List<Pet> pets = [];
  late Future<ApiResponse> futureResponse;
  late Future<SharedPreferences> prefs;

  @override
  void initState() {
    super.initState();
    prefs = SharedPreferences.getInstance();
    /*
    futureResponse = fetchFromApi(RequestOptions(
        path: '/api/users/getallpets',
        bearier:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTG91aXNlIEJ1cmtzIiwiaWQiOiI2NTFmMmFiOGY5MWMwZDUwMzc1NDUxMzAiLCJpYXQiOjE2OTcxODA0NTJ9.NxUiekwxWp-l-ZBoveKLek1N4CkKqjEBr32l7hXNUIg'
        ));
    */
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Mascotas'),
        leading: Image.asset('lib/assets/mypetcare.png'),
        backgroundColor: Color.fromARGB(128, 0, 213, 255),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 500) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 90,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.principal);
                    },
                    label: const Text('Principal'),
                    icon: const Icon(Icons.home),
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.createPet);
                    },
                    label: const Text('Nueva mascota'),
                    icon: const Icon(Icons.add),
                  ),
                  SizedBox(
                    width: 90,
                  ),
                ],
              ),
              
              FutureBuilder<SharedPreferences>(future: prefs, builder: ((context, snapshot) {
                if(snapshot.hasData){
                  if(snapshot.data == null){
                    return Text("Error cargando tu información");
                  }
                  try {
                    final String jwt = snapshot.data!.getString('jwt') ?? '';
                    futureResponse = fetchFromApi(RequestOptions(
                      path: '/api/users/getallpets',
                      bearier: jwt
                    ));
                    return FutureBuilder<ApiResponse>(
                      future: futureResponse,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final ApiResponse apiResponse = snapshot.data!;
                          if (apiResponse.statusCode == 200) {
                            final List<dynamic> body = jsonDecode(apiResponse.body);
                            pets = body
                                .map((dynamic item) => Pet.fromJson(item))
                                .toList();
                            return Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: pets.length,
                                itemBuilder: (context, index) {
                                  return PetCard(pet: pets[index]);
                                },
                              ),
                            );
                          } else {
                            return Text('Error al obtener los datos');
                          }
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    );

                  } catch (e) {
                    print('throwed error when accesing data $e');
                    snapshot.data!.clear();
                    return Text("Algo salió mal, vuelve a iniciar seción");
                  }
                }
                else if (snapshot.hasError){
                  print(snapshot.error);
                  snapshot.data!.clear();
                  return Text("Algo salió mal, vuelve a iniciar seción");
                }
                else{
                  return const CircularProgressIndicator();
                }
              }))

            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.principal);
                    },
                    label: const Text('Principal'),
                    icon: const Icon(Icons.home),
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.createPet);
                    },
                    label: const Text('Nueva mascota'),
                    icon: const Icon(Icons.add),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              FutureBuilder<SharedPreferences>(future: prefs, builder: ((context, snapshot) {
                if(snapshot.hasData){
                  if(snapshot.data == null){
                    return Text("Error cargando tu información");
                  }
                  try {
                    final String jwt = snapshot.data!.getString('jwt') ?? '';
                    futureResponse = fetchFromApi(RequestOptions(
                      path: '/api/users/getallpets',
                      bearier: jwt
                    ));
                    return FutureBuilder<ApiResponse>(
                      future: futureResponse,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final ApiResponse apiResponse = snapshot.data!;
                          if (apiResponse.statusCode == 200) {
                            final List<dynamic> body = jsonDecode(apiResponse.body);
                            pets = body
                                .map((dynamic item) => Pet.fromJson(item))
                                .toList();
                            return Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: pets.length + 1,
                                itemBuilder: (context, index) {
                                  // first element is a text to specify the number of pets
                                  if (index == 0) {
                                    return Padding(
                                      padding: EdgeInsets.only(top: 20, bottom: 20),
                                      child:
                                        Text(
                                          'Tienes ${pets.length} mascotas',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                      );
                                  }
                                  // rest 1 to ignore the first element
                                  return PetCard(pet: pets[index - 1]);
                                },
                              ),
                            );
                          } else {
                            return Text('Error al obtener los datos');
                          }
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    );

                  } catch (e) {
                    print('throwed error when accesing data $e');
                    snapshot.data!.clear();
                    return Text("Algo salió mal, vuelve a iniciar seción");
                  }
                }
                else if (snapshot.hasError){
                  print(snapshot.error);
                  snapshot.data!.clear();
                  return Text("Algo salió mal, vuelve a iniciar seción");
                }
                else{
                  return const CircularProgressIndicator();
                }
              }))
            ],
          );
        }
      }),
    );
  }
}
