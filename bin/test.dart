
void main() {
  var value = MyValue();
  print(value.arg);
}

class MyValue {
  int? arg;

  factory MyValue({int? arg}) = Implementor;

  MyValue._name({this.arg});
}

class Implementor extends MyValue {
  factory Implementor({Object? arg = #default_value}) {
    return Implementor._(arg: arg == #default_value ? 5 : arg as int?);
  }
  Implementor._({int? arg}) : super._name(arg: arg);
}