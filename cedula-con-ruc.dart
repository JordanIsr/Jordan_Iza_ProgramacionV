import 'dart:io';

void main() {
  print("====================================");
  print(" VALIDACIÓN DE CÉDULA Y RUC - ECUADOR");
  print("====================================");

  stdout.write("Ingrese su cédula o RUC: ");
  String documento = stdin.readLineSync() ?? "";

  // 1. Validar que no esté vacío y que solo tenga números
  if (documento.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(documento)) {
    print("Error: Ingrese únicamente números.");
    return;
  }

  // 2. Identificar el tipo de documento
  if (documento.length == 10) {
    print("Tipo de documento: CÉDULA");
    validarCedula(documento);
  } else if (documento.length == 13) {
    print("Tipo de documento: RUC");
    validarRuc(documento);
  } else {
    print("Error: El documento debe tener 10 o 13 dígitos.");
  }
}

// Códigos de las provincias de Ecuador
final Map<String, String> provincias = {
  "01": "Azuay",
  "02": "Bolívar",
  "03": "Cañar",
  "04": "Carchi",
  "05": "Cotopaxi",
  "06": "Chimborazo",
  "07": "El Oro",
  "08": "Esmeraldas",
  "09": "Guayas",
  "10": "Imbabura",
  "11": "Loja",
  "12": "Los Ríos",
  "13": "Manabí",
  "14": "Morona Santiago",
  "15": "Napo",
  "16": "Pastaza",
  "17": "Pichincha",
  "18": "Tungurahua",
  "19": "Zamora Chinchipe",
  "20": "Galápagos",
  "21": "Sucumbíos",
  "22": "Orellana",
  "23": "Santo Domingo de los Tsáchilas",
  "24": "Santa Elena",
};

// Validar el código de provincia
bool validarProvincia(String documento) {
  String codigo = documento.substring(0, 2);

  if (!provincias.containsKey(codigo)) {
    print("Error: Código de provincia no válido ($codigo).");
    return false;
  }

  print("Provincia: ${provincias[codigo]}");
  return true;
}

// Validar cédula ecuatoriana
bool validarCedula(String cedula) {
  if (cedula.length != 10) {
    print("Error: La cédula debe tener 10 dígitos.");
    return false;
  }

  if (!validarProvincia(cedula)) {
    return false;
  }

  int tercerDigito = int.parse(cedula[2]);

  if (tercerDigito > 5) {
    print("Error: El tercer dígito de la cédula no es válido.");
    return false;
  }

  int sumaImpares = 0;
  int sumaPares = 0;

  for (int i = 0; i < 9; i++) {
    int digito = int.parse(cedula[i]);

    if (i % 2 == 0) {
      int producto = digito * 2;

      if (producto > 9) {
        producto -= 9;
      }

      sumaImpares += producto;
    } else {
      sumaPares += digito;
    }
  }

  int sumaTotal = sumaImpares + sumaPares;
  int residuo = sumaTotal % 10;

  int verificador = residuo == 0 ? 0 : 10 - residuo;
  int ultimoDigito = int.parse(cedula[9]);

  print("Suma de posiciones impares: $sumaImpares");
  print("Suma de posiciones pares: $sumaPares");
  print("Suma total: $sumaTotal");
  print("Dígito verificador calculado: $verificador");
  print("Décimo dígito ingresado: $ultimoDigito");

  if (verificador == ultimoDigito) {
    print("Resultado: CÉDULA VÁLIDA MATEMÁTICAMENTE.");
    return true;
  } else {
    print("Resultado: CÉDULA INVÁLIDA.");
    return false;
  }
}

// Validar RUC
void validarRuc(String ruc) {
  if (ruc.length != 13) {
    print("Error: El RUC debe tener 13 dígitos.");
    return;
  }

  if (!validarProvincia(ruc)) {
    return;
  }

  int tercerDigito = int.parse(ruc[2]);
  String establecimiento = ruc.substring(10, 13);

  // RUC de persona natural
  if (tercerDigito <= 5) {
    print("Tipo de contribuyente: PERSONA NATURAL");

    String cedula = ruc.substring(0, 10);

    if (!validarCedula(cedula)) {
      print("Resultado: RUC INVÁLIDO.");
      return;
    }

    if (establecimiento == "000") {
      print("Error: El establecimiento no puede ser 000.");
      return;
    }

    print("Resultado: ESTRUCTURA DE RUC VÁLIDA.");
  }
  // RUC de sociedad privada
  else if (tercerDigito == 9) {
    print("Tipo de contribuyente: SOCIEDAD PRIVADA");

    if (establecimiento != "001") {
      print("Error: Se esperaba el establecimiento 001.");
      return;
    }

    print("Resultado: ESTRUCTURA BÁSICA VÁLIDA.");
    print("La validez definitiva debe comprobarse con el SRI.");
  }
  // RUC de entidad pública
  else if (tercerDigito == 6) {
    print("Tipo de contribuyente: ENTIDAD PÚBLICA");

    if (establecimiento != "001") {
      print("Error: Se esperaba el establecimiento 001.");
      return;
    }

    print("Resultado: ESTRUCTURA BÁSICA VÁLIDA.");
    print("La validez definitiva debe comprobarse con el SRI.");
  } else {
    print("Error: Tercer dígito no válido para estos tipos de RUC.");
  }
}
