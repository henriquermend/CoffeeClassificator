
# ☕ Coffee Classificator

Uma aplicação Flutter voltada para a **classificação de grãos de café utilizando inteligência artificial**. Este projeto visa auxiliar produtores e pesquisadores na identificação rápida e precisa de diferentes estágios ou tipos de grãos, otimizando processos na cadeia de produção.

---

## 🔍 Funcionalidades

- 📸 Captura de imagens de grãos de café diretamente pela câmera.
- 🧠 Classificação automática utilizando modelo de IA.
- 🗃️ Visualização dos grãos classificados no estilo "Pokédex" — **CoffeeDex**.
- 🗂️ Organização das informações com widgets customizados como `Coffee_Card`, `Coffee_Bean`, e muito mais.

---

## 🧩 Estrutura do Projeto

- `Camera_Screen.dart` — Tela de captura de imagens.
- `CoffeeDex_page.dart` — Interface que lista os grãos classificados.
- `Coffee_Bean.dart` — Classe modelo para os dados do grão.
- `Coffee_Card.dart` — Widget de exibição visual dos grãos.
- `image_processing_service.dart` — Serviço para pré-processamento e classificação das imagens.
- `state_management.dart` — Lógica de estado central do app.
- `Splash_Screen.dart` — Tela inicial animada.
- `Main.dart` — Arquivo principal de execução.

---

## 🛠️ Como rodar

1. Clone o repositório:
   ```bash
   git clone https://github.com/henriquermend/CoffeeClassificator/flutter_application_1.git
   ```
2. Instale as dependências:
   ```bash
   flutter pub get
   ```
3. Execute o app:
   ```bash
   flutter run
   ```

> Certifique-se de que você tem o Flutter instalado e um emulador ou dispositivo físico configurado.

---

## 📦 Dependências

As principais bibliotecas utilizadas no projeto são:

- `camera`
- `image_picker`
- `tflite` ou similar para inferência do modelo
- `provider` ou outra lib para gerenciamento de estado (se aplicável)

---

## 📷 Dataset & Modelo

Este app espera que você utilize um modelo `.tflite` treinado previamente e um arquivo `labels.txt` contendo as classes dos grãos. Ambos devem estar na pasta `assets/`.

---

