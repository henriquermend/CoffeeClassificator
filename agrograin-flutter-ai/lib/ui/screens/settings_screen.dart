import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Configurações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(LucideIcons.user),
            title: const Text('Perfil da Conta'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(LucideIcons.settings),
            title: const Text('Preferências do Modelo'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(LucideIcons.helpCircle),
            title: const Text('Ajuda e Suporte'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(LucideIcons.info),
            title: const Text('Sobre o App'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(LucideIcons.logOut, color: Colors.red),
            title: const Text('Sair', style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
