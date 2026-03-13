import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../providers/app_providers.dart';
import '../components/primary_button.dart';
import '../../theme/app_theme.dart';

class AnalyzeScreen extends ConsumerStatefulWidget {
  const AnalyzeScreen({super.key});

  @override
  ConsumerState<AnalyzeScreen> createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends ConsumerState<AnalyzeScreen> {
  bool _showGuide = true;
  bool _isCapturing = false;
  int _step = 0; // 1-3 = capturando fotos , 4 = analisando

  Future<void> _startCaptureFlow() async {
    setState(() => _isCapturing = true);

    // Passo A: Stepper 1->3 com 2s
    for (int i = 1; i <= 3; i++) {
      setState(() => _step = i);
      await Future.delayed(const Duration(seconds: 2));
    }

    // Passo B: Mostra "Analisando..."
    setState(() => _step = 4);
    
    // Passo C: Simula chamada Riverpod e vai para resultado
    await ref.read(captureProvider.notifier).setMockImages();
    await ref.read(captureProvider.notifier).runAnalysis();

    if (mounted) {
      context.pushReplacement('/result');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isCapturing) return _buildCapturingState();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Mock ViewPort Câmera
          Positioned.fill(
            child: Container(color: Colors.grey.shade900),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(child: _buildCameraTarget()),
                _buildBottomControls(),
              ],
            ),
          ),
          if (_showGuide) _buildGuideOverlay(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          const Text('Classificar Grãos', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          IconButton(
            icon: const Icon(LucideIcons.helpCircle, color: Colors.white),
            onPressed: () => setState(() => _showGuide = true),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraTarget() {
    return Center(
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2),
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Center(
          child: Text(
            'Posicione os grãos',
            style: TextStyle(color: Colors.white, backgroundColor: Colors.black54),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
      ),
      padding: const EdgeInsets.all(24),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            PrimaryButton(
              text: 'Capturar e Classificar',
              icon: LucideIcons.camera,
              onPressed: _startCaptureFlow,
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.image, color: Colors.grey),
                SizedBox(width: 8),
                Text('Escolher da galeria', style: TextStyle(color: Colors.grey)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCapturingState() {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_step <= 3) ...[
              const CircularProgressIndicator(color: AppTheme.primaryColor),
              const SizedBox(height: 32),
              Text('Capturando foto $_step de 3...', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ] else ...[
              const CircularProgressIndicator(color: AppTheme.primaryColor),
              const SizedBox(height: 32),
              const Text('Analisando...', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Isso levará apenas alguns segundos', style: TextStyle(color: Colors.grey)),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildGuideOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.7),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Guia de Foto Ideal', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                const Text('• Use fundo claro (folha de sulfite)\n• Evite sombras fortes\n• Espalhe bem os grãos'),
                const SizedBox(height: 24),
                PrimaryButton(text: 'Entendi, começar', onPressed: () => setState(() => _showGuide = false)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
