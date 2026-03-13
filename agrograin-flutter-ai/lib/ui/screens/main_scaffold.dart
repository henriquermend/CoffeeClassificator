import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/history')) return 2;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    if (index == 0) {
      context.go('/home');
    } else if (index == 1) {
      context.push('/analyze');
    } else if (index == 2) {
      context.go('/history');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onItemTapped(index, context),
        items: const [
          BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.camera), label: 'Analisar'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.history), label: 'Histórico'),
        ],
      ),
    );
  }
}
