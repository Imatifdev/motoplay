import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motplay/screens/f1_screen.dart';
import 'package:motplay/screens/motogp.dart';

import '../screens/configration.dart';
import '../screens/dmca.dart';
import '../screens/donation.dart';
import '../screens/privacy-policy.dart';
import 'mycolors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "MOTOPLAY",
                  style: TextStyle(fontSize: 31, color: Colors.black),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.left_chevron,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: blue,
            height: 20,
          ),
          const ListTile(
            leading: Icon(Icons.home),
            title: Text(
              "Home",
              style: TextStyle(fontSize: 23, color: blue),
            ),
          ),
          const Divider(
            height: 0,
            thickness: 0.5,
          ),
          ListTile(
            leading: const Icon(Icons.drive_eta_rounded),
            title: const Text(
              "F1",
              style: TextStyle(fontSize: 23, color: blue),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => F1Screen(),
              ));
            },
          ),
          const Divider(
            height: 0,
            thickness: 0.5,
          ),
          ListTile(
            leading: const Icon(Icons.drive_eta_outlined),
            title: const Text(
              "Moto GP",
              style: TextStyle(fontSize: 23, color: blue),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MotoGp(),
              ));
            },
          ),
          const Divider(
            height: 0,
            thickness: 0.5,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const Configration()));
            },
            leading: const Icon(Icons.settings),
            title: const Text(
              "Configration",
              style: TextStyle(fontSize: 23, color: blue),
            ),
          ),
          const Divider(
            height: 0,
            thickness: 0.5,
          ),
          ListTile(
            leading: ImageIcon(AssetImage("assets/images/icons7.png")),
            title: Text(
              "Donación",
              style: TextStyle(fontSize: 23, color: blue),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Donation(),
              ));
            },
          ),
          const Divider(
            height: 0,
            thickness: 0.5,
          ),
          const ListTile(
            leading: ImageIcon(AssetImage("assets/images/icon3.png")),
            title: Text(
              "Repeticiones f1ss",
              style: TextStyle(fontSize: 23, color: blue),
            ),
          ),
          const Divider(
            height: 0,
            thickness: 0.5,
          ),
          const ListTile(
            leading: ImageIcon(AssetImage("assets/images/icon3.png")),
            title: Text(
              "Repeticiones  MotoGP",
              style: TextStyle(fontSize: 23, color: blue),
            ),
          ),
          const Divider(
            height: 0,
            thickness: 0.5,
          ),
          const ListTile(
            leading: Icon(Icons.restore_outlined),
            title: Text(
              "Últimas Actualizaciones",
              style: TextStyle(fontSize: 23, color: blue),
            ),
          ),
          const Divider(
            height: 0,
            thickness: 0.5,
          ),
          const ListTile(
            leading: ImageIcon(AssetImage("assets/images/icon1.png")),
            title: Text(
              "Redes Sociales",
              style: TextStyle(fontSize: 23, color: blue),
            ),
          ),
          const Divider(
            height: 0,
            thickness: 0.5,
          ),
          const ListTile(
            leading: Icon(Icons.notification_important_outlined),
            title: Text(
              "Configurar las Notificaciones",
              style: TextStyle(fontSize: 23, color: blue),
            ),
          ),
          const Divider(
            height: 0,
            thickness: 0.5,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => PrivacyPolicyScreen()));
            },
            leading: const ImageIcon(AssetImage("assets/images/icon2.png")),
            title: const Text(
              "Politicas de Privacidad",
              style: TextStyle(fontSize: 23, color: blue),
            ),
          ),
          const Divider(
            height: 0,
            thickness: 0.5,
          ),
          const ListTile(
            leading: Icon(Icons.screen_share_rounded),
            title: Text(
              "Comparitir App",
              style: TextStyle(fontSize: 23, color: blue),
            ),
          ),
          const Divider(
            height: 0,
            thickness: 0.5,
          ),
          const ListTile(
            leading: ImageIcon(AssetImage("assets/images/icon5.png")),
            title: Text(
              "Acerca de la App",
              style: TextStyle(fontSize: 23, color: blue),
            ),
          ),
          const Divider(
            height: 0,
            thickness: 0.5,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => DMCA()));
            },
            leading: const ImageIcon(AssetImage("assets/images/icon4.png")),
            title: const Text(
              "DMCA ",
              style: TextStyle(fontSize: 23, color: blue),
            ),
          ),
        ],
      ),
    );
  }
}
