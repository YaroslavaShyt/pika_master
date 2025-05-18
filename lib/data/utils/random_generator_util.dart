import 'dart:math';

import 'package:pika_master/domain/utils/irandom_generator_util.dart';

class RandomGeneratorUtil implements IRandomGeneratorUtil {
  RandomGeneratorUtil({
    required int min,
    required int max,
  })  : _max = max,
        _min = min;

  final int _min;
  final int _max;

  final Random _random = Random();

  @override
  Set<int> generateNumbers({int quantity = 5}) {
    if (quantity <= 0) return {};

    final Set<int> numbers = {};
    while (numbers.length < quantity) {
      numbers.add(_random.nextInt(_max) + _min);
    }
    return numbers;
  }
}
