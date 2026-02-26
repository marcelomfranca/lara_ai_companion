import 'package:go_router/go_router.dart';

abstract interface class Module {
  String get name;
  List<RouteBase> get routes;
  List<Map<String, dynamic>> get sqlScript;
}
