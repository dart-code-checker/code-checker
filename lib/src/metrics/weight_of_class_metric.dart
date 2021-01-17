import 'package:analyzer/dart/ast/ast.dart';

import '../models/class_type.dart';
import '../models/function_type.dart';
import '../models/scoped_class_declaration.dart';
import '../models/scoped_function_declaration.dart';
import '../utils/metric_utils.dart';
import '../utils/scope_utils.dart';
import 'metric.dart';
import 'metric_computation_result.dart';

/// Weight Of Class (WOC)
///
/// Number of **functional** public methods divided by the total number of public methods.
class WeightOfClassMetric extends Metric<double> {
  static const String metricId = 'weight-of-class';
  static const _metricName = 'Weight Of Class';
  static const _metricShortName = 'WOC';
  static const _defaultThreshold = 0.33;

  WeightOfClassMetric({Map<String, Object> config = const {}})
      : super(
          id: metricId,
          name: _metricName,
          shortName: _metricShortName,
          documentation: null,
          threshold: readThreshold<double>(config, metricId, _defaultThreshold),
          levelComputer: invertValueLevel,
        );

  @override
  MetricComputationResult<double> computeImplementation(
    ScopedClassDeclaration classDeclaration,
    Iterable<ScopedFunctionDeclaration> functionDeclarations,
  ) {
    final totalPublicMethods =
        classMethods(classDeclaration, functionDeclarations)
            .where(_isPublicMethod)
            .toList(growable: false);

    final functionalMethods = totalPublicMethods.where(_isFunctionalMethod);

    return MetricComputationResult(
      value: functionalMethods.length / totalPublicMethods.length,
    );
  }

  @override
  String commentMessage(ClassType type, double value, double threshold) {
    final exceeds = value < threshold
        ? ', which is lower then the threshold of $threshold allowed'
        : '';

    return 'This ${type.toString().toLowerCase()} has a weight of $value$exceeds.';
  }

  bool _isPublicMethod(ScopedFunctionDeclaration function) =>
      !Identifier.isPrivateName(function.name);

  bool _isFunctionalMethod(ScopedFunctionDeclaration function) {
    const _nonFunctionalTypes = {
      FunctionType.constructor,
      FunctionType.setter,
      FunctionType.getter,
    };

    return !_nonFunctionalTypes.contains(function.type);
  }
}