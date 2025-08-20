# docsnap

Biblioteca Dart/Flutter para extração automática de dados de documentos de identificação angolanos a partir de texto reconhecido por OCR.

> **Atenção:** Atualmente, **apenas a extração do Bilhete de Identidade (BI) angolano está disponível**. Outros documentos serão suportados em versões futuras.

---

## Funcionalidades

- ✅ Extração automática dos campos do **Bilhete de Identidade (BI) angolano**
- 🚧 Verificação e extração de dados do **Passaporte angolano** *(em desenvolvimento)*
- 🚧 Verificação e extração de dados da **Carta de Condução angolana** *(em desenvolvimento)*

---

## Principais Campos Extraídos do BI

- Nome completo
- Número do bilhete
- Data de nascimento
- Sexo
- Estado civil
- Naturalidade
- Província
- Residência
- Altura
- Data de emissão
- Data de validade

- Tratamento de variações e erros comuns de OCR
- Modelagem dos dados extraídos em uma estrutura única (`BiModel`)

---

## Instalação

Adicione ao seu `pubspec.yaml`:

```yaml
dependencies:
  docsnap: ^1.0.0
```

Execute:

```sh
flutter pub get
```

---

## Uso Básico

A extração dos dados retorna uma instância da classe `BiModel`, que possui as seguintes propriedades:

```dart
enum Sexo { masculino, feminino, desconhecido }

class BiModel {
  final String nomeCompleto;
  final String numeroBilhete;
  final DateTime? dataNascimento;
  final Sexo sexo;
  final String estadoCivil;
  final String residencia;
  final String naturalDe;
  final String provinciaDe;
  final DateTime? emitidoEm;
  final DateTime? validoAte;
  final double? altura;

  BiModel({
    required this.nomeCompleto,
    required this.numeroBilhete,
    required this.dataNascimento,
    required this.sexo,
    required this.estadoCivil,
    required this.residencia,
    required this.naturalDe,
    required this.provinciaDe,
    required this.emitidoEm,
    required this.validoAte,
    required this.altura,
  });
}
```

### 1. Extraindo dados para o modelo `BiModel`

```dart
import 'package:docsnap/model/bi_parser.dart';
import 'package:docsnap/model/bi_model.dart';
import 'dart:io';

final biModel = await BiParser.parseFromImage(File('caminho/para/imagem.jpg'));

if (biModel != null) {
  final dadosMap = biModel.toJson();

  // Convertendo o mapa para o modelo BiModel novamente
  final novoBiModel = BiModel.fromJson(dadosMap);

  print(novoBiModel.nomeCompleto);
  print(novoBiModel.numeroBilhete);
  print(novoBiModel.sexo);
  // ... demais campos
}
```

### 2. Extraindo dados e acessando como mapa

```dart
import 'package:docsnap/model/bi_parser.dart';

final biModel = BiParser.parseFromText(textoOcr);

if (biModel != null) {
  print('Nome: ${biModel["nome_completo"]}');
  print('Número do BI: ${biModel["numero_bilhete"]}');
  // ... demais campos
}
```

---

## API

### BiParser

- `Future<BiModel?> parseFromImage(File imageFile)`
  - Processa uma imagem e retorna um modelo com os campos extraídos do BI angolano.

### BiModel

Estrutura de dados com os seguintes campos:

- `nomeCompleto`
- `numeroBilhete`
- `dataNascimento`
- `sexo`
- `estadoCivil`
- `residencia`
- `naturalDe`
- `provinciaDe`
- `emitidoEm`
- `validoAte`
- `altura`

---

## Requisitos

- Flutter >= 3.0
- [google_mlkit_text_recognition](https://pub.dev/packages/google_mlkit_text_recognition) para reconhecimento de texto

---
## link do pacote pub dev


---
[![link do package](https://img.shields.io/pub/v/docsnap.svg)](https://pub.dev/packages/docsnap)

---



## Observações

- **Somente para BI angolano.** Outros documentos não são suportados nesta versão.
- A precisão depende da qualidade da imagem e do texto reconhecido.
- O parser foi ajustado para os padrões do BI angolano.

---

## Roadmap

- ✅ Suporte ao Bilhete de Identidade angolano
- 🚧 Suporte ao Passaporte angolano *(em breve)*
- 🚧 Suporte à Carta de Condução angolana *(em breve)*

---

## Licença

MIT
