# Coffee Classificator (Flutter)

O **Coffee Classificator** é um aplicativo móvel voltado para classificar o nível de maturação de grãos de café de forma automática e rápida. Usando Machine Learning, o usuário pode tirar fotos do seu lote de grãos e instantaneamente ver uma análise classificando os grãos entre: Verde, Cereja, Passa ou Seco.

## 🚀 Como testar/usar o App

### 1. Instalando o Aplicativo (APK)
Disponibilizamos um arquivo `.apk` para você baixar e instalar diretamente no seu celular Android.
1. Faça o download do arquivo `app-release.apk`
2. No seu celular, permita a "Instalação de aplicativos de fontes desconhecidas" caso seja solicitado.
3. Instale e abra o **Coffee Classificator**!

### 2. Rodando o projeto localmente (Para Desenvolvedores)
Se você quer rodar o código-fonte na sua máquina ou emulador:
1. Certifique-se de ter o **Flutter** instalado (`flutter doctor`).
2. Entre na pasta do projeto e instale as dependências executando:
   ```bash
   flutter pub get
   ```
3. Conecte o seu celular via depuração USB, ou abra um emulador de Android/iOS.
4. Rode o aplicativo:
   ```bash
   flutter run
   ```

## 🧠 Como trocar o Modelo de IA (.tflite)

O aplicativo utiliza a biblioteca `tflite_flutter` para inferência offline. Por padrão, ele está apontado para o arquivo `assets/best_float32.tflite`.
Para alterar o modelo preditivo, siga estes passos:

1. Coloque o seu novo modelo `.tflite` (e.g., `meu_modelo_treinado.tflite`) dentro da pasta `assets/`.
2. Abra o arquivo `pubspec.yaml` e certifique-se de que a pasta de assets está incluída (isso já deve estar feito por padrão).
3. Abra o arquivo de serviço da câmera/inferência localizado em: `lib/services/inference_service.dart`.
4. Procure a seguinte linha na função de carregamento do modelo (`_loadModel()`):
   ```dart
   _interpreter = await Interpreter.fromAsset('assets/best_float32.tflite');
   ```
5. Substitua `'assets/best_float32.tflite'` pelo nome do seu novo arquivo:
   ```dart
   _interpreter = await Interpreter.fromAsset('assets/meu_modelo_treinado.tflite');
   ```

> **Atenção:** Você pode precisar ajustar o pré-processamento de imagem (`_processImage`) caso o novo modelo espere um tamanho de entrada (*Input Size*) diferente de `224x224` ou seja do tipo *Quantized (int8)* ao invés de *Float32*. O loop detecta a resolução base pelo próprio tflite, mas garanta que os formatos conferem!
