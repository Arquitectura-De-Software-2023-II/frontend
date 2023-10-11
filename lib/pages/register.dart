import 'package:flutter/material.dart';
import 'package:mypetcare/main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

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
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                fillColor: Colors.blue.shade200,
              ),
              obscureText: true,
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
                }
                Navigator.pushNamed(context, Routes.home);
              },
              child: const Text('Registrarse'),
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
