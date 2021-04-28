import 'package:moor/moor_web.dart';

import '../database.dart';
/// Constructor de la base de datos para web
MyDatabase constructDb({bool logStatements = false}) {
  return MyDatabase(WebDatabase('db', logStatements: logStatements));
}
