import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../components/primary_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              const Icon(Icons.speed, size: 100, color: Colors.orange),
              const SizedBox(height: 32),
              const Text(
                'Classificação Automática de Maturação',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Obtenha resultados instantâneos sobre a qualidade e maturação do seu café usando inteligência artificial.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Spacer(),
              PrimaryButton(
                text: 'Começar Agora',
                onPressed: () => context.go('/home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
