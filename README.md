# docsnap

Biblioteca Dart/Flutter para extração automática de dados de documentos de identificação angolanos a partir de texto reconhecido por OCR.

> **Atenção:** Atualmente, **apenas a extração do Bilhete de Identidade (BI) angolano está disponível**. Outros documentos serão suportados em versões futuras.

## Funcionalidades Disponíveis

- [x] Extração automática dos campos do **Bilhete de Identidade (BI) angolano**
- [ ] Verificação e extração de dados do **Passaporte angolano** *(em desenvolvimento)*
- [ ] Verificação e extração de dados da **Carta de Condução angolana** *(em desenvolvimento)*

## Visão Geral

O package `docsnap` identifica e extrai os principais campos do BI angolano a partir do texto reconhecido por OCR, facilitando automação de cadastros e validação de dados em aplicativos Flutter.

## Principais Funcionalidades do BI Angolano

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

## Instalação

Adicione ao seu `pubspec.yaml`:

```yaml
dependencies:
  docsnap: ^1.0.0
```

Execute:

```
flutter pub get
```

## Uso Básico

```dart
import 'package:docsnap/model/bi_parser.dart';
import 'dart:io';

// Exemplo: processando uma imagem do BI angolano
final biModel = await BiParser.parseFromImage(File('caminho/para/imagem.jpg'));

print(biModel?.nomeCompleto);
print(biModel?.numeroBilhete);
// ... demais campos
```

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
- `natural_de`
- `provincia_de`
- `resindecia`
- `altura`
- `emitido_em`
- `valido_ate`

## Requisitos

- Flutter >= 3.0
- [google_mlkit_text_recognition](https://pub.dev/packages/google_mlkit_text_recognition) para reconhecimento de texto

## Observações

- **Somente para BI angolano.** Outros documentos não são suportados nesta versão.
- A precisão depende da qualidade da imagem e do texto reconhecido.
- O parser foi ajustado para os padrões do BI angolano.

## Roadmap

- [x] Suporte ao Bilhete de Identidade angolano
- [ ] Suporte ao Passaporte angolano *(em breve)*
- [ ] Suporte à Carta de Condução angolana *(em breve)*

## Licença

MIT
