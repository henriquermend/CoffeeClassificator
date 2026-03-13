import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../providers/app_providers.dart';

class HistoryDetailScreen extends ConsumerWidget {
  final String id;

  const HistoryDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyList = ref.watch(historyProvider);
    final item = historyList.firstWhere((e) => e.id == id, orElse: () => historyList.first);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Detalhes do Histórico', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(LucideIcons.fileText, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(item.batch, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('${item.type} - ${item.status}', style: const TextStyle(color: Colors.orange, fontSize: 18)),
            const SizedBox(height: 8),
            Text(item.date, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
