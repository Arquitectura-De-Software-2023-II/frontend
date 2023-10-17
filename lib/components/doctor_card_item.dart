import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mypetcare/models/doctor.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.doctor,
  });

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    IconData icon = Icons.person_4_rounded;

    return Center(child: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Card(
              margin: const EdgeInsets.only(
                  right: 90, left: 90, bottom: 10, top: 10),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                ListTile(
                  leading: FaIcon(icon),
                  title: Text(doctor.name),
                  subtitle: Text(doctor.title),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton.icon(
                      icon: Icon(Icons.edit),
                      label: Text('Editar'),
                      onPressed: () {/* ... */},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      icon: Icon(Icons.delete),
                      label: Text('Eliminar'),
                      onPressed: () {/* ... */},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton.icon(
                      icon: Icon(Icons.admin_panel_settings),
                      label: Text('Administrar'),
                      onPressed: () {
                        /* ... */
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    const SizedBox(width: 3),
                  ],
                )
              ]));
        } else {
          return Card(
              margin: const EdgeInsets.only(
                  right: 10, left: 10, bottom: 10, top: 10),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                ListTile(
                  leading: FaIcon(icon),
                  title: Text(doctor.name),
                  subtitle: Text(doctor.title),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton.icon(
                      icon: Icon(Icons.edit),
                      label: Text(''),
                      onPressed: () {/* ... */},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      icon: Icon(Icons.delete),
                      label: Text(''),
                      onPressed: () {/* ... */},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton.icon(
                      icon: Icon(Icons.admin_panel_settings),
                      label: Text(''),
                      onPressed: () {
                        /* ... */
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    const SizedBox(width: 3),
                  ],
                )
              ]));
        }
      },
    ));
  }
}
