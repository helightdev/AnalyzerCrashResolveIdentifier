import 'dart:async';

import 'package:macro_test/content.dart';
import 'package:macros/macros.dart';

macro class ControllerMacro implements ClassDeclarationsMacro {

  const ControllerMacro();
  @override
  FutureOr<void> buildDeclarationsForClass(ClassDeclaration clazz, MemberDeclarationBuilder builder) async {
    await introspectTest(clazz, builder);
  }
}