import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';

class CyclomaticComplexityFlowVisitor extends RecursiveAstVisitor<void> {
  final _complexityEntities = <SyntacticEntity>[];

  Iterable<SyntacticEntity> get complexityEntities => _complexityEntities;

  @override
  void visitAssertStatement(AssertStatement node) {
    _increaseComplexity(node);

    super.visitAssertStatement(node);
  }

  @override
  void visitBlockFunctionBody(BlockFunctionBody node) {
    _visitBlock(
      node.block.leftBracket.next,
      node.block.rightBracket,
    );

    super.visitBlockFunctionBody(node);
  }

  @override
  void visitCatchClause(CatchClause node) {
    _increaseComplexity(node);

    super.visitCatchClause(node);
  }

  @override
  void visitConditionalExpression(ConditionalExpression node) {
    _increaseComplexity(node);

    super.visitConditionalExpression(node);
  }

  @override
  void visitExpressionFunctionBody(ExpressionFunctionBody node) {
    _visitBlock(
      node.expression.beginToken.previous,
      node.expression.endToken.next,
    );

    super.visitExpressionFunctionBody(node);
  }

  @override
  void visitForStatement(ForStatement node) {
    _increaseComplexity(node);

    super.visitForStatement(node);
  }

  @override
  void visitIfStatement(IfStatement node) {
    _increaseComplexity(node);

    super.visitIfStatement(node);
  }

  @override
  void visitSwitchCase(SwitchCase node) {
    _increaseComplexity(node);

    super.visitSwitchCase(node);
  }

  @override
  void visitSwitchDefault(SwitchDefault node) {
    _increaseComplexity(node);

    super.visitSwitchDefault(node);
  }

  @override
  void visitWhileStatement(WhileStatement node) {
    _increaseComplexity(node);

    super.visitWhileStatement(node);
  }

  @override
  void visitYieldStatement(YieldStatement node) {
    _increaseComplexity(node);

    super.visitYieldStatement(node);
  }

  void _visitBlock(Token firstToken, Token lastToken) {
    const tokenTypes = [
      TokenType.AMPERSAND_AMPERSAND,
      TokenType.BAR_BAR,
      TokenType.QUESTION_PERIOD,
      TokenType.QUESTION_QUESTION,
      TokenType.QUESTION_QUESTION_EQ,
    ];

    var token = firstToken;
    while (token != lastToken) {
      if (token.matchesAny(tokenTypes)) {
        _increaseComplexity(token);
      }

      token = token.next;
    }
  }

  void _increaseComplexity(SyntacticEntity entity) {
    _complexityEntities.add(entity);
  }
}
