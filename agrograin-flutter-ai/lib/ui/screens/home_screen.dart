import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../components/info_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visão Geral', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Bem-vindo,', style: TextStyle(color: Colors.grey, fontSize: 16)),
            const Text('Produtor', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Pronto para classificar?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 8),
                        Text('Analise a maturação do seu lote de forma instantânea.', style: TextStyle(color: Colors.grey.shade700, fontSize: 14)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  FloatingActionButton(
                    heroTag: 'home_capture',
                    onPressed: () => context.push('/analyze'),
                    backgroundColor: Colors.orange.shade700,
                    elevation: 0,
                    child: const Icon(LucideIcons.camera, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('Dicas Rápidas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            const InfoCard(
              title: 'Iluminação Importa',
              description: 'Realize as fotos sempre em local aberto ou muito bem iluminado.',
              icon: LucideIcons.sun,
            ),
            const SizedBox(height: 12),
            const InfoCard(
              title: 'Sem Sobreposição',
              description: 'Espalhe os grãos em uma superfície clara, lado a lado.',
              icon: LucideIcons.layers,
            ),
          ],
        ),
      ),
    );
  }
}
