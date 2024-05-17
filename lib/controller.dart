import 'package:macro_test/macro_test.dart';

@ControllerMacro()
class MyControllerText {
  @CustomAnnotation()
  void main() {}
}

class CustomAnnotation {
  const CustomAnnotation();
}
