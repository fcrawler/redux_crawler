import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 1. 创建State
@immutable
class CountState {
  int _count;

  get count => _count;

  CountState(this._count);

  CountState.initState() {
    _count = 0;
  }
}

// 2. 创建Action
enum CountAction { MINUS, PLUS }

// 3. 创建Reducer
CountState reducer(CountState countState, action) {
  switch (action) {
    case CountAction.MINUS:
      return CountState(countState.count - 1);
      break;
    case CountAction.PLUS:
      return CountState(countState.count + 1);
      break;
  }

  return CountState(0);
}
