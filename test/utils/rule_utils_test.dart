@TestOn('vm')
import 'package:code_checker/src/models/severity.dart';
import 'package:code_checker/src/utils/rule_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Rule utils', () {
    test('documentation returns the url with documentation', () {
      const ruleId1 = 'rule-id-1';
      const ruleId2 = 'rule-id-2';

      expect(
        documentation(ruleId1).toString(),
        equals(
          'https://dart-code-checker.github.io/code-checker/rules/$ruleId1.html',
        ),
      );
      expect(
        documentation(ruleId2).pathSegments.last,
        equals('$ruleId2.html'),
      );
    });

    test('readSeverity returns a Severity from Map based config', () {
      expect(
        [
          {'severity': 'ERROR'},
          {'severity': 'wArnInG'},
          {'severity': 'performance'},
          {'severity': ''},
          {'': null},
        ].map((data) => readSeverity(data, Severity.style)),
        equals([
          Severity.error,
          Severity.warning,
          Severity.performance,
          Severity.none,
          Severity.style,
        ]),
      );
    });
  });
}
