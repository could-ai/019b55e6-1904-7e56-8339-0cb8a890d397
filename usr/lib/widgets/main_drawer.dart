import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget _buildListTile(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Colors.teal.shade700,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 20, // Equivalent text-xl
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Colors.teal, // Equivalent bg-teal-500
            child: const Text(
              'Voyage & Découverte',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 24, // Equivalent text-2xl
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildListTile(
            'Accueil',
            Icons.home,
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          _buildListTile(
            'Destinations',
            Icons.flight_takeoff,
            () {
              // Navigation fictive pour l'exemple
              Navigator.of(context).pop();
            },
          ),
          _buildListTile(
            'Favoris',
            Icons.favorite,
            () {
              Navigator.of(context).pop();
            },
          ),
          const Divider(),
          _buildListTile(
            'Paramètres',
            Icons.settings,
            () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
