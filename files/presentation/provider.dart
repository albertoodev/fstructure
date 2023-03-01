import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExampleProvider extends ChangeNotifier {
  ///
  /// get instance of [ExampleProvider] with listen false
  ///
  static ExampleProvider read(BuildContext context) =>
      Provider.of<ExampleProvider>(context, listen: false);

  ///
  /// get instance of [ExampleProvider] with listen true
  ///
  static ExampleProvider watch(BuildContext context) =>
      Provider.of<ExampleProvider>(context);
}
