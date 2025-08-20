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

  factory BiModel.fromJson(Map<String, dynamic> json) {
    return BiModel(
      nomeCompleto: json['nome_completo'] as String,
      numeroBilhete: json['numero_bilhete'] as String,
      dataNascimento: parseDate(json['data_nascimento']),
      sexo: parseSexo(json['sexo']),
      estadoCivil: json['estado_civil'] as String,
      residencia: json['residencia'] as String,
      naturalDe: json['natural_de'] as String,
      provinciaDe: json['provincia_de'] as String,
      emitidoEm: parseDate(json['emitido_em']),
      validoAte: parseDate(json['valido_ate']),
      altura: parseAltura(json['altura']),
    );
  }

  Map<String, dynamic> toJson() => {
    'nome_completo': nomeCompleto,
    'numero_bilhete': numeroBilhete,
    'data_nascimento': dataNascimento?.toIso8601String(),
    'sexo': sexo.name,
    'estado_civil': estadoCivil,
    'residencia': residencia,
    'natural_de': naturalDe,
    'provincia_de': provinciaDe,
    'emitido_em': emitidoEm?.toIso8601String(),
    'valido_ate': validoAte?.toIso8601String(),
    'altura': altura,
  };

  static DateTime? parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    try {
      // Aceita formatos como "dd/MM/yyyy"
      final parts = value.split(RegExp(r'[/\-]'));
      if (parts.length == 3) {
        return DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0]),
        );
      }
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }

  static Sexo parseSexo(dynamic value) {
    if (value == null) return Sexo.desconhecido;
    final v = value.toString().toLowerCase();
    if (v.startsWith('m')) return Sexo.masculino;
    if (v.startsWith('f')) return Sexo.feminino;
    return Sexo.desconhecido;
  }

  static double? parseAltura(dynamic value) {
    if (value == null) return null;
    try {
      return double.parse(value.toString().replaceAll(',', '.'));
    } catch (_) {
      return null;
    }
  }
}
