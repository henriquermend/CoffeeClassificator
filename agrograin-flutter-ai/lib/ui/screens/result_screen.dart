import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../providers/app_providers.dart';
import '../components/primary_button.dart';
import '../components/result_badge.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final captureState = ref.watch(captureProvider);
    final resultData = captureState.result;

    final classification = resultData?.finalResult ?? 'Cereja';
    final confidence = ((resultData?.confidence ?? 0.98) * 100).toInt();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => context.go('/home'),
        ),
        title: const Text('Resultado da Análise', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade200),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(child: Icon(LucideIcons.image, size: 48, color: Colors.grey)),
                  ),
                  const SizedBox(height: 16),
                  const Text('CLASSIFICAÇÃO FINAL', style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Maturação: $classification', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      ResultBadge(type: classification),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('O grão atingiu o ponto ideal de maturação.', style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.orange.shade100),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Confiança do Modelo', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('$confidence%', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: confidence / 100,
                    backgroundColor: Colors.orange.shade200,
                    color: Colors.orange.shade700,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(8),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              text: 'Salvar no Histórico',
              icon: LucideIcons.save,
              onPressed: () {
                // Ao salvar, adiciona no estado
                ref.read(historyProvider.notifier).add(
                  HistoryItem(
                    id: DateTime.now().toString(),
                    date: 'Agora mesmo',
                    batch: 'Novo Lote',
                    type: classification,
                    status: '$confidence% Maturação',
                  ),
                );
                context.go('/history');
              },
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              text: 'Nova Classificação',
              icon: LucideIcons.camera,
              isOutline: true,
              onPressed: () => context.pushReplacement('/analyze'),
            ),
          ],
        ),
      ),
    );
  }
}
