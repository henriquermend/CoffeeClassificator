import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/inference_service.dart';

final inferenceServiceProvider = Provider<InferenceService>((ref) {
  return InferenceService();
});

class HistoryItem {
  final String id;
  final String date;
  final String batch;
  final String type;
  final String status;

  HistoryItem({
    required this.id,
    required this.date,
    required this.batch,
    required this.type,
    required this.status,
  });
}

class HistoryNotifier extends StateNotifier<List<HistoryItem>> {
  HistoryNotifier() : super([
    HistoryItem(id: '1', date: '14 Out, 08:30', batch: 'Lote A1', type: 'Cereja', status: '92% Maturação'),
    HistoryItem(id: '2', date: '14 Out, 07:15', batch: 'Lote B2', type: 'Verde', status: '15% Maturação'),
    HistoryItem(id: '3', date: '13 Out, 16:45', batch: 'Lote C3', type: 'Cereja', status: '88% Maturação'),
  ]);

  void add(HistoryItem item) {
    state = [item, ...state];
  }
}

final historyProvider = StateNotifierProvider<HistoryNotifier, List<HistoryItem>>((ref) {
  return HistoryNotifier();
});

class CaptureState {
  final List<File> capturedImages;
  final bool isAnalyzing;
  final InferenceResult? result;

  CaptureState({
    this.capturedImages = const [],
    this.isAnalyzing = false,
    this.result,
  });

  CaptureState copyWith({
    List<File>? capturedImages,
    bool? isAnalyzing,
    InferenceResult? result,
  }) {
    return CaptureState(
      capturedImages: capturedImages ?? this.capturedImages,
      isAnalyzing: isAnalyzing ?? this.isAnalyzing,
      result: result ?? this.result,
    );
  }
}

class CaptureNotifier extends StateNotifier<CaptureState> {
  final InferenceService service;

  CaptureNotifier(this.service) : super(CaptureState());

  Future<void> setMockImages() async {
    // Apenas simulação de passagem de imagens da câmera
    state = state.copyWith(capturedImages: [File('mock1'), File('mock2'), File('mock3')]);
  }

  Future<void> runAnalysis() async {
    state = state.copyWith(isAnalyzing: true);
    final result = await service.runInferenceOnImages(state.capturedImages);
    state = state.copyWith(isAnalyzing: false, result: result);
  }

  void reset() {
    state = CaptureState();
  }
}

final captureProvider = StateNotifierProvider<CaptureNotifier, CaptureState>((ref) {
  final service = ref.watch(inferenceServiceProvider);
  return CaptureNotifier(service);
});
