import 'package:flutter/material.dart';
import 'package:mypetcare/main.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({Key? key}) : super(key: key);

  @override
  State<PrincipalPage> createState() => PrincipalPageState();
}

class PrincipalPageState extends State<PrincipalPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Principal'),
        leading: Image.asset('lib/assets/mypetcare.png'),
        backgroundColor: Color.fromARGB(128, 0, 213, 255),
      ),
      body: Center(
        child:Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/animals.png'),
              repeat: ImageRepeat.repeat,
              fit: BoxFit.fitHeight,
            ),
          ),
          constraints: BoxConstraints.expand(),
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.register);
                },
                child: const Text('Registrarse'),
              ),
            SizedBox(
               height: 10,
            ), 
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.login);
                },
                child: const Text('Ingresar'),
              ),
            SizedBox(
               height: 10,
            ), 
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.maps);
                },
                child: const Text('Mapa'),
              )
            ],
          ),
        ),
      ),
    );
  }
}