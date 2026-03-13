import 'dart:io';


import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class InferenceResult {
  final String finalResult;
  final Map<String, int> perPhotoResults;
  final double confidence;

  InferenceResult({
    required this.finalResult,
    required this.perPhotoResults,
    required this.confidence,
  });
}

class InferenceService {
  Interpreter? _interpreter;
  List<String>? _labels;

  Future<void> _loadModel() async {
    if (_interpreter != null) return;
    try {
      _interpreter = await Interpreter.fromAsset('assets/best_float32.tflite');
      // Observação: Assumindo as labels de saída fixas do contexto das conversas anteriores:
      _labels = ['Verde', 'Cereja', 'Passa', 'Seco'];
    } catch (e) {
      print("Erro ao carregar modelo TFLite: $e");
    }
  }

  /// Processa a imagem para o formato Float32 que o TFLite espera.
  /// Dimensões padrão geralmente são 224x224, 3 canais (RGB).
  /// Modifique o tamanho (224) se o 'best_float32.tflite' tiver uma dimensão de input diferente.
  List<List<List<List<double>>>> _processImage(File imageFile, int inputSize) {
    final imageBytes = imageFile.readAsBytesSync();
    img.Image? image = img.decodeImage(imageBytes);

    if (image == null) return [[[[0.0]]]];

    img.Image resizedImage = img.copyResize(image, width: inputSize, height: inputSize);

    // Cria o array 4D [1, size, size, 3] esperado pelo TFLite float32
    var imageMatrix = List.generate(
      1,
      (b) => List.generate(
        inputSize,
        (y) => List.generate(
          inputSize,
          (x) => List.generate(3, (c) => 0.0),
        ),
      ),
    );

    for (int y = 0; y < inputSize; y++) {
      for (int x = 0; x < inputSize; x++) {
        final pixel = resizedImage.getPixel(x, y);
        // Normalização de 0 a 1 em Float32.
        imageMatrix[0][y][x][0] = pixel.r / 255.0; // R
        imageMatrix[0][y][x][1] = pixel.g / 255.0; // G
        imageMatrix[0][y][x][2] = pixel.b / 255.0; // B
      }
    }

    return imageMatrix;
  }

  Future<InferenceResult> runInferenceOnImages(List<File> images) async {
    await _loadModel();
    
    if (_interpreter == null) {
      // Retorno de fallback caso não consiga carregar o modelo.
      return InferenceResult(
        finalResult: 'Erro',
        perPhotoResults: {'Verde': 0, 'Cereja': 0, 'Passa': 0, 'Seco': 0},
        confidence: 0.0,
      );
    }

    int totalVerde = 0;
    int totalCereja = 0;
    int totalPassa = 0;
    int totalSeco = 0;
    double maxConfidence = 0.0;
    String finalClass = "Desconhecido";

    // Tamanho do input. Esse valor precisa ser o mesmo definido no treinamento (e.g., YOLO normalmente é 640 ou 416 ou 224). 
    // Assumindo 224 por enquanto como fallback seguro, ou ajuste dependendo do seu best_float32.
    final inputSize = _interpreter!.getInputTensor(0).shape[1]; 

    for (var imageFile in images) {
      var input = _processImage(imageFile, inputSize);

      // Assumindo output classification 1D com 4 classes [1, 4]
      var output = List.filled(4, 0.0).reshape([1, 4]);

      try {
        _interpreter!.run(input, output);
        
        List<double> scores = output[0].cast<double>();
        
        int highestIndex = 0;
        double currentMaxScore = 0.0;

        for (int i = 0; i < scores.length; i++) {
          if (scores[i] > currentMaxScore) {
            currentMaxScore = scores[i];
            highestIndex = i;
          }
        }
        
        if(currentMaxScore > maxConfidence) {
           maxConfidence = currentMaxScore;
           finalClass = _labels![highestIndex];
        }

        // Acumulando contagem (simulando que cada foto prediz a classe predominante)
        switch (_labels![highestIndex]) {
          case 'Verde': totalVerde += 10; break;
          case 'Cereja': totalCereja += 10; break;
          case 'Passa': totalPassa += 10; break;
          case 'Seco': totalSeco += 10; break;
        }
      } catch (e) {
        print("Erro durante a inferência na imagem: $e");
      }
    }

    return InferenceResult(
      finalResult: finalClass,
      perPhotoResults: {
        'Verde': totalVerde,
        'Cereja': totalCereja,
        'Passa': totalPassa,
        'Seco': totalSeco,
      },
      confidence: maxConfidence,
    );
  }
}
