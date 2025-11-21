import 'dart:math';

typedef FormulaValueResolver = dynamic Function(String reference);

/// Evaluates spreadsheet-like formulas with support for arithmetic,
/// logical operations, conditional branching, and helper functions such as
/// IF, AND, OR, SUM, AVG, MIN, MAX, ROUND, RANDOM, RANDBETWEEN,
/// PERCENT, and RANGE.
class FormulaEvaluator {
  FormulaEvaluator({required this.valueResolver, Random? random})
    : _random = random ?? Random();

  final FormulaValueResolver valueResolver;
  final Random _random;

  dynamic evaluate(String expression) {
    if (expression.trim().isEmpty) return null;
    final parser = _FormulaParser(expression);
    final node = parser.parse();

    final runtime = _FormulaRuntime(resolver: valueResolver, random: _random);

    return node.evaluate(runtime);
  }
}

class FormulaEvaluationException implements Exception {
  FormulaEvaluationException(this.message);
  final String message;

  @override
  String toString() => 'FormulaEvaluationException: $message';
}

class FormulaMissingDependencyException implements Exception {
  const FormulaMissingDependencyException([this.message = '']);
  final String message;

  @override
  String toString() =>
      'FormulaMissingDependencyException: ${message.isEmpty ? "Missing dependency" : message}';
}

// ---------------------------------------------------------------------------
// Parsing
// ---------------------------------------------------------------------------

class _FormulaParser {
  _FormulaParser(this._source);

  final String _source;
  int _index = 0;

  bool get _isAtEnd => _index >= _source.length;

  _FormulaNode parse() {
    final node = _parseLogicalOr();
    _skipWhitespace();
    if (!_isAtEnd) {
      throw FormulaEvaluationException(
        'Unexpected token "${_source.substring(_index)}"',
      );
    }
    return node;
  }

  _FormulaNode _parseLogicalOr() {
    var node = _parseLogicalAnd();
    while (true) {
      _skipWhitespace();
      if (_matchString('||')) {
        final right = _parseLogicalAnd();
        node = _BinaryNode('||', node, right);
      } else {
        break;
      }
    }
    return node;
  }

  _FormulaNode _parseLogicalAnd() {
    var node = _parseEquality();
    while (true) {
      _skipWhitespace();
      if (_matchString('&&')) {
        final right = _parseEquality();
        node = _BinaryNode('&&', node, right);
      } else {
        break;
      }
    }
    return node;
  }

  _FormulaNode _parseEquality() {
    var node = _parseComparison();
    while (true) {
      _skipWhitespace();
      if (_matchString('==') || _matchChar('=')) {
        final right = _parseComparison();
        node = _BinaryNode('==', node, right);
      } else if (_matchString('!=') || _matchString('<>')) {
        final right = _parseComparison();
        node = _BinaryNode('!=', node, right);
      } else {
        break;
      }
    }
    return node;
  }

  _FormulaNode _parseComparison() {
    var node = _parseTerm();
    while (true) {
      _skipWhitespace();
      if (_matchString('>=')) {
        final right = _parseTerm();
        node = _BinaryNode('>=', node, right);
      } else if (_matchString('<=')) {
        final right = _parseTerm();
        node = _BinaryNode('<=', node, right);
      } else if (_matchChar('>')) {
        final right = _parseTerm();
        node = _BinaryNode('>', node, right);
      } else if (_matchChar('<')) {
        final right = _parseTerm();
        node = _BinaryNode('<', node, right);
      } else {
        break;
      }
    }
    return node;
  }

  _FormulaNode _parseTerm() {
    var node = _parseFactor();
    while (true) {
      _skipWhitespace();
      if (_matchChar('+')) {
        final right = _parseFactor();
        node = _BinaryNode('+', node, right);
      } else if (_matchChar('-')) {
        final right = _parseFactor();
        node = _BinaryNode('-', node, right);
      } else {
        break;
      }
    }
    return node;
  }

  _FormulaNode _parseFactor() {
    var node = _parseUnary();
    while (true) {
      _skipWhitespace();
      if (_matchChar('*')) {
        final right = _parseUnary();
        node = _BinaryNode('*', node, right);
      } else if (_matchChar('/')) {
        final right = _parseUnary();
        node = _BinaryNode('/', node, right);
      } else if (_matchChar('%')) {
        final right = _parseUnary();
        node = _BinaryNode('%', node, right);
      } else {
        break;
      }
    }
    return node;
  }

  _FormulaNode _parseUnary() {
    _skipWhitespace();
    if (_matchChar('+')) {
      return _UnaryNode('+', _parseUnary());
    }
    if (_matchChar('-')) {
      return _UnaryNode('-', _parseUnary());
    }
    if (_matchChar('!') || _matchKeyword('NOT')) {
      return _UnaryNode('!', _parseUnary());
    }
    return _parsePrimary();
  }

  _FormulaNode _parsePrimary() {
    _skipWhitespace();
    if (_matchChar('(')) {
      final node = _parseLogicalOr();
      _skipWhitespace();
      _expectChar(')');
      return node;
    }

    if (_matchChar('|')) {
      final node = _parseLogicalOr();
      _skipWhitespace();
      _expectChar('|');
      return _FunctionNode('ABS', [node]);
    }

    if (_matchChar('{')) {
      final buffer = StringBuffer();
      while (!_isAtEnd && _currentChar() != '}') {
        buffer.write(_currentChar());
        _index++;
      }
      _expectChar('}');
      return _PlaceholderNode(buffer.toString());
    }

    if (_peekIsDigit() || _peekIsDotNumber()) {
      return _LiteralNode(_parseNumberLiteral());
    }

    if (_matchChar('"') || _matchChar('\'')) {
      final quote = _source[_index - 1];
      final buffer = StringBuffer();
      var closed = false;
      while (!_isAtEnd) {
        final ch = _currentChar();
        _index++;
        if (ch == '\\' && !_isAtEnd) {
          buffer.write(_currentChar());
          _index++;
          continue;
        }
        if (ch == quote) {
          closed = true;
          break;
        }
        buffer.write(ch);
      }
      if (!closed) {
        throw FormulaEvaluationException('Unterminated string literal');
      }
      return _LiteralNode(buffer.toString());
    }

    if (_peekIsAlpha()) {
      final identifier = _readIdentifier();
      final upper = identifier.toUpperCase();
      _skipWhitespace();
      if (_matchChar('(')) {
        final args = <_FormulaNode>[];
        _skipWhitespace();
        if (_matchChar(')')) {
          return _FunctionNode(upper, args);
        }

        while (true) {
          args.add(_parseLogicalOr());
          _skipWhitespace();
          if (_matchChar(',')) {
            continue;
          }
          _expectChar(')');
          break;
        }
        return _FunctionNode(upper, args);
      }

      switch (upper) {
        case 'TRUE':
          return _LiteralNode(true);
        case 'FALSE':
          return _LiteralNode(false);
        case 'NULL':
          return _LiteralNode(null);
        default:
          throw FormulaEvaluationException(
            'Unexpected identifier "$identifier"',
          );
      }
    }

    throw FormulaEvaluationException('Unexpected token at position $_index');
  }

  num _parseNumberLiteral() {
    final start = _index;
    while (!_isAtEnd && _isDigit(_currentChar())) {
      _index++;
    }
    if (!_isAtEnd && _currentChar() == '.') {
      _index++;
      while (!_isAtEnd && _isDigit(_currentChar())) {
        _index++;
      }
    }
    final literal = _source.substring(start, _index);
    return num.parse(literal);
  }

  bool _peekIsDigit() {
    return !_isAtEnd && _isDigit(_currentChar());
  }

  bool _peekIsDotNumber() {
    return !_isAtEnd &&
        _currentChar() == '.' &&
        _index + 1 < _source.length &&
        _isDigit(_source[_index + 1]);
  }

  bool _peekIsAlpha() {
    if (_isAtEnd) return false;
    final ch = _currentChar();
    return _isAlpha(ch) || ch == '_';
  }

  String _readIdentifier() {
    final start = _index;
    while (!_isAtEnd &&
        (_isAlphaNumeric(_currentChar()) || _currentChar() == '_')) {
      _index++;
    }
    return _source.substring(start, _index);
  }

  bool _matchKeyword(String keyword) {
    _skipWhitespace();
    final upper = keyword.toUpperCase();
    final end = _index + keyword.length;
    if (end > _source.length) return false;
    final candidate = _source.substring(_index, end).toUpperCase();
    if (candidate != upper) return false;

    final prev = _index - 1 >= 0 ? _source[_index - 1] : '';
    final next = end < _source.length ? _source[end] : '';
    if ((_isAlphaNumeric(prev)) || (_isAlphaNumeric(next))) {
      return false;
    }

    _index = end;
    return true;
  }

  bool _matchString(String value) {
    _skipWhitespace();
    final end = _index + value.length;
    if (end > _source.length) return false;
    if (_source.substring(_index, end) == value) {
      _index = end;
      return true;
    }
    return false;
  }

  bool _matchChar(String char) {
    _skipWhitespace();
    if (_isAtEnd) return false;
    if (_source[_index] == char) {
      _index++;
      return true;
    }
    return false;
  }

  void _expectChar(String char) {
    if (!_matchChar(char)) {
      throw FormulaEvaluationException('Expected "$char" at position $_index');
    }
  }

  void _skipWhitespace() {
    while (!_isAtEnd) {
      final ch = _source[_index];
      if (ch == ' ' || ch == '\t' || ch == '\n' || ch == '\r') {
        _index++;
      } else {
        break;
      }
    }
  }

  String _currentChar() => _source[_index];

  bool _isDigit(String ch) => ch.codeUnitAt(0) >= 48 && ch.codeUnitAt(0) <= 57;

  bool _isAlpha(String ch) {
    final code = ch.codeUnitAt(0);
    return (code >= 65 && code <= 90) || (code >= 97 && code <= 122);
  }

  bool _isAlphaNumeric(String ch) => _isAlpha(ch) || _isDigit(ch);
}

// ---------------------------------------------------------------------------
// AST Nodes & runtime helpers
// ---------------------------------------------------------------------------

abstract class _FormulaNode {
  dynamic evaluate(_FormulaRuntime runtime);
}

class _LiteralNode extends _FormulaNode {
  _LiteralNode(this.value);
  final dynamic value;

  @override
  dynamic evaluate(_FormulaRuntime runtime) => value;
}

class _PlaceholderNode extends _FormulaNode {
  _PlaceholderNode(this.reference);
  final String reference;

  @override
  dynamic evaluate(_FormulaRuntime runtime) {
    final value = runtime.resolver(reference);
    if (value == null ||
        (value is String && value.trim().isEmpty) ||
        (value is Iterable && value is! String && value.isEmpty)) {
      throw const FormulaMissingDependencyException();
    }
    if (value is Iterable && value is! String) {
      final iterator = value.iterator;
      if (iterator.moveNext()) {
        return iterator.current;
      }
      throw const FormulaMissingDependencyException();
    }
    return value;
  }
}

class _UnaryNode extends _FormulaNode {
  _UnaryNode(this.operator, this.operand);
  final String operator;
  final _FormulaNode operand;

  @override
  dynamic evaluate(_FormulaRuntime runtime) {
    final value = operand.evaluate(runtime);
    switch (operator) {
      case '+':
        final numeric = _asNumber(value);
        if (numeric == null) {
          throw FormulaEvaluationException('Unary + requires numeric value');
        }
        return numeric;
      case '-':
        final numeric = _asNumber(value);
        if (numeric == null) {
          throw FormulaEvaluationException('Unary - requires numeric value');
        }
        return -numeric;
      case '!':
        return !_asBool(value);
      default:
        throw FormulaEvaluationException('Unknown unary operator $operator');
    }
  }
}

class _BinaryNode extends _FormulaNode {
  _BinaryNode(this.operator, this.left, this.right);
  final String operator;
  final _FormulaNode left;
  final _FormulaNode right;

  @override
  dynamic evaluate(_FormulaRuntime runtime) {
    switch (operator) {
      case '+':
        return _applyNumeric(left, right, runtime, (a, b) => a + b, '+');
      case '-':
        return _applyNumeric(left, right, runtime, (a, b) => a - b, '-');
      case '*':
        return _applyNumeric(left, right, runtime, (a, b) => a * b, '*');
      case '/':
        return _applyNumeric(left, right, runtime, (a, b) {
          if (b == 0) throw FormulaEvaluationException('Division by zero');
          return a / b;
        }, '/');
      case '%':
        return _applyNumeric(left, right, runtime, (a, b) {
          if (b == 0) throw FormulaEvaluationException('Modulo by zero');
          return a % b;
        }, '%');
      case '==':
        return _areEqual(left.evaluate(runtime), right.evaluate(runtime));
      case '!=':
        return !_areEqual(left.evaluate(runtime), right.evaluate(runtime));
      case '>':
      case '<':
      case '>=':
      case '<=':
        return _compareValues(
          left.evaluate(runtime),
          right.evaluate(runtime),
          operator,
        );
      case '&&':
        final leftValue = _asBool(left.evaluate(runtime));
        if (!leftValue) return false;
        return _asBool(right.evaluate(runtime));
      case '||':
        final leftValue = _asBool(left.evaluate(runtime));
        if (leftValue) return true;
        return _asBool(right.evaluate(runtime));
      default:
        throw FormulaEvaluationException('Unknown operator $operator');
    }
  }
}

class _FunctionNode extends _FormulaNode {
  _FunctionNode(this.name, this.args);
  final String name;
  final List<_FormulaNode> args;

  @override
  dynamic evaluate(_FormulaRuntime runtime) {
    switch (name) {
      case 'IF':
        return _evaluateIf(runtime);
      case 'AND':
        return _evaluateAnd(runtime);
      case 'OR':
        return _evaluateOr(runtime);
      case 'NOT':
        return !_asBool(_argValue(runtime, 0));
      case 'SUM':
        return _evaluateAggregation(runtime, (values) {
          return values.fold<num>(0, (prev, element) => prev + element);
        }, defaultWhenEmpty: 0);
      case 'AVG':
      case 'AVERAGE':
        return _evaluateAggregation(runtime, (values) {
          if (values.isEmpty) return 0;
          final sum = values.fold<num>(0, (prev, element) => prev + element);
          return sum / values.length;
        }, defaultWhenEmpty: 0);
      case 'MIN':
        return _evaluateAggregation(runtime, (values) {
          if (values.isEmpty) return null;
          num min = values.first;
          for (final value in values.skip(1)) {
            if (value < min) min = value;
          }
          return min;
        });
      case 'MAX':
        return _evaluateAggregation(runtime, (values) {
          if (values.isEmpty) return null;
          num max = values.first;
          for (final value in values.skip(1)) {
            if (value > max) max = value;
          }
          return max;
        });
      case 'ROUND':
        return _evaluateRound(runtime);
      case 'ABS':
        final value = _asNumber(_argValue(runtime, 0));
        if (value == null) return null;
        return value.abs();
      case 'FLOOR':
        final floorValue = _asNumber(_argValue(runtime, 0));
        if (floorValue == null) return null;
        return floorValue.floor();
      case 'CEIL':
      case 'CEILING':
        final ceilValue = _asNumber(_argValue(runtime, 0));
        if (ceilValue == null) return null;
        return ceilValue.ceil();
      case 'RANDOM':
        return _evaluateRandom(runtime);
      case 'RANDBETWEEN':
        return _evaluateRandBetween(runtime);
      case 'PERCENT':
        return _evaluatePercent(runtime);
      case 'RANGE':
        return _evaluateRange(runtime);
      default:
        throw FormulaEvaluationException('Unsupported function $name');
    }
  }

  dynamic _evaluateIf(_FormulaRuntime runtime) {
    if (args.isEmpty) return null;
    final condition = _asBool(args[0].evaluate(runtime));
    if (condition) {
      return args.length >= 2 ? args[1].evaluate(runtime) : null;
    }
    return args.length >= 3 ? args[2].evaluate(runtime) : null;
  }

  bool _evaluateAnd(_FormulaRuntime runtime) {
    for (final node in args) {
      if (!_asBool(node.evaluate(runtime))) {
        return false;
      }
    }
    return true;
  }

  bool _evaluateOr(_FormulaRuntime runtime) {
    for (final node in args) {
      if (_asBool(node.evaluate(runtime))) {
        return true;
      }
    }
    return false;
  }

  dynamic _evaluateAggregation(
    _FormulaRuntime runtime,
    num? Function(List<num>) aggregator, {
    num? defaultWhenEmpty,
  }) {
    final values = <num>[];
    for (final node in args) {
      final dynamic value = node.evaluate(runtime);
      values.addAll(_flattenNumeric(value));
    }
    if (values.isEmpty) return defaultWhenEmpty;
    return aggregator(values);
  }

  dynamic _evaluateRound(_FormulaRuntime runtime) {
    final value = _asNumber(_argValue(runtime, 0));
    if (value == null) return null;
    final decimals = _argValue(runtime, 1);
    final precision = _asNumber(decimals)?.toInt() ?? 0;
    final factor = pow(10, precision);
    return (value * factor).round() / factor;
  }

  dynamic _evaluateRandom(_FormulaRuntime runtime) {
    if (args.isEmpty) {
      return runtime.random.nextDouble();
    }
    if (args.length == 1) {
      final max = _asNumber(args[0].evaluate(runtime)) ?? 1;
      return runtime.random.nextDouble() * max;
    }
    num min = _asNumber(args[0].evaluate(runtime)) ?? 0;
    num max = _asNumber(args[1].evaluate(runtime)) ?? min;
    if (min > max) {
      final temp = max;
      max = min;
      min = temp;
    }
    if (max == min) return min;
    return min + runtime.random.nextDouble() * (max - min);
  }

  dynamic _evaluateRandBetween(_FormulaRuntime runtime) {
    if (args.length < 2) {
      throw FormulaEvaluationException('RANDBETWEEN needs at least 2 params');
    }
    num min = _asNumber(args[0].evaluate(runtime)) ?? 0;
    num max = _asNumber(args[1].evaluate(runtime)) ?? min;
    if (min > max) {
      final temp = max;
      max = min;
      min = temp;
    }
    num step = args.length >= 3
        ? (_asNumber(args[2].evaluate(runtime)) ?? 1)
        : 1;
    if (step <= 0) {
      throw FormulaEvaluationException('RANDBETWEEN step must be positive');
    }
    final steps = ((max - min) / step).floor();
    final pick = runtime.random.nextInt(steps + 1);
    final value = min + pick * step;
    return step % 1 == 0 ? value.round() : value;
  }

  dynamic _evaluatePercent(_FormulaRuntime runtime) {
    if (args.isEmpty) return null;
    final firstValue = _asNumber(args[0].evaluate(runtime));
    if (firstValue == null) return null;
    if (args.length == 1) {
      return firstValue * 100;
    }
    final total = _asNumber(args[1].evaluate(runtime));
    if (total == null || total == 0) {
      throw FormulaEvaluationException('PERCENT total must be numeric');
    }
    final percentage = (firstValue / total) * 100;
    return percentage;
  }

  dynamic _evaluateRange(_FormulaRuntime runtime) {
    if (args.length < 3) {
      throw FormulaEvaluationException('RANGE expects value, min, max');
    }
    final value = _asNumber(args[0].evaluate(runtime));
    final min = _asNumber(args[1].evaluate(runtime));
    final max = _asNumber(args[2].evaluate(runtime));
    if (value == null || min == null || max == null) {
      return null;
    }
    if (max == min) return 0;
    final clamped = value.clamp(min, max);
    return (clamped - min) / (max - min);
  }

  dynamic _argValue(_FormulaRuntime runtime, int index) {
    if (index >= args.length) return null;
    return args[index].evaluate(runtime);
  }
}

class _FormulaRuntime {
  _FormulaRuntime({required this.resolver, required this.random});

  final FormulaValueResolver resolver;
  final Random random;
}

// ---------------------------------------------------------------------------
// Helper functions
// ---------------------------------------------------------------------------

num? _asNumber(dynamic value) {
  if (value == null) return null;
  if (value is num) return value;
  if (value is bool) return value ? 1 : 0;
  if (value is String) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null;
    return num.tryParse(trimmed);
  }
  return null;
}

bool _asBool(dynamic value) {
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final lowered = value.trim().toLowerCase();
    if (lowered == 'true') return true;
    if (lowered == 'false' || lowered.isEmpty) return false;
    final numeric = num.tryParse(lowered);
    if (numeric != null) return numeric != 0;
  }
  return value != null;
}

dynamic _applyNumeric(
  _FormulaNode left,
  _FormulaNode right,
  _FormulaRuntime runtime,
  num Function(num, num) operation,
  String operator,
) {
  final leftValue = left.evaluate(runtime);
  final rightValue = right.evaluate(runtime);
  final leftNum = _asNumber(leftValue);
  final rightNum = _asNumber(rightValue);
  if (leftNum == null || rightNum == null) {
    throw FormulaEvaluationException('Operator $operator requires numbers');
  }
  return operation(leftNum, rightNum);
}

bool _areEqual(dynamic left, dynamic right) {
  final leftNum = _asNumber(left);
  final rightNum = _asNumber(right);
  if (leftNum != null && rightNum != null) {
    return (leftNum - rightNum).abs() < 1e-9;
  }
  return left?.toString() == right?.toString();
}

bool _compareValues(dynamic left, dynamic right, String operator) {
  final leftNum = _asNumber(left);
  final rightNum = _asNumber(right);
  if (leftNum != null && rightNum != null) {
    switch (operator) {
      case '>':
        return leftNum > rightNum;
      case '<':
        return leftNum < rightNum;
      case '>=':
        return leftNum >= rightNum;
      case '<=':
        return leftNum <= rightNum;
    }
  }

  final leftStr = left?.toString() ?? '';
  final rightStr = right?.toString() ?? '';
  switch (operator) {
    case '>':
      return leftStr.compareTo(rightStr) > 0;
    case '<':
      return leftStr.compareTo(rightStr) < 0;
    case '>=':
      return leftStr.compareTo(rightStr) >= 0;
    case '<=':
      return leftStr.compareTo(rightStr) <= 0;
    default:
      return false;
  }
}

List<num> _flattenNumeric(dynamic value) {
  if (value == null) return [];
  if (value is Iterable && value is! String) {
    return value.map(_asNumber).whereType<num>().toList();
  }
  final numValue = _asNumber(value);
  if (numValue == null) return [];
  return [numValue];
}
