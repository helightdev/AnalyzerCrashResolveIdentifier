import 'package:macro_test/macro_test.dart';

@ControllerMacro()
class MyControllerText {
  @CustomAnnotation()
  @refAnnotation
  void main() {
    
  }
}

class CustomAnnotation {
  const CustomAnnotation();
}

const refAnnotation = CustomAnnotation();
