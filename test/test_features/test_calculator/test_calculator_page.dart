import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_1/features/calculator/calculator_page.dart';

void main() {
  group('String Calculator - add()', () {
    test('Empty string returns 0', () {
      expect(add(''), 0);
    });

    test('Single number returns the number itself', () {
      expect(add('5'), 5);
    });

    test('Multiple numbers comma separated returns sum', () {
      expect(add('1,2,3,4'), 10);
    });

    test('Supports newline as a delimiter', () {
      expect(add('1\n2,3'), 6);
    });

    test('Custom delimiter (;) is supported', () {
      expect(add('//;\n1;2'), 3);
    });

    test('Custom delimiter (#) is supported', () {
      expect(add('//#\n2#3'), 5);
    });

    test('Throws exception for single negative number', () {
      expect(() => add('2,-3,4'),
          throwsA(predicate((e) => e.toString().contains('negative numbers not allowed: -3'))));
    });



    test('Ignores non-numeric values', () {
      expect(add('1,a,3'), 4); // skips 'a'
    });

    test('Handles custom delimiter with special regex characters like *', () {
      expect(add('//*\n1*2*3'), 6);
    });

    test('Handles spaces and trims input', () {
      expect(add(' 1 , 2 , 3 '), 6);
    });
  });
}
