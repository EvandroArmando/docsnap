import 'dart:io';
import 'package:docsnap/generator/generator_functions.dart';
import 'package:docsnap/model/bi_model.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:flutter/foundation.dart'; // compute()

class BiParser {
  static Future<Map<String, dynamic>> parseFromImage(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    final RecognizedText recognizedText = await textRecognizer.processImage(
      inputImage,
    );
    await textRecognizer.close();

    final String fullText = recognizedText.text;

    // Envia para isolate (função pesada)
    final biJson = await compute(_parseTextToBiModel, fullText);

    return biJson;
  }

  // Função executada no isolate (precisa ser top-level ou static)
  static Map<String, dynamic> _parseTextToBiModel(String fullText) {
    final nascimentoReg = RegExp(r'\b(\d{2}[\/\-]\d{2}[\/\-]\d{4})\b');
    final nascimentoLabelReg = RegExp(
      r'(Data de Nascimento|Nascimento)[^\d]*(\d{2}[\/\-]\d{2}[\/\-]\d{4})',
    );
    final numeroReg = RegExp(
      r'(?:Bilhete de Identidade\s*(?:N[ºo]\.?\s*)?)?([A-Z0-9]{14})',
      caseSensitive: false,
    );
    final sexoReg = RegExp(r'Sexo:\s*(\w+)', caseSensitive: false);
    final estadoCivilReg = RegExp(
      r'Estado Civil:\s*(\w+)',
      caseSensitive: false,
    );

    final biModel = BiModel(
      nomeCompleto: extractNomeCompleto(fullText),
      numeroBilhete: numeroReg.firstMatch(fullText)?.group(1) ?? '',
      dataNascimento: BiModel.parseDate(
        nascimentoLabelReg.firstMatch(fullText)?.group(2) ??
            nascimentoReg.firstMatch(fullText)?.group(1),
      ),
      sexo: BiModel.parseSexo(sexoReg.firstMatch(fullText)?.group(1)),
      estadoCivil: estadoCivilReg.firstMatch(fullText)?.group(1) ?? '',
      residencia: extractResidencia(fullText),
      naturalDe: extractNaturalidade(fullText),
      provinciaDe: extractProvincia(fullText),
      emitidoEm: BiModel.parseDate(extractEmitidoEm(fullText)),
      validoAte: BiModel.parseDate(extractValidoAte(fullText)),
      altura: BiModel.parseAltura(extractAltura(fullText)),
    );

    return biModel.toJson();
  }
}
