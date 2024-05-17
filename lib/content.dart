import 'package:macros/macros.dart';
import 'package:lyell/lyell.dart';

Future introspectTest(
    ClassDeclaration clazz, MemberDeclarationBuilder builder) async {
  var typeToken = await builder.resolveIdentifier(
      Uri.parse("package:lyell/src/lyell_base.dart"), "TypeToken");
  var methods = await builder.methodsOf(clazz);
  for (var method in methods) {
    var code = DeclarationCode.fromParts([
      NamedTypeAnnotationCode(
          name: typeToken, typeArguments: [method.returnType.code]),
      " t",
      method.identifier.name,
      " = ",
      NamedTypeAnnotationCode(
          name: typeToken, typeArguments: [method.returnType.code]),
      "();"
    ]);
    builder.declareInType(code);

    var annotations = method.metadata.map(rebuildMetadata).toList();

    var metaCode = DeclarationCode.fromParts([
      "dynamic meta_",
      method.identifier.name,
      " = ",
      "[",
      ...annotations.expand((e) => [e, ","]),
      "];"
    ]);
    builder.declareInType(metaCode);
  }
}

Code rebuildMetadata(MetadataAnnotation annotation) {
  if (annotation is IdentifierMetadataAnnotation) {
    return RawCode.fromParts([annotation.identifier]);
  } else if (annotation is ConstructorMetadataAnnotation) {
    var parts = <Object>[annotation.type.code, "("];
    for (var arg in annotation.positionalArguments) {
      parts.add(arg);
      parts.add(",");
    }
    for (var arg in annotation.namedArguments.entries) {
      parts.add(arg.key);
      parts.add(":");
      parts.add(arg.value);
      parts.add(",");
    }
    parts.add(")");
    return RawCode.fromParts(parts);
  }
  return RawCode.fromString("null");
}
