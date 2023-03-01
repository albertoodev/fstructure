import 'package:scout/src/features/faeture/data/repositories/example_data_repository.dart';

abstract class ExampleRepository {
  static ExampleRepository create() => ExampleDataRepository();
}
