import '../database.dart';

/// El constructor lanzara una excepción en caso de no soportar la plataforma
MyDatabase constructDb({bool logStatements = false}) {
  throw 'Platform not supported';
}
