import 'package:meta/meta.dart';

/// Represents all metric documentation
@immutable
class MetricDocumentation {
  /// The name of a metric
  final String name;

  /// The short name of a metric
  final String shortName;

  /// The short message with formal statement about metric
  final String brief;

  /// The message with detailed statement of what exactly a metric calculate
  final Iterable<String> definition;

  const MetricDocumentation({
    @required this.name,
    @required this.shortName,
    @required this.brief,
    @required this.definition,
  });
}