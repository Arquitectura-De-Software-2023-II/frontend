import 'package:flutter/material.dart';
import 'package:mypetcare/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({Key? key}) : super(key: key);

  @override
  State<PrincipalPage> createState() => PrincipalPageState();
}

class PrincipalPageState extends State<PrincipalPage> {
  final _formKey = GlobalKey<FormState>();
  late Future<SharedPreferences> prefs;
  late bool logged;

  @override
  void initState() {
    super.initState();
    prefs = SharedPreferences.getInstance() ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Principal'),
        leading: Image.asset('lib/assets/mypetcare.png'),
        backgroundColor: Color.fromARGB(128, 0, 213, 255),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/animals.png'),
              repeat: ImageRepeat.repeat,
              fit: BoxFit.fitHeight,
            ),
          ),
          constraints: BoxConstraints.expand(),
          key: _formKey,
          
          child: 
          FutureBuilder <SharedPreferences>(future: prefs, builder: (context, snapshot) {
            if (snapshot.hasData){
              if (snapshot.data == null){
                logged = false;
              } 
              // if there is data
              try {
                logged = snapshot.data!.getBool('logged') ?? false; 
                
              } catch (e) {
                // getBool throws error when
                print('throwed error when accesing data $e');
                snapshot.data!.clear();
                logged = false;
              }
            }
            else if (snapshot.hasError){
              print(snapshot.error);
              snapshot.data!.clear();
              logged = false;
            }
            else{
              return const CircularProgressIndicator();
            }
            // if logged
            if(logged){
              return 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                  height: 30,
                  ),

                  Text('Bienvenido', style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),
          
                  ElevatedButton(
                    onPressed: () {
                      snapshot.data!.clear();
                      Navigator.pushReplacementNamed(context, Routes.principal);
                    },
                    child: const Text('cerrar sesion'),
                  ),
                  SizedBox(
                  height: 10,
                  ), 
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.lookPets);
                    },
                    child: const Text('Mis mascotas'),
                  ),
                  SizedBox(
                    height: 10,
                  ), 
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.maps);
                    },
                    child: const Text('Mapa'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.lookDoctors);
                    },
                    child: const Text('Doctores'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.news);
                    },
                    child: const Text('Noticias'),
                  )
                ],
              );

            }
            // if not logged
            else{
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
          
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.register);
                    },
                    child: const Text('Registrarse'),
                  ),
                  SizedBox(
                    height: 10,
                  ), 
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.login);
                    },
                    child: const Text('Ingresar'),
                  )
                  ,
                  SizedBox(
                    height: 10,
                  ), 
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.maps);
                    },
                    child: const Text('Mapa'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.lookDoctors);
                    },
                    child: const Text('MyDoctors'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.news);
                    },
                    child: const Text('Noticias'),
                  )
                ],
                
              );
    
            }
          },),
        ),
      ),
    );
  }
}
