// Função para normalizar texto (remover acentos, símbolos e padronizar)
String normalizar(String input) {
  return input
      .toLowerCase()
      .replaceAll(RegExp(r'[áàâã]'), 'a')
      .replaceAll(RegExp(r'[éèê]'), 'e')
      .replaceAll(RegExp(r'[íìî]'), 'i')
      .replaceAll(RegExp(r'[óòôõ]'), 'o')
      .replaceAll(RegExp(r'[úùû]'), 'u')
      .replaceAll(RegExp(r'[^a-z0-9\s:]'), ''); // remove símbolos extras
}

// Extrair nome completo
String extractNomeCompleto(String fullText) {
  final lines = fullText.split('\n');
  final buffer = StringBuffer();
  bool nomeEncontrado = false;

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i].trim();
    if (!nomeEncontrado && line.toLowerCase().startsWith('nome completo')) {
      nomeEncontrado = true;
      final parts = line.split(':');
      if (parts.length > 1) buffer.write(parts[1].trim());
      continue;
    }

    if (nomeEncontrado) {
      final lower = line.toLowerCase();
      final isNovoCampo =
          lower.startsWith('sexo') ||
          lower.contains('nascimento') ||
          lower.contains('filiação') ||
          lower.contains('bilhete') ||
          lower.contains('natural');
      if (isNovoCampo) break;

      buffer.write(' ');
      buffer.write(line);
    }
  }

  return buffer.toString().trim();
}

// Extrair naturalidade
String extractNaturalidade(String fullText) {
  final lines = fullText.split('\n');
  final buffer = StringBuffer();
  bool captura = false;

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i].trim();
    final lineNorm = normalizar(line);

    if (!captura &&
        (lineNorm.startsWith('natural de') ||
         lineNorm.startsWith('naturalidade'))) {
      captura = true;
      final parts = line.split(':');
      if (parts.length > 1) buffer.write(parts[1].trim());
      continue;
    }

    if (captura) {
      final isNovoCampo =
          lineNorm.startsWith('sexo') ||
          lineNorm.contains('nascimento') ||
          lineNorm.contains('filiacao') ||
          lineNorm.contains('bilhete') ||
          lineNorm.contains('residencia') ||
          lineNorm.contains('provincia') ||
          lineNorm.contains('estado civil') ||
          lineNorm.startsWith('nome completo');
      if (isNovoCampo) break;

      if (!buffer.toString().contains(line)) {
        buffer.write(' ');
        buffer.write(line);
      }
    }
  }

  return buffer.toString().trim();
}

// Extrair altura
String extractAltura(String fullText) {
  final lines = fullText.split('\n');

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i].trim().toLowerCase();

    if (line.startsWith('altura')) {
      final alturaRegExp = RegExp(r'(\d+[.,]\d{1,2})');
      final match = alturaRegExp.firstMatch(line);

      if (match != null) {
        return match.group(1)!.replaceAll(',', '.');
      }
    }
  }

  return '';
}

// Extrair validade (Válido até)
String extractValidoAte(String fullText) {
  final validoReg = RegExp(
    r'(Valido ate|Válido até)\s*:?\s*(\d{2}[\/\-]\d{2}[\/\-]\d{4})',
    caseSensitive: false,
  );
  final match = validoReg.firstMatch(fullText);
  return match?.group(2)?.trim() ?? '';
}

// Extrair província
String extractProvincia(String fullText) {
  final lines = fullText.split('\n');
  final buffer = StringBuffer();
  bool captura = false;

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i].trim();
    final lineNorm = normalizar(line);

    if (!captura &&
        (lineNorm.startsWith('provincia de') ||
         lineNorm.startsWith('provincia'))) {
      captura = true;
      final parts = line.split(':');
      if (parts.length > 1) buffer.write(parts[1].trim());
      continue;
    }

    if (captura) {
      final isNovoCampo =
          lineNorm.startsWith('sexo') ||
          lineNorm.contains('nascimento') ||
          lineNorm.contains('filiacao') ||
          lineNorm.contains('bilhete') ||
          lineNorm.contains('residencia') ||
          lineNorm.contains('estado civil') ||
          lineNorm.startsWith('nome completo');
      if (isNovoCampo) break;

      buffer.write(' ');
      buffer.write(line);
    }
  }

  return buffer.toString().trim();
}

// Extrair residência
String extractResidencia(String fullText) {
  final lines = fullText.split('\n');
  final buffer = StringBuffer();
  bool captura = false;

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i].trim();
    final lineNorm = normalizar(line);

    if (!captura && lineNorm.startsWith('residencia')) {
      captura = true;
      final parts = line.split(':');
      if (parts.length > 1) buffer.write(parts[1].trim());
      continue;
    }

    if (captura) {
      final isNovoCampo =
          lineNorm.startsWith('sexo') ||
          lineNorm.contains('nascimento') ||
          lineNorm.contains('filiacao') ||
          lineNorm.contains('bilhete') ||
          lineNorm.contains('natural') ||
          lineNorm.contains('estado civil') ||
          lineNorm.startsWith('nome completo');
      if (isNovoCampo) break;

      buffer.write(' ');
      buffer.write(line);
    }
  }

  return buffer.toString().trim();
}

// Extrair data de emissão
String extractEmitidoEm(String fullText) {
  final lines = fullText.split('\n');
  final buffer = StringBuffer();
  bool captura = false;

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i].trim();
    final lineNorm = normalizar(line);

    if (!captura &&
        (lineNorm.startsWith('emitido em') ||
         lineNorm.startsWith('Emitido em'))) {
      captura = true;
      final parts = line.split(':');
      if (parts.length > 1) buffer.write(parts[1].trim());
      continue;
    }

    if (captura) {
      final isNovoCampo =
          lineNorm.startsWith('sexo') ||
          lineNorm.contains('nascimento') ||
          lineNorm.contains('filiacao') ||
          lineNorm.contains('bilhete') ||
          lineNorm.contains('residencia') ||
          lineNorm.contains('estado civil') ||
          lineNorm.contains('Válido até') ||
          lineNorm.contains('Director') ||
          lineNorm.startsWith('nome completo');
      if (isNovoCampo) break;

      buffer.write(' ');
      buffer.write(line);
    }
  }

  final result = buffer.toString().trim().replaceAll("Válido até", "");

  if (result.length > 10) {
    final valor = "${result.substring(0, 5)}/${result.substring(6)}";
    return valor;
  }

  return result;
}
