import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mypetcare/components/pet_card_item.dart';
import 'package:mypetcare/connections/request_options.dart';
import 'package:mypetcare/connections/request_to_api.dart';
import 'package:mypetcare/connections/response_api.dart';
import 'package:mypetcare/main.dart';
import 'package:mypetcare/models/pet.dart';


class WatchUserPets extends StatefulWidget {
  const WatchUserPets({Key? key}) : super(key: key);

  @override
  State<WatchUserPets> createState() => WatchUserPetsState();
}

class WatchUserPetsState extends State<WatchUserPets>{
  List<Pet> pets = [];
  late Future<ApiResponse> futureResponse;

  @override
  void initState() {
    super.initState();
    futureResponse = fetchFromApi(RequestOptions( path: '/api/users/getallpets', bearier: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTG91aXNlIEJ1cmtzIiwiaWQiOiI2NTFmMmFiOGY5MWMwZDUwMzc1NDUxMzAiLCJpYXQiOjE2OTcxODA0NTJ9.NxUiekwxWp-l-ZBoveKLek1N4CkKqjEBr32l7hXNUIg'));
    
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
          if (constraints.maxWidth > 500){

            return

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
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
                        Navigator.pushNamed(context, Routes.principal);
                      },
                      label: const Text('Principal'),
                      icon: const Icon(Icons.home),
                    ),
                    Spacer(),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.principal);
                      },
                      label: const Text('Nueva mascota'),
                      icon: const Icon(Icons.add),
                    ),
                    SizedBox(
                      width: 90,
                    ),
                  ],
                ),
                FutureBuilder<ApiResponse>(
                  future: futureResponse,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final ApiResponse apiResponse = snapshot.data!;
                      if (apiResponse.statusCode == 200) {
                        final List<dynamic> body = jsonDecode(apiResponse.body);
                        pets = body.map((dynamic item) => Pet.fromJson(item)).toList();
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
                ),
          
              ],

            ); 
          } else {
            return 
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
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
                        Navigator.pushNamed(context, Routes.principal);
                      },
                      label: const Text('Principal'),
                      icon: const Icon(Icons.home),
                    ),
                    Spacer(),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.principal);
                      },
                      label: const Text('Nueva mascota'),
                      icon: const Icon(Icons.add),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                FutureBuilder<ApiResponse>(
                  future: futureResponse,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final ApiResponse apiResponse = snapshot.data!;
                      if (apiResponse.statusCode == 200) {
                        final List<dynamic> body = jsonDecode(apiResponse.body);
                        pets = body.map((dynamic item) => Pet.fromJson(item)).toList();
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
                ),
          
              ],

            ); 
          }
        }),
    );
  }  
}
