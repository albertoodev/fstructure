import '/src/features/featuree/data/repositories/example_data_repository.dart';

abstract class ExampleRepository {
  static ExampleRepository create() => ExampleDataRepository();
}
