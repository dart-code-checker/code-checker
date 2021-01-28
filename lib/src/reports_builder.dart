import 'package:code_checker/checker.dart';
import 'package:code_checker/rules.dart';

abstract class ReportsBuilder {
  void recordClass(ScopedClassDeclaration declaration, ClassReport report);

  void recordAntiPatternCases(Iterable<Issue> issues);

  void recordIssues(Iterable<Issue> issues);
}
