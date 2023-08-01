import 'package:flutter/material.dart';
import 'package:motplay/utils/mycolors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/custom_drawer.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: blue,
        title: Text(
          'Política de Privacidad',
          style: TextStyle(fontSize: 32),
        ),
        iconTheme: IconThemeData(color: Colors.grey.shade200),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text(
            "Política de Privacidad y Contenido",
            style: TextStyle(fontSize: 24, color: blue),
          ),
          ListTile(
            title: Text(
                'La app no recoge ningún dato de carácter personal del usuario como, por ejemplo, nombre, fotografías o localización.'),
          ),
          ListTile(
            title: Text(
                'En consecuencia, la app no comparte ningún dato personal con ninguna otra entidad o terceras personas.'),
          ),
          ListTile(
            title: Text(
                'Las imágenes y los videos introducidos por el usuario son enviados al servidor imgs1.e-droid.net con el fin de poder ser recuperados posteriormente por el propio usuario, y con el fin de que la app pueda ofrecer las funcionalidades según su descripción.'),
          ),
          ListTile(
            title: Text(
                'Permitimos que terceras compañías publiquen anuncios y recopilen cierta información anónima cuando visite nuestra aplicación. Estas empresas pueden utilizar información anónima, como su ID de publicidad de Google, el tipo y la versión de su dispositivo, la actividad de navegación, la ubicación y otros datos técnicos relacionados con su dispositivo, a fin de proporcionar anuncios.'),
          ),
          ListTile(
            title: Text(
                'Si desea obtener más información sobre cómo estas empresas utilizan su información y cómo darse de baja de ciertas funciones publicitarias, puede visitar los siguientes enlaces:'),
          ),
        ],
      ),
    );
  }
}
