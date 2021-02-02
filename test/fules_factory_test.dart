@TestOn('vm')
import 'package:code_checker/src/rules/newline_before_return/newline_before_return.dart';
import 'package:code_checker/src/rules_factory.dart';
import 'package:test/test.dart';

void main() {
  test('rulesByConfig returns only required rules', () {
    expect(rulesByConfig({}), isEmpty);
    expect(
      rulesByConfig({
        NewlineBeforeReturnRule.ruleId: <String, Object>{},
      }).map((rule) => rule.id),
      equals([
        NewlineBeforeReturnRule.ruleId,
      ]),
    );
  });
}
